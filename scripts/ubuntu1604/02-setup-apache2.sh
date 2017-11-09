#!/bin/bash
# ******************************************
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# ******************************************

# Install Apache
sudo apt-get install -y apache2 apache2-utils;
sudo a2enmod rewrite;
sudo sed -i "s/export APACHE_RUN_USER=www-data$/export APACHE_RUN_USER=ubuntu/" /etc/apache2/envvars;
sudo sed -i "s/export APACHE_RUN_GROUP=www-data$/export APACHE_RUN_GROUP=ubuntu/" /etc/apache2/envvars;
    
echo "02-setup-apache2: Done!!!!!";
