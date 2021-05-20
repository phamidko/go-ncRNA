provider "aws" {
    region = "eu-west-2"
    shared_credentials_file = "/home/vscode/.aws/credentials"
    
}

resource "aws_instance" "ec2" {
    ami = "ami-0a13d44dccf1f5cf6"
    instance_type = "t2.micro"
    key_name = "aws_ansible"
    security_groups = ["launch-wizard-1"]
    tags = {
        Name = "Ansible"
    }
    
    provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --private-key /workspaces/ansible-course/key/aws_ansible_vscode.pem -i ${aws_instance.ec2.public_ip}, playbook.yaml"
    }  
}