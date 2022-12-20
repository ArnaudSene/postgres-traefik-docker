#!/bin/bash
# ----------------------------------------------
# DEVOPS --
# Script to deploy a Traefik reverse proxy container
# with docker-compose
# ----------------------------------------------
# Required from .env
ENV_FILE=".env"
USERS_FILE="users_file"

if [ ! -f ${ENV_FILE} ]
then
    echo "${ENV_FILE} is missing!"
    exit 1
fi

if [ ! -f ${USERS_FILE} ]
then
    echo "${USERS_FILE} is missing!"
    exit 1
fi

# shellcheck disable=SC2046
export $(grep -v '^#' ${ENV_FILE} | xargs)

# Start Container
/usr/bin/docker compose up -d
