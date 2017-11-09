#!/bin/bash
# ******************************************
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# ******************************************

# PHPMYADMIN
sudo echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections;
sudo echo "phpmyadmin phpmyadmin/app-password-confirm password $config_mysql_root_password" | sudo debconf-set-selections;
sudo echo "phpmyadmin phpmyadmin/mysql/admin-pass password $config_mysql_root_password" | sudo debconf-set-selections;
sudo echo "phpmyadmin phpmyadmin/mysql/app-pass password $config_mysql_root_password" | sudo debconf-set-selections;
sudo echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections;
sudo apt-get install -y phpmyadmin;
    
echo "04-setup-phpmyadmin: Done!!!!!";
