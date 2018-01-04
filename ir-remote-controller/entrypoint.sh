#!/bin/bash -e

# Start service
sudo /etc/init.d/lircd start

# Keep as forground process
tail -f /dev/null

