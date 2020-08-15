# **terraform-s3-bucket-replication**
AWS S3 Bucket Same Region Replication (SRR) using Terraform

![](images/demo.gif)

### **NOTES**
Make sure to update terraform.tfvars file to configure variable per your needs. Do not use Access and Secret keys inline. Checkout Terraform documentation for proper approaches to use credentials.

Make sure to tighten our IAM ROLES for better security.

# **Configure Variables**
| Variable | Example Value | Description |
|----------|---------------|-------------|
| region | us-west-2 | The AWS region to issue API requests in. |
| access_key | AKIAIOSFODNN7EXAMPLE |  |
| secret_key | wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY |  |


# **Initialize Terraform**
```
terraform init
```
![](images/terraforminit.png)

# **Plan and predict changes**
```
terraform plan
```
![](images/terraformplan.png)

# **Create reproducible infrastructure**
```
terraform apply
```
![](images/terraformapply.png)

#### **Verify Buckets are created**
![](images/bucketlist.png)

#### **Verify Replication configuration on Source Buckets**
![](images/replicationconfig.png)


# **Destroy deployed infrastructure**
```
terraform destroy
```
![](images/terraformdestroy.png)


# Resources
- [Hashicorp Terraform](https://www.terraform.io)
- [Security Best Practices for Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/security-best-practices.html)