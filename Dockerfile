# docker build -t ansible_commun --target ansible_commun .
FROM ubuntu:latest as ansible_commun

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python3

RUN apt install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN useradd -d /home/ansible -s /bin/bash -g users -G sudo -u 1000 ansible 
RUN echo 'ansible:test' | chpasswd

RUN mkdir -p /home/ansible/.ssh
RUN chown -R ansible /home/ansible

# -----------------------------------------------------------
# docker build -t ansible_service --target ansible_service .
# docker run --rm --name app01 -u ansible ansible_service
# docker run --rm --name app02 -u ansible ansible_service
# docker run --rm --name lb01 -u ansible ansible_service


FROM ansible_commun as ansible_service

RUN apt install -y openssh-server

COPY id_ed25519_ansible_tuto.pub /home/ansible/.ssh/authorized_keys

RUN chmod 600 /home/ansible/.ssh/authorized_keys

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN chown -R ansible /home/ansible/.ssh

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

# -----------------------------------------------------------
# docker build -t ansible_control --target ansible_control .
# docker run -it --rm --name control -u ansible -v $(pwd):/home/ansible/ansible_work ansible_control

FROM ansible_commun as ansible_control

RUN apt install -y vim software-properties-common sudo python3-pip

RUN pip3 install ansible

COPY id_ed25519_ansible_tuto /home/ansible/.ssh
COPY id_ed25519_ansible_tuto.pub /home/ansible/.ssh
COPY ssh_config /home/ansible/.ssh/config

RUN chown -R ansible /home/ansible/.ssh

RUN mkdir /home/ansible/ansible_work
