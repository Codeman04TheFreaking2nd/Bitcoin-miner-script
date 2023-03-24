#!/bin/bash

# Change the following variables to match your configuration
address="YOUR BTC ADDRESS GOES HERE!"
pool_url="stratum+tcp://us-east.stratum.slushpool.com:3333"
worker_name="worker1"
worker_password="x"

# Install dependencies
sudo apt-get update
sudo apt-get install -y build-essential libusb-1.0-0-dev

# Download and build cgminer
wget https://github.com/ckolivas/cgminer/archive/v4.10.0.tar.gz
tar -zxvf v4.10.0.tar.gz
cd cgminer-4.10.0
./autogen.sh
./configure --enable-opencl --enable-scrypt --enable-bitforce --enable-icarus --enable-modminer --enable-ztex --enable-avalon --enable-bitfury --enable-hashfast
make

# Start mining
./cgminer -o $pool_url -u $worker_name -p $worker_password --bmsc-options 115200:0.59 -S all --api-listen

# Send mined Bitcoin to the specified address
bitcoin-cli sendtoaddress $address $(bitcoin-cli getbalance)
