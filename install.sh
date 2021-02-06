#!/bin/bash

# Download the code-server package.
URL="https://github.com/cdr/code-server/releases/download/v3.8.0/code-server_3.8.0_amd64.deb"
CODE_SERVER_DEB_PATH="/tmp/code-server.deb"
rm $CODE_SERVER_DEB_PATH 2>/dev/null
curl -fL $URL -o $CODE_SERVER_DEB_PATH

# Verify integrity.
SHA256SUM=$(sha256sum $CODE_SERVER_DEB_PATH | awk '{ print $1 }')

if [[ $SHA256SUM != "ee10f45b570050939cafd162fbdc52feaa03f2da89d7cdb8c42bea0a0358a32a" ]]; then
  echo "File download failed, please download $URL and move it as $CODE_SERVER_DEB_PATH"
  exit 1
fi

# Install Deb File
sudo apt install $CODE_SERVER_DEB_PATH -yyq

# Setup config file.
mkdir -p /home/liman/.config/code-server/
RANDOM_PASSWORD=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 25 ; echo)
echo """bind-addr: 0.0.0.0:5435
auth: password
password: $RANDOM_PASSWORD
cert: /liman/certs/liman.crt
cert-key: /liman/certs/liman.key
    """ > /home/liman/.config/code-server/config.yaml

# Start Code Server for Liman User
sudo systemctl enable --now code-server@liman

# Install module package.

URL="https://github.com/mertcelen/liman-gelistirme-modulu/releases/download/latest/liman-gelistirme-modulu.deb"
MODULE_DEB_PATH="/tmp/liman-gelistirme-modulu.deb"
rm $MODULE_DEB_PATH 2>/dev/null
curl -fL $URL -o $MODULE_DEB_PATH

# Install Deb File
sudo apt install $MODULE_DEB_PATH -yyq

# Verify integrity.
SHA256SUM=$(sha256sum $MODULE_DEB_PATH | awk '{ print $1 }')

if [[ $SHA256SUM != "" ]]; then
  echo "File download failed, please download $URL and move it as $MODULE_DEB_PATH"
  exit 1
fi

echo "Modül yüklendi! github.com/mertcelen"