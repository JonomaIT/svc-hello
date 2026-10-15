# svc-hello

Test app of the JonomaIT platform: proves the whole path (Cloudflare → shared ALB → ECS service) and, in production, the failover between regions.

It runs the public [`traefik/whoami`](https://github.com/traefik/whoami) image, which answers every request with the task's hostname and IPs, so each answer shows **which task and which region** served it. `/health` answers 200.

```
deploy/
├── app.hcl               runtime, name, port, health check, env, slo
└── env/
    ├── staging.tfvars    hello-stg.joshuel.com.br, us-east-1
    └── production.tfvars hello.joshuel.com.br, us-east-1 + sa-east-1
```

There is no `src/` or `Dockerfile` yet: the image comes from Docker Hub. When the build pipeline exists, this repo gets its own image in ECR (shared-services) like any other app.

## Deploy (by hand, until the deploy pipeline exists)

From `pipelines/terraform-runner/ecs`, see the `pipelines` README:

```bash
terraform apply \
  -var-file=../../../svc-hello/deploy/app.hcl \
  -var-file=../../../svc-hello/deploy/env/staging.tfvars \
  -var environment=staging -var region=us-east-1 -var image=traefik/whoami:v1.10.3
```

```bash
curl https://hello-stg.joshuel.com.br
```
