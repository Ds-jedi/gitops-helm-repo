resource "aws_iam_role" "test_role" {
    #arn                   = "arn:aws:iam::995515626231:role/dev-demo-stage-eks-aws-lb-controller"
    assume_role_policy    = jsonencode(
        {
            Statement = [
                {
                    Action    = [
                        "sts:AssumeRoleWithWebIdentity",
                        "sts:AssumeRole",
                    ]
                    Condition = {
                        StringEquals = {
                            "oidc.eks.us-east-1.amazonaws.com/id/21E023A20198F4BC5DD65CC46F4E96D3:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
                        }
                    }
                    Effect    = "Allow"
                    Principal = {
                        Federated = "arn:aws:iam::521525530234:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/21E023A20198F4BC5DD65CC46F4E96D3"
                    }
                    Sid       = ""
                },
            ]
            Version   = "2012-10-17"
        }
    )
    #create_date           = "2023-10-22T18:47:48Z"
    force_detach_policies = false
    #id                    = "dev-demo-stage-eks-aws-lb-controller"
    managed_policy_arns   = [
        "arn:aws:iam::521525530234:policy/dev-demo-stage-eks-aws-lb-controller",
    ]
    max_session_duration  = 43200
    name                  = "dev-demo-stage-eks-aws-lb-controller"
    path                  = "/"
    tags                  = {
        "Createdby"   = "Terraform"
        "Environment" = "stage"
        "Project"     = "dev-demo"
        "Team"        = "devops"
    }
    tags_all              = {
        "Createdby"   = "Terraform"
        "Environment" = "stage"
        "Project"     = "dev-demo"
        "Team"        = "devops"
    }
    #unique_id             = "AROA6PSK26L3TRWHI2LCP"
}

# terraform import aws_iam_role.test_role dev-demo-stage-eks-aws-lb-controller