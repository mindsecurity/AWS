#!/bin/bash

POLICY=$1
BUCKET=$2

echo "Creating IAM policy '$POLICY'"
aws iam create-policy --policy-name "'$POLICY'" \
 --description "An IAM policy that allows IAM users to access their own home directory in S3. The home directory is a bucket that includes a home folder and folders for individual users (Programmatically and in the Console)." \
 --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::*",
            "Effect": "Allow"
        },
        {
            "Action": "s3:ListBucket",
            "Resource": [
                "arn:aws:s3:::arn:aws:s3:::$BUCKET"
            ],
            "Effect": "Allow",
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "",
                        "home/",
                        "home/${aws:username}/*"
                    ]
                }
            }
        },
        {
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::arn:aws:s3:::$BUCKET/home/${aws:username}",
                "arn:aws:s3:::arn:aws:s3:::$BUCKET/home/${aws:username}/*"
            ],
            "Effect": "Allow"
        }
    ]
}' \
 --region "undefined"
