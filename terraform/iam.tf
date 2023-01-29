resource "aws_iam_user" "github_action_anwarias_cloudchallenge" {
  name = "github-action-anwarias-cloudchallenge"
}

resource "aws_iam_group" "github_action_cloudchallenge" {
  name = "github_action_cloudchallenge"
}

resource "aws_iam_group_membership" "assignment" {
  name  = "assignment"
  users = [aws_iam_user.github_action_anwarias_cloudchallenge.name]
  group = aws_iam_group.github_action_cloudchallenge.name
}

resource "aws_iam_group_policy" "github_action_anwarias_cloudchallenge" {
  name  = "github_action_anwarias_cloudchallenge"
  group = aws_iam_group.github_action_cloudchallenge.name
  policy = jsonencode({
    Version = "2012-10-07"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.databucket}/*",
          "arn:aws:s3:::${var.databucket}"
        ]
      }
    ]
  })
}