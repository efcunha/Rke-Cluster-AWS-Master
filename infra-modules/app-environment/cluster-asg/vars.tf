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
  default     = "k8s_control_plane_profile"
  description = "Nome do perfil da instância do EC2"
}

variable "availability_zones" {
  type  = list(string)
  default = ["us-east-1a", "us-east-1b", "us-eastS-1c"]
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
  description = "Private subnet IDs"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "Private subnet IDs"
}

variable launch_template_security_group_ids {
  type        = list(string)
  description = "Launch template SGs"
}

/* variable "target_group_arn" {
  type        = string
  description = "List of target groups"
} */

variable "cluster_name" {
  description = "The name of the cluster"
  type = string
}

variable "key_name" {
  type = string
}