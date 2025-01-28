
pipeline {
  agent any
	
  stages {

    stage('Build Artifact - Maven') {
      steps {
        sh "mvn clean package -DskipTests=true"
        archiveArtifacts 'target/*.jar'
      }
    }
    stage('Unit Tests') {
      steps {
        sh "mvn test"
      }
      post {
	   always {
    	    junit 'target/surefire-reports/*.xml'		   
	    jacoco execPattern: 'target/jacoco.exec'
	   }   
      }
  }
     stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build("ibrt2021/numeric-app:${env.$GIT_COMMIT}")
                }
            }
        }
    stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub') {
                        dockerImage.push()
                    }
                }
            }
        }
}
}
