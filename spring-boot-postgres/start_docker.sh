#!/bin/bash

# Check if docker-compose is running and if so, shut it down
if [ "$(docker-compose ps -q)" != "" ]; then
    echo "Docker Compose is running. Shutting it down..."
    docker-compose down
fi

# Check if .env file exists and if not, run the create_passwords script
if [ ! -f .env ]; then
    echo ".env file not found. Creating passwords..."
    bash create_passwords.sh
fi

# Source the .env file to load the environment variables
set -a
source .env
set +a


# Start docker-compose in detached mode
echo "Starting Docker Compose in detached mode..."
docker-compose up -d
