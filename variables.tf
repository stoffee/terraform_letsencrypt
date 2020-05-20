variable "acme_server_url" {
default = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "email_address" {
    description = "Email addressed used for Let's Encrypt!"
}

variable "common_name" {
    default = "www.domain.com"
}

variable "subject_alternative_names" {
    description = "This is a list of names you want to use in the SAN of the CA"
    default = ["www.domain.com","service.sub.domain.com"]
}

variable "aws_region" {
    default = "us-west-1"
}

variable "aws_access_key" {
}

variable "aws_secret_key" {
}