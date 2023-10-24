resource "aws_iam_policy" "policy" {
    #arn         = "arn:aws:iam::995515626231:policy/dev-demo-stage-eks-aws-lb-controller"
    description = "IAM Policy"
    #id          = "arn:aws:iam::995515626231:policy/dev-demo-stage-eks-aws-lb-controller"
    name        = "dev-demo-stage-eks-aws-lb-controller"
    path        = "/"
    policy      = jsonencode(
        {
            Statement = [
                {
                    Action    = "ec2:CreateTags"
                    Condition = {
                        Null         = {
                            "aws:RequestTag/elbv2.k8s.aws/cluster" = "false"
                        }
                        StringEquals = {
                            "ec2:CreateAction" = "CreateSecurityGroup"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "arn:aws:ec2:*:*:security-group/*"
                    Sid       = "VisualEditor0"
                },
                {
                    Action    = [
                        "ec2:DeleteTags",
                        "ec2:CreateTags",
                    ]
                    Condition = {
                        Null = {
                            "aws:RequestTag/elbv2.k8s.aws/cluster"  = "true"
                            "aws:ResourceTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "arn:aws:ec2:*:*:security-group/*"
                    Sid       = "VisualEditor1"
                },
                {
                    Action    = [
                        "ec2:RevokeSecurityGroupIngress",
                        "ec2:AuthorizeSecurityGroupIngress",
                        "ec2:DeleteSecurityGroup",
                    ]
                    Condition = {
                        Null = {
                            "aws:ResourceTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "*"
                    Sid       = "VisualEditor2"
                },
                {
                    Action   = [
                        "ec2:AuthorizeSecurityGroupIngress",
                        "elasticloadbalancing:ModifyListener",
                        "wafv2:AssociateWebACL",
                        "ec2:DescribeInstances",
                        "wafv2:GetWebACLForResource",
                        "iam:ListServerCertificates",
                        "ec2:DescribeCoipPools",
                        "wafv2:GetWebACL",
                        "elasticloadbalancing:SetWebAcl",
                        "ec2:DescribeInternetGateways",
                        "waf-regional:GetWebACLForResource",
                        "elasticloadbalancing:DescribeLoadBalancers",
                        "waf-regional:GetWebACL",
                        "elasticloadbalancing:CreateRule",
                        "ec2:DescribeAccountAttributes",
                        "elasticloadbalancing:AddListenerCertificates",
                        "iam:GetServerCertificate",
                        "wafv2:DisassociateWebACL",
                        "ec2:DescribeVpcPeeringConnections",
                        "shield:GetSubscriptionState",
                        "ec2:RevokeSecurityGroupIngress",
                        "elasticloadbalancing:DescribeLoadBalancerAttributes",
                        "acm:DescribeCertificate",
                        "shield:CreateProtection",
                        "elasticloadbalancing:DescribeTargetGroupAttributes",
                        "elasticloadbalancing:ModifyRule",
                        "elasticloadbalancing:DescribeRules",
                        "ec2:DescribeSubnets",
                        "waf-regional:AssociateWebACL",
                        "ec2:DescribeAddresses",
                        "shield:DescribeProtection",
                        "shield:DeleteProtection",
                        "elasticloadbalancing:RemoveListenerCertificates",
                        "elasticloadbalancing:CreateListener",
                        "ec2:DescribeNetworkInterfaces",
                        "elasticloadbalancing:DescribeListeners",
                        "ec2:DescribeAvailabilityZones",
                        "ec2:CreateSecurityGroup",
                        "acm:ListCertificates",
                        "elasticloadbalancing:DescribeListenerCertificates",
                        "elasticloadbalancing:DeleteRule",
                        "cognito-idp:DescribeUserPoolClient",
                        "elasticloadbalancing:DescribeSSLPolicies",
                        "waf-regional:DisassociateWebACL",
                        "ec2:DescribeTags",
                        "ec2:GetCoipPoolUsage",
                        "elasticloadbalancing:DescribeTags",
                        "elasticloadbalancing:*",
                        "ec2:DescribeSecurityGroups",
                        "ec2:DescribeVpcs",
                        "elasticloadbalancing:DescribeTargetHealth",
                        "elasticloadbalancing:DescribeTargetGroups",
                        "elasticloadbalancing:DeleteListener",
                    ]
                    Effect   = "Allow"
                    Resource = "*"
                    Sid      = "VisualEditor3"
                },
                {
                    Action    = [
                        "elasticloadbalancing:CreateLoadBalancer",
                        "elasticloadbalancing:CreateTargetGroup",
                    ]
                    Condition = {
                        Null = {
                            "aws:RequestTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "*"
                    Sid       = "VisualEditor4"
                },
                {
                    Action    = [
                        "elasticloadbalancing:CreateLoadBalancer",
                        "elasticloadbalancing:CreateTargetGroup",
                    ]
                    Condition = {
                        Null = {
                            "aws:RequestTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "*"
                    Sid       = "VisualEditor5"
                },
                {
                    Action    = [
                        "elasticloadbalancing:RemoveTags",
                        "elasticloadbalancing:AddTags",
                    ]
                    Condition = {
                        Null = {
                            "aws:RequestTag/elbv2.k8s.aws/cluster"  = "true"
                            "aws:ResourceTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = [
                        "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                        "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
                        "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                    ]
                    Sid       = "VisualEditor6"
                },
                {
                    Action    = [
                        "elasticloadbalancing:RemoveTags",
                        "elasticloadbalancing:AddTags",
                    ]
                    Condition = {
                        Null = {
                            "aws:RequestTag/elbv2.k8s.aws/cluster"  = "true"
                            "aws:ResourceTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = [
                        "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                        "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
                        "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                    ]
                    Sid       = "VisualEditor7"
                },
                {
                    Action    = [
                        "elasticloadbalancing:DeleteLoadBalancer",
                        "elasticloadbalancing:SetSecurityGroups",
                        "elasticloadbalancing:SetIpAddressType",
                        "elasticloadbalancing:SetSubnets",
                        "elasticloadbalancing:ModifyLoadBalancerAttributes",
                        "elasticloadbalancing:DeleteTargetGroup",
                        "elasticloadbalancing:ModifyTargetGroupAttributes",
                        "elasticloadbalancing:ModifyTargetGroup",
                    ]
                    Condition = {
                        Null = {
                            "aws:ResourceTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "*"
                    Sid       = "VisualEditor8"
                },
                {
                    Action    = [
                        "elasticloadbalancing:DeleteLoadBalancer",
                        "elasticloadbalancing:SetSecurityGroups",
                        "elasticloadbalancing:SetIpAddressType",
                        "elasticloadbalancing:SetSubnets",
                        "elasticloadbalancing:ModifyLoadBalancerAttributes",
                        "elasticloadbalancing:DeleteTargetGroup",
                        "elasticloadbalancing:ModifyTargetGroupAttributes",
                        "elasticloadbalancing:ModifyTargetGroup",
                    ]
                    Condition = {
                        Null = {
                            "aws:ResourceTag/elbv2.k8s.aws/cluster" = "false"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "*"
                    Sid       = "VisualEditor9"
                },
                {
                    Action   = [
                        "elasticloadbalancing:RemoveTags",
                        "elasticloadbalancing:AddTags",
                    ]
                    Effect   = "Allow"
                    Resource = [
                        "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
                        "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
                        "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
                        "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
                    ]
                    Sid      = "VisualEditor10"
                },
                {
                    Action   = [
                        "elasticloadbalancing:RemoveTags",
                        "elasticloadbalancing:AddTags",
                    ]
                    Effect   = "Allow"
                    Resource = [
                        "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
                        "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
                        "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
                        "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
                    ]
                    Sid      = "VisualEditor11"
                },
                {
                    Action   = [
                        "elasticloadbalancing:RegisterTargets",
                        "elasticloadbalancing:DeregisterTargets",
                    ]
                    Effect   = "Allow"
                    Resource = "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
                    Sid      = "VisualEditor12"
                },
                {
                    Action    = "iam:CreateServiceLinkedRole"
                    Condition = {
                        StringEquals = {
                            "iam:AWSServiceName" = "elasticloadbalancing.amazonaws.com"
                        }
                    }
                    Effect    = "Allow"
                    Resource  = "*"
                    Sid       = "VisualEditor13"
                },
                {
                    Action   = [
                        "elasticloadbalancing:RegisterTargets",
                        "elasticloadbalancing:DeregisterTargets",
                    ]
                    Effect   = "Allow"
                    Resource = "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
                    Sid      = "VisualEditor14"
                },
            ]
            Version   = "2012-10-17"
        }
    )
    #policy_id   = "ANPA6PSK26L37VL5MIHZP"
    tags        = {
        "Createdby"   = "Terraform"
        "Environment" = "stage"
        "Project"     = "dev-demo"
        "Team"        = "devops"
    }
    tags_all    = {
        "Createdby"   = "Terraform"
        "Environment" = "stage"
        "Project"     = "dev-demo"
        "Team"        = "devops"
    }
}

#terraform import aws_iam_policy.policy arn:aws:iam::995515626231:policy/dev-demo-stage-eks-aws-lb-controller
