#!/bin/bash

# argument(s):
# $1: SSL cert Common Name (CN)
# tips: find your IP addr that's reachable from your client (e.g. 192.168.1.69)

# CN via argument is prioritized
if [[ -n $1 ]]; then
  COMMON_NAME=$1

# then defined variable in .env
else
  # read .env
  source .env
  if [[ -v DOMAIN_NAME ]]; then
    COMMON_NAME=$DOMAIN_NAME

  # otherwise fallback to loopback
  else
    COMMON_NAME='127.0.0.1'
  fi
fi

echo 'domain name: '$COMMON_NAME

mkdir -p cert
openssl req -x509 -days 36500 -out cert/server.crt -subj /CN=$COMMON_NAME \
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

