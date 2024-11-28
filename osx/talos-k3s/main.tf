provider "local" {
    version = "~> 2.1"
}

provider "null" {
    version = "~> 3.0"
}

resource "null_resource" "install_k3s_control_plane" {
    provisioner "local-exec" {
        command = <<EOT
            docker run -d --privileged --name talos-server \
                -p 6443:6443 -p 80:80 -p 443:443 \
                talos-systems/talos:v0.13.0

            docker exec talos-server sh -c "
                curl -sfL https://get.k3s.io | sh -
            "
        EOT
    }
}
resource "null_resource" "install_k3s_worker" {
    count = 3
    depends_on = [null_resource.install_k3s_control_plane]

    provisioner "local-exec" {
        command = <<EOT
            docker run -d --privileged --name talos-agent-${count.index} \
                --link talos-server:talos-server \
                talos-systems/talos:v0.13.0 agent \
                --server https://talos-server:6443 \
                --token $(docker exec talos-server cat /var/lib/rancher/k3s/server/node-token)
        EOT
    }
}

output "docker_version" {
    value = "K3s with 1 control plane and 3 worker nodes have been installed."
}
