#!/bin/bash
# Create logs directory if it doesn't exist
mkdir -p logs

echo "Starting all services..."

# Start backend server with output redirection
echo "Starting backend server on port 5500..."
nohup python backend/server.py > logs/backend.log 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > logs/backend.pid

# Start webapp with output redirection
echo "Starting webapp on port 3000..."
nohup yarn --cwd webapp start > logs/webapp.log 2>&1 &
WEBAPP_PID=$!
echo $WEBAPP_PID > logs/webapp.pid

# Start CMS with output redirection
echo "Starting CMS on port 4000..."
nohup yarn --cwd cms start > logs/cms.log 2>&1 &
CMS_PID=$!
echo $CMS_PID > logs/cms.pid

# ...rest of the code remains the same but update log paths...
echo "  tail -f logs/backend.log"
echo "  tail -f logs/webapp.log"
echo "  tail -f logs/cms.log"

# Wait a few seconds for services to start
sleep 3

# Print status
echo -e "\n=== Services Status ==="
echo "Backend (PID: $BACKEND_PID) - http://localhost:5500"
echo "Backend API Documentation - http://localhost:5500/docs"  # Added Swagger UI note
echo "Webapp (PID: $WEBAPP_PID) - http://localhost:3000"
echo "CMS (PID: $CMS_PID) - http://localhost:4000"

# Create a stop script
cat > scripts/stop.sh << 'EOF'
#!/bin/bash

clear_port() {
    local port=$1
    # Try different methods to find the process
    local pid=$(lsof -ti:$port 2>/dev/null || netstat -tunlp 2>/dev/null | grep ":$port " | awk '{print $7}' | cut -d'/' -f1)
    if [ ! -z "$pid" ]; then
        echo "Clearing port $port (PID: $pid)"
        kill -9 $pid 2>/dev/null
        sleep 1  # Wait for port to be fully released
    else
        echo "Port $port is not in use"
    fi
}

echo "Stopping services..."

# Stop existing services using PID files
kill $(cat logs/backend.pid) 2>/dev/null
kill $(cat logs/webapp.pid) 2>/dev/null
kill $(cat logs/cms.pid) 2>/dev/null

# Clear specific ports
echo "Clearing ports..."
clear_port 5500  # Backend port
clear_port 3000  # Webapp port
clear_port 4000  # CMS port

# Clean up PID files
rm logs/*.pid 2>/dev/null
echo "All services stopped and ports cleared"
rm scripts/stop.sh
EOF

chmod +x scripts/stop.sh

echo -e "\n=== Management Commands ==="
echo "- View logs:"
echo "  tail -f logs/backend.log"
echo "  tail -f logs/webapp.log"
echo "  tail -f logs/cms.log"
echo -e "\n- Stop all services:"
echo "  ./scripts/stop.sh"