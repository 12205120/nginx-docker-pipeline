pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "dynamic-nginx"
        PROJECT_DIR = "${WORKSPACE}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling latest code from Git...'
                git url: 'https://github.com/12205120/nginx-docker-pipeline.git', branch: 'main'
            }
        }

        stage('Update Content') {
            steps {
                echo "Running update-content.ps1..."
                powershell '.\\update-content.ps1'
            }
        }

        stage('Backup Content') {
            steps {
                echo "Running backup.ps1..."
                powershell '.\\backup.ps1'
            }
        }

        stage('Rebuild and Restart Docker') {
            steps {
                echo "Rebuilding and restarting Docker container..."
                bat 'docker-compose down'
                bat 'docker-compose up --build -d'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Listing running containers..."
                bat 'docker ps'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment succeeded.'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}

