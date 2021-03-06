﻿#!/usr/bin/env bash

touch /etc/profile.d/composer_global.sh
cat << EOF | sudo tee -a /etc/profile.d/on_terminal_load.sh
  echo ======================================================
  echo =
  echo =   CHANGELOG
  echo =   DATE ---- AUTHOR -- CHANGES
  echo =
  echo =   07/01/17 -- MS ---- Initial build
  echo =
  echo ======================================================
  echo =
  echo =   DEVELOPMENT ENVIRONMENT
  echo =   FOR QUICKPHPOTO
  echo =
  echo =   Application Path /var/www
  echo =   Webroot /var/www/public
  echo =
  echo =   AUTHOR - Martin Smith - MS
  echo =
  echo ======================================================
  echo ======================================================
EOF

ln -s /vagrant/projects
cat << EOF | sudo tee -a /etc/motd.tail
*****************************************************
* STARTING PROVISIONING FOR DEVELOPMENT ENVIRONMENT *
*****************************************************
EOF

echo ===================================
echo =
echo =   CREATE DB TABLE
echo =
echo ===================================

sudo mysql -uroot -e "CREATE DATABASE quickphoto"

echo ===================================
echo =
echo =   COMPOSER INSTALL
echo =
echo ===================================

cd /var/www
sudo composer self-update
sudo composer install

echo ===================================
echo =
echo =   MIGRATIONS AND SEEDS
echo =
echo ===================================

cd /var/www
#sudo php artisan migrate
#sudo php artisan db:seed

echo ===================================
echo =
echo =   PROVISIONING SCRIPT COMPLETE
echo =
echo ===================================
