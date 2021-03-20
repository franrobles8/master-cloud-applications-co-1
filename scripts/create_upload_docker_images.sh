#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ENDCOLOR="\033[0m"

DOCKER_HUB_USER=franrobles8

################
# Server service
################

SERVER_SERVICE=eoloplants_server
SERVER_SERVICE_REPO="${DOCKER_HUB_USER}/${SERVER_SERVICE}"

echo -e "${GREEN}Building service image: [server]${ENDCOLOR}"
docker build -t $SERVER_SERVICE_REPO ./server

echo -e "${GREEN}Pushing image: [server]${ENDCOLOR}"
docker push $SERVER_SERVICE_REPO

if [ $? -ne 0 ]; then
    echo -e "${RED}Check that you have logged in to a docker repo. Try \"docker login\"${ENDCOLOR}"
    exit 1
fi

echo -e "${BLUE}Images have been generated and pushed to the docker registry${ENDCOLOR}"