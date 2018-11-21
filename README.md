# docker rsyslog labo

## Getting Started

0. create network
```
sh create_network.sh
```

1. build image
```
sh build.sh
```

2. up containers
```
docker-compose up -d
```

## Example

```
togashik@togashik:~/work/docker-test/docker-rsyslog$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                           NAMES
b883b8250722        rsyslog_daemon      "/usr/bin/supervisor…"   6 seconds ago       Up 2 seconds        0.0.0.0:10003->22/tcp, 0.0.0.0:10004->514/udp   docker-rsyslog_sender_1
c85d36acf8bb        rsyslog_daemon      "/usr/bin/supervisor…"   6 seconds ago       Up 2 seconds        0.0.0.0:10001->22/tcp, 0.0.0.0:10002->514/udp   docker-rsyslog_receiver_1
togashik@togashik:~/work/docker-test/docker-rsyslog$ docker inspect docker-rsyslog_sender_1 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.22.0.3",
togashik@togashik:~/work/docker-test/docker-rsyslog$ docker inspect docker-rsyslog_receiver_1 | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
                    "IPAddress": "172.22.0.2",                   
rsyslog_senderから、rsyslog_receiverに、対してloggerを実行すると届くのがわかる。
togashik@togashik:~/work/docker-test/docker-rsyslog$ ssh -lroot -p10003 localhost 'hostname; logger -n 172.22.0.1 -P 10002 hogehoge; echo sent!!'
root@localhost's password:
rsyslog_sender
sent!!
togashik@togashik:~/work/docker-test/docker-rsyslog$ ssh -lroot -p10001 localhost 'hostname;tail -1 /var/log/syslog'
root@localhost's password:
Permission denied, please try again.
root@localhost's password:
rsyslog_receiver
Nov 21 09:55:50 rsyslog_sender root hogehoge
```
