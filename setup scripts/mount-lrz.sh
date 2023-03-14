#!/bin/bash

#this script installs cifs if not available and mounts the lrz nas

# 1. Install cifs

#!/bin/bash

#this script installs cifs if not available and mounts the lrz nas

# 1. Install cifs

sudo apt-get update && sudo apt-get install cifs-utils -y


## 2. Mount shared files from lrz storage

cd /mnt
sudo mkdir lrz
sudo mount -t cifs //nas.ads.mwn.de/ga87yol/ma-fs /mnt/lrz -o username=ga87yol,domain=ADS,vers=3.1.1,nodfs,uid=ubuntu,gid=ubuntu
