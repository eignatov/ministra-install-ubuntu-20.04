#!/usr/bin/env bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
echo ""

if [ -z "$1" ];
then
  echo "You have not specified a password for MySQL..."
  echo ""
  exit 0
fi

# Create Docker Network.
echo "Creating Docker Network..."
docker network create --driver bridge whmcs-net > /dev/null 2>&1

# Create MySQL Storage Volume.
echo "Creating MySQL Storage Volume..."
docker volume create mysql-server > /dev/null 2>&1

# Start MySQL Container
echo "Starting MySQL Container..."
docker run \
--name mysql-server \
-v mysql-server:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=$1 \
--network whmcs-net -p 3306:3306 \
-hmysql-server \
-d mysql:8 > /dev/null 2>&1

# Creating Whmcs Storage Volumes.
echo "Creating Whmcs Storage Volumes..."
docker volume create whmcs-downloads > /dev/null 2>&1
docker volume create whmcs-templates > /dev/null 2>&1
docker volume create whmcs-attachments > /dev/null 2>&1

# Start Whmcs Container
echo "Starting Whmcs Container..."
docker run -itd \
--name whmcs -p 80:80 \
-v whmcs-downloads:/var/www/downloads \
-v whmcs-templates:/var/www/templates_c \
-v whmcs-attachments:/var/www/attachments \
--network whmcs-net scriptingonline/whmcs:8.3.0 > /dev/null 2>&1

echo "Waiting 15 Seconds for MySQL to Start..."
sleep 15

echo "Setting up Whmcs Database..."
# Set Up Whmcs Database
docker exec -i mysql-server /usr/bin/mysql -u root -p$1 -e "CREATE DATABASE whmcs;" > /dev/null 2>&1
docker exec -i mysql-server /usr/bin/mysql -u root -p$1 -e "FLUSH PRIVILEGES;" > /dev/null 2>&1

echo ""
echo "############################################################################################"
echo ""
echo "Navigate to ${GREEN}http://localhost/install/install.php${NC} to continue the installation"
echo ""
echo "Enter the following when prompted."
echo ""
echo "Database Host: ${GREEN}mysql-server${NC}"
echo "Database Port: ${GREEN}3306${NC}"
echo "Database Username: ${GREEN}root${NC}"
echo "Database Password: ${GREEN}"$1"${NC}"
echo "Database Name: ${GREEN}whmcs${NC}"
echo ""
echo "############################################################################################"
echo ""
echo -n "When you get to the screen that says ${RED}Installation Completed Sucessfully!.${NC} Press ${GREEN}[Enter]${NC} to Continue..."
read var_name
echo ""
echo "############################################################################################"
echo ""
echo "Securing Installation."
docker exec -it whmcs sh /secure.sh
echo ""
echo "############################################################################################"
echo ""
echo "${GREEN}Finished!${NC}"
echo ""
echo "Navigate to ${GREEN}http://localhost/admin${NC} to login."
echo ""
echo "After login you can create 3 new Local Storage Directories as follows:"
echo "1: /var/www/downloads"
echo "2: /var/www/attachments"
echo "3: /var/www/attachments/projects"
echo ""
echo "Once you have done this be sure to change paths in Storage Settings to match your new ones above."
echo ""
echo "crons directory has been moved to /var/www/crons"
echo "templates_c directory has been moved to /var/www/templates_c"
echo "set update folder to /var/www/updates in Updater Configuration"
echo ""
echo "All data in Attachments, Downloads & Templates_C is persistent along with mysql data"
echo ""
echo "Enjoy!"
echo ""
echo "############################################################################################"
