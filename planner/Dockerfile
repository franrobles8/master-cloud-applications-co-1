
###################################
# Base image for compile container
###################################
FROM maven:3.6.3-jdk-11 as builder

# Define working directory
WORKDIR /usr/app

# Copy application dependencies
COPY pom.xml /usr/app/

# Download application dependencies
RUN mvn clean verify

# Copy application code
COPY /src /usr/app/src

# Compile the project
RUN mvn package -DskipTests=true

######################################
# Base image for application container
######################################
FROM openjdk:11-jre-slim

# Define working directory for app container
WORKDIR /usr/app/

# Copy JAR from compilation container
COPY --from=builder /usr/app/target/*.jar /usr/app/

# Specify the exposed port for the container
EXPOSE 8081

# Executed command when doing 'docker run ...'
CMD [ "java", "-jar", "planner-0.0.1-SNAPSHOT.jar" ]


