# docker build -t ansible_commun --target ansible_commun .
FROM ubuntu:latest as ansible_commun

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python

RUN apt install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN useradd -rm -d /home/ansible -s /bin/bash -g root -G sudo -u 1000 ansible 
RUN echo 'ansible:test' | chpasswd

RUN mkdir -p /home/ansible/.ssh
RUN chown -R ansible /home/ansible/.ssh

# -----------------------------------------------------------
# docker build -t ansible_service --target ansible_service .
# docker run --rm --name app01 -u ansible 555903a338b0
# docker run --rm --name app02 -u ansible 95e97c33f5ea
# docker run --rm --name lb01 -u ansible 95e97c33f5ea


FROM ansible_commun as ansible_service

RUN apt install -y openssh-server sudo

COPY id_ed25519_ansible_tuto.pub /home/ansible/.ssh/authorized_keys
RUN chown -R ansible /home/ansible/.ssh

#RUN chmod 700 /home/ansible/.ssh
RUN chmod 600 /home/ansible/.ssh/authorized_keys


RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

# -----------------------------------------------------------
# docker build -t ansible_control --target ansible_control .
# docker run -it --rm --name control -u ansible f0077a726812

FROM ansible_commun as ansible_control

RUN apt install -y vim software-properties-common ansible

COPY id_ed25519_ansible_tuto /home/ansible/.ssh
COPY id_ed25519_ansible_tuto.pub /home/ansible/.ssh
COPY ssh_config /home/ansible/.ssh/config

RUN chown -R ansible:root /home/ansible/.ssh

