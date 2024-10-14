resource "aws_key_pair" "my-vpc-key" {
    public_key = file("/Users/ramprasad/.ssh/id_rsa.pub")
    key_name = var.key-name
  
}

resource "aws_instance" "my-instance" {
    ami = var.ami
    instance_type = var.instance
    subnet_id = aws_subnet.my-vpc-public.id
    security_groups = [ aws_security_group.my-sg.id ]
    key_name = aws_key_pair.my-vpc-key.key_name

    provisioner "remote-exec" {
        inline = [ "sudo apt update", "sudo apt install docker.io -y" ]

        connection {
          host = self.public_ip
          private_key = file("/Users/ramprasad/.ssh/id_rsa")
          user = "ubuntu"
          type = "ssh"
          
        }
      
    }
  
}