# AWS EC2 Provisioning and Configuration using Terraform and Ansible

## Overview

This project demonstrates a complete Infrastructure as Code (IaC) workflow using Terraform and Ansible. It provisions an EC2 instance on AWS, configures a remote backend for state management using S3, implements state locking with DynamoDB, and automates server configuration using Ansible.

The entire setup is performed without relying on the AWS Management Console, emphasizing a fully code-driven and reproducible infrastructure workflow.

---

## Architecture

The project consists of the following stages:

1. **Backend Setup (Terraform)**
   - Creates an S3 bucket to store Terraform state remotely.
   - Configures DynamoDB for state locking to prevent concurrent modifications.

2. **Infrastructure Provisioning (Terraform)**
   - Provisions an EC2 instance.
   - Creates and attaches a security group allowing SSH (22) and HTTP (80).
   - Injects an SSH public key for password-less authentication.

3. **Configuration Management (Ansible)**
   - Connects to the EC2 instance via SSH.
   - Installs Nginx on Amazon Linux.
   - Starts and enables the Nginx service.

---

## Tech Stack

- **Terraform** – Infrastructure provisioning
- **AWS EC2** – Compute resource
- **AWS S3** – Remote backend for Terraform state
- **AWS DynamoDB** – State locking
- **Ansible** – Configuration management
- **SSH (Key-based authentication)** – Secure access

---

## Project Structure

```
.
├── ansible
│   ├── inventory.ini
│   └── playbook.yml
├── backend.tf
├── main.tf
├── output.tf
├── README.md
├── terraform.tfstate
└── terraform.tfstate.backup
```

---

## Features

- Remote state management using S3
- State locking using DynamoDB
- Fully automated EC2 provisioning
- Security group configuration via Terraform
- Password-less SSH authentication using key pairs
- Automated server configuration using Ansible
- No dependency on AWS Console (fully CLI/IaC driven)

---

## Prerequisites

- AWS account with configured credentials (`aws configure`)
- Terraform installed
- Ansible installed
- SSH key pair available (`~/.ssh/id_ed25519`)

---

## Setup Instructions

### 1. Initialize Terraform

```
terraform init
```

---

### 2. Apply Infrastructure

```
terraform apply
```

This will:

- Create S3 bucket and DynamoDB table (backend)
- Provision EC2 instance
- Configure networking and SSH access

---

### 3. Retrieve EC2 Public IP

```
terraform output ec2_public_ip
```

---

### 4. Configure Ansible Inventory

Update `ansible/inventory.ini`:

```
[web]
<EC2_PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=/home/yogramming/.ssh/id_ed25519
```

---

### 5. Test Connectivity

```
ansible all -i ansible/inventory.ini -m ping
```

---

### 6. Run Ansible Playbook

```
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

---

## Verification

Open the following URL in a browser:

```
http://<EC2_PUBLIC_IP>
```

You should see the default Nginx welcome page.

---

## Key Learnings

- Infrastructure provisioning should be fully automated and reproducible.
- Remote state and locking are critical for team-based Terraform workflows.
- SSH key injection must be handled at instance creation time.
- Configuration management tools like Ansible complement Terraform by handling post-provisioning tasks.
- Avoid manual changes in cloud consoles to maintain consistency.

---

## Future Improvements

- Modularize Terraform configuration
- Use dynamic inventory for Ansible
- Integrate CI/CD pipeline (GitHub Actions)
- Add application deployment (e.g., Node.js or Dockerized services)
- Implement AWS SSM to eliminate SSH dependency

---

## Conclusion

This project demonstrates a production-style workflow where infrastructure provisioning and configuration are fully automated using industry-standard tools. It serves as a foundational step toward building scalable and maintainable DevOps pipelines.
