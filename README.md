
Following this tutorial: [Ansible tutorial not for real beginners :p](https://linuxhint.com/ansible-tutorial-beginners/)

# build docker images

	docker build -t ansible_commun --target ansible_commun .
	docker build -t ansible_control --target ansible_control .
	docker build -t ansible_service --target ansible_service .

# run containers with docker

	docker network create --subnet=172.18.0.0/16 ansible_network

	docker run --rm --net ansible_network --ip 172.18.0.2 --name app01 -u root ansible_service
	docker run --rm --net ansible_network --ip 172.18.0.3 --name app02 -u root ansible_service
	docker run --rm --net ansible_network --ip 172.18.0.4 --name lb01 -u root -p 80:80 ansible_service

	docker run -it --rm --net ansible_network --ip 172.18.0.5 --name control -u ansible -v $(pwd):/home/ansible/ansible_work ansible_control

in a browser go on http://172.18.0.4

# useful commands

	docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <my_container>

	docker stop <my_container>

	docker images | head -n 10

	docker image rm <my_image>