.DEFAULT_GOAL := help

help:
		@echo "Please use 'make <target>' where <target> is one of"
		@echo ""
		@echo "  setup       create python virtual environment"
		@echo "  install     install or update python virtual environment"
		@echo "  lint        lint code"
		@echo "  test        run all the tests"
		@echo "  dvc-repro   run dvc pull and repro commands"
		@echo "  training    train machine learning model"
		@echo "  run         start FastAPI application"
		@echo "  requests    run sample HTTP requests against FastAPI application"
		@echo "  all         runs both lint and test commands"
		@echo ""
		@echo "Check the Makefile to know exactly what each target is doing."

setup:
	conda env create --file starter/environment.yml
	conda activate ml_census_fastapi

install:
	conda env update --file starter/environment.yml --name ml_census_fastap

test:
	pytest -vv

lint:
	flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

dvc-repro:
	dvc pull
	dvc repro

training:
	python ./starter/starter/train_model.py

run:
	uvicorn starter.main:app --reload --workers 1 --host 0.0.0.0 --port 8000

requests:
	python api_requests.py

all: lint test
