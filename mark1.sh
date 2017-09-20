#!/bin/bash

cd /home/pi/gaurav-bansal.github.io/

git config credential.helper store
git config --global credential.helper 'cache --timeout 10800'
git push https://github.com/gaurav-bansal/gaurav-bansal.github.io.git
echo "gaurav-bansal"
echo "iPhone password"
