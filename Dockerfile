FROM ubuntu:16.04

WORKDIR /home/ubuntu
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install ssh -y
RUN apt-get install software-properties-common -y
RUN apt-add-repository --yes ppa:ansible/ansible
RUN apt-get install python -y
RUN apt-get update
RUN apt-get install ansible -y

ADD app /home/ubuntu/app
ADD nodeapp.conf /home/ubuntu/nodeapp.conf
ADD provision_app.yml /home/ubuntu/provision_app.yml
ADD ansible_hosts /home/ubuntu/ansible_hosts

RUN mkdir ~/.ssh
RUN chmod 700 ~/.ssh
RUN mkdir ~/.ssh/authorized_keys
COPY id_rsa.pub ~/.ssh/authorized_keys

EXPOSE 3000 22 80 443

ENV ANSIBLE_HOST_KEY_CHECKING false
CMD ["ansible-playbook", "-i", "ansible_hosts", "provision_app.yml"]
