output "instances" {
  value       = aws_instance.my_server.*.id
}
