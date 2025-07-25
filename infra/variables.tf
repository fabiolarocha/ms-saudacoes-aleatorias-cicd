variable "app_name" {
  type    = string
  default = "ms-saudacoes-aleatorias-app"
}

variable "service_name" {
  type    = string
  default = "ms-saudacoes-aleatorias-service"
}

variable "instance_type" {
  type    = string
  default = "free"
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "docker_user_name" {
  description = "fabiolarochauft"
  type        = string
  sensitive   = false # Não é sensível se for apenas o nome de usuário
}

variable "docker_image_name" {
  type    = string
  default = "ms-saudacoes-aleatorias"
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}