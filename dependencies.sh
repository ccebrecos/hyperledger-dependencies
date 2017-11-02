#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Execute as root in order to install properly cURL, docker, docker-compose, node, npm and go language"
  exit
fi



echo "1. Update & Upgrade"
apt update && apt upgrade

# cURL
echo "Install cURL ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	apt install curl
	
	# Check
	echo "--> check for the installation"
	curl -V
fi

##--------------------- docker --------------------- ##
# Docker
echo "Install docker ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
	apt update	
	apt install -y docker-engine
	
	groupadd docker
	usermod -aG docker $USER
	echo "maybe a restart is required in order to use docker as a non-root user"
	
	# Check
	echo "--> check for the installation"
	docker --version
fi

##--------------------- docker-compose --------------------- ##
# Docker-compose
echo "Install docker-compose ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	
	# Check
	echo "--> check for the installation"
	docker-compose --version
fi

##--------------------- node.js --------------------- ##
# Node 6.9
echo "Install node ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
	apt-get install -y nodejs

	# Check	
	echo "--> check for the installation"
	node --version && npm --version
fi

##--------------------- golang --------------------- ##
# GO
echo "Install Go Language ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	curl -O https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
	tar -xvf go1.8.linux-amd64.tar.gz
	mv go /usr/local
	echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
	source ~/.profile
	
	# Check
	echo "--> check for the installation"
	go version
fi

##--------------------- Platform-specific Binaries --------------------- ##
# Platform-specific Binaries
echo "Install Platform-specific Binaries ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	curl -sSL https://goo.gl/fMh2s3 | bash
	
	# Check
	docker images

	echo "Add bin folder to the path? (y/n)"
	read ans
	if echo "$ans" | grep -iq "^y"; then
		export PATH=$PWD/bin:$PATH
	fi
fi

##--------------------- Template --------------------- ##
# Something
echo "Install something ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	echo "--> something installed"
	
	# Check
	
fi

##--------------------- Fabric-repo --------------------- ##
# Fabric repo
echo "Clone hyperledger-fabric respository ? (y/n)"
read ans

if echo "$ans" | grep -iq "^y"; then
	git clone https://github.com/hyperledger/fabric-samples.git	

fi

