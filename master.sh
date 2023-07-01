#!/bin/bash
sudo docker swarm init --advertise-addr=10.10.10.100
sudo docker swarm join-token worker | grep docker > /vagrant/worker.sh

sudo docker volume create info_volume

sudo bash -c 'echo "<?php phpinfo(); ?>" > /var/lib/docker/volumes/info_volume/_data/info.php'

sudo cp /var/lib/docker/volumes/info_volume/_data/info.php /vagrant/
sudo cp /vagrant/worker.sh /vagrant/info.php /vagrant/

sudo docker run -d -p 80:80 -v info_volume:/var/www/html --name httpd-container httpd