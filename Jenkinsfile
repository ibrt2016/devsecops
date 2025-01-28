
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
        docker.withDockerRegistry('docker-hub',"") {
          sh 'printenv'
          sh 'sudo docker build -t ibrt2021/numeric-app:""$GIT_COMMIT"" .'
          sh 'sudo docker push ibrt2021/numeric-app:""$GIT_COMMIT""'
        }
      }
    }
}
}
