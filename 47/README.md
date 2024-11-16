
# 47
hybrid app/docker/bare metal on 47 infrastructure
Use Terraform as a IaS and Ansible for configuration

# 1st Step: Install Terraform and GitHub to Get Code and Deploy with Terraform

<!-- 
## Explanation 
- **Function Definitions**: Separate functions to handle the installation of Terraform on CentOS/Red Hat, Ubuntu/Debian, and macOS. 
- **OS Detection**: The script detects the operating system and calls the appropriate installation function. 
- **Verification**: After installation, the script verifies the Terraform installation by printing the Terraform version. 

This script ensures that Terraform is installed on the detected operating system using the appropriate package manager and repository. If the OS is not supported, it prints an error message and exits. 
-->

chmod +x auto_install_terraform.sh
./auto_install_terraform.sh


# crete linux docker for openvpn
#create terraform for install CentOS Stream docker for POC 47 network (later use bare-metal)