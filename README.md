Create an ssh key called a2_key: ssh-keygen -t rsa -b 2048 -f ~/.ssh/a2_key
Import key to aws: aws ec2 import-key-pair --key-name a2_key --public-key-material fileb://~/.ssh/a2_key.pub
Initialize terraform file: terraform init
Run terraform file: terraform apply