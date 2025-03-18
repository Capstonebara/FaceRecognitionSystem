#!/bin/bash

# Function to display the menu and get user choice
select_torch_version() {
    echo "Which PyTorch version would you like to install?"
    echo "1) CPU Version"
    echo "2) CUDA Version"
    read -p "Enter your choice (1 or 2): " choice

    case $choice in
        1)
            echo "Installing PyTorch CPU version..."
            pip install torch==2.2.2 torchvision==0.17.2 --index-url https://download.pytorch.org/whl/cpu
            ;;
        2)
            echo "Installing PyTorch CUDA version..."
            pip install torch==2.2.2 torchvision==0.17.2
            ;;
        *)
            echo "Invalid choice. Please select 1 or 2."
            select_torch_version
            ;;
    esac
}

# Main installation process
echo "Starting installation process..."

# Step 1: PyTorch Installation
select_torch_version

# Step 2: Install backend requirements
echo "Installing backend requirements..."
pip install -r ../backend/requirements.txt

# Step 3: Install webapp dependencies
echo "Installing webapp dependencies..."
yarn --cwd ../webapp install

# Step 4: Install cms dependencies
echo "Installing cms dependencies..."
yarn --cwd ../cms install

echo "Installation completed!"