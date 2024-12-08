# ECS React App with Localstack Pro

This project demonstrates how to deploy a React application to AWS ECS using Localstack Pro for local development and testing. The infrastructure is defined using Terraform, and the application is containerized using Docker.

## Prerequisites

- Docker and Docker Compose
- Terraform (>= 1.0.0)
- Make
- Localstack Pro account and authentication token

## Project Structure

```
.
├── website/              # React application source code
├── terraform/            # Terraform configuration files
├── docker-compose.yml    # Docker compose configuration
└── Makefile             # Build and deployment automation
```

## Environment Setup

1. Set your Localstack authentication token:
```bash
export LOCALSTACK_AUTH_TOKEN=your-token-here
```

## Building and Running

1. Build the React application Docker image:
```bash
make build
```

2. Initialize Terraform:
```bash
make tf-init
```

3. Plan and apply the infrastructure:
```bash
make tf-plan
make tf-apply
```

## Infrastructure Components

The project creates the following infrastructure:

- VPC with public subnets
- ECS Cluster
- ECS Task Definition for the React application
- ECS Service
- Security Group for the container
- IAM roles and policies

## Local Development

The project uses Localstack Pro to emulate AWS services locally. The following services are emulated:
- ECS
- EC2 (for networking)
- IAM
- Route53
- EventBridge

## Makefile Commands

- `make build` - Builds the React application Docker image
- `make localstack-start` - Starts Localstack Pro services
- `make localstack-stop` - Stops Localstack Pro services
- `make tf-init` - Initializes Terraform
- `make tf-plan` - Shows planned infrastructure changes
- `make tf-apply` - Applies infrastructure changes

## Notes

- The React application is a simple "Hello World" demonstration
- The application is containerized using a multi-stage Dockerfile for optimal image size
- Infrastructure is created locally using Localstack Pro
- Make sure your Localstack Pro subscription is active and your authentication token is valid

## Cleanup

To stop all services:
```bash
make localstack-stop
```

To destroy the infrastructure:
```bash
terraform destroy
```
