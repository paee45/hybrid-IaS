provider "local" {
  version = "~> 2.1"
}

provider "null" {
  version = "~> 3.0"
}

resource "null_resource" "install_docker" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo docker run hello-world"
    ]

    connection {
      type     = "ssh"
      user     = "your-username"
      private_key = file("~/.ssh/id_rsa")
      host     = "your-debian-host"
    }
  }
}

output "docker_installation_status" {
  value = "Docker has been installed and verified on the remote Debian machine."
}