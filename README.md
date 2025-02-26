Localizing open-sources AI models using ollma and Open-WebUI running on docker.

# Manage Docker Containers with `manage_containers.sh`

## Overview

This script provides an easy way to manage Docker containers running Ollama, Open-WebUI, and ChromaDB. It allows users to start, stop, restart, check status, list, and access the shell of specific containers.

## Features

- Start Containers: Starts all specified containers using Docker Compose.

- Stop Containers: Gracefully stops all specified containers.

- Restart Containers: Stops and then restarts all specified containers.

- Check Status: Displays the status of all running containers.

- List Containers: Lists all containers, including stopped ones.

- Access Shell: Opens an interactive shell session inside a running container.

- Help Menu: Provides a guide on how to use the script.

## Prerequisites

- Docker and Docker Compose must be installed and configured.

- Ensure that the necessary container images are available.

- Run the script from the directory containing the docker-compose.yml file.

## Installation

1. Clone or copy the script into your system.

2.  Make the script executable:
```
chmod +x manage_containers.sh
```

## Usage 

**Start Containers**

Starts **Ollama**, **Open-WebUI**, and **ChromaDB** in detached mode.
```
./manage_containers.sh start
```

**Stop Containers**

Stops the running containers gracefully.
```
./manage_containers.sh stop
```

**Restart Containers**

Restarts all specified containers.
```
./manage_containers.sh restart
```

**Check Container Status**

Displays the current status of running containers.
```
./manage_containers.sh status
```

**List All Containers (Including Stopped Ones)**
```
./manage_containers.sh list
```

**Access a Container's Shell**

Open an interactive shell in a running container.
```
./manage_containers.sh shell <container_name>
```
Example:
```
./manage_containers.sh shell ollama
```

**Help Menu**

Displays available commands and their usage.
```
./manage_containers.sh help
```

## Notes

- The script only manages Ollama, Open-WebUI, and ChromaDB containers.
- If a container is not in the predefined list, accessing its shell will result in an error.
- The script assumes all containers are properly defined in the `docker-compose.yml` file.


## Troubleshooting

**Containers are not starting?**
- Ensure Docker is running: systemctl status docker (Linux) or check Docker Desktop (Windows/Mac).
- Verify `docker-compose.yml` exists in the working directory.

**Cannot access a container's shell?**
- Ensure the container is running using `./manage_containers status`.
- Confirm the container name is correct.
