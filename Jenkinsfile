pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'feature-1',
                    url: 'https://github.com/Sandeepdevops22/Parcel-service.git'
            }
        }

        stage('Setup Environment') {
            steps {
                sh '''
                echo "Installing Java 17 & Maven..."

                # Install Java 17
                if ! java -version &>/dev/null; then
                    sudo apt update
                    sudo apt install -y openjdk-17-jdk
                fi

                # Set JAVA_HOME
                JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which java))))
                export JAVA_HOME=$JAVA_HOME_PATH
                export PATH=$JAVA_HOME/bin:$PATH

                # Install Maven
                if ! mvn -version &>/dev/null; then
                    sudo apt install -y maven
                fi

                echo "Java & Maven setup complete."
                java -version
                mvn -version
                '''
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Run Spring Boot App') {
            steps {
                sh '''
                echo "Starting Spring Boot app..."
                nohup mvn spring-boot:run &
                sleep 15
                '''
            }
        }

        stage('Validate Application') {
            steps {
                sh '''
                echo "Checking if application is running..."

                RESPONSE=$(curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:8080)

                if [ "$RESPONSE" -eq 200 ]; then
                    echo "Application started successfully..."
                else
                    echo "Application failed to start. HTTP Response Code: $RESPONSE"
                    exit 1
                fi
                '''
            }
        }

        stage('Wait for 5 Minutes') {
            steps {
                sh '''
                echo "Holding app live for 5 minutes..."
                sleep 300
                '''
            }
        }

        stage('Stop Spring Boot App') {
            steps {
                sh 'mvn spring-boot:stop'
            }
        }

    }
}
