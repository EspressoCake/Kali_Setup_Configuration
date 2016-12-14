#!/bin/bash

apt-get update > /dev/null 2>&1
apt-get install docker-engine -y
docker pull chrysanthemum/jujukali
docker run -t -i chrysanthemum/jujukali /bin/bash
