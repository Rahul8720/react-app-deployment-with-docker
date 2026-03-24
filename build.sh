#!/bin/bash

docker login -u $DOCKER_USERNAME -p $DOCKER_PASS

docker stop deploy-project
docker rm deploy-project


docker build -t react-project .

docker run -itd --name deploy-project -p 555:80 react-project

docker tag react-project rahul9786/react-project-1

docker push rahul9786/react-project-1
