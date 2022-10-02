# tf-eks-cluster
Terraform example of EKS cluster

## Usage

1. Create a user with key-based access.
2. Assign an IAM policy to the user using the defined in [./aws.policy.json](./aws.policy.json) file.
3. Initialize S3 + Dynamodb backend for storing Terraform state with `cd init && terraform apply`
