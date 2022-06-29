variable "profile" {
  description = "Perfil AWS"
  type        = string
}

variable "region" {
  description = "região aws para implantar"
  type        = string
}

variable "cluster_name" {
  description = "O nome do cluster"
  type = string
}

variable "environment" {
  description = "Ambiente de aplicação"
  type = string
}

variable "key_name" {
  type = string
}