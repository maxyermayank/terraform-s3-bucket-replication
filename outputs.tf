output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = "${aws_s3_bucket.source.id}"
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = "${aws_s3_bucket.source.arn}"
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = "${aws_s3_bucket.source.region}"
}

output "s3_bucket_domain_name" {
  description = "The AWS bucket domain name."
  value       = "${aws_s3_bucket.source.bucket_domain_name}"
}

output "s3_bucket_regional_domain_name" {
  description = "The AWS bucket Regional domain name."
  value       = "${aws_s3_bucket.source.bucket_regional_domain_name}"
}
