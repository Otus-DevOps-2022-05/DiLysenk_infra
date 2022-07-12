#!/bin/bash
apt update
apt install -y ruby-full ruby-bundler build-essential
# check ruby
ruby -v
# check bundler
bundler -v
