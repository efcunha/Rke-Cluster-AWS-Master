# Criar IP elástico
resource "aws_eip" "main" {
  vpc              = true
}

# Cria Gateway NAT
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "NAT Gateway for Custom Kubernetes Cluster"
  }
}

# Adiciona rota à tabela de rotas
resource "aws_route" "main" {
  route_table_id            = aws_vpc.custom_vpc.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}