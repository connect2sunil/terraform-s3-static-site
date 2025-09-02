


resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static_website" {
  bucket = "s3-static-website-${random_id.bucket_suffix.hex}"
}

#enabling public access to the bucket
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = false # If set to true, it blocks any public access granted via ACLs 
  block_public_policy     = false #If true, it prevents bucket policies that allow public access.
  ignore_public_acls      = false #If true, S3 will ignore any public ACLs, even if they exist.
  restrict_public_buckets = false #If true, it blocks all public access regardless of ACLs or policies—even if you try to make it public.
}
#policy to allow only reads on this bucket and deny write
resource "aws_s3_bucket_policy" "read_policy" {
  bucket = aws_s3_bucket.static_website.id
  policy = jsonencode({    # Converts a native HCL object into a JSON string, which is required by AWS for bucket policies.
    Version = "2012-10-17" # Specifies the policy language version. "2012-10-17" is the latest and standard version for AWS IAM policies.
    Statement = [          # Begins the list of policy statements. Each statement defines a permission rule
      {
        Sid       = "PublicReadGetObject" # Sid is an optional identifier for the statement. Here, it's named to reflect its purpose
        Effect    = "Allow"               # Grants permission
        Principal = "*"                   # Applies the permission to everyone 
        Action = [
          "s3:GetObject" # Allows the s3:GetObject action, which lets users read/download objects from the bucket.
        ]
        Resource = "${aws_s3_bucket.static_website.arn}/*" # Targets all objects inside the bucket by appending /* to the bucket’s ARN.

        /*The policy allows (Effect = "Allow") everyone (Principal = "*") to perform read-only actions (Action = ["s3:GetObject"]) on all objects inside the specified 
S3 bucket (Resource = "${aws_s3_bucket.static_website.arn}/*"). */
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "build/index.html"
  content_type = "text/html"

}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "error.html"
  source       = "build/error.html"
  content_type = "text/html"
}