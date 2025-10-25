pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        IMAGE_NAME = "shivanijoshi38/pythonhelloworld"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Specify the correct branch
                git branch: 'main', url: 'https://github.com/assign-stone/python-hello-world-docker-jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Use DockerHub credentials to push
                    withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
}

