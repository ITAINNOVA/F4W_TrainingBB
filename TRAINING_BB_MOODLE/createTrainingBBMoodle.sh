#!/bin/bash
#############################################################################
# File:  createTrainingBBMysql.sh
# Project: FACTS4WORKERS (facts4workers.eu)
# Partner: ITAINNOVA (www.itainnova.es)
# Author:  Francisco Jose Lacueva Pérez (@FJlacueva, fjlacueva@itainnova.es)
# Version: 1.0
# Date: 23/01/2018
# Purpose:  
#   Create f4w/training_bb_mysql image: change the password of root and creates
#   the moodle database as well as the moodle databa base user (see 
#   Dockerfile). It also enable the connection from outside of the container, 
#   modify it as your security policies requires.
#
#   Create the f4w_tho_training_bb_mysql_var and f4w_tho_training_bb_mysql_etc 
#   volumes to manage the database 
# Use:
# sudo ./createTrainingBBMoodle.sh
# 
#############################################################################

#############################################################################
# Setup variables
F4W_TBB_MOODLE_IMAGE_NAME=f4w/training_bb_moodle
F4W_TBB_MOODLE_CONTAINER_NAME=f4w_trainingbb_moodle
F4W_TBB_MOODLE_CONTAINER_DATA_VOLUME="${F4W_TBB_MOODLE_CONTAINER_NAME}_moodledata"
F4W_TBB_MOODLE_CONTAINER_HTML_VOLUME="${F4W_TBB_MOODLE_CONTAINER_NAME}_moodle"
F4W_TBB_MOODLE_CONTAINER_ETC_VOLUME="${F4W_TBB_MOODLE_CONTAINER_NAME}_etc"
F4W_TBB_MOODLE_MOODLE_HTTPS_EXTERNAL_CONTAINER_PORT=9443 
F4W_TBB_MOODLE_MOODLE_HTTP_EXTERNAL_CONTAINER_PORT=8680 

#############################################################################
# Making sure nothing makes dificult the creatio and startup of the container
# Stop the container
sudo docker stop $F4W_TBB_MOODLE_CONTAINER_NAME
# Remove the final container if it exists
sudo docker rm $F4W_TBB_MOODLE_CONTAINER_NAME
# Remove the final images if it exists
sudo docker rmi $F4W_TBB_MOODLE_IMAGE_NAME
# Remove the containers (just in case of a full image creation comment in other
# case
# JUST FOR TESTING Dockerfile purpose
#sudo docker volume rm $F4W_TBB_MOODLE_CONTAINER_DATA_VOLUME
#sudo docker volume rm $F4W_TBB_MOODLE_CONTAINER_HTML_VOLUME
#sudo docker volume rm $F4W_TBB_MOODLE_CONTAINER_ETC_VOLUME



###############################################################################
# Create host volume folders
# Host volume folders are in the path /data/TdAT/docker/volumes/<host_volumen_name>/_data
#sudo docker volume create $F4W_TBB_MOODLE_CONTAINER_DATA_VOLUME
#sudo docker volume create $F4W_TBB_MOODLE_CONTAINER_HTML_VOLUME
#sudo docker volume create $F4W_TBB_MOODLE_CONTAINER_ETC_VOLUME
# Build the f4w/training_bb_mysql images from scrath see Dockerfile for details
sudo docker build -t="${F4W_TBB_MOODLE_IMAGE_NAME}" .

#############################################################################
# Create a container f4w-trainingbb_mysql from f4w/training_bb_mysql
# And startup it.
# When volumes are managed by docker, instead of binding them directly to host folders,
# The data which is initally on the containter folder is copy to the host folder and persits
# between  container life cycles.  When the binding optios is considered the content on the 
# host folder is seen from the container.  If the volume is not mounted the original content
# of the container is shown.
# JUST FOR TESTING Dockerfile purpose
#sudo docker run -d --name $F4W_TBB_MOODLE_CONTAINER_NAME \
#   -p $F4W_TBB_MOODLE_MOODLE_HTTPS_EXTERNAL_CONTAINER_PORT:443 \
#   -p $F4W_TBB_MOODLE_MOODLE_HTTP_EXTERNAL_CONTAINER_PORT:80 \
#   --volume $F4W_TBB_MOODLE_CONTAINER_DATA_VOLUME:/var/moodledata \
#   --volume $F4W_TBB_MOODLE_CONTAINER_HTML_VOLUME:/var/www/html/moodle \
#   --volume $F4W_TBB_MOODLE_CONTAINER_ETC_VOLUME:/etc \
#   $F4W_TBB_MOODLE_IMAGE_NAME

#############################################################################
# Connect to the container
# sudo docker exec -ti $F4W_TBB_MOODLE_CONTAINER_NAME /bin/bash
