variable "virtual_machine_name" {
  type = string
}

variable "virtual_machine_resource_group" {
  type = string
}

variable "virtual_machine_location" {
  type = string
}

variable "virtual_machine_domain_name_label" {
  type = string
}

variable "virtual_machine_subnet_id" {
  type = string
}

variable "virtual_machine_public_ip" {
  type    = bool
  default = false
}

variable "virtual_machine_size" {
  type = string
}

variable "virtual_machine_admin_user" {
  type = string
}

/*
variable "virtual_machine_public_key" {
  type = string
}
*/

variable "virtual_machine_admin_password" {
  type = string

}