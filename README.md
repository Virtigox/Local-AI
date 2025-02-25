Localizing open-sources AI models using ollma and Open-WebUI running on docker.

# Manage Containers on Dockers `manage_containers.sh`
> The provided shell script is designed to manage Docker containers named "ollama", "open-WebUI", and "chromadb". Here's a step-by-step explanation of how the script works:

- Container Definitions: The script starts by defining an array of container names (CONTAINERS), which include "ollama", "open-WebUI", and "chromadb".
- Starting Containers: The start_containers function uses docker compose up -d, which starts all defined containers in detached mode (running them in the background).
- Stopping Containers: The stop_containers function stops all specified containers using docker stop.
- Restarting Containers: The restart_containers function first stops all containers and then restarts them, effectively cycling their state.
- Checking Container Status: The status_containers function displays the status of each container, including their names and ports, using docker ps --format.
- Accessing Container Shell: The shell_containers function allows access to a container's shell by first verifying that the provided container name is valid and then checking if it's running. If so, it executes either /bin/bash or sh in the container.
- Help Menu: The help_containers function provides usage information for all available commands, making it easy to understand how to interact with the script.
- Command Handling: The script processes user input through a series of cases:
    1. start: Starts all containers.
    2. stop: Stops all containers.
    3. restart: Restarts all containers by stopping and then starting them.
    4. status: Displays the current status of all containers.
    5. shell `<container_name>`: Grants access to the shell of a specified container, if valid and running.
    6. help: Displays help information.

**Example Usage**:

To start all containers:
```
bash
./script.sh start
```
To stop all containers:
```
bash
./script.sh stop
```
To restart all containers:
```
bash
./script.sh restart
```

To check container status:
```
bash
./script.sh status
```
To access a container's shell (e.g., "ollama"):
```
bash
./script.sh shell ollama
```

**Notes**:
>- Ensure Docker and Docker Compose are installed and properly configured.
>- The script assumes all containers are exposed without additional security measures, which may not be suitable for production environments.
>- If a container is not in the predefined list, accessing its shell will result in an error.