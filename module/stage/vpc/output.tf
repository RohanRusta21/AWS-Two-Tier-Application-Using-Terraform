output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet" {
  value = [for subnet in aws_aws_subnet.public_subnets : subnet.id]
}
output "private_subnet" {
  value = [for subnet in aws_aws_subnet.private_subnets : subnet.id]
}
# output "public_subnet" {
#   value = 
# }
# output "private_subnet_az2" {
#   value = 
# }

