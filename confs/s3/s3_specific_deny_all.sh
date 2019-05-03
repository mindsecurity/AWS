#!/bin/bash

POLICY=$1
BUCKET=$2

echo "Creating IAM policy '$POLICY'"
aws iam create-policy --policy-name "$POLICY" \
 --description "An IAM policy that limits managing an S3 bucket by allowing all S3 actions on the specific bucket, but explicitly denying access to every AWS service except Amazon S3. This policy also denies access to actions that can't be performed on an S3 bucket, such as s3:ListAllMyBuckets or s3:GetObject. This policy provides the permissions necessary to complete this action using the AWS API or AWS CLI only." \
 --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::arn:aws:s3:::$BUCKET",
                "arn:aws:s3:::arn:aws:s3:::$BUCKET/*"
            ],
            "Effect": "Allow"
        },
        {
            "NotResource": [
                "arn:aws:s3:::arn:aws:s3:::$BUCKET",
                "arn:aws:s3:::arn:aws:s3:::$BUCKET/*"
            ],
            "Effect": "Deny"
        }
    ]
}' \
 --region "undefined"
