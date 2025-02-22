#!/bin/bash

# Define container names
CONTAINERS=("ollama" "open-WebUI" "chromadb")

# Function to start containers
start_containers() {
    echo "Starting Ollama and Open WebUI..."
    docker compose up -d
    echo "Containers started successfully!"
}

# Function to stop containers
stop_containers() {
    echo "Stopping Ollama and Open WebUI..."
    docker stop "${CONTAINERS[@]}"
    echo "Containers stopped!"
}

# Function to restart containers
restart_containers() {
    stop_containers
    start_containers
}

# Check user input
case "$1" in
    start)
        start_containers
        ;;
    stop)
        stop_containers
        ;;
    restart)
        restart_containers
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

