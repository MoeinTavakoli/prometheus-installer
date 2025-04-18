#!/bin/sh

set -e

if [ ! -f .env ]; 
    then
    echo "copy .env file"
    cp .env.example .env
fi

export CUR_DIR=$PWD
source .env

sudo rm -rf /etc/prometheus-file/
sudo rm -f prometheus-*-amd64.tar.gz

sudo mkdir /etc/prometheus-file/

wget "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"

sudo mv prometheus-*-amd64.tar.gz /etc/prometheus-file/

cd /etc/prometheus-file/

sudo tar -xvf /etc/prometheus-file/prometheus-*.linux-amd64.tar.gz --strip-components=1

sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

echo "copy data to /usr/local/bin/ "
sudo cp /etc/prometheus-file/prometheus /usr/local/bin/
sudo cp /etc/prometheus-file/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

echo "copy to /etc/prometheus/"
sudo cp -r /etc/prometheus-file/consoles /etc/prometheus
sudo cp -r /etc/prometheus-file/console_libraries /etc/prometheus
sudo cp /etc/prometheus-file/prometheus.yml /etc/prometheus/

echo "change ownership /etc/prometheus/"
sudo chown -R prometheus:prometheus /etc/prometheus/*

echo "copy unit file"
sudo cp $CUR_DIR/prometheus.service  /etc/systemd/system/

sudo rm -rf /etc/prometheus-file
echo "install successfully ..."



echo "reload daemon and system"
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
