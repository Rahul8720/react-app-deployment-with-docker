pipeline {
    agent any

    environment {
        IMAGE_NAME = "reactapp"
        CONTAINER_NAME = "reactapp"
        DOCKERHub_IMAGE = "rahul8720/reactapp"
    }

    stages {

        stage('Clone Code') {
            steps {
                git branch: 'master',
                url: 'https://github.com/Rahul8720/react-app-deployment-with-docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh 'docker tag $IMAGE_NAME $DOCKERHub_IMAGE:latest'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                sh 'docker push $DOCKERHub_IMAGE:latest'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                sh '''
                docker run -d \
                -p 80:3000 \
                --name $CONTAINER_NAME \
                $DOCKERHub_IMAGE:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'React App Deployed Successfully!'
        }

        failure {
            echo 'Deployment Failed!'
        }
    }
}
