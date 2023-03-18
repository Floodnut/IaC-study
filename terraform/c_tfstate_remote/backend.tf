terraform {
    backend "s3" {
        bucket = "your_bucket_name"
        region = "ap-northeast-2"
        key = "terraform/project"
    }
}