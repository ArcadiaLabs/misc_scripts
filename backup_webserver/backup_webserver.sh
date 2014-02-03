#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~ CONFIGURATION ~~~~~~~~~~~~~~~~~~~~~~~~~~#
EXPORT_DIR='/media/usb0/backups/webserver/'
USER=SQL_USER
PASS=SQL_PASSWORD

#~~~~~~~~~~~~~~~~~~~~~~~~ DEPENDANCES ~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~ UTILES A LA PREMIERE UTILISATION ~~~~~~~~~~~~~~~~~#
apt-get install zip

#~~~~~~~~~~~~~~~~~ FABRICATION DES VARIABLES ~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~ CREATION DES DOSSIERS ~~~~~~~~~~~~~~~~~~~~~~#
filebackup="${EXPORT_DIR}www/" && mkdir $filebackup
filesecurebackup="${EXPORT_DIR}www-secure/" && mkdir $filesecurebackup
sqlbackup="${EXPORT_DIR}sql/" && mkdir $sqlbackup
DATE=`date +%Y-%m-%d`
TIME=`date +%H-%M`

#~~~~~~~~~~~~~~~~~~~~~~~ BACKUP DOSSIERS ~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Execution du script de backup en excluant le répertoire data et supprime les backups
zip -r $filebackup/www.$DATE.$TIME.zip /var/www -v -9
zip -r $filesecurebackup/www-secure.$DATE.$TIME.zip /var/www-secure -v -9

#~~~~~~~~~~~~~~~~~~~~~~~~~~~ BACKUP SQL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
mysqldump --host=localhost --all-databases --user=$USER --password=$PASS > $sqlback$

#FIN