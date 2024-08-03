# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance_id" {
  description = "ID of the EC2 instance"
  # value       = aws_instance.web_app.id   # 삭제
  value = [for instance in aws_instance.web_app : instance.id] # 추가

}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  # value       = aws_instance.web_app.public_ip   # 삭제
  value = [for instance in aws_instance.web_app : instance.public_ip] #추가

}

output "instance_name" {
  description = "Tags of the EC2 instance"
  # value = aws_instance.web_app.tags   # 삭제
  value = [for instance in aws_instance.web_app : instance.tags.Name] #추가
}
