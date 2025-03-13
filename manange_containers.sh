#!/bin/bash

# Define container names
CONTAINERS=("ollama" "open-WebUI" "chromadb")

# Function to compose the docker config file
docker_build() {
    if command docker-compose &> /dev/null; then
        echo "🛠️  Building Docker images... "
        docker_compose build --no-cache
    else
        echo "❌ Error: docker-compose not found. Please install Docker Compose."
        exit 1
    fi
}

# Function to start containers
start_containers() {
    echo "🚀 Starting containers: ${CONTAINERS[*]}..."
    docker compose up -d
    echo "✅ Containers started successfully!"
}

# Function to stop containers
stop_containers() {
    echo "🛑 Stopping containers: ${CONTAINERS[*]}..."
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

# Fucntion to list the all the containers (running + stopped)
list_containers() {
    echo "☝️  Listing Containers..."
    docker ps -a  --format "table {{.Image}}\t{{.Names}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Ports}}"
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

check_resources_utilization() {
    echo "🔍 Checking the resources that have being used.."

    # Check utilization for containers
    docker stats --no-stream

    # Check NVIDIA GPU status if available
    if command -v nvidia-smi &> /dev/null; then
        echo -e "\✅ NVIDIA GPU Utilization:"
        nvidia-smi
    else
        echo -e "⚠️  No NVIDIA GPU detected or drivers not installed. "
    fi
}




# Function to check and update each image
# 1.  pull the $IMAGE, monitor:display the progess of pulling the image
# 2. Get the digest file, get the latest digest files, and compare with the current container image
# 3. If different, which means newer verion is released, prompt the user whether update to newer version or not.
# 4. Stop and Delete the old containers.
# 5. Loop all the containers in the docker.
# 6. Start the dockers with newer containers.

check_update() {
    local IMAGE=$1

    echo "🔍 Checking for updates for $IMAGE..."

    # Step 1: Capture existing image IDs before pulling the update
    OLD_IMAGE_IDS=$(docker images --format "{{.ID}} {{.Repository}}:{{.Tag}}" | grep "$IMAGE" | awk '{print $1}')

    # Step 2: Pull the latest image
    docker pull "$IMAGE"

    # Step 3: Get the latest image ID after the pull
    NEW_IMAGE_ID=$(docker images --format "{{.ID}} {{.Repository}}:{{.Tag}}" | grep "$IMAGE" | awk '{print $1}' | head -n 1)

    # Step 4: Get the currently running, and also stopped container ID (if any)
    CONTAINER_ID=$(docker ps -a -q --filter "ancestor=$IMAGE")

    # Step 5: Compare old and new image IDs
    if echo "$OLD_IMAGE_IDS" | grep -q "$NEW_IMAGE_ID"; then
        echo "✅ $IMAGE is already up to date."
    else
        echo "🚀 New version detected for $IMAGE."

        read -p "Would you like to update? (YES: y / NO: n): " RESPONSE

        if [[ "$RESPONSE" == "y" ]]; then
            echo "🔄 Updating $IMAGE..."

            # Step 6: Stop and remove the running container (if any)
            if [[ ! -z "$CONTAINER_ID" ]]; then
                echo "🛑 Stopping container $CONTAINER_ID..."
                docker stop "$CONTAINER_ID"
                docker rm "$CONTAINER_ID"
            fi

            # Step 7: Remove old images (excluding the new one)
            echo "🗑️ Removing old versions of $IMAGE..."
            echo "$OLD_IMAGE_IDS" | grep -v "$NEW_IMAGE_ID" | xargs -r docker rmi

            echo "✅ $IMAGE has been updated!"
        else
            echo "⏭️ Skipping update for $IMAGE."
        fi
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
  list          Listing containers including that had stopped.
  resources     Checking the resources that have being utilized by containers
  build         Building Docker Images(No Cache)
  update        Update container & image versions
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
    list)
        list_containers
    ;;
    resources)
        check_resources_utilization
    ;;
    update)
        # Define container images
        IMAGES=("ollama/ollama" "ghcr.io/open-webui/open-webui" "chromadb/chroma")
        for IMAGE in "${IMAGES[@]}"; do
            check_update "$IMAGE" # pass $IMAGE as an argument
        done
        # Restart with the new image (Modify if needed for your setup)
        echo "🚀 Restarting with the new image..."
        docker compose up -d --force-recreate    
    ;;
    help)
        help_containers
    ;;
    build)
        docker_build
    ;;
    *)
        echo "❌ Usage: $0 {start|stop|restart|status|shell|help|build|update}"
        exit 1
        ;;
esac

