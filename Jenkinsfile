@Library('Shared_lib') _
pipeline {
   agent { label 'slave1' }
     // agent any
    tools {
        jdk 'JDK17'
        maven 'maven'
    }

        stage('Build') {
           steps {
                script {
                        build('install')  
                }
            }
        }
 stage('Run Application') {
            steps {
                  sh 'mvn spring-boot:run'
                  dir('/var/lib/jenkins/workspace/Parcel_service_feature-1/target') {
                   sh """
                     //   nohup java -jar simple-parcel-service-app-1.0-SNAPSHOT.jar > app.log 2>&1 &
                        //echo "Application started"
                   """
        }
    }
}

    }
}
