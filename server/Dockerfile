#######################################
# Base image to compile the application
#######################################
FROM node:14.16.0-alpine3.12 as builder

# Define the working directory inside the container
WORKDIR /usr/app

# Copy dependencies file
COPY package.json /usr/app/

# Install app dependencies
RUN npm install --only=production

######################################
# Base image for application container
######################################
FROM node:14.16.0-alpine3.12

# Specify Env variable to execute dependencies in production mode
ENV NODE_ENV production

# Define the working directory
WORKDIR /usr/app

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

