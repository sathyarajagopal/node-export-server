## Install Docker

Docker is a platform that enables you to combine an app plus its configuration and dependencies into a single, independently deployable unit called a container.

### Download and Install

You'll be asked to register for Docker Store before you can download the installer.

By default, Docker will use Linux Containers on Windows. Leave this configuration settings as-is when prompted in the installer.

[Get Docker for Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

### Check that Docker is ready to use

Once you've installed, open a new command prompt and run the following command:

    docker --version

If the command runs, displaying some version information, then Docker is successfully installed.

## Add Docker metadata

To run with Docker Image you need a Dockerfile — a text file that contains instructions for how to build your app as a Docker image. A docker image contains everything needed to start an instance of your app.

### Return to app directory

Since you opened a new command prompt in the previous step, you'll need to return to the directory you created your project in.

    cd node-export-server

### Add a DockerFile

To create an empty Dockerfile, run the following command:

    echo . > Dockerfile

Please note that if you are using VS Code and you ran this command in VS Code terminal you may get parse error in line 1 of Dockerfile when building image. In that case press Ctrl+Shift+P to open Command palette in VS Code and then make use of Docker:Add Docker Files to Workspace command to generate Dockerfile from Visual Code.

Open the Dockerfile in the text editor of your choice and replace the contents with the following:

    FROM node:latest

    WORKDIR /

    RUN git clone  https://github.com/highcharts/node-export-server.git && \
        chown -R node /node-export-server

    WORKDIR /node-export-server

    USER node 

    ENV ACCEPT_HIGHCHARTS_LICENSE="YES"

    RUN rm package-lock.json && \
        npm install

    USER root	 
    RUN npm link --unsafe-perm

    USER node

    WORKDIR /node-export-server

    EXPOSE 7801
    ENTRYPOINT ["highcharts-export-server", "--enableServer", "1", "--logLevel", "4"]

## Switch to Linux containers

Right click on Docker Desktop whale icon in systems tray and select "Switch to Linux containers..." only if the whale is currently running in windows container.

## Create Docker image

Run the following command:

    docker build -t node-export-server .

The docker build command uses the information from your Dockerfile to build a Docker image.

The -t parameter tells it to tag (or name) the image as node-export-server.
The final parameter tells it which directory to find the Dockerfile in (. specifies the current directory).

You can run the following command to see a list of all images available on your machine, including the one you just created.

    docker image ls

## Run Docker image

A Docker container is an instance of your app, created from the definition and resources from your Docker image.

To run your app in a container, run the following command:

    docker run -it --rm -p 7801:80 node-export-server

Once the command completes, browse to http://localhost:7801/health.

Congratulations! You've successfully created a small, independent Highcharts node export server that can be deployed and scaled using Docker containers.

These are the fundamental building blocks to get a Node.js application into a Docker container.

## References

1. https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
2. https://buddy.works/guides/how-dockerize-node-application
3. https://github.com/ONSdigital/highcharts-export-docker/blob/master/README.md
4. https://github.com/nodejs/docker-node/blob/master/README.md#how-to-use-this-image
5. https://hub.docker.com/r/boostepargne/highcharts-node-export-server/dockerfile
6. https://github.com/highcharts/node-export-server
7. https://github.com/highcharts/highcharts-export-server
8. https://www.highcharts.com/forum/viewtopic.php?t=40349
9. https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md