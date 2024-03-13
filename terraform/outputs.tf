output "nginx_server_ip" {
  value = module.compute_instances.nginx_public_ip
}

output "tool_server_ips" {
  value = [module.compute_instances.tool_server_ips]
}
