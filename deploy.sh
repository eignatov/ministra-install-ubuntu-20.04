#!/usr/bin/env bash
GREEN='\033[0;32m'
NC='\033[0m'
echo ""

if [ -z "$1" ];
then
  echo "You have not specified a password for MySQL or required version..."
  echo ""
  exit 0
fi

# Create Docker Network.
echo "Creating Docker Network..."
docker network create --driver bridge ministra-net > /dev/null 2>&1

# Create MySQL Storage Volume.
echo "Creating MySQL Storage Volume..."
docker volume create mysql-server > /dev/null 2>&1

# Start MySQL Container
echo "Starting MySQL Container..."
docker run \
--name mysql-server \
-v mysql-server:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=$1 \
--network ministra-net -p 3306:3306 \
-hmysql-server \
-d mysql:5.7 --sql-mode="NO_ENGINE_SUBSTITUTION" > /dev/null 2>&1

# Create custom.ini File.
echo "Creating custom.ini..."
touch custom.ini
echo 'text here' >> custom.ini
echo '[l18n]' >> custom.ini
echo 'default_timezone = Europe/London' >> custom.ini
echo '' >> custom.ini
echo '[database]' >> custom.ini
echo 'mysql_host = mysql-server' >> custom.ini
echo 'mysql_port = 3306' >> custom.ini
echo 'mysql_user = root' >> custom.ini
echo 'mysql_pass = '$1 >> custom.ini
echo 'db_name = stalker_db' >> custom.ini

# Start Ministra Container
echo "Starting Ministra Container..."
docker run -itd \
-e MYSQLPASS=$1 \
-e MYSQLADDR='mysql-server' \
--name ministra -p 80:80 \
--mount type=bind,source=$(pwd)/custom.ini,target=/var/www/html/stalker_portal/server/custom.ini \
--network ministra-net scriptingonline/ministra:$2 > /dev/null 2>&1

echo ""
echo "############################################################################################"
echo ""
echo "You can access the admin interface at http://localhost/stalker_portal/server/adm/"
echo ""
echo "Username: admin"
echo "Password: 1" 
echo ""
echo "############################################################################################"

echo ""
echo "${GREEN}Done.${NC}"
echo ""
