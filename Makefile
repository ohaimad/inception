# Makefile for managing Docker Compose

# Variables
DOCKER_COMPOSE = docker-compose
COMPOSE_FILE = srcs/docker-compose.yml

# Default target: build and start the containers
up: 
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build

# Build the containers without starting them
build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

# Stop the containers
stop:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop

# Remove containers, networks, volumes, and images created by up
down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

# Full clean: run clean and remove all images and containers
fclean: 
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune -f
	docker rmi -f $(docker images -q)
	docker rm -f $(docker ps -aq)
