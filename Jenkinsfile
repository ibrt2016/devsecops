
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
     stage('Docker Build and Push') {
      steps {
	withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
          sh 'printenv'
	  sh 'docker login --username $USERNAME --password $PASSWORD'
          sh 'sudo docker build -t ibrt2021/numeric-app:""$GIT_COMMIT"" .'
          sh 'sudo docker push ibrt2021/numeric-app:""$GIT_COMMIT""'
            }      
      
      }
    }
}
}
