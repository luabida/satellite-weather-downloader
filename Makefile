#
.ONESHELL:

include .env

ENV:=$(ENV)
SERVICES:=
SERVICE:=

DOCKER=docker-compose \
	--env-file .env \
	--project-name satellite \
	--file docker/compose.yaml \

CONSOLE:=bash

# Docker basic
# DOCKER
.PHONY:docker-build
docker-build:
	$(DOCKER) build downloader weather flower

.PHONY:docker-start
docker-start:
	$(DOCKER) up -d ${SERVICES}

.PHONY:docker-stop
docker-stop:
	$(DOCKER) stop ${SERVICES}

.PHONY:docker-exec
docker-exec:
	$(DOCKER) exec ${SERVICES} bash

.PHONY:docker-run
docker-run:
	$(DOCKER) run ${SERVICE} bash

.PHONY:docker-logs-follow
docker-logs-follow:
	$(DOCKER) logs --follow --tail 300 ${SERVICES}

.PHONY:docker-down
docker-down:
	$(DOCKER) down -v --remove-orphans

.PHONY: prepare-environment
prepare-environment:
	envsubst < env.tpl > .env
	echo "HOST_UID=`id -u`\nHOST_GID=`id -g`" >> .env

# Python
.PHONY: clean
clean: ## clean all artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	rm -fr .idea/
	rm -fr */.eggs
	rm -fr db
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -fr {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	find . -name '*.ipynb_checkpoints' -exec rm -rf {} +
	find . -name '*.pytest_cache' -exec rm -rf {} +
