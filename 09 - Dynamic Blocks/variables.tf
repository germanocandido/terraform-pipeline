variable "portas" {
  description = "postas que serao abertas no SG"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}