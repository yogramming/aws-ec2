# Terraform + Ansible AWS EC2 Infrastructure - by yogramming

This project provisions an AWS EC2 instance using Terraform and configures it using Ansible. It uses S3 for remote state storage and DynamoDB for state locking.

## Features

- EC2 instance (t3.micro)
- Remote state storage using S3
- State locking using DynamoDB
- Key-based SSH authentication
- Ansible-based configuration management
- Clean and modular project structure

## Project Structure

```
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── terraform.tfvars
│
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yml
│
├── .gitignore
└── README.md
```

## Prerequisites

- Terraform
- AWS CLI (configured)
- Ansible
- SSH key pair configured

## Remote State Setup

Create S3 bucket:

```bash
aws s3 mb s3://<your-terraform-state-bucket>
```

Create DynamoDB table:

```bash
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

## Terraform Workflow

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

To destroy resources:

```bash
terraform destroy
```

## Ansible Usage

Update `inventory.ini` with EC2 public IP:

```
[web]
<public_ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ed25519
```

Run playbook:

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

## Notes

- Do not commit `.terraform/`, `terraform.tfstate`, or `.tfvars` files
- Always run `terraform plan` before `apply`
- Ensure security group allows SSH (port 22)

## License

MIT
