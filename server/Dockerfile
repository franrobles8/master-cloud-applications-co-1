#######################################
# Base image to compile the application
#######################################
FROM node:lts-alpine as builder

# Define the working directory inside the container
WORKDIR /usr/app

# Copy dependencies file
COPY package.json /usr/app/

# Install app dependencies
RUN npm install --only=production

######################################
# Base image for application container
######################################
FROM node:lts

# Specify Env variable to execute dependencies in production mode
ENV NODE_ENV production

# Define the working directory
WORKDIR /usr/app

# Download the script wait-for-it.sh
RUN curl -LJO https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && chmod +x /usr/app/wait-for-it.sh

# Copy node_modules with all the installed dependencies from the compilation image
COPY --from=builder /usr/app/node_modules /usr/app/node_modules

# Copy application files
COPY package.json /usr/app
COPY /config /usr/app/config
COPY /public /usr/app/public
COPY /src /usr/app/src

# Expose port container
EXPOSE 3000

# Run the app inside the container
CMD ["node", "src/server.js"]

