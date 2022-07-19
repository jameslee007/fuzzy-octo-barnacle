#!/usr/bin/env bash


## Install the dependencies
poetry install

## Run the service
pushd data-ops;

### Install the Meltano dependencies
poetry run meltano install

### Run the scheduler
poetry run meltano invoke airflow scheduler

### Run the Webserver
poetry run meltano invoke webserver