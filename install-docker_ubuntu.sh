#!/bin/bash

echo "Updating your System..."
sudo apt-get update && sudo apt-get upgrade -y > /dev/null 2>&1
echo "Done."

#Remove any unofficale packages

echo "Removing any unoffical packages..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done > /dev/null 2>&1
echo "Done."

# UPDATE & UPGRADE

echo "Installing dependencies..."
sudo apt-get install ca-certificates curl gnupg > /dev/null 2>&1
echo "Done."

#ADD Docker Key

echo "Getting Docker Key..."
sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
echo "Done."

#SETUP REPOSITORY

echo "Setting up Docker repository..."
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Done."

# INSTALL DOCKER

echo "Installing Docker..."
sudo apt-get update 2>&1
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin > /dev/null 2>&1
sudo systemctl enable docker> /dev/null 2>&1
echo "Done."

# INSTALL DOCKER-COMPOSE

echo "Installing docker-compose..."
sudo apt-get install docker-compose-plugin > /dev/null 2>&1
echo "Done."

#VERIFY INSTALL

echo "Verifying Installation..."
sudo docker version > /dev/null 2>&1
echo "Done."

echo "########### INSTALLATION WAS SUCCESSFULL ###########"
echo "#                                                  #"
echo "# You can now fully use Docker and Docker-compose! #"
echo "#                                                  #"
echo "# To run a Container use:                          #"
echo "#                                                  #"
echo "# docker run [your_container-name]                 #"
echo "#                                                  #"
echo "####################################################"
