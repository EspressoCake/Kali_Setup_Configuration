#!/bin/bash

docker kill $(docker ps -q)
docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -q)
