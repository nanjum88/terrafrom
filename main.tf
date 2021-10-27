provider "aws" {
    region = "us-west-2"
    access_key = "AKIAZ3HYQLTJ7LIKD5FE"
    secret_key = "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"
}

variable "cidr_blocks" {
  description = "vpc & subnet cidr blocks"
  type = list(object({ 
        cidr_block = string
        Name = string
   }))
}

resource "aws_vpc" "development-vpc1" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name = var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc1.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "us-west-2a"
    tags = {
        Name = var.cidr_blocks[1].name
    }
}

data "aws_vpc" "existing-vpc" {
    default = true
}

resource "aws_subnet" "existing_subnet-1" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "us-west-2a"
    tags = {
        Name = "Existing-dev-Subnet"
    }

}

output "vpc_id" {
  value = aws_vpc.development-vpc1.id
}

output "subnet_id" {
  value = aws_subnet.existing_subnet-1.id
}
