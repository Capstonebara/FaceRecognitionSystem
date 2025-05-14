This repository contains the code for the Face Recognition System project.

## Cloning the Repository

To clone this repository along with its submodules, use the following command:

```bash
git clone --recursive https://github.com/Capstonebara/FaceRecognitionSystem.git
```

This command will clone the main repository and all its submodules, ensuring you have all the necessary code to run the project.

**Note:** If you have already cloned the repository without the `--recursive` option, you can update the submodules using the following command:

```bash
git submodule update --init --recursive
```

## Keeping Repository Updated

To update both the main repository and all submodules, use:

```bash
git pull --recurse-submodules
```

This will pull changes from all remote repositories and update all submodules.

## Environment Setup

Each component (backend, webapp, cms) requires its own environment configuration. Follow these steps:

### Backend Environment

1. Copy the example environment file:
```bash
cd backend
cp .env.example .env
```

2. Edit the `.env` file and update the following values:
```bash
# Authentication
VALID_USERNAME=your_username
VALID_PASSWORD=your_password

# JWT Settings
JWT_SECRET_KEY=your_jwt_secret
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

### Webapp Environment

1. Copy the example environment file:
```bash
cd webapp
cp .env.example .env
```

2. Edit the `.env` file with your configuration:
```bash
NEXT_PUBLIC_API_URL=http://localhost:5500
```

### CMS Environment

1. Copy the example environment file:
```bash
cd cms
cp .env.example .env
```

2. Edit the `.env` file with your configuration:
```bash
NEXT_PUBLIC_API_URL=http://localhost:5500
```

**Note:** Make sure to replace the placeholder values with your actual configuration. The `.env` files contain sensitive information and are already included in `.gitignore` to prevent them from being committed to the repository.

## Installation and Setup

The project includes several scripts in the `scripts` directory to help you set up and run the system:

### 1. Installation

Run the installation script to set up all dependencies:

```bash
./scripts/install.sh
```

This script will:
- Ask you to choose between CPU or CUDA version of PyTorch
- Install Python backend requirements
- Install webapp dependencies
- Install CMS dependencies

### 2. Building

Build all applications using:

```bash
./scripts/build.sh
```

This will create production builds for both the webapp and CMS.

### 3. Running the Services

Start all services using:

```bash
./scripts/main.sh
```

This will start:
- Backend server on http://localhost:5500
- Webapp on http://localhost:3000
- CMS on http://localhost:4000

You can access the API documentation at http://localhost:5500/docs

### Managing Services

- To view logs:
```bash
# Backend logs
tail -f logs/backend.log

# Webapp logs
tail -f logs/webapp.log

# CMS logs
tail -f logs/cms.log
```

- To stop all services:
```bash
./scripts/stop.sh
```

**Note:** Make sure all environment files are properly configured before running these scripts. See the Environment Setup section above for details.
