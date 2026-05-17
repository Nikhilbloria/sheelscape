pipeline {
    agent any

    stages {
        stage('Clone Code') {
            steps {
                echo 'Cloning latest code from GitHub...'
                git branch: 'main', url: 'https://github.com/Nikhilbloria/sheelscape.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t shellscape:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                echo 'Stopping old container...'
                sh 'docker stop shellscape-container || true'
            }
        }

        stage('Remove Old Container') {
            steps {
                echo 'Removing old container...'
                sh 'docker rm shellscape-container || true'
            }
        }

        stage('Run New Container') {
            steps {
                echo 'Starting new container...'
                sh 'docker run -d -p 80:80 --name shellscape-container shellscape:latest'
            }
        }
    }
}