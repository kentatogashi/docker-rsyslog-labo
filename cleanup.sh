#!/bin/sh
ps auxwww | grep -E '(^docker-proxy|containerd-shim)' | awk '{print $2}' | xargs sudo kill -9
sudo docker rm -f $(docker ps -qa)
