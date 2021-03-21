#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ENDCOLOR="\033[0m"

DOCKER_HUB_USER=franrobles8

str_image_built() {
    echo -e "${GREEN}Image ${1} has been built${ENDCOLOR}"
}

str_image_pushed () {
    echo -e "${GREEN}Image ${1} has been pushed${ENDCOLOR}"
}

str_error_image_build () {
    echo -e "${RED}Error trying to build image ${1}${ENDCOLOR}"
}

str_error_image_push () {
    echo -e "${RED}Error trying to push image ${1}${ENDCOLOR}"
}

build_and_push_server () {

    service_name=eoloplants_server
    service_repo="${DOCKER_HUB_USER}/${service_name}"

    echo -e "${GREEN}Building service image: [${service_name}]${ENDCOLOR}"
    docker build -t $service_repo ./server && str_image_built $service_repo || str_error_image_build $service_repo

    echo -e "${GREEN}Pushing image: [${service_repo}]${ENDCOLOR}"
    docker push $service_repo && str_image_pushed $service_repo || str_error_image_push $service_repo

}

build_and_push_weatherservice () {

    # Image generated using Buildpacks

    service_name=eoloplants_weatherservice
    service_repo="${DOCKER_HUB_USER}/${service_name}"

    echo -e "${GREEN}Building service image: [${service_name}]${ENDCOLOR}"
    pack build ${DOCKER_HUB_USER}/${service_name} --path ./weatherservice --builder gcr.io/buildpacks/builder:v1 \
        && str_image_built $service_repo || str_error_image_build $service_repo

    echo -e "${GREEN}Pushing image: [${service_repo}]${ENDCOLOR}"
    docker push $service_repo && str_image_pushed $service_repo || str_error_image_push $service_repo

}

build_and_push_planner () {

    # Image generated with cached maven dependencies

    service_name=eoloplants_planner
    service_repo="${DOCKER_HUB_USER}/${service_name}"

    echo -e "${GREEN}Building service image: [${service_name}]${ENDCOLOR}"
    docker build -t $service_repo ./planner && str_image_built $service_repo || str_error_image_build $service_repo

    echo -e "${GREEN}Pushing image: [${service_repo}]${ENDCOLOR}"
    docker push $service_repo && str_image_pushed $service_repo || str_error_image_push $service_repo

}

echo -e "${GREEN}Starting building and pushing images...${ENDCOLOR}"

build_and_push_server
build_and_push_weatherservice
build_and_push_planner

echo -e "${BLUE}Images have been generated and pushed to the docker registry${ENDCOLOR}"