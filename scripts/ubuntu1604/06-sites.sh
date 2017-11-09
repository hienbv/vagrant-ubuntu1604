#!/bin/bash
# ******************************************
# Developer: HienBV(Bui Van Hien)
# Email:hienbv.it@gmail.com
# Date: 08-11-2017
# ******************************************

index=1
while :; do
    app_name="config_site${index}_app_name"
    server_name="config_site${index}_server_name"
    port="config_site${index}_port"
    root_path="config_site${index}_root_path"

    # Empty is break
    if [ -z "${!app_name}" ]; then
        break
    fi
    
    block="<VirtualHost *:$port>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com
        ServerAdmin $app_name@localhost
        ServerName $server_name
        ServerAlias www.$server_name
        DocumentRoot $root_path
        <Directory $root_path>
            AllowOverride All
            Require all granted
        </Directory>
        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
        ErrorLog \${APACHE_LOG_DIR}/$app_name-error.log
        CustomLog \${APACHE_LOG_DIR}/$app_name-access.log combined
        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
    </VirtualHost>
    # vim: syntax=apache ts=4 sw=4 sts=4 sr noet
    "

    sudo echo "$block" > "/etc/apache2/sites-available/$app_name.conf"
    sudo ln -fs "/etc/apache2/sites-available/$app_name.conf" "/etc/apache2/sites-enabled/$app_name.conf"
    index=`expr $index + 1`
done

sudo service apache2 restart;    
echo "06-sites.sh: Done!!!!!";
