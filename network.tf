data "aws_availability_zones" "us_east_1" {
  provider = aws.us_east_1
  state    = "available"
}

data "aws_availability_zones" "us_east_2" {
  provider = aws.us_east_2
  state    = "available"
}

# US East 1 Resources
resource "aws_vpc" "us_east_1" {
  provider             = aws.us_east_1
  cidr_block           = local.regions.us_east_1.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "ecs-vpc-us-east-1"
  })
}

resource "aws_subnet" "us_east_1_public" {
  provider          = aws.us_east_1
  count             = 2
  vpc_id            = aws_vpc.us_east_1.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = data.aws_availability_zones.us_east_1.names[count.index]

  tags = merge(local.common_tags, {
    Name = "ecs-public-subnet-us-east-1-${count.index + 1}"
  })
}

resource "aws_internet_gateway" "us_east_1" {
  provider = aws.us_east_1
  vpc_id   = aws_vpc.us_east_1.id

  tags = merge(local.common_tags, {
    Name = "ecs-igw-us-east-1"
  })
}

resource "aws_route_table" "us_east_1_public" {
  provider = aws.us_east_1
  vpc_id   = aws_vpc.us_east_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us_east_1.id
  }

  tags = merge(local.common_tags, {
    Name = "ecs-public-rt-us-east-1"
  })
}

resource "aws_route_table_association" "us_east_1_public" {
  provider       = aws.us_east_1
  count          = 2
  subnet_id      = aws_subnet.us_east_1_public[count.index].id
  route_table_id = aws_route_table.us_east_1_public.id
}

# US East 2 Resources
resource "aws_vpc" "us_east_2" {
  provider             = aws.us_east_2
  cidr_block           = local.regions.us_east_2.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "ecs-vpc-us-east-2"
  })
}

resource "aws_subnet" "us_east_2_public" {
  provider          = aws.us_east_2
  count             = 2
  vpc_id            = aws_vpc.us_east_2.id
  cidr_block        = "10.1.${count.index + 1}.0/24"
  availability_zone = data.aws_availability_zones.us_east_2.names[count.index]

  tags = merge(local.common_tags, {
    Name = "ecs-public-subnet-us-east-2-${count.index + 1}"
  })
}

resource "aws_internet_gateway" "us_east_2" {
  provider = aws.us_east_2
  vpc_id   = aws_vpc.us_east_2.id

  tags = merge(local.common_tags, {
    Name = "ecs-igw-us-east-2"
  })
}

resource "aws_route_table" "us_east_2_public" {
  provider = aws.us_east_2
  vpc_id   = aws_vpc.us_east_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us_east_2.id
  }

  tags = merge(local.common_tags, {
    Name = "ecs-public-rt-us-east-2"
  })
}

resource "aws_route_table_association" "us_east_2_public" {
  provider       = aws.us_east_2
  count          = 2
  subnet_id      = aws_subnet.us_east_2_public[count.index].id
  route_table_id = aws_route_table.us_east_2_public.id
}
