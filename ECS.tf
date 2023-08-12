# creating ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name = "mkdocs"
}

# creating IAM role for the cluster's service
resource "aws_iam_role" "full_watch" {
  name = "ECS_Watch"
  assume_role_policy = file("${path.module}/roles/policy.json")
}

data "aws_ecr_image" "service_image" {
  repository_name = "mkdocuments"
  image_tag       = "latest"
}


# defining Task for cluster's service
resource "aws_ecs_task_definition" "mkdocs_task" {
  family                   = "MKDOCS-Family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"     
  memory                   = "3072"     

  execution_role_arn = aws_iam_role.full_watch.arn
  task_role_arn      = aws_iam_role.full_watch.arn

  container_definitions = jsonencode([
    {
      name  = "mkdocuments",
      image = "${data.aws_ecr_image.service_image}",
      portMappings = [
        {
          containerPort = 8000,
          protocol      = "tcp"
        }
      ],
      cpu    = 1,
      memory = 3072,
      memoryReservation = 1024  
    }
  ])
}

# creating VCP and Subnet for cluster's service
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
}

# creating ECS Service and running task in it
resource "aws_ecs_service" "mkdocs_service" {
  name            = "mkdocs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.mkdocs_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.my_subnet.id]
    assign_public_ip = true
  }

  deployment_controller {
    type = "ECS"
  }

  platform_version = "LATEST"

  desired_count = 1
 }