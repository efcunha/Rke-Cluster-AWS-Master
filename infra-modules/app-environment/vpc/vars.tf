variable "vpc_tag_name" {
  type        = string
  description = "Tag de nome para a VPC"
}

variable "route_table_tag_name" {
  type        = string
  default     = "main"
  description = "Descrição da tabela de rotas"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Intervalo de blocos CIDR para vpc"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
  description = "Intervalo de blocos CIDR para a sub-rede privada"
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
  description = "Intervalo de blocos CIDR para a sub-rede pública"
}

variable "private_subnet_tag_name" {
  type        = string
  default = "Custom Kubernetes cluster private subnet"
  description = "Etiqueta de nome para a sub-rede privada"
}

variable "public_subnet_tag_name" {
  type        = string
  default = "Custom Kubernetes cluster public subnet"
  description = "Etiqueta de nome para a sub-rede pública"
}

/* variable "nlb_name" {
  type = string
  description = "O nome do NLB"
} */

variable "environment" {
  type        = string
  description = "Ambiente de aplicação"
}

variable "availability_zones" {
  type  = list(string)
  default = ["us-east-1a", "us-east-1b"]
  description = "Lista de zonas de disponibilidade para a região selecionada"
}

variable "region" {
  description = "região aws para implantar"
  type        = string
}

variable "cluster_name" {
  description = "O nome do cluster"
  type = string
}