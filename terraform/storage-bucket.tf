terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_storage_bucket" "terraform" {
  access_key    = var.s3_access_key
  secret_key    = var.s3_secret_key
  bucket        = var.bucket_name
  force_destroy = true
}
