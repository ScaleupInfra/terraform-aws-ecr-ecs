output "ecr_repository_url" {
  value = aws_ecr_repository.my_ecr_repo.repository_url
}

output "ecr_repository_arn" {
  value = aws_ecr_repository.my_ecr_repo.arn
}

output "ecs_task_definition" {
  value = aws_ecs_task_definition.mkdocs_task.arn
}