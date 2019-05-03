#!/bin/bash 

BUCKET=$1

aws s3api create-bucket \
 --bucket "$BUCKET"
 
aws s3api put-bucket-encryption \
 --bucket "$BUCKET" \
 --server-side-encryption-configuration {"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"aws:kms","KMSMasterKeyID":"aws/s3"}}]}

aws s3api put-bucket-versioning \
 --bucket "$BUCKET" \
 --versioning-configuration {"Status":"Enabled"}

aws s3api put-bucket-logging \
 --bucket "$BUCKET" \
 --bucket-logging-status {"LoggingEnabled":{"TargetBucket":"","TargetPrefix":""}}

aws s3api put-bucket-acl \
 --bucket "$BUCKET" \
 --acl "Private"
