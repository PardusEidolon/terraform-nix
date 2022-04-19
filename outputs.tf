output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.ec2_instance.instance_state
}
# output "volume_size" {
#   description = "Disk size of the EC2 instance"
#   value       = aws_instance.ec2_instance.root_block_device.volume_size
# }