ps auxwww | grep -E '(^Ccker-proxy|containerd-shim)' | awk '{print $2}' | xargs sudo kill -9
sudo docker rm -f $(docker ps -qa)
