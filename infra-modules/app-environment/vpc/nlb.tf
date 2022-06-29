/* # Cria NLB
resource "aws_lb" "nlb" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"

  enable_deletion_protection = false

  subnets            = aws_subnet.public_subnet.*.id
}

# Grupo-alvo NLB
resource "aws_lb_target_group" "nlb_tg" {
  depends_on  = [
    aws_lb.nlb
  ]
  name        = "${var.nlb_name}-tg-${var.environment}"
  port        = 6443
  target_type = "instance"
  protocol    = "TCP"
  vpc_id      = aws_vpc.custom_vpc.id
}

# Redireciona todo o tráfego do NLB para o grupo de destino
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.id
  port              = 6443
  protocol    = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg.id
    type             = "forward"
  }
} */