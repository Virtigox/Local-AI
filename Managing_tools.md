## Overview

This script provides an easy way to manage Docker containers running Ollama, Open-WebUI, and ChromaDB. It allows users to start, stop, restart, check status, list, and access the shell of specific containers, and so on.

## Features

- Start Containers: Starts all specified containers using Docker Compose.

- Stop Containers: Gracefully stops all specified containers.

- Restart Containers: Stops and then restarts all specified containers.

- Check Status: Displays the status of all running containers.

- List Containers: Lists all containers, including stopped ones.

- Access Shell: Opens an interactive shell session inside a running container.

- Check Resource Utilization: Displaying the usage of system resources, including Nvidia GPU by the containers. 

- Update containers:  Updates containers and images with the latest available versions. Decision of updating will be prompted.

- Calculate VRAM/RAM : Calculate the GPU's VRAM or system's RAM requirement to run local LLMs models.

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

**Display usage of system resources**
```
./manage_containers.sh resources
```

**Update Containers**
```
./manage_containers.sh update
```

**Calculate VRAM/RAM**

User will prompted three value entries to calculate VRAM/RAM requirement.
```
./manage_containers.sh cal_ram
```
Example:
```
`LLAMA7b:FP16 with overhead 15%`
Enter the number of parameters (in billions): 7
Enter the precision (FP32=32, FP16=16, INT8=8, INT4=4): 16
Enter the overhead factor (1.15, 1.25, 1.30, 1.40): 1.15
🖥️ The system needs approximately **16.10 GB** of VRAM/RAM to run this model.
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
