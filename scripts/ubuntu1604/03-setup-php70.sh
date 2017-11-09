#!/bin/bash
# ******************************************
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# ******************************************

# Install PHP7
sudo apt-get install -y; 
# Install module of PHP7
sudo apt-get install -y libapache2-mod-php php php-mcrypt php-curl php-intl;
sudo phpenmod mcrypt;    
# /etc/apache2/mods-enabled/dir.conf
sudo sed -i "s/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm$/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/" /etc/apache2/mods-enabled/dir.conf;

# Update the /etc/php/7.0/apache2/php.ini file.
sudo sed -i "s/post_max_size = 8M$/post_max_size = 1024M/" /etc/php/7.0/apache2/php.ini;
sudo sed -i "s/upload_max_filesize = 2M$/upload_max_filesize = 1024M/" /etc/php/7.0/apache2/php.ini;
sudo sed -i "s/;date\.timezone =$/date\.timezone = Asia\/Tokyo/" /etc/php/7.0/apache2/php.ini;
sudo sed -i "s/; max_input_vars = 1000$/max_input_vars = 10000/" /etc/php/7.0/apache2/php.ini;
sudo sed -i "s/session\.gc_maxlifetime = 1440$/session\.gc_maxlifetime = 56700/" /etc/php/7.0/apache2/php.ini;
    
echo "03-setup-php70: Done!!!!!";
