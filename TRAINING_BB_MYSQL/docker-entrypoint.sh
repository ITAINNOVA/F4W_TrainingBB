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
service mysql restart && tail -F /var/log/mysql/error.log

