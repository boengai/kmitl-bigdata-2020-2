DOCKER_COMPOSE_FILE := -f resources/docker/docker-compose.yaml

up: down
	docker-compose ${DOCKER_COMPOSE_FILE} up 

up/db: down
	docker-compose ${DOCKER_COMPOSE_FILE} up rdbms

up/reset: down
	sudo rm -rf ./resources/docker/postgresql/data
	@make -s up

down:
	docker-compose ${DOCKER_COMPOSE_FILE} down --remove-orphans