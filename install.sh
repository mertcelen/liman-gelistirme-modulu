#!/bin/bash

# Download the code-server package.
URL="https://github.com/cdr/code-server/releases/download/v3.8.1/code-server_3.8.1_amd64.deb"
CODE_SERVER_DEB_PATH="/tmp/code-server.deb"
if [ ! -f $CODE_SERVER_DEB_PATH ]; then
    curl -fL $URL -o $CODE_SERVER_DEB_PATH
fi

# Verify integrity.
SHA256SUM=$(sha256sum $CODE_SERVER_DEB_PATH | awk '{ print $1 }')
if [[ $SHA256SUM != "23ed8ad4bedec6bec32159870ece3abe0103e2104002fad149eb24e7f11ba96e" ]]; then
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
sudo systemctl restart code-server@liman

# Install module package.
URL="https://github.com/mertcelen/liman-gelistirme-modulu/releases/download/latest/liman-gelistirme-modulu.deb"
MODULE_DEB_PATH="/tmp/liman-gelistirme-modulu.deb"
if [ ! -f $MODULE_DEB_PATH ]; then
    curl -fL $URL -o $MODULE_DEB_PATH
fi

# Install Deb File
sudo apt install $MODULE_DEB_PATH -yyq

# Verify integrity.
SHA256SUM=$(sha256sum $MODULE_DEB_PATH | awk '{ print $1 }')
if [[ $SHA256SUM != "1d4778d1ef01b3a5891755e7776cc347b0010f94edef9a4a9c26917faed5f914" ]]; then
  echo "File download failed, please download $URL and move it as $MODULE_DEB_PATH"
  exit 1
fi
echo "Modül yüklendi! github.com/mertcelen"