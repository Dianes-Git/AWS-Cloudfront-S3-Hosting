resource "aws_s3_object" "website_files" {
  for_each = fileset("website/", "**")

  bucket       = aws_s3_bucket.website_bucket.id
  key          = each.value
  source       = "website/${each.value}"
  etag         = filemd5("website/${each.value}")
  content_type = lookup(var.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
}

variable "mime_types" {
  type = map(string)
  default = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
  }
}
