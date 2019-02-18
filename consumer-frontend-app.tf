# Purpose: use this file to demo private module registry
# Input Variables: number_of_instances, name
# Configuration:
# 1) Add private module into TFE from https://github.com/mocofound/terraform-aws-consumer-elb
# 2) Add private module into TFE from https://github.com/mocofound/terraform-aws-consumer-ec2-instance
# 3) In code below, for all modules, change module versions appropriatly for your imports (e.g. version = "1.9")
# 4) In code below, for all modules, change source = "" to match your modules source
# 5) Modify variables as needed
# 6) rename file from consumer-frontend-app.nothing to  consumer-frontend-app.tf

variable "number_of_instances" {
  description = "Number of instances to create and attach to Consumer ELB"
  default     = 2
}

variable "name" {
  description = "The name of the app deployed"
  default = "Consumer-App"
}

module "elb" {
  source  = "app.terraform.io/aharness-org/consumer-elb/aws"
  version = "1.9"
  name = "${var.name}-elb"
  
  # ELB attachments
  number_of_instances = "${var.number_of_instances}"
  instances           = ["${module.ec2_instances.id}"]
}
  
module "ec2_instances" {
  source = "app.terraform.io/aharness-org/consumer-ec2-instance/aws"
  version = "1.4"
  name                        = "${var.name}-ec2"
  instance_count = "${var.number_of_instances}"
}
