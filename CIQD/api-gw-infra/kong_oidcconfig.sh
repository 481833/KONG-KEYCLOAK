#!/bin/sh
#usage sh kong_oidcconfig <host ip> <client secret id from keycloak>

HOST_IP=${1}
CLIENT_SECRET=${2}

if [ -z "${HOST_IP}" ] 
then
  echo "Error:host ip not set"
  exit 1
elif [ -z "${CLIENT_SECRET}" ] 
then
   echo "Error:client secret not set"
   exit 1
fi

echo ${HOST_IP} ${CLIENT_SECRET}

curl -s -X POST http://localhost:8001/plugins \
  -d name=oidc \
  -d config.client_id=kong \
  -d config.client_secret=${CLIENT_SECRET} \
  -d config.discovery=http://${HOST_IP}:8180/auth/realms/master/.well-known/openid-configuration \
  | python -mjson.tool
