pipeline {
    agent none

    stages {
        stage('Install Dependencies') {
            agent {
                docker {
                    image 'node:16'
                }
            }
            steps {
                sh 'npm ci'
            }
        }

        stage('Unit Tests') {
            agent {
                docker {
                    image 'node:16'
                }
            }
            steps {
                sh 'npm test'
            }
        }

        stage('Dependency Security Scan') {
            agent {
                docker {
                    image 'node:16'
                }
            }
            steps {
                sh 'npm audit --audit-level=high'
            }
        }

        stage('Build Docker Image') {
            agent any
            steps {
                sh 'docker build -t mazharulhoque/aws-elastic-beanstalk-express-js-sample:${BUILD_NUMBER} .'
            }
        }

        stage('Push Docker Image') {
            agent any
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push mazharulhoque/aws-elastic-beanstalk-express-js-sample:${BUILD_NUMBER}
                        docker tag mazharulhoque/aws-elastic-beanstalk-express-js-sample:${BUILD_NUMBER} mazharulhoque/aws-elastic-beanstalk-express-js-sample:latest
                        docker push mazharulhoque/aws-elastic-beanstalk-express-js-sample:latest
                        docker logout
                    '''
                }
            }
        }
    }
}
