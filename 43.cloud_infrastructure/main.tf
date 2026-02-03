provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_user" "devops_user" {
  name = "devops_user"  
}

resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "s3_full_access_policy"
  description = "Policy to grant full access to S3"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "devops_user_s3_policy_attachment" {
  name       = "devops_user_s3_policy_attachment"
  users      = [aws_iam_user.devops_user.name]
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
  
}

resource "aws_iam_role" "devops_role" {
    name = "devops_role"
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        }
      ]
    })  
}

resource "aws_iam_role_policy_attachment" "devops_role_s3_policy" {
  role = aws_iam_role.devops_role.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

resource "aws_iam_group" "devops_group" {
  name = "devops_group"  
}

resource "aws_iam_group_policy_attachment" "devops_group_s3_policy" {
  group = aws_iam_group.devops_group.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

resource "aws_iam_user_group_membership" "devops_user_group_membership" {
  user = aws_iam_user.devops_user.name
  groups = [aws_iam_group.devops_group.name]
}