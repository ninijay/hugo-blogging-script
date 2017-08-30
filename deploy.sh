#!/bin/bash

####################### SETUP ###################
#												#
username="WRITE_YOUR_USERNAME_HERE"				#
#												#
server="WRITE_YOUR_SERVER_HERE"					#
#												#
dir="WRITE_YOUR_WWW_ROOT_DIRECTORY_HERE"		#
#												#
#################################################



echo "Begin deployment...."
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo "Build & push"
hugo
cd public
git add -A
git commit -m "Update, $DATE"
git push blog master
echo "git pull over SSH"
ssh ${username}@${server} << HERE
cd $dir
git pull blog master
HERE

