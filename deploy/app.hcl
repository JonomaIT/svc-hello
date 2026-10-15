runtime           = "ecs"
name              = "svc-hello"
port              = 80
health_check_path = "/health"

env = {
  WHOAMI_NAME = "svc-hello" # shown in every answer, next to the task's IP and hostname
}

slo = {
  disponibilidade = 99.5
  latencia_p95_ms = 500
}
