#!/bin/bash
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
# check ruby
ruby -v
# check bundler
bundler -v
