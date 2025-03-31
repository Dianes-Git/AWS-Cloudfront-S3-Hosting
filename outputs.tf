output "s3_website_url" {
  description = "The URL of the S3 static website"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "cloudfront_distribution_url" {
  description = "The CloudFront distribution URL"
  value       = "https://${aws_cloudfront_distribution.cdn.domain_name}"
}
