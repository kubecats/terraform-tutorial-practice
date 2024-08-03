# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "public_dns_name" {
  description = "Public DNS name of load balancer."
  value       = module.elb_http.elb_dns_name
}

output "vpc_arn" {
  description = "ARN of the vpc."
  value       = module.vpc.vpc_arn
}

output "instance_ids" {
  description = "IDs of EC2 instances."
  value       = aws_instance.app.*.id
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
}

data "aws_subnet" "subnet_details" {
  count = length(data.aws_subnets.all.ids)
  id    = element(data.aws_subnets.all.ids, count.index)
}

output "subnet_az_mapping" {
  value = {
    for subnet in data.aws_subnets.all.ids :
    subnet => element(data.aws_subnet.subnet_details.*.availability_zone, index(data.aws_subnets.all.ids, subnet))
  }
}