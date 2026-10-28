#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Installing nextflow environment"
echo "======================================"

# -----------------------------------------------
# 1. Update system packages
# -----------------------------------------------

sudo apt-get update

#-----------------------------------------------
# 2. Install basic dependencies
#-----------------------------------------------

sudo apt-get install -y \
    git \
    curl \
    ca-certificates \
    openjdk-17-jre-headless \
    ocker.io

#-----------------------------------------------
# 3. Start Docker
#-----------------------------------------------

sudo systemctl enable docker
sudo systemctl start docker

# Allow current user to run Docker without sudo
sudo usermod -aG docker $USER

#-----------------------------------------------
# 4. Install Nextflow
#-----------------------------------------------

if ! command -v nextflow >/dev/null 2>&1; then
    echo "Installing Nextflow..."
    curl -fsSl https://get.nextflow.io | bash

    sudo mv nextflow /usr/local/bin/nextflow
    sudo chmod +x /usr/local/bin/nextflow

else
    echo "Nextflow is already installed."

fi

#-----------------------------------------------
# 5. Verify installation
#-----------------------------------------------

echo 
echo "Git version:"
git --version
echo
echo "Java version:"
java -version
echo
echo "Docker version:"
docker --version
echo
echo "Nextflow version:"
nextflow -v 
echo
echo "IMPORTANT:"
echo "Docker group permission may require a new login"
echo
echo "Run:"
echo "    newgrp docker"
echo
echo "or log out and log back in to apply the Docker group changes."
echo
echo "Then test docker by running:"
echo "    docker run hello-world"