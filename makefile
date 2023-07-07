#!/usr/bin/make
SHELL = /bin/bash

UID := $(id -u)
GID := $(id -g)

export UID
export GID

.PHONY: up down test reload clean help
.DEFAULT_GOAL := help

build: ## Re build XNAT
	docker compose build

up: ## Start xnat stack
	docker compose up -d xnat-web xnat-db xnat-nginx

down: ## Terminate xnat stack containers (xnat, db, nginx)
	docker compose down

reload: ## Restart xnat container to reload the plugins
	docker restart $$(docker ps | grep "web" | awk '{ print $$1 }')

test: ## Run robot framework test suits
	docker compose down && make clean && docker compose -f docker-compose-robot.yml up --build --abort-on-container-exit

clean: ## Clean robot framework reports
	rm -f reports/*

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'