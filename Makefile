.DEFAULT_GOAL := help

help:
		@echo "Please use 'make <target>' where <target> is one of"
		@echo ""
		@echo "  setup       create python virtual environment"
		@echo "  lint        lint code"
		@echo "  test        run all the tests"
		@echo "  all         runs both lint and test commands"
		@echo ""
		@echo "Check the Makefile to know exactly what each target is doing."

setup:
	conda env create --file starter/environment.yml
	conda activate ml_census_fastapi

test:
	pytest -vv -p no:logging

lint:
	flake8

all: lint test
