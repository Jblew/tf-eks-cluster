# tf-eks-cluster
Terraform example of EKS cluster

## Usage

1. Create an AWS user with key-based access.
2. Assign an IAM policy to the user using the defined in [./aws.policy.json](./aws.policy.json) file.
3. Create the `keys.tfvars` file with the following format:

   ```hcl
   aws_access_key_id = "paste key here"
   aws_secret_access_key = "paste key here"
   ```
4. Initialize S3 + Dynamodb backend for storing Terraform state with `cd init-tf-on-aws && terraform apply -var-file="../keys.tfvars"`

## Cleanup

1. Remove the `infra` aws resources: `cd infra && terraform destroy -var-file="../keys.tfvars"`
1. Remove the `init-tf-on-aws` aws resources: `cd init-tf-on-aws && terraform destroy -var-file="../keys.tfvars"`
