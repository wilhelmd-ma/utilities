#!/bin/bash

TARGET_IP=$1
TARGET_DIR=/mnt/datasets


for IP in 172.24.33.111 172.24.33.90 172.24.33.82 172.24.33.47; do
#for IP in 172.24.33.25; do
TARGET_IP=$IP
echo "target: $TARGET_IP"

ssh ubuntu@$TARGET_IP "sudo rm -rf $TARGET_DIR"
ssh ubuntu@$TARGET_IP "sudo mkdir -p $TARGET_DIR"
for FILE in /mnt/lrz/datasets/*
do
 FILENAME=$(basename $FILE)
 echo copying $FILENAME 
 scp $FILE $TARGET_IP:
 ssh $TARGET_IP sudo mv $FILENAME $TARGET_DIR
done

done

