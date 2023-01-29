resource "aws_iam_user" "github_action_user" {
  name = "github-action-anwarias-cloudchallenge"
}

resource "aws_iam_group" "github_action_group" {
  name = "github-action-anwarias-cloudchallenge"
}

resource "aws_iam_group_membership" "github_action_policyassignment" {
  name  = "github-action-policyassignment"
  users = [aws_iam_user.github_action_user.name]
  group = aws_iam_group.github_action_group.name
}

data "aws_iam_policy_document" "github_action_policy" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = [
        aws_s3_bucket.databucket.arn,
        "${aws_s3_bucket.databucket.arn}/*"
    ]
    effect    = "Allow"
  }
}

resource "aws_iam_group_policy" "github_action_policy" {
  name   = "github-action-anwarias-cloudchallenge_policy"
  group  = aws_iam_group.github_action_group.name
  policy = data.aws_iam_policy_document.github_action_policy.json
}