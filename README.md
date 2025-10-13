# terraform-aws-ambiente-setup-ec2

Boilerplate Terraform para inicializar e criar instâncias AWS EC2 (Ubuntu Jammy). Este repositório provê um módulo simples para criar instâncias EC2 com opções de anexar EBS block devices.

## Sumário rápido
- O módulo busca a AMI Ubuntu Jammy (Canonical).
- Configure credenciais AWS e região.
- Use o example em `examples/main.tf` para testes locais ou publique este módulo no Registry e consuma por `source = "dantas-4cloud/ambiente-setup-ec2/aws"`.

## Pré-requisitos
- Terraform (>= 1.0)
- AWS CLI (opcional, para configurar credenciais)
- Conta AWS com permissões para criar EC2, EBS e tags

Em Windows PowerShell:
```powershell
# (opcional) configure perfil padrão
aws configure
# ou defina variáveis de ambiente temporariamente
$env:AWS_ACCESS_KEY_ID = "AKIA..."
$env:AWS_SECRET_ACCESS_KEY = "..."
$env:AWS_REGION = "us-east-1"
```

## Como usar (modo rápido)
1. Copie/edite `examples/main.tf` ou crie seu próprio `main.tf` que consuma o módulo.
2. Crie um arquivo `terraform.tfvars` com os valores necessários (exemplo abaixo).
3. Execute os comandos Terraform no diretório do example ou no root (dependendo de onde você colocou a configuração).

Exemplo de `terraform.tfvars`:
```hcl
nome = "exemplo_simples"
environment = "dev"
ebs_block_devices = [
  {
    device_name = "/dev/sdf"
    encrypted   = false
    volume_size = 10
  }
]
```

Comandos PowerShell (no diretório com o `main.tf` do exemplo):
```powershell
terraform init
terraform validate
terraform plan -var-file="terraform.tfvars" -out=tfplan
terraform apply "tfplan"
# para destruir
terraform destroy -var-file="terraform.tfvars"
```

Se preferir passar variáveis pela linha de comando:
```powershell
terraform plan -var="nome=exemplo_simples" -var="environment=dev"
terraform apply -var="nome=exemplo_simples" -var="environment=dev"
```

## Entradas (variables)
As variáveis expostas estão em `variables.tf`:
- `nome` (string) — Nome da instância (obrigatório).
- `environment` (string) — Ambiente (default: `dev`).
- `ebs_block_devices` (list(any)) — Lista de blocos EBS a anexar (default: `[]`).

Exemplo `ebs_block_devices`:
```hcl
ebs_block_devices = [
  {
    device_name = "/dev/sdf"
    encrypted   = false
    volume_size = 20
  },
  {
    device_name = "/dev/sdg"
    encrypted   = true
    volume_size = 50
  }
]
```

## Exemplo de uso (consumindo como módulo publicado)
No seu projeto:
```hcl
module "ambiente-setup-ec2" {
  source  = "dantas-4cloud/ambiente-setup-ec2/aws"
  version = "1.0.1"
  nome    = "exemplo_simples"
  # environment e ebs_block_devices são opcionais
}
```

## Saídas / Verificação
- Após o `apply`, verifique a instância no Console AWS EC2 ou use:
```powershell
terraform show
# ou para outputs (caso existam outputs definidos no módulo)
terraform output
```

## Boas práticas e notas de segurança
- Não comite credenciais no repositório.
- Use profiles IAM com permissões mínimas (criação/gerenciamento de EC2, EBS e tags).
- Para ambientes de produção, habilite criptografia EBS (`encrypted = true`) e use KMS se necessário.
