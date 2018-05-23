#!/bin/bash
#############################################################################
# File:  moodle_extract_moodle_log.sh
# Project: FACTS4WORKERS (facts4workers.eu)
# Partner: ITAINNOVA (www.itainnova.es)
# Autho:  Francisco Jose Lacueva Pérez (@FJlacueva, fjlacueva@itainnova.es)
# Version: 1.0
# Date: 20/04/2018
# Purpose:Read all the entries in log table from las execution and 
# bulk them to the stdoutput 
#############################################################################
TIME_STAMP_FILE="/var/F4W_Trainining_BB/last_log_time_stamp"
TIME_BETWEEN_ITERATIONS=3

while true
do
  #sleep $TIME_BETWEEN_ITERATIONS
  read LAST_TIME_STAMP < /var/F4W_Trainining_BB/last_log_time_stamp
  #echo $LAST_TIME_STAMP
  MAX_TIME_STAMP=$(mysql -h  dockercompose_f4w_trainingbb_mysql_1  -u root -pFACTs4WORKERs.2018 moodle -B -N -e "SELECT MAX(timecreated) FROM moodle.mdl_logstore_standard_log;")
  #echo $LAST_TIME_STAMP 
  #echo $MAX_TIME_STAMP
  sleep $TIME_BETWEEN_ITERATIONS
  if [ "$LAST_TIME_STAMP" -lt "$MAX_TIME_STAMP" ]; then
    echo $MAX_TIME_STAMP > /var/F4W_Trainining_BB/last_log_time_stamp
    #echo ========================!!!!!
    #mysql -h  dockercompose_f4w_trainingbb_mysql_1  -u root -pFACTs4WORKERs.2018 moodle -B -N -e "set @min_TimeCreated = $LAST_TIME_STAMP; set @max_TimeCreated = $MAX_TIME_STAMP; set @relateduserid_null_Value = -1; SELECT concat( t.id , ';', t.eventname, ';' , t.component , ';', t.action, ';',t.target, ';', t.contextid, ';' , t.userid, ';', t.courseid, ';',  case when t.relateduserid is null then @relateduserid_null_Value else t.relateduserid end, ';',t.anonymous, ';', t.other, ';', t.timecreated, ';', t.origin,  ';', t.ip, CHAR(13),CHAR(13),'a') FROM moodle.mdl_logstore_standard_log as t where timecreated >=  @min_TimeCreated  and timecreated <= @max_TimeCreated order by t.timecreated;"
    mysql -h  dockercompose_f4w_trainingbb_mysql_1  -u root -pFACTs4WORKERs.2018 moodle -B -N -e "set @min_TimeCreated = $LAST_TIME_STAMP; set @max_TimeCreated = $MAX_TIME_STAMP; set @relateduserid_null_Value = -1; set @training_BB_URL = 'hamilton.ita.es/moodle'; SELECT concat( @training_BB_URL, ';', t.id , ';', t.eventname, ';' , t.component , ';', t.action, ';',t.target, ';', t.contextid, ';' , t.userid, ';', t.courseid, ';',t.anonymous, ';', t.other, ';', t.timecreated, ';', t.origin,  ';', t.ip, CHAR(13),CHAR(13),'a') FROM moodle.mdl_logstore_standard_log as t where timecreated >=  @min_TimeCreated  and timecreated <= @max_TimeCreated order by t.timecreated;"
  fi
  #mysql -h  dockercompose_f4w_trainingbb_mysql_1  -u root -p moodle
done

