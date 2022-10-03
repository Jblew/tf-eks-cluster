
aws iam create-policy-version \
 --policy-arn arn:aws:iam::${AWS_USER_ID}:policy/${AWS_POLICY_NAME} \
 --policy-document file://./aws.policy.json --set-as-default
