#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <LAT> <LNG>"
  exit 1
fi

LAT=$1
LNG=$2

echo "SPOOF_LAT=$LAT" > .env
echo "SPOOF_LNG=$LNG" >> .env

echo "[+] Updated coordinates to: $LAT, $LNG"
sudo systemctl restart geo
