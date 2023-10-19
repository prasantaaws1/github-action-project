resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "Demo_vpc"
    }
}

resource "aws_subnet" "subnet" {
    count = length(var.subnet_cidr)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr[count.index]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = var.subnet_names[count.index]
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "demo-igw"
    }
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "My_Route_Table"
    }
}

resource "aws_route_table_association" "rta" {
    count = length(var.subnet_cidr)
    subnet_id = aws_subnet.subnet[count.index].id
    route_table_id = aws_route_table.rt.id
}