#!/bin/bash
# ******************************************
# Program: LAMP, Git, Composer, phpmyadmin
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# Last Updated: 05-10-2016
# ******************************************

DBPASSWD=123456

echo "Begin install";
if [ "`lsb_release -is`" == "Ubuntu" ] || [ "`lsb_release -is`" == "Debian" ]
then
    sudo apt-get update;
    sudo apt-get upgrade -y;
    sudo apt-get autoremove;
	# Install CURL
	sudo apt-get install -y curl;
	# GIT
    sudo apt-get install -y git;
	
    # Install Apache
    sudo apt-get install -y apache2 apache2-utils;
	sudo a2enmod rewrite;
	sudo sed -i "s/export APACHE_RUN_USER=www-data$/export APACHE_RUN_USER=ubuntu/" /etc/apache2/envvars;
    sudo sed -i "s/export APACHE_RUN_GROUP=www-data$/export APACHE_RUN_GROUP=ubuntu/" /etc/apache2/envvars;
	
	# Install PHP7
	sudo apt-get install -y 
	# Install module of PHP7
	sudo apt-get install -y libapache2-mod-php php php-mcrypt php-curl php-intl php-mysql;
    sudo php5enmod mcrypt;    
    # /etc/apache2/mods-enabled/dir.conf
    sudo sed -i "s/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm$/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/" /etc/apache2/mods-enabled/dir.conf;
    
    # Update the /etc/php/7.0/apache2/php.ini file.
	sudo sed -i "s/post_max_size = 8M$/post_max_size = 1024M/" /etc/php/7.0/apache2/php.ini;
	sudo sed -i "s/upload_max_filesize = 2M$/upload_max_filesize = 1024M/" /etc/php/7.0/apache2/php.ini;
	sudo sed -i "s/;date\.timezone =$/date\.timezone = Asia\/Tokyo/" /etc/php/7.0/apache2/php.ini;
	sudo sed -i "s/; max_input_vars = 1000$/max_input_vars = 10000/" /etc/php/7.0/apache2/php.ini;
	sudo sed -i "s/session\.gc_maxlifetime = 1440$/session\.gc_maxlifetime = 56700/" /etc/php/7.0/apache2/php.ini;
    
    # MYSQL
    sudo echo "mysql-server-5.7 mysql-server/root_password password $DBPASSWD" | sudo debconf-set-selections;
    sudo echo "mysql-server-5.7 mysql-server/root_password_again password $DBPASSWD" | sudo debconf-set-selections;
	sudo apt-get install -y mysql-server;
	
	# Change MySQL Listening IP Address from local 127.0.0.1 to All IPs 0.0.0.0
	sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf;
	# Update mysql Table root record to accept incoming remote connections
	sudo mysql -uroot -p$DBPASSWD -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;';
	# Restart MySQL Service
	service mysql restart
    
    # PHPMYADMIN
	sudo echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections;
    sudo echo "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD" | sudo debconf-set-selections;
    sudo echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD" | sudo debconf-set-selections;
    sudo echo "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD" | sudo debconf-set-selections;
    sudo echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections;
    sudo apt-get install -y phpmyadmin;
    echo "Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf;    
	
	# Copy apache2 config
    sudo rm /etc/apache2/apache2.conf;
    sudo rm /etc/apache2/sites-available/papps.conf;    
    sudo cp /apache_config/apache2.conf /etc/apache2/apache2.conf;
    sudo cp /apache_config/papps.conf /etc/apache2/sites-available/papps.conf;    
    sudo a2ensite papps.conf;
    
    sudo systemctl restart apache2;    
elif [ "`lsb_release -is`" == "CentOS" ] || [ "`lsb_release -is`" == "RedHat" ]
then
    # TODO
    echo "CentOS - RedHat";
else
	echo "Unsupported Operating System";
fi

# Install Composer
EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q);
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');");
if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]
then
    php composer-setup.php --quiet;
    RESULT=$?;
    rm composer-setup.php;
    mv composer.phar /usr/local/bin/composer;
else
    >&2 echo 'ERROR: Invalid installer signature';
    rm composer-setup.php;
fi

# Symlink web directory into vagrant direcotry
if ! [ -L /var/www/html ]; then
    rm -rf /var/www/html
    ln -fs /vagrant /var/www/html
fi
    
echo "End install";
