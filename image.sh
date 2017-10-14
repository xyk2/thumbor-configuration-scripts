#! /bin/bash

apt-get update
apt-get -y upgrade

# install all thumbor dependencies
apt-get -y install \
build-essential \
checkinstall \
gcc \
python \
python-dev \
libpng12-dev \
libtiff5-dev \
libpng-dev \
libjasper-dev \
libwebp-dev \
libcurl4-openssl-dev \
python-pgmagick \
libmagick++-dev \
graphicsmagick \
libopencv-dev \
python-pip \
python-opencv

apt-get install nginx -y
apt-get install supervisor -y
pip install pycurl numpy thumbor

