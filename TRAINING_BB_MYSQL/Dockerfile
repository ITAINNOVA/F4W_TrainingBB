##########################################################
# F4W Training BB Mysql Dockerfile
# Project:  FACTS4WORKERS (facts4workers.eu)
# Partner: ITANINNOVA (itainnova.es)
# Author:  Francisco José Lacueva Pérez (fjlacueva@itainnova.es)
# Date: 17/01/2018
# References:
# https://docs.moodle.org/31/en/Step-by-step_Installation_Guide_for_Ubuntu#Step_2:_Install_Apache.2FMySQL.2FPHP

##########################################################

# Pull ubuntu base image (latest)
#
FROM ubuntu:latest
MAINTAINER Francisco José Lacueva Pérez <fjlacueva@itainnova.es>

# mysql root user password
ENV  mysql_root_password FACTs4WORKERs.2018
ENV  mysql_passwordformoodledude passwordformoodledude
ENV  mysql_root_password_s1="mysql-server mysql-server/root_password password FACTs4WORKERs.2018"
ENV  mysql_root_password_s2="mysql-server mysql-server/root_password_again FACTs4WORKERs.2018"
# Moodle version to be instaled
ENV  moodle_version MOODLE_34_STABLE

# Install moodle=apache2 + mysql + moodle
RUN apt-get  update
RUN apt-get install apt-utils -y
RUN apt-get install mysql-client -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

#Setting up mysql external access and database configurations
COPY ./mysql/mysqld.cnf /etc/mysql/mysql.conf.d

# Creating the folder which will contain moodle configuration scripts
RUN mkdir /var/F4W_Trainining_BB 
RUN chmod 0777 /var/F4W_Trainining_BB 
COPY   ./docker-entrypoint.sh /var/F4W_Trainining_BB 
COPY   ./mysql/moodel.new.dump /var/F4W_Trainining_BB
RUN chmod 0777 /var/F4W_Trainining_BB/*
 

# Modifiying database moodle internal setup 
RUN service mysql restart && \
   echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysql_root_password}'; \n" > /var/F4W_Trainining_BB/modifyRoot_01.sql &&\
   echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${mysql_root_password}'; \n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql &&\ 
   echo "FLUSH PRIVILEGES; \n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql && \
   echo "CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;\n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql &&\
   echo "create user 'moodledude'@'localhost' IDENTIFIED BY '${mysql_passwordformoodledude}';\n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql && \
   echo "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO 'moodledude'@'%' IDENTIFIED BY '${mysql_passwordformoodledude}';\n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql && \
   echo "FLUSH PRIVILEGES; \n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql && \
   echo "EXIT \n" >> /var/F4W_Trainining_BB/modifyRoot_01.sql && \
   mysql -u root < /var/F4W_Trainining_BB/modifyRoot_01.sql 

RUN service mysql restart && \
   cd /var/F4W_Trainining_BB && \
   mysql --user=root --password=${mysql_root_password}  --database=moodle < moodel.new.dump

# Exposing the listening ports of the container:   mysql 3306
EXPOSE 3306

# Container folders which are going to be shared as volumes with the hosts: they contain logs, configuration, data, moodle source, etc.
VOLUME [ "/var/lib/mysql", "/etc" ]
# Startup the mysql service
ENTRYPOINT ["/var/F4W_Trainining_BB/docker-entrypoint.sh"]
CMD [" "]
