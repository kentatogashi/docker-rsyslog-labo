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
togashik@togashik:~/work/docker-test/docker-rsyslog$ ssh -lroot -p10003 localhost 'tail -f /var/log/syslog'
root@localhost's password:
Nov 21 07:46:40 b883b8250722 rsyslogd: [origin software="rsyslogd" swVersion="8.16.0" x-pid="9" x-info="http://www.rsyslog.com"] start
Nov 21 07:46:40 b883b8250722 rsyslogd-2222: command 'KLogPermitNonKernelFacility' is currently not permitted - did you already set it via a RainerScript command (v6+ config)? [v8.16.0 try http://www.rsyslog.com/e/2222 ]
Nov 21 07:46:40 b883b8250722 rsyslogd: imklog: cannot open kernel log (/proc/kmsg): Operation not permitted.
Nov 21 07:46:40 b883b8250722 rsyslogd-2145: activation of module imklog failed [v8.16.0 try http://www.rsyslog.com/e/2145 ]
Nov 21 07:46:40 b883b8250722 rsyslogd: rsyslogd's groupid changed to 107
Nov 21 07:46:40 b883b8250722 rsyslogd: rsyslogd's userid changed to 105
Nov 21 07:46:40 b883b8250722 rsyslogd-2039: Could not open output pipe '/dev/xconsole':: No such file or directory [v8.16.0 try http://www.rsyslog.com/e/2039 ]
Nov 21 07:46:40 b883b8250722 rsyslogd-2007: action 'action 9' suspended, next retry is Wed Nov 21 07:47:10 2018 [v8.16.0 try http://www.rsyslog.com/e/2007 ]host
別のコンソールで

```
