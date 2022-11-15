pipeline {
  agent any
  environment {
        CREDENTIALS_ID ='gcp-2022-1-phase2-Mikhalskyi'
        BUCKET = credentials('GCP_BUCKET_NAME')
        PATTERN = 'target/*.jar'
  }
  stages {
    stage('Build') {
      steps {
        script {
            git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
	        echo "Build the app..."
            sh "sudo ./mvnw package"
        }
      }
    }

    stage('Test') {
      steps {
        script {
          echo "Executing some tests..."
        }
      }
    }

    stage('Upload artifact to GCS') {
      steps {
        script {
          echo "Uploading..."
          step([$class: 'ClassicUploadStep', credentialsId: env.CREDENTIALS_ID,  bucket: "gs://${env.BUCKET}/jenkins-petclinic", pattern: env.PATTERN])
        }
      }
    }

    stage('Provision prod server') {
      steps {
        script {
          dir("${env.WORKSPACE}/terraform") {
            sh "pwd"
            sh "terraform init" 
            sh "terraform apply -auto-approve"
          }
        }
      }
    }

      stage('Clean workspace') {
        steps {
          script {
            cleanWs()
          }
        }
      }
    }
  }

