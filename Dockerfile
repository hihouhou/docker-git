#################################################
# Debian with added git.
#################################################

# Using latest debian image as base
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >


# install dependancies
RUN apt-get update && apt-get install -y git openssh-server

# Setting openssh
RUN mkdir /var/run/sshd
RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

# Adding git user
RUN adduser --system git
RUN mkdir -p /home/git/.ssh

# Clearing and setting authorized ssh keys
RUN > /home/git/.ssh/authorized_keys && echo 'your key' >> /home/git/.ssh/authorized_keys

# Updating shell to bash
RUN sed -i s#/home/git:/bin/false#/home/git:/bin/bash# /etc/passwd

# SSH already used
EXPOSE 1234
CMD ["/usr/sbin/sshd", "-D", "-p 1234"]
