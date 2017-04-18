#!/bin/sh
set -e

if [ -z $DOMAIN ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ ! -f "/data/base.pem" ]; then
    echo "[*] Creating certificates ..."

    openssl genrsa -out base.key 2048
    openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=${DOMAIN}" -out base.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=${DOMAIN}" -out device.csr
    openssl x509 -req -in device.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out device.crt
fi

ngrokd -tlsKey=/data/device.key -tlsCrt=/data/device.crt -domain="${DOMAIN}" -httpAddr=${HTTP_ADDR} -httpsAddr=${HTTPS_ADDR} -tunnelAddr=${TUNNEL_ADDR}
