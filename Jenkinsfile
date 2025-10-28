pipeline {
    agent any

    environment {
        IMAGE_NAME = "sagargiragani/java-webapp-demo"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "🔹 Cloning repository..."
                git branch: 'master', url: 'https://github.com/sagargiragani45/java-webapp-demo.git'
            }
        }

        stage('Build WAR') {
            steps {
                echo "🔹 Building Maven project..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🔹 Building Docker image..."
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "🔹 Pushing Docker image..."
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker push $IMAGE_NAME:$BUILD_NUMBER
                docker push $IMAGE_NAME:latest
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                echo "🚀 Deploying container on port 9090..."
                sh '''
                docker stop java-webapp-demo || true
                docker rm java-webapp-demo || true
                docker run -d -p 9091:8080 --name java-webapp-demo $IMAGE_NAME:latest
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Access app at: http://<your-ip>:9090/java-webapp-demo/"
        }
        failure {
            echo "❌ Pipeline failed. Check Jenkins logs."
        }
    }
}

