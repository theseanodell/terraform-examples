variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}
variable "vpc-name" {
  description = "AWS VPC Name"
  type        = string
}
variable "customer" {
  description = "Customer"
  type        = string
}
variable "product" {
  description = "Product"
  type        = string
}
variable "team" {
  description = "Team"
  type        = string
}
variable "owner" {
  description = "Owner"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}
variable "organization" {
  description = "Organization"
  type        = string
}
variable "cost-center" {
  description = "Cost Center"
  type        = string
}