# tf-eks-cluster
Terraform example of EKS cluster

## Usage

1. Create an AWS user with key-based access.
2. Assign an IAM policy to the user using the defined in [./aws.policy.json](./aws.policy.json) file.
3. Create the `aws.tfvars` file with the following format:

   ```hcl
   access_key = "paste key here"
   secret_key = "paste key here"
   region     = "eu-central-1"
   ```
4. Initialize S3 + Dynamodb backend for storing Terraform state with:

   ````bash
   cd init-tf-on-aws
   terraform init
   terraform apply -var-file="../aws.tfvars"
   ````
5. Initialize and apply the cluster:

   ```bash
   cd infra
   terraform init -backend-config="../aws.tfvars"
   terraform plan -var-file="../aws.tfvars"
   ```

   

## Cleanup

1. Remove the `infra` aws resources: `cd infra && terraform destroy -var-file="../keys.tfvars"`
1. Remove the `init-tf-on-aws` aws resources: `cd init-tf-on-aws && terraform destroy -var-file="../keys.tfvars"`
