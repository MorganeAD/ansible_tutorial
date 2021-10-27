FROM ansible_commun

RUN apt install -y vim software-properties-common python3-pip ssh curl

RUN pip3 install ansible

COPY ssh_config/* /home/ansible/.ssh/

RUN chown -R ansible /home/ansible/.ssh

RUN mkdir /home/ansible/ansible_work
