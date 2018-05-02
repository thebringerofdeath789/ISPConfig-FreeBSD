# ISPConfig - Hosting Control Panel for FreeBSD 11.1-RELEASE

- Manage multiple servers from one control panel
- Easy Installation using 'sh freebsd_install.sh'
- Web server management (nginx)
- Mail server management (with virtual mail users)
- DNS server management (BIND)
- Administrator, reseller and client login
- Configuration mirroring and clusters
- Open Source software (BSD license)

# Installation instructions
- In your FreeBSD shell, as root, type 'pkg install git' and install git
- When the repo is downloaded, type 'cd ISPConfig-FreeBSD' and 'sh freebsd_installer.sh'
- The installer script will install all necessary packages for you
- The admin user/password will be admin:admin at http(s)://yourip:8080

#Release Notes

- This will set up Nginx, PHP 7.2/PHP-FPM, Mysql 8, Postfix, Dovecot, Pure-Ftpd, Phpmyadmin, Mailman
- This does not support Apache2 or installation on a Linux System. Some normal functionality is missing such as quota's, firewall configuration and containers
