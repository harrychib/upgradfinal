pipeline {
    agent any
    stages{
        stage('checkout'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/harrychib/upgradfinal.git']]])
            }
        }
        stage('build'){
            steps{
                sh 'docker build -t finalproject .'
                sh 'docker tag finalproject 216366843793.dkr.ecr.us-east-1.amazonaws.com/harryassignment:nodejs'
                
                script {
                    docker.withRegistry("https://216366843793.dkr.ecr.us-east-1.amazonaws.com", "ecr:us-east-1:awscred") { 
                    docker.image("216366843793.dkr.ecr.us-east-1.amazonaws.com/harryassignment:nodejs").push()
                    }
                }
            }
        }
        stage('deploy to app server'){
            steps{
                sshagent(credentials : ['app']){
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@10.0.2.98 docker run -itd -p 8080:8081 216366843793.dkr.ecr.us-east-1.amazonaws.com/harryassignment:nodejs'                
                }
            }
        }
    }
}
