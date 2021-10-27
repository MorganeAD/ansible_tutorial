
Following this tutorial: [Ansible tutorial not for real beginners :p](https://linuxhint.com/ansible-tutorial-beginners/)


# With Docker only

First, build docker images

	docker build -f dockerfiles/commun.Dockerfile -t ansible_commun --target ansible_commun .
	docker build -f dockerfiles/control.Dockerfile -t ansible_control --target ansible_control .
	docker build -f dockerfiles/service.Dockerfile -t ansible_service --target ansible_service .

Then, run containers with docker

	docker network create --subnet=172.18.0.0/16 ansible_network

	docker run --rm --net ansible_network --ip 172.18.0.2 --name app01 -u root ansible_service
	docker run --rm --net ansible_network --ip 172.18.0.3 --name app02 -u root ansible_service
	docker run --rm --net ansible_network --ip 172.18.0.4 --name lb01 -u root -p 80:80 ansible_service

	docker run -it --rm --net ansible_network --ip 172.18.0.5 --name control -u ansible -v $(pwd):/home/ansible/ansible_work ansible_control


# With Docker-compose

	docker-compose build

	docker-compose up

	docker-compose exec --user ansible control bash


# Check the webservice

in a browser go on http://172.18.0.4


# Useful commands

	docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <my_container>

	docker stop <my_container>

	docker images | head -n 10

	docker image rm <my_image>