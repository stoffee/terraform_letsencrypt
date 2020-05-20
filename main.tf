provider "acme" {
  server_url = var.acme_server_url
}

resource "tls_private_key" "reg_private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.reg_private_key.private_key_pem
  email_address   = var.email_address
}
resource "tls_private_key" "cert_private_key" {
  algorithm = "RSA"
}

resource "tls_cert_request" "req" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.cert_private_key.private_key_pem
  dns_names       = var.subject_alternative_names

  subject {
    common_name = var.common_name
  }
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  certificate_request_pem   = tls_cert_request.req.cert_request_pem

  dns_challenge {
    provider = "route53"

    config = {
      AWS_ACCESS_KEY_ID     = var.aws_access_key
      AWS_SECRET_ACCESS_KEY = var.aws_secret_key
      AWS_DEFAULT_REGION    = var.aws_region
    }
  }
}

resource "local_file" "reg_private_key" {
    content     = tls_private_key.reg_private_key.private_key_pem
    filename = "${path.module}/${var.common_name}-reg-private-key.pem"
}

resource "local_file" "reg_public_key" {
    content     = tls_private_key.reg_private_key.public_key_pem
    filename = "${path.module}/${var.common_name}-reg-public-key.pem"
}

resource "local_file" "cert_private_key" {
    content     = tls_private_key.cert_private_key.private_key_pem
    filename = "${path.module}/${var.common_name}-cert-private-key.pem"
}

resource "local_file" "cert_public_key" {
    content     = tls_private_key.cert_private_key.public_key_pem
    filename = "${path.module}/${var.common_name}-cert-public-key.pem"
}