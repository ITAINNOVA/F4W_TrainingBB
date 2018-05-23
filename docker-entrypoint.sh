#!/bin/bash
#############################################################################
# File:  docker-entrypoint.sh
# Project: FACTS4WORKERS (facts4workers.eu)
# Partner: ITAINNOVA (www.itainnova.es)
# Autho:  Francisco Jose Lacueva Pérez (@FJlacueva, fjlacueva@itainnova.es)
# Version: 1.0
# Date: 17/01/2018
# Purpose:  Script to be used for starting up the Training_BB_MYSQL container
#############################################################################
service apache2 restart && tail -F /var/log/apache2/access.log && tail-F /var/log/apache2/error.log && /var/F4W_Trainining_BB/moodle_extract_moodle_log.sh

