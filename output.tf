output "server_url" {
  value = var.acme_server_url
}

output "registration_url" {
  value = acme_registration.reg.registration_url
}

output "registration_public_key_pem" {
  value = tls_private_key.reg_private_key.public_key_pem
}

output "registration_private_key_pem" {
  value = tls_private_key.reg_private_key.private_key_pem
}
