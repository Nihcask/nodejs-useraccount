pipeline {
    agent any
    environment {
        // Define environment variables for ECR and Kubernetes
        ECR_REGISTRY = '957955336045.dkr.ecr.ap-south-1.amazonaws.com/my-docker-repo'
        ECR_REPO = 'my-docker-repo'
        KUBE_NAMESPACE = 'your-kubernetes-namespace'
        KUBE_DEPLOYMENT = 'your-kubernetes-deployment'
        DOCKERFILE_PATH = 'path/to/Dockerfile'
    }
    
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    def dockerImage
                    
                    // Build the Docker image
                    dockerImage = docker.build("${ECR_REGISTRY}/${ECR_REPO}:latest", "-f ${DOCKERFILE_PATH} .")
                    
                    // Log in to ECR
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'your-ecr-credentials-id', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        docker.withRegistry("https://${ECR_REGISTRY}", 'ecr') {
                            // Push the Docker image to ECR
                            dockerImage.push()
                        }
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Install and configure Kubernetes CLI (kubectl) if needed
                // ...
                
                // Deploy the image to Kubernetes
                sh "kubectl apply -f path/to/kubernetes/manifests"
            }
        }
    }
}
