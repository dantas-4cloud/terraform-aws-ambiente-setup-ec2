variable "nome" {
  type        = string
  description = "Nome da instância"
}

variable "environment" {
  type        = string
  description = "Ambiente da instância"
  default     = "dev"
}

variable "ebs_block_devices" {
  description = "List of EBS block devices to attach to the instances"
  type        = list(any)
}