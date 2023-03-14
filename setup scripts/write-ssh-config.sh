#!/bin/bash

echo "writing ssh config..."
echo "Host 172.24.33.*
User ubuntu
IdentityFile ~/.ssh/ma-rsa" > ~/.ssh/config
echo "done"
