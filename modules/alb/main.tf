resource "aws_lb" "myelb" {
    name               = "application-load-balancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.sg_id]
    subnets = var.subnets
}

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.myelb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tga" {
    count = length(var.instances)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instances[count.index]
  port             = 80
}