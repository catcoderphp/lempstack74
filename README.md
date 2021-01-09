# catcoder/lempstack74
A Docker image to NGINX PHP7.4 Mysql 5.8

# Requeriments

A docker installation. How to install [docker](https://docs.docker.com/install/ "Docker installation").

# usage
To get the image write the follow command

` docker pull catcoder/lempstack74 `

This install the image on your Docker installation

# Create a container

Once you have pulled the image, to create a container run the follow command:

` docker run -p 8081:80 --name lempstack72Container catcoder/lempstack74 `

This will run a server on your [Localhost](http://localhost:8081 "Docker installation").

# Networking
This section provides an overview of Docker’s default networking behavior, including the type of networks created by default and how to create your own user-defined networks. It also describes the resources required to create networks on a single host or across a cluster of hosts.

# Creating a virtual network

` docker network create --driver=bridge --subnet=172.19.0.0/16 --ip-range=172.19.5.0/24 --gateway=172.19.5.254 myDockerNetwork `

# Connecting with other services

Create a container associated to the new network

` docker run -tid --net myDockerNetwork --ip 172.19.0.1 -p 8082:80 -v $(pwd):/var/www/sites --name expressive catcoder/lempstack74 `

# Redis
Pull the [Redis image](https://hub.docker.com/_/redis "Docker installation") and see the details to create a container.

Create a new redis container associated to the new network

` docker run --net myDockerNetwork --ip 172.19.0.2 --name some-redis -d redis `

Now you can listen redis from your first container (expressive)

Check the example on this [repository](https://github.com/catcoderphp/expressive-example/blob/master/src/App/Services/RedisConnector.php "Docker installation")

# MongoDB
MongoDB connector support!!

Just install mongodb image from dockerhub

` docker run --net myDockerNetwork --ip 172.19.0.3 --name mongo_server -d mongo `