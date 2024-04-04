include .env

define find.functions
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
endef

test_env:
	@echo $(DOCKER_NAME)
	@echo $(DOCKER_TAG)

help:
	@echo 'The following commands can be used.'
	@echo ''
	$(call find.functions)

init: ## sets up environment
init:
	pip install poetry
	poetry init

install: ## Installs development requirements inside project folder
install:
	poetry config virtualenvs.in-project true
	poetry install --no-root

clean: ## Remove build, cache and .venv files
clean:
	rm -rf *.egg-info
	rm -rf build
	rm -rf dist
	rm -rf .pytest_cache
	rm -rf .venv
	# Remove all pycache
	find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

test: ## Run tests
test:
	pytest

build: ## Build docker image
build:
	docker build -t $(DOCKER_NAME):$(DOCKER_TAG) .

run: ## build, start and run docker image
run: build
	docker run -p 80:80 -it $(DOCKER_NAME):$(DOCKER_TAG)

compose: ## build, start and run docker image
compose: build
	docker-compose up --build

exec: ## build, start and exec into docker image
exec: start
	docker exec -it $(DOCKER_NAME) python

migration: ## Create migration
migration:
	docker compose exec app alembic upgrade head
