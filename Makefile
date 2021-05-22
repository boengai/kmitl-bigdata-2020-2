include .env

RESOURCES_PATH := ./resources
DOCKER_PATH := ${RESOURCES_PATH}/docker
DOCKER_COMPOSE_FILE := -f ${DOCKER_PATH}/docker-compose.yaml --env-file ./.env
MONGO_PATH := ${DOCKER_PATH}/mongo
POSTGRES_PATH := ${DOCKER_PATH}/postgresql
PGADMIN_PATH := ${DOCKER_PATH}/pgadmin

up: down
	docker-compose ${DOCKER_COMPOSE_FILE} up 

up/db: down
	docker-compose ${DOCKER_COMPOSE_FILE} up nosql

up/reset: down
	sudo rm -rf ./resources/docker/postgresql/data
	sudo rm -rf ./resources/docker/mongodb/data

down:
	docker-compose ${DOCKER_COMPOSE_FILE} down --remove-orphans

logs:
	docker-compose ${DOCKER_COMPOSE_FILE} logs -f

exec/mongo:
	docker exec -it bigdata-nosql bash -c "\
		mongo -u ${MONGO_ROOT_USERNAME} -p ${MONGO_ROOT_PASSWORD} -- ${MONGO_DATABASE} \
	"

reset: down cleanup/persistence
	
cleanup/persistence:
	sudo rm -rf ${MONGO_PATH}/data/
	sudo rm -rf ${POSTGRES_PATH}/data/
	sudo rm -rf ${PGADMIN_PATH}/data/