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

        stage('Ensure HTML Exists') {
            steps {
                echo 'Creating html/index.html if it does not exist...'
                powershell '''
                    if (-Not (Test-Path "html")) {
                        New-Item -ItemType Directory -Path "html" | Out-Null
                    }
                    if (-Not (Test-Path "html/index.html")) {
                        @"
<!DOCTYPE html>
<html>
<head>
  <title>Initial Page</title>
</head>
<body>
  <h1>Hello from Jenkins!</h1>
</body>
</html>
"@ | Set-Content "html/index.html" -Encoding UTF8
                    }
                '''
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
