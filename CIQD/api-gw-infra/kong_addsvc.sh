#!/bin/sh
#usage sh kong_addsvc <service name> <service url>

#curl -s -X POST http://localhost:8001/services \
#    -d name=mock-service \
#    -d url=http://mockbin.org/request \
#    | python -mjson.tool

service_name=${1}
service_url=${2}

if [ -z "$service_name" ] 
then
  echo "Error:service name not set"
  exit 1
elif [ -z "$service_url" ] 
then
   echo "Error:service url not set"
   exit 1
fi

echo ${service_name} ${service_url}

curl -s -X POST http://localhost:8001/services \
    -d name=${service_name} \
    -d url=${service_url} \
    | python -mjson.tool
