#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ENDCOLOR="\033[0m"

DOCKER_HUB_USER=franrobles8

################
# Server service
################

service_name=eoloplants_server
service_repo="${DOCKER_HUB_USER}/${service_name}"

echo -e "${GREEN}Building service image: [${service_name}]${ENDCOLOR}"
docker build -t $service_repo ./server && echo -e "Image built" || echo -e echo -e "${RED}Error trying to build image${ENDCOLOR}"

echo -e "${GREEN}Pushing image: [${service_repo}]${ENDCOLOR}"
docker push $service_repo && echo -e "Image pushed" || echo -e echo -e "${RED}Error trying to push image${ENDCOLOR}"

#################
# Weather service
#################

service_name=eoloplants_weatherservice
service_repo="${DOCKER_HUB_USER}/${service_name}"

echo -e "${GREEN}Building service image: [${service_name}]${ENDCOLOR}"
pack build ${DOCKER_HUB_USER}/${service_name} --path ./weatherservice --builder gcr.io/buildpacks/builder:v1 \
    && echo -e "Image built" || echo -e echo -e "${RED}Error trying to build image${ENDCOLOR}"

echo -e "${GREEN}Pushing image: [${service_repo}]${ENDCOLOR}"
docker push $service_repo && echo -e "Image pushed" || echo -e echo -e "${RED}Error trying to push image${ENDCOLOR}"

echo -e "${BLUE}Images have been generated and pushed to the docker registry${ENDCOLOR}"