##########################################################
# F4W Training BB Dockerfile
# Project:  FACTS4WORKERS (facts4workers.eu)
# Partner: ITANINNOVA (itainnova.es)
# Author:  Francisco José Lacueva Pérez (fjlacueva@itainnova.es)
# Date: 23/01/2018
# References:
# https://docs.moodle.org/31/en/Step-by-step_Installation_Guide_for_Ubuntu#Step_2:_Install_Apache.2FMySQL.2FPHP
##########################################################

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

# Install moodle=apache2 + mysql client + moodle
RUN apt-get  update
RUN apt-get install apt-utils -y
RUN apt-get install apache2 -y
RUN apt-get install mysql-client -y
RUN apt-get install php7.0  -y
RUN apt-get install libapache2-mod-php7.0 -y
RUN apt-get install graphviz -y
RUN apt-get install aspell -y
RUN apt-get install php7.0-pspell -y
RUN apt-get install php7.0-curl -y
RUN apt-get install php7.0-gd -y
RUN apt-get install php7.0-intl -y
RUN apt-get install php7.0-mysql -y
RUN apt-get install php7.0-xml -y
RUN apt-get install php7.0-xmlrpc -y
RUN apt-get install php7.0-ldap -y
RUN apt-get install php7.0-zip -y
RUN service apache2 restart
RUN apt-get install git-core -y
RUN apt-get install git-core -y
RUN apt-get install unzip -y


##Download and install Moodle code  (it must be copied remember)
#RUN cd /opt  && \
#  git clone git://git.moodle.org/moodle.git && \
#  cd moodle && \
#  pwd && \
#  ls && \
#  git branch -a && \
#  git branch --track ${moodle_version} origin/${moodle_version} && \
#  git checkout ${moodle_version} 

# Creating the folder which will contain moodle configuration scripts
RUN mkdir /var/F4W_Trainining_BB 
RUN chmod 0777 /var/F4W_Trainining_BB 
COPY   ./moodle.zip /var/F4W_Trainining_BB 
COPY   ./moodledata.zip /var/F4W_Trainining_BB 
COPY   ./config.php /var/F4W_Trainining_BB
RUN cd /var/F4W_Trainining_BB && \
  unzip moodle.zip -d . && \
  unzip moodledata.zip -d . && \
  cp /var/F4W_Trainining_BB/config.php /var/F4W_Trainining_BB/moodle


# Copy moodle  local repository to /var/www/html/
# RUN cp -R /opt/moodle /var/www/html/ && \
#   mkdir /var/moodledata && \
RUN cp -R /var/F4W_Trainining_BB/moodle /var/www/html/ && \
  cp -R /var/F4W_Trainining_BB/moodledata /var/ && \
  chown -R www-data /var/moodledata &&\
  chmod -R 777 /var &&\
  chmod -R 777 /var/moodledata &&\
  chmod -R 777 /var/www &&\
  chmod -R 777 /var/www/html &&\
  chmod -R 0755 /var/www/html/moodle

# Copying the startup services container file 
COPY   ./last_log_time_stamp /var/F4W_Trainining_BB
COPY   ./moodle_extract_moodle_log.sh /var/F4W_Trainining_BB
COPY   ./docker-entrypoint.sh /var/F4W_Trainining_BB 
RUN chmod 0777 /var/F4W_Trainining_BB/docker-entrypoint.sh
RUN chmod 0777 /var/F4W_Trainining_BB/last_log_time_stamp
RUN chmod 0777 /var/F4W_Trainining_BB/docker-entrypoint.sh

# Exposing the listening ports of the container:  apache2 (80, 443)
EXPOSE 80 443

# Container folders which are going to be shared as volumes with the hosts: they contain logs, configuration, data, moodle source, etc.
VOLUME [ "/var/www/html/moodle", "/var/moodledata", "/etc" ]

# Startup the apache2 service
ENTRYPOINT ["/var/F4W_Trainining_BB/docker-entrypoint.sh"]
CMD [" "]

