DOCKER_COMPOSE = docker-compose
COMPOSE_FILE = srcs/docker-compose.yml

up: 
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build

build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

stop:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop

down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v

fclean: 
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune -f
	docker rmi -f $(shell docker images -aq)
	docker rm -f $(shell docker ps -aq)
