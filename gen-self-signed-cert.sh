#!/bin/bash

# find the IP addr yourself, it depends on which interface you would access
[[ -z $1 ]] && IP_ADDR='127.0.0.1' || IP_ADDR=$1
echo 'domain name: '$IP_ADDR

openssl req -x509 -days 36500 -out cert/server.crt -subj /CN=$IP_ADDR \
  -newkey rsa:2048 -nodes -keyout cert/server.key

# verify
echo 'Verifying...'
if diff <(openssl x509 -in cert/server.crt -noout -modulus|openssl md5) <(openssl rsa -in cert/server.key -noout -modulus|openssl md5); then
  echo 'Same modulus.'
else
  echo 'Different moduli!'
  exit 1
fi

openssl x509 -in cert/server.crt -noout -issuer -subject -dates

