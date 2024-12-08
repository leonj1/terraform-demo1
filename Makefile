.PHONY: build clean docker-build docker-clean localstack-start localstack-stop tf-init tf-plan tf-apply

# Variables
DOCKER_IMAGE_NAME = react-hello-world
DOCKER_IMAGE_TAG = latest
DOCKER_FULL_IMAGE = $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

# Build the React application Docker image
build:
	@echo "Building React application Docker image..."
	cd website && docker build -t $(DOCKER_FULL_IMAGE) .

# Start Localstack and build services
localstack-start:
	@echo "Starting Localstack and services..."
	docker-compose up -d

# Stop Localstack and remove containers
localstack-stop:
	@echo "Stopping Localstack and services..."
	docker-compose down

# Initialize Terraform
tf-init:
	@echo "Initializing Terraform..."
	terraform init

# Plan Terraform changes
tf-plan:
	@echo "Planning Terraform changes..."
	terraform plan

# Apply Terraform changes
tf-apply:
	@echo "Applying Terraform changes..."
	terraform apply -auto-approve

# Build everything and start services
build: docker-build localstack-start
