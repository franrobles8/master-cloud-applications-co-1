# EoloPlanner

## Needed

In order to create some of the images for the different services of this application, you will need to install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/).

## Deployment

To deploy the app, follow the next steps:

1. First, we need to create the images for the different services. We have prepared a script to create the images in different ways (Docker with cached dependencies, Buildpacks, etc). To generate the images and push them to a repository, you can edit the file `scripts/create_upload_docker_images.sh` and modify the variable `DOCKER_HUB_USER=example_user` with the one you have configured (using `docker login` command).

2. From the root folder, execute `./scripts/create_upload_docker_images.sh`. After all the process of generating and pushing the images has finished, you can check your docker registry to see that you have uploaded the images **eoloplants_toposervice**, **eoloplants_planner**, **eoloplants_weatherservice** and **eoloplants_server**.

3. In order to start the application, we need to run the containers with the images we pushed in the above steps. We can do that by running `docker-compose -f ./docker-compose-prod.yml up` from the root folder. It will take some seconds/minutes for the containers to be ready and well configured.

4. To play with the application, you can navigate to [http://localhost:3000](http://localhost:3000) and use some of the cities that are being shown to check that the different services are well connected and so, the progress bar is being updated for the cities.