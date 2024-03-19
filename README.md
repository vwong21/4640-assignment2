Make sure the directory is running in the home directory
Create an ssh key called a2_key: ssh-keygen -t rsa -b 2048 -f ~/.ssh/a2_key
Initialize terraform file: terraform init
Run terraform file: terraform apply
In hosts.yaml, replace the ansible host for each of the instances with the ip of the instances
Run ansible playbook: ansible-playbook ansible/deploy.yml

https://youtu.be/FvqGckbpIVQ 