# Ministra install on Ubuntu 20.04 LTS / 18.04 LTS
Ministra Portal auto install script on Ubuntu 20.04 LTS / 18.04 LTS
# +
# Ministra 5.6.1 - 5.6.8 Dockerized
[![Docker](https://raw.githubusercontent.com/sybdata/ministra-install-ubuntu-20.04/main/docker.svg)](https://docs.docker.com/get-docker)
Ministra 5.6.1 - 5.6.8 Dockerized, Deploy on any Distribution, Super easy to set up & No hassle. 
##### Runs Dockerized on
[![Ubuntu](https://raw.githubusercontent.com/sybdata/ministra-install-ubuntu-20.04/main/ubuntu.svg)](https://www.ubuntu.com)
[![Debian](https://raw.githubusercontent.com/sybdata/ministra-install-ubuntu-20.04/main/debian.svg)](https://www.debian.org/download)
[![Centos](https://raw.githubusercontent.com/sybdata/ministra-install-ubuntu-20.04/main/centos.svg)](https://www.centos.org/centos-linux)
[![Fedora](https://raw.githubusercontent.com/sybdata/ministra-install-ubuntu-20.04/main/fedora.svg)](https://getfedora.org/de/server/download)
```bash
cd ~/
wget -O deploy.sh https://raw.githubusercontent.com/sybdata/ministra-install-ubuntu-20.04/main/deploy.sh
chmod +X deploy.sh
sh ./deploy.sh somepassword version
```



[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/paypalme/sybdata)  You can make one-time donations via PayPal.

##### Runs auto install script on
[![Ubuntu](![debian-logo-1024x576](https://user-images.githubusercontent.com/24189833/147383181-cc95f80d-92dc-4afc-ad05-f7ee048b4ae0.png))](https://www.ubuntu.com)

This script work only on Clean Ubuntu 20.04 LTS / 18.04 LTS

Ministra auto install script
  * Version of Ministra 5.6.8

## Installation
```bash
apt-get install git
git clone https://github.com/sybdata/ministra-install-ubuntu-20.04.git
cd ministra-install-ubuntu-20.04/
```

Open ministra_install_ubuntu.20.04.sh with your favorite text editor and change on line 11
```bash
mysql_root_password="test123456"
```
This is the root password for MySQL that will be set during the installation, you can change it with yours if you wish.


And on line 10 change
```bash
TIME_ZONE="Europe/Amsterdam"
```
This is the time zone that will be set during the installation, you can change it with yours if you wish

The installation itself is as follows:
```bash
chmod +x ministra_install_ubuntu.20.04.sh
./ministra_install_ubuntu.20.04.sh
```
Accordingly, during the installation, when executing the last command, phing will ask you for the root password for MySQL, enter the password you set on line 11



You can access your stalker portal at: http://ipadres/stalker_portal The username and password to login to the portal are your default
```
Login: admin
pass: 1
```

Remove all test channels from the database through the terminal
```bash
mysql -u root -p stalker_db
truncate ch_links;
truncate itv;
```




[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/paypalme/sybdata)  You can make one-time donations via PayPal.
