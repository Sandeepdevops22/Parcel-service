#!/bin/bash
set -e

echo "Starting Maven project setup..."

echo "=========================="
echo "Step 1: Install Java 17"
echo "=========================="

# Install Java 17 if not installed
if ! java -version &>/dev/null; then
    echo "Installing Java 17..."
    sudo apt update
    sudo apt install -y openjdk-17-jdk
else
    echo "Java is already installed:"
    java -version
fi

echo "=========================="
echo "Setting JAVA_HOME"
echo "=========================="

JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which java))))

if ! grep -q "JAVA_HOME=$JAVA_HOME_PATH" /etc/environment; then
    echo "Setting JAVA_HOME..."

    echo "JAVA_HOME=$JAVA_HOME_PATH" | sudo tee -a /etc/environment
    echo "export JAVA_HOME=$JAVA_HOME_PATH" | sudo tee -a /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile
    
    source /etc/profile
    echo "JAVA_HOME set to $JAVA_HOME_PATH"
else
    echo "JAVA_HOME is already set."
fi

echo "=========================="
echo "Step 2: Install Maven"
echo "=========================="

if ! mvn -version &>/dev/null; then
    echo "Installing Maven..."
    sudo apt install -y maven
else
    echo "Maven is already installed:"
    mvn -version
fi

echo "Environment setup completed!"

echo "=========================="
echo "To build manually:"
echo "mvn clean install"
echo
echo "To run manually:"
echo "mvn spring-boot:run"
echo "OR"
echo "java -jar target/simple-parcel-service-app-1.0-SNAPSHOT.jar"
echo "=========================="
