#!/bin/bash
sudo apt-get update
sudo apt-get install -y mongodb
sudo systemctl enable mongod
sudo systemctl start mongod
