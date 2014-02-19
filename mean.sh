#!/bin/bash
#   Modified by Carlin Yuen 2014/02
#
#   Run this from the folder that you want to be the root of your app,
#   which can be cloned from or later pushed to Heroku's git repo.
#   NOTE: this is best done with a clean / empty root folder!
#   Troubleshooting: https://github.com/linnovate/mean.
#
#   This will pull the latest MEAN.io and install/update the following packages:
#       Brew, Git, Node, Bower, Grunt, Heroku Toolbelt, MongoDB, 
#       and any other local packages defined in package.json


# Check if Homebrew is installed
echo " - Brew Check..."
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew - http://brew.sh/
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
else
    brew update
fi


# Check if Git is installed
echo " - Git Check..."
which -s git || brew install git


# Get clone of MEAN.io's repo minus the .git folder and copy to current
echo " - Cloning MEAN.io..."
rm -rf .meanStackSetupTemp
git clone git@github.com:linnovate/mean.git .meanStackSetupTemp || exit $?
rm -rf .meanStackSetupTemp/.git
mv .meanStackSetupTemp/{.,}* ./


# Check if Node is installed
#   Note that npm comes with node now
echo " - Node & npm Check..."
which -s node || brew install node


# Install Bower
echo " - Bower Check..."
which -s bower || npm install -g bower


# Install Grunt
echo " - Grunt Check..."
which -s grunt || npm install -g grunt


# Check if Heroku toolbelt is installed
echo " - Heroku Toolbelt Check..."
which -s heroku
if [[ $? != 0 ]] ; then
    # Install Heroku toolbelt
    echo "Downloading Heroku toolbelt"
    curl -O http://assets.heroku.com/heroku-toolbelt/heroku-toolbelt.pkg
    open /tmp/heroku-toolbelt.pkg
    read -p "Press return when done with Heroku installation"

    # open https://api.heroku.com/login
    # https://api.heroku.com/signup
else
    heroku update
fi


# Install MongoDB
echo " - MongoDB Check..."
which -s mongo || brew install mongodb


# Install node packages
echo " - Installing package.json packages..."
npm install


# Creating some folders for local db storage and startup mongoDB instance
if [[ ! -d /data/db/ ]]; then
    sudo mkdir -p /data/db/
    sudo chown `id -u` /data/db
fi
if [[ ! -d /data/dumps/ ]]; then
    sudo mkdir -p /data/dumps/
    sudo chown `id -u` /data/dumps
fi
echo " - Starting MongoDB in background"
ps -ef | grep mongod | awk '{print$2}' | xargs kill {} # Kill old mongodb process
mongod &


# Starting up nodejs server on localhost:3000
echo " - Starting app using Grunt"
grunt
