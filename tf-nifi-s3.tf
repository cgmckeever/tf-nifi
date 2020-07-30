# s3 bucket
resource "aws_s3_bucket" "tf-nifi-bucket" {
  bucket                  = var.bucket_name
  acl                     = "private"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.tf-nifi-kmscmk.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# s3 objects (zookeeper playbook)
resource "aws_s3_bucket_object" "tf-nifi-zookeepers" {
  for_each                = fileset("zookeepers/", "*")
  bucket                  = aws_s3_bucket.tf-nifi-bucket.id
  key                     = "zookeepers/${each.value}"
  source                  = "zookeepers/${each.value}"
  etag                    = filemd5("zookeepers/${each.value}")
}