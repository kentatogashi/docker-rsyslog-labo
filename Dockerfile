FROM ubuntu:16.04
MAINTAINER togashik

RUN apt-get update && apt-get install -y openssh-server rsyslog supervisor iproute2 vim
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# allow 514 udp receive
RUN sed -i -e 's/#module(load="imudp")/module(load="imudp")/' -e 's/#input(type="imudp" port="514")/input(type="imudp" port="514")/' /etc/rsyslog.conf

# daemonize rsyslogd and sshd
RUN echo '[program:sshd]' > /etc/supervisor/conf.d/sshd.conf
RUN echo 'command=/usr/sbin/sshd -D' >> /etc/supervisor/conf.d/sshd.conf
RUN echo '[program:rsyslogd]' > /etc/supervisor/conf.d/rsyslogd.conf
RUN echo 'command=/usr/sbin/rsyslogd -n' >> /etc/supervisor/conf.d/rsyslogd.conf

EXPOSE 22
EXPOSE 514/udp
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
