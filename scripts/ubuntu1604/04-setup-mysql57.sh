#!/bin/bash
# ******************************************
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# ******************************************
# MYSQL

#config_mysql_root_password=123456
sudo echo "mysql-server-5.7 mysql-server/root_password password $config_mysql_root_password" | sudo debconf-set-selections;
sudo echo "mysql-server-5.7 mysql-server/root_password_again password $config_mysql_root_password" | sudo debconf-set-selections;
sudo apt-get install -y mysql-server php-mysql;

# Change MySQL Listening IP Address from local 127.0.0.1 to All IPs 0.0.0.0
sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf;
# Update mysql Table root record to accept incoming remote connections
sudo mysql -uroot --password=$config_mysql_root_password -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;';
# Restart MySQL Service
sudo service mysql restart;

echo "04-setup-mysql57: Done!!!!!";
