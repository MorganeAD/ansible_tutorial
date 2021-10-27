FROM ansible_commun

RUN apt install -y openssh-server

COPY ssh_config/id_ed25519_ansible_tuto.pub /home/ansible/.ssh/authorized_keys

RUN chmod 600 /home/ansible/.ssh/authorized_keys

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN chown -R ansible /home/ansible/.ssh

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
