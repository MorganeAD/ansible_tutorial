FROM ubuntu:latest as ansible_commun

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python3 sudo

RUN apt install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN useradd -d /home/ansible -s /bin/bash -g users -G sudo -u 1000 ansible 
RUN echo 'ansible:test' | chpasswd

RUN mkdir -p /home/ansible/.ssh
RUN chown -R ansible /home/ansible


# ----------------------------------------
FROM ansible_commun as ansible_control

RUN apt install -y vim software-properties-common python3-pip ssh curl

RUN pip3 install ansible

COPY ssh_config/* /home/ansible/.ssh/

RUN chown -R ansible /home/ansible/.ssh

RUN mkdir /home/ansible/ansible_work


# ----------------------------------------
FROM ansible_commun as ansible_service

RUN apt install -y openssh-server

COPY ssh_config/id_ed25519_ansible_tuto.pub /home/ansible/.ssh/authorized_keys

RUN chmod 600 /home/ansible/.ssh/authorized_keys

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN chown -R ansible /home/ansible/.ssh

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
