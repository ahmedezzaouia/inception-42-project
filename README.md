# Incpetion
 
## Description
This project consists of setting up a small infrastructure composed of different services under specific rules. The whole project has to be done in a virtual machine using Docker Compose. Each Docker image must have the same name as its corresponding service, and each service must run in a dedicated container. 

For performance reasons, the containers must be built either from the penultimate stable version of Alpine or Debian, and you have to write your own Dockerfiles, one per service. It is forbidden to pull ready-made Docker images, as well as using services such as DockerHub (Alpine/Debian being excluded from this rule).


## What is Docker?

Docker is a containerization platform that allows you to package and deploy an application in a self-contained environment. It solves the problem of "it works on my machine" by providing a consistent and portable environment for running applications. Docker allows you to create, run, and manage containers that encapsulate an application and its dependencies, making it easy to deploy and scale applications in any environment. 

## Why Docker?

- Provides a consistent and portable environment for running applications.
- Allows you to package an application and its dependencies into a single container.
- Makes it easy to deploy and scale applications in any environment.
- Reduces the risk of "it works on my machine" by providing a standardized environment for development, testing, and production.

The following services must be set up:
- A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
- A Docker container that contains WordPress + php-fpm only without NGINX.
- A Docker container that contains MariaDB only without NGINX.
- A volume that contains your WordPress database.
- A second volume that contains your WordPress website files.
- A Docker network that establishes the connection between your containers.

Your containers must restart in case of a crash.

## Diagram
![Diagram](https://raw.githubusercontent.com/izenynn/inception/main/diagram.png)

## Installation
1. Clone this repository
2. Create a `.env` file in the `srcs` directory and add the necessary environment variables
3. Build the Docker images and start the containers:
    ```
    make up
    ```
4. Access the WordPress website at `https://<your-login>.42.fr`

## Rules and Restrictions
- It is forbidden to use `network: host` or `--link` or `links:`.
- Containers must not be started with a command running an infinite loop.
- In the WordPress database, there must be two users, one of them being the administrator. The administrator’s username can’t contain `admin/Admin` or `administrator/Administrator`.
- Passwords must not be present in your Dockerfiles.
- Environment variables must be used and it is strongly recommended to use a `.env` file to store them.
- The NGINX container must be the only entry point into your infrastructure via port 443 only, using the TLSv1.2 or TLSv1.3 protocol.
- The latest tag is prohibited.

## Usage
- Start the containers:
    ```
    make up
    ```
- Stop the containers:
    ```
    make stop
    ```
- Remove the containers and volumes:
    ```
    make down
    ```
