#/bin/bash
apt-get update
apt-get upgrade

apt-get install apache2

apt-get install zip
wget https://fr.wordpress.org/latest-fr_FR.zip

unzip latest-fr_FR.zip
mv -v wordpress/ /var/www/

sed -i -e  "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/wordpress/g" /etc/apache2/sites-available/000-default.conf
service apache2 restart

chown -R www-data:www-data /var/www/wordpress/

apt-get install php
apt-get install php-mysql
service apache2 restart

apt-get install default-mysql-server

mysql -u root -p -e "CREATE DATABASE wordpress";
mysql -u root -p -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'Toto42'";
mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost'";
mysql -u root -p -e "FLUSH PRIVILEGES";

service apache2 restart
service apache2 status
