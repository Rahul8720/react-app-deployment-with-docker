pipeline {
    agent any

    environment {
        AWS_REGION = "ap-southeast-2"
        ECR_REPO = "react-app-repo"
        ECR_URI = "864482618084.dkr.ecr.ap-southeast-2.amazonaws.com/react-app-repo"
        IMAGE_TAG = "latest"
        ECS_CLUSTER = "react-app"
        ECS_SERVICE = "Task_execution_role-service-fs3oqdor"
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
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .'
            }
        }

        stage('Tag Image') {
            steps {
                sh 'docker tag $ECR_REPO:$IMAGE_TAG $ECR_URI:$IMAGE_TAG'
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin $ECR_URI
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push $ECR_URI:$IMAGE_TAG'
            }
        }

        stage('Deploy to ECS') {
            steps {
                sh '''
                aws ecs update-service \
                    --cluster $ECS_CLUSTER \
                    --service $ECS_SERVICE \
                    --force-new-deployment \
                    --region $AWS_REGION
                '''
            }
        }
    }

    post {
        success {
            echo '🚀 ECS Deployment Successful'
        }
        failure {
            echo '❌ Deployment Failed'
        }
    }
}
