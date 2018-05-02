#!/bin/sh
### PACKAGE INSTALLATION ### 
pkg install nano git bash php72 nginx wget php72-session php72-filter php72-simplexml php72-curl php72-bcmath php72-bz2 php72-ftp php72-gd php72-imap php72-json php72-mysqli php72-mbstring php72-pdo php72-pdo_mysql php72-zlib php72-xml php72-sqlite3 php72-soap php72-openssl mysql80-client mysql80-server postfix-sasl awstats webalizer dovecot jailkit py27-fail2ban py27-certbot py27-certbot-nginx cyrus-sasl-saslauthd amavisd-new amavisd-milter clamav clamav-milter pure-ftpd bind912 postgrey



### DOVECOT CONFIGURATION ###
cp -R /usr/local/etc/dovecot/example-config/* \
                /usr/local/etc/dovecot
mkdir /usr/local/etc/ssl/certs

mkdir /usr/local/etc/ssl/private
mkdir /usr/local/libexec/dovecot/modules
mkdir /usr/local/libexec/dovecot/modules/lda

mkdir /usr/local/etc/pure-ftpd
mkdir /usr/local/etc/pure-ftpd/conf

openssl req -new -x509 -days 1000 -nodes -out "/usr/local/etc/postfix/smtpd.cert" -keyout "/usr/local/etc/postfix/smtpd.key"

openssl req -new -x509 -days 1000 -nodes -out "/usr/local/etc/ssl/certs/dovecot.pem" -keyout "/usr/local/etc/ssl/private/dovecot.pem"

rndc-confgen -a

#### NGINX CONFIGURATION ###
mkdir /usr/local/etc/nginx/sites-available
mkdir /usr/local/etc/nginx/sites-enabled
sed '$ s/.$//' /usr/local/etc/nginx/nginx.conf >>nginx
echo '     include /usr/local/etc/nginx/conf.d/*.conf;' >> nginx
echo '     include /usr/local/etc/nginx/sites-enabled/*;' >> nginx
echo '}' >> nginx
mv nginx /usr/local/etc/nginx/nginx.conf
###PHP-FPM CONFIG ###
sed 's/listen /;listen /g' /usr/local/etc/php-fpm.d/www.conf >> ww.conf
echo 'listen = /var/run/php5-fpm.sock' >> ww.conf
mv ww.conf /usr/local/etc/php-fpm.d/www.conf


### SERVICE CONFIGURATION ###
sysrc named_enable="YES"
sysrc postfix_enable="YES"
sysrc sendmail_enable="NONE"
sysrc mysql_enable="YES"
sysrc nginx_enable="YES"
sysrc php_fpm_enable="YES"
sysrc dovecot_enable="YES"
sysrc fail2ban_enable="YES"
sysrc saslauthd_enable="YES"
sysrc amavisd_enable="YES"
sysrc amavis_milter_enable="YES"
sysrc pureftpd_enable="YES"
sysrc clamav_clamd_enable="YES"

service amavisd start
service saslauthd start
service fail2ban start
service postfix start
service nginx start
service mysql-server start
service php-fpm start
service dovecot start

### MAIL CONFIGURATION ###
mv /usr/local/etc/mail/mailer.conf /usr/local/etc/mail/mailer.conf.old
install -m 0644 /usr/local/share/postfix/mailer.conf.postfix /usr/local/etc/mail/mailer.conf

### PHP CONFIGURATION ###
mkdir /var/www
mv /usr/local/etc/php.ini-production /usr/local/etc/php.ini
ln -s /usr/local/bin/php /usr/bin/php

### SYSTEM CONFIGURATION ###
ln -s /etc/master.passwd /etc/passwd
ln -s /usr/local/bin/bash /bin/bash

### POST INSTALL COMMANDS ###
mkdir /usr/local/etc/amavis

### INSTALL ISPCONFIG ###
git clone https://git.ispconfig.org/mra/ispconfig3.git
cd ispc*
cd install
php -q install.php





chmod g=rx /usr/local/ispconfig/interface/lib/config.inc.php
chmod go=rx /usr/local/ispconfig/interface/lib/app.inc.php
chown ispconfig:ispconfig /usr/local/ispconfig/interface/lib/classes/db_mysql.inc.php
chmod g=rx /usr/local/ispconfig/interface/lib/classes/db_mysql.inc.php
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/stylesheets/*
chmod o=rx /usr/local/ispconfig/interface/web/js/select2/*
chmod o=rx /usr/local/ispconfig/interface/web/js/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/javascripts/*
chmod o=rx /usr/local/ispconfig/interface/web
chmod o=rx /usr/local/ispconfig/interface/web/*
chmod o=rx /usr/local/ispconfig/interface
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/lib/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/lib/classes/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/lib/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/lib/classes/IDS
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/web/themes/default/assets/javascripts
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/*/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/*/*/*
chown -R ispconfig:ispconfig /usr/local/ispconfig/interface/*/*/*/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/stylesheets/themes/default/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/stylesheets/themes/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/stylesheets/*
chmod o=rx /usr/local/ispconfig/interface/web/themes/default/assets/fonts/*
service nginx restart
service mysql-server restart
service php-fpm restart

