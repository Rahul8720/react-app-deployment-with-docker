#!/bin/bash

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker stop react-container || true
docker rm react-container || true

docker build -t react-app .

docker run -d --name react-container -p 555:80 reac-app

docker tag react-app rahul9786/react-app-1:latest

docker push rahul9786/react-app-1:latest
