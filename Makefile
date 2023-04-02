# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ahmez-za <ahmez-za@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/25 18:56:36 by ahmez-za          #+#    #+#              #
#    Updated: 2022/09/27 21:49:09 by ahmez-za         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# Start the Docker containers defined in the docker-compose.yml file
all: 
	@docker-compose -f ./srcs/docker-compose.yml up

# Stop and remove the Docker containers defined in the docker-compose.yml file
down:
	@docker-compose -f ./srcs/docker-compose.yml down

# Rebuild and start the Docker containers defined in the docker-compose.yml file
re:
	@docker-compose -f srcs/docker-compose.yml up --build

# Stop and remove all running Docker containers, remove all Docker images, remove all Docker volumes, and remove all Docker networks
clean:
	@docker stop $$(docker ps -aq) || true
	@docker rm -f $$(docker ps -aq) || true
	@docker rmi -f $$(docker images -aq) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true


# Declare the all, re, down, and clean targets as phony targets to ensure they are always executed regardless of whether a file with the same name exists
.PHONY: all re down clean
