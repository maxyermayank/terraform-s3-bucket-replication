provider "aws" {
  access_key            = var.access_key
  secret_key            = var.secret_key
  region                = var.region
}

locals {
  global_tags = merge(
    {
      "Name"        = var.source_bucket_name
      "Product"     = var.product
      "Project"     = var.project
      "Environment" = var.stage
      "Description" = var.description
      "ManagedBy"   = var.managedBy
    },
    var.tags,
  )
}

resource "aws_s3_bucket" "destination" {
  bucket        = var.destination_bucket_name
  acl           = var.public
  force_destroy = var.force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = var.versioned
  }
  tags = local.global_tags
}

resource "aws_s3_bucket_policy" "destination" {
  bucket = aws_s3_bucket.destination.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:DeleteBucket"
      ],
      "Effect": "Deny",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.destination.id}",
      "Principal": {
        "AWS": ["*"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  name        = var.iam_role_name
  description = "Replication Policy"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectVersionForReplication",
                "s3:GetObjectVersionAcl"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.source.id}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetReplicationConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.source.id}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ReplicateObject",
                "s3:ReplicateDelete",
                "s3:ReplicateTags",
                "s3:GetObjectVersionTagging"
            ],
            "Resource": "arn:aws:s3:::${aws_s3_bucket.destination.id}/*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "replication" {
  name = var.iam_role_name
  tags = local.global_tags

  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Principal":{
            "Service":"s3.amazonaws.com"
         },
         "Action":"sts:AssumeRole"
      }
   ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "source" {
  bucket        = var.source_bucket_name
  acl           = var.public
  force_destroy = var.force_destroy

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = var.versioned
  }

  replication_configuration {
    role = aws_iam_role.replication.arn
    rules {
      id     = "destination"
      prefix = "DIRECTORY_NAME/"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.destination.arn
        storage_class = "STANDARD_IA"
      }
    }
  }
  tags = local.global_tags
}
