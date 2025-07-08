pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8.7'  // This tells Jenkins to use the Maven installation we configured
    }
    
    environment {
        PROJECT_NAME = 'devops-tomcat-app'
        CONTAINER_NAME = 'devops-app'
        PORT = '9090'
        TOMCAT_SERVER = '44.203.134.169'  // Replace with your actual Tomcat IP
        SSH_CREDENTIALS = 'tomcat-ssh-key'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '🚀 Starting DevOps Pipeline...'
                git branch: 'main', url: 'https://github.com/Deexxtteerr/devops-tomcat-dashboard.git'
            }
        }
        
        stage('Build') {
            steps {
                echo '🔨 Building application...'
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage('Docker Build') {
            steps {
                echo '🐳 Building Docker image...'
                sh 'docker build -t ${PROJECT_NAME} .'
            }
        }
        
        stage('Deploy to Tomcat Server') {
    steps {
        echo '🚀 Deploying to remote Tomcat server...'
        sshagent(credentials: [SSH_CREDENTIALS]) {
            sh '''
                # Copy files to Tomcat server with correct names
                scp -o StrictHostKeyChecking=no target/simple-app.war ubuntu@${TOMCAT_SERVER}:/opt/deployment/simple-app.war
                scp -o StrictHostKeyChecking=no Dockerfile ubuntu@${TOMCAT_SERVER}:/opt/deployment/
                
                # Deploy on remote server
                ssh -o StrictHostKeyChecking=no ubuntu@${TOMCAT_SERVER} "
                    cd /opt/deployment
                    # Create a modified Dockerfile for remote deployment
                    sed 's|target/simple-app.war|simple-app.war|g' Dockerfile > Dockerfile.remote
                    docker build -f Dockerfile.remote -t ${PROJECT_NAME} .
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d -p ${PORT}:8080 --name ${CONTAINER_NAME} ${PROJECT_NAME}
                "
            '''
        }
    }
}

        
        stage('Verify Deployment') {
            steps {
                echo '✅ Verifying deployment...'
                sh '''
                    sleep 30
                    curl -f http://${TOMCAT_SERVER}:${PORT}/devops-dashboard || exit 1
                '''
                echo '🎉 DevOps Dashboard is deployed!'
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully!'
            echo '🌐 Application URL: http://${TOMCAT_SERVER}:${PORT}/devops-dashboard'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
        always {
            echo '📋 Pipeline completed for DevOps project'
        }
    }
}
