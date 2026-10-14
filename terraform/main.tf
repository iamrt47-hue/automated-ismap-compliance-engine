provider "aws" {
  region = "ap-northeast-1" # Hardcoded to target the Japan market location context
}

resource "aws_vpc" "corporate_hub" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name           = "tokyo-enterprise-hub"
    ComplianceScope = "ISMAP-Audit-Zone"
  }
}

# ENGINEERED SECURITY FLAW: Permissive administrative port ingress exposed publicly
resource "aws_security_group" "vulnerable_ingress_sg" {
  name        = "gateway-perimeter-rules"
  description = "Simulated legacy edge entry point"
  vpc_id      = aws_vpc.corporate_hub.id

  ingress {
    description = "CRITICAL FLAW: Open SSH ingress violating ISMAP Boundary Controls"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to the public internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
