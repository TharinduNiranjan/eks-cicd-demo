output "nginx_public_ip" {
  value = aws_instance.nginx_server.public_ip
}

output "keypair_name" {
value = aws_key_pair.user_key_pair.key_name
}


output "tool_server_ips" {
  value = { for instance_name, instance in aws_instance.tool_servers : instance_name => instance.private_ip }
}
