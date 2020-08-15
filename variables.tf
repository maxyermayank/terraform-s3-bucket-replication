variable "access_key" {
  description = "AWS Access Key"
}

variable "secret_key" {
  description = "AWS Secret Key"
}

variable "region" {
    default = "us-west-2"
    description = "AWS Region"
}

variable "source_bucket_name" {
  type        = string
  description = "Source Bucket Name"
}

variable "stage" {
  type        = string
  description = "Deployment stage/environment name"
}

variable "project" {
  type        = string
  description = "Project Name"
  default     = "Bucket Replication Project"
}

variable "product" {
  type        = string
  description = "Product Domain"
  default     = "DEMO"
}

variable "description" {
  type        = string
  description = "The description of this S3 bucket"
  default     = "S3 Bucket to hold your Data"
}

variable "managedBy" {
  description = "Managed By automation tool name"
  default     = "Terraform"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "public" {

  description = "Allow public read access to bucket"
  default     = "private"
}

variable "force_destroy" {
  description = "Delete all objects in bucket on destroy"
  default     = false
}

variable "versioned" {
  description = "Version the bucket"
  default     = true
}

variable "lifecycle_enabled" {
  description = "Is Lifecycle enabled?"
  default     = false
}

variable "iam_role_name" {
  type        = string
  description = "IAM Role name for replication"
}

variable "destination_bucket_name" {
  type        = string
  description = "Destination bucket name"
}
