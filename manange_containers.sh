#!/bin/bash

# Define container names
CONTAINERS=("ollama" "open-WebUI" "chromadb")

# Function to start containers
start_containers() {
    echo "🚀 Starting Ollama and Open WebUI..."
    docker compose up -d
    echo "✅ Containers started successfully!"
}

# Function to stop containers
stop_containers() {
    echo "🛑 Stopping Ollama and Open WebUI..."
    docker stop "${CONTAINERS[@]}"
    echo "✅ Containers stopped!"
}

# Function to restart containers
restart_containers() {
    stop_containers
    start_containers
}

# Function to monitor containers' status
status_containers() {
   echo "📊 Checking Containers' Status.."
   docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# Function to access a container's shell
shell_containers() {
    local container_name="$1"  # Use second argument as container name
    
    # Debugging: Print out the detected argument
    echo "Received container name: '$container_name'"
    if [ -z "$container_name" ]; then
        echo "❌ Usage: $0 shell <container_name>"
        exit 1
    fi

    # Check if the container exists in the declared list
    local found=false
    for container in "${CONTAINERS[@]}"; do
        if [ "$container" == "$container_name" ]; then
            found=true
            break
        fi
    done
     
    if [ "$found" = false ]; then 
        echo "❌ Error: '$container_name' is not in the declared container list: ${CONTAINERS[*]}"
        exit 1
    fi

    # Check if the container is running
    if docker ps -a --format '{{.Names}}' | grep -wq "$container_name"; then
        echo "✅ Accessing shell of container '$container_name'..."
        docker exec -it "$container_name" /bin/bash || docker exec -it "$container_name" sh
    else
        echo "❌ Container '$container_name' not found or not running. Use 'list' to check."
    fi
}

help_containers() {
    echo "
Usage: $0 {start|stop|restart|status|shell <container_name>}

Commands:
  start         Start all containers (Ollama, Open WebUI, ChromaDB)
  stop          Stop all running containers
  restart       Restart all containers
  status        Show the status of all containers
  shell <name>  Access the shell of a running container (e.g., 'ollama')
"
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
    status)
	status_containers
	;;
    shell)
    shell_containers "$2"
    ;;
    help)
    help_containers
    ;;
    *)
        echo "❌ Usage: $0 {start|stop|restart|status|shell|help}"
        exit 1
        ;;
esac

