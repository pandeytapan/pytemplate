# Enable execution of all commands in a single shell for each recipe.
.ONESHELL:

ENV_PREFIX=$(shell python3 -c "if __import__('pathlib').Path('.venv/bin/pip').exists(): print('.venv/bin/')")
@echo "ENV_PREFIX: $(ENV_PREFIX)"
#Variables

# Define the virtual environment name.
VENV_NAME := .venv

# Specify the python and the pip binaries.
PYTHON := $(ENV_PREFIX)python3
PIP := $(ENV_PREFIX)pip

# Declare the targets that will not produce the files.
.PHONY: help virtualenv show-venv install

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Target for creating the virtual environment.
virtualenv: ## Create a virtual environment and install dependencies.
	@echo "Creating virtualenv ..."
	@rm -rf $(VENV_NAME)
	@$(PYTHON) -m venv $(VENV_NAME)
	@$(PIP) install -U pip
	@echo "Virtual environment created."
	@make install

# Target for installing dependencies from requirements-base.txt.
install: ## Install base dependencies into the virtual environment.
	@echo "$(ENV_PREFIX)"
	@echo "Installing dependencies ..."
	@$(PIP) install -r requirements.txt
	@echo "Dependencies installed."
	@echo "!!!Activate the virtual environment by running: source $(VENV_NAME)/bin/activate"

# Target for showing the virtual environment.
show-venv: ## Show the virtual environment.
	@echo "Virtual environment: $(VENV_NAME)"
	@echo "Running using $(PYTHON) ..."
	@echo "Python Version" && $(PYTHON) --version
	@$(PYTHON) -m site
