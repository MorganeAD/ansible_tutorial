FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python3 sudo

RUN apt install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN useradd -d /home/ansible -s /bin/bash -g users -G sudo -u 1000 ansible 
RUN echo 'ansible:test' | chpasswd

RUN mkdir -p /home/ansible/.ssh
RUN chown -R ansible /home/ansible

#RUN echo "172.18.0.2 app01" >> /etc/hosts
#RUN echo "172.18.0.3 app02" >> /etc/hosts
#RUN echo "172.18.0.4 lb01" >> /etc/hosts
#RUN echo "172.18.0.5 control" >> /etc/hosts
