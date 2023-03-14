#!/bin/bash

echo "configuring worker at ${1}..."
echo "running apt-get update"
echo "##########"
ssh ubuntu@"${1}" << EOF
  sudo apt-get update
EOF

echo "##########"
echo
echo "installing java,.."
ssh ubuntu@"${1}" << EOF
  sudo apt-get install openjdk-8-jdk -y
EOF

echo "##########"
echo
echo "removing archive on target if exists..."
ssh ubuntu@"${1}" << EOF
   rm /home/ubuntu/spark-1.1.0-bin-hadoop1.tgz
EOF


echo "##########"
echo
echo "copying spark archive to ${1}"
scp ./spark-1.1.0-bin-hadoop1.tgz ubuntu@"${1}":/home/ubuntu/spark-1.1.0-bin-hadoop1.tgz
echo "done"

echo "##########"
echo
echo "installing spark and setting env vars..."
ssh ubuntu@"${1}" << EOF
  sudo rm -rf /opt/spark/spark-1.1.0-bin-hadoop1
  tar xvf spark-1.1.0-bin-hadoop1.tgz
  sudo mv spark-1.1.0-bin-hadoop1/ /opt/spark
  export SPARK_HOME=/opt/spark
  export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
  export SPARK_MASTER=spark://master:7077
EOF

echo "##########"
echo
echo "done. ${1} should now be ready. don't forget to add it to /opt/spark/conf/slaves file"
