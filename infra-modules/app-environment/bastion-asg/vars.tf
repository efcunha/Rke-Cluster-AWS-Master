variable ec2_instance_type {
  type        = string
  default     = "t3.medium"
  description = "Tipos de instância de host EC2"
}

variable name_prefix {
  type        = string
  description = "Prefixo de nome ASG EC2"
}

variable asg_tag {
  type        = string
  description = "Nome da tag ASG"
}

variable launch_template_tag {
  type        = string
  description = "Nome da tag ASG"
}

variable user_data {
  type        = string
  description = "Dados do usuário EC2"
}

variable desired_capacity {
  type        = number
  description = "Capacidade desejada para ASG"
}

variable max_size {
  type        = number
  description = "Capacidade máxima para ASG"
}

variable min_size {
  type        = number
  description = "Capacidade mínima para ASG"
}

variable instance_profile_name {
  type        = string
  default     = "k8s_bastion_profile"
  description = "Nome do perfil da instância do EC2"
}

variable "availability_zones" {
  type  = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  description = "Lista de zonas de disponibilidade para a região selecionada"
}

variable vpc_id {
  type        = string
  description = "ID da VPC personalizada na qual os recursos são implantados"
}

variable "environment" {
  type        = string
  description = "Ambiente de aplicação"
}

variable private_subnet_ids {
  type        = list(string)
  description = "IDs de sub-rede privada"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "IDs de sub-rede privada"
}

variable launch_template_security_group_ids {
  type        = list(string)
  description = "Lançar modelos de SGs"
}

variable "cluster_name" {
  description = "O nome do cluster"
  type = string
}

variable "key_name" {
  type = string
}