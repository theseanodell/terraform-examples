module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.vpc-name
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets     = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
  public_subnets      = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
  database_subnets    = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]
  elasticache_subnets = ["20.10.31.0/24", "20.10.32.0/24", "20.10.33.0/24"]
  redshift_subnets    = ["20.10.41.0/24", "20.10.42.0/24", "20.10.43.0/24"]
  intra_subnets       = ["20.10.51.0/24", "20.10.52.0/24", "20.10.53.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true
  create_database_subnet_group = false

  manage_default_route_table = true
  default_route_table_tags   = { DefaultRouteTable = true }

  enable_classiclink             = true
  enable_classiclink_dns_support = true

  enable_dns_hostnames = true
  enable_dns_support   = true

# VPC Flow Logs (Cloudwatch log group and IAM role will be created)

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

# VPC endpoint for S3
# Note - S3 Interface type support is only available on AWS provider 3.10 and later
  enable_s3_endpoint              = true
  s3_endpoint_type                = "Interface"
  s3_endpoint_private_dns_enabled = false
  s3_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for DynamoDB
  enable_dynamodb_endpoint = true
  dynamodb_endpoint_policy = data.aws_iam_policy_document.dynamodb_endpoint_policy.json

# VPC endpoint for SSM
  enable_ssm_endpoint              = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for Lambda
  enable_lambda_endpoint              = true
  lambda_endpoint_private_dns_enabled = true
  lambda_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for SSMMESSAGES
  enable_ssmmessages_endpoint              = true
  ssmmessages_endpoint_private_dns_enabled = true
  ssmmessages_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC Endpoint for EC2
  enable_ec2_endpoint              = true
  ec2_endpoint_policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC Endpoint for EC2MESSAGES
  enable_ec2messages_endpoint              = true
  ec2messages_endpoint_private_dns_enabled = true
  ec2messages_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC Endpoint for ECR API
  enable_ecr_api_endpoint              = true
  ecr_api_endpoint_policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
  ecr_api_endpoint_private_dns_enabled = true
  ecr_api_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC Endpoint for ECR DKR
  enable_ecr_dkr_endpoint              = true
  ecr_dkr_endpoint_policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
  ecr_dkr_endpoint_private_dns_enabled = true
  ecr_dkr_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for KMS
  enable_kms_endpoint              = true
  kms_endpoint_private_dns_enabled = true
  kms_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for ECS
  enable_ecs_endpoint              = true
  ecs_endpoint_private_dns_enabled = true
  ecs_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for ECS telemetry
  enable_ecs_telemetry_endpoint              = true
  ecs_telemetry_endpoint_private_dns_enabled = true
  ecs_telemetry_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for CodeDeploy
  enable_codedeploy_endpoint              = true
  codedeploy_endpoint_private_dns_enabled = true
  codedeploy_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# VPC endpoint for CodeDeploy Commands Secure
  enable_codedeploy_commands_secure_endpoint              = true
  codedeploy_commands_secure_endpoint_private_dns_enabled = true
  codedeploy_commands_secure_endpoint_security_group_ids  = [data.aws_security_group.default.id]

# Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

# Tagging 
  vpc_tags = {
    Name  = var.vpc-name
    Endpoint = "true"
  }

  tags = {
    Terraform = "true"
    Customer = var.customer
    Product = var.product
    Team = var.team
    Owner = var.owner
    Environment = var.environment
    Organization = var.organization
    "Cost Center" = var.cost-center
  }

  vpc_endpoint_tags = {
    Project  = "Secret"
    Endpoint = "true"
  }
}
