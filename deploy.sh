#!/bin/bash

echo "Begin deployment...."
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "Build & push"
hugo
cd public