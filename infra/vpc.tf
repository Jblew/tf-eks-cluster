resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/18"
  # assign_generated_ipv6_cidr_block = true
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf-eks-cluster-vpc-main"
  }
}

resource "aws_subnet" "az_a_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/22"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-eks-cluster-vpc-subnet-a-public"
  }
}

resource "aws_subnet" "az_b_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/22"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-eks-cluster-vpc-subnet-b-public"
  }
}

resource "aws_subnet" "az_a_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.32.0/22"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "tf-eks-cluster-vpc-subnet-a-private"
  }
}

resource "aws_subnet" "az_b_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.36.0/22"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "tf-eks-cluster-vpc-subnet-b-private"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags {
        Name = "tf-eks-cluster-vpc-igw"
    }
}

resource "aws_route_table" "public_crt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0" //associated subnet can reach everywhere
        gateway_id = aws_internet_gateway.igw.id //CRT uses this IGW to reach internet
    }
    tags {
        Name = "tf-eks-cluster-vpc-public-crt"
    }
}

resource "aws_route_table_association" "crta_public_a"{
    subnet_id = aws_subnet.az_a_public.id
    route_table_id = aws_route_table.public_crt.id
}

resource "aws_route_table_association" "crta_public_b"{
    subnet_id = aws_subnet.az_b_public.id
    route_table_id = aws_route_table.public_crt.id
}

resource "aws_nat_gateway" "public_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.az_a_private.id

  tags = {
    Name = "tf-eks-cluster-vpc-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "tf-eks-cluster-vpc-eip"
  }
}
