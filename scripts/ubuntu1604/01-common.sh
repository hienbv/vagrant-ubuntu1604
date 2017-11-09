#!/bin/bash
# ******************************************
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# ******************************************

# Install CURL
sudo apt-get install -y curl;

# Install GIT
sudo apt-get install -y git;    

# Install Composer
sudo wget https://getcomposer.org/composer.phar
sudo mv composer.phar /usr/local/bin/composer;

echo "01-common.sh: Done!!!!!";
