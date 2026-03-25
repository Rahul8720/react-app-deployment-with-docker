#!/bin/bash

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker stop deploy-project || true
docker rm deploy-project || true

docker build -t react-project .

docker run -d --name deploy-project -p 555:80 react-project

docker tag react-project rahul9786/react-project-1:latest

docker push rahul9786/react-project-1:latest
