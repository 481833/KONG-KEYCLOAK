#!/bin/sh
#usage sh kongadroute <service id> <path>

#curl -s -X POST http://localhost:8001/routes \
#    -d service.id=${service_id} \
#    -d paths[]=/mock \
#    | python -mjson.tool

service_id=${1}
path=${2}

if [ -z "$service_id" ] 
then
  echo "Error:service_id not set"
  exit 1
elif [ -z "$path" ] 
then
   echo "Error:path not set"
   exit 1
fi

echo ${service_id} ${path}

curl -s -X POST http://localhost:8001/routes \
    -d service.id=${service_id} \
    -d paths[]=${path} \
    | python -mjson.tool
