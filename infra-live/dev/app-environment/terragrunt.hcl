inputs = {
  environment    = "dev"
}

include {
   # O auxiliar find_in_parent_folders() irá
   # pesquisa automaticamente na árvore de diretórios para encontrar a raiz terragrunt.hcl e herdar
   # a configuração remote_state dele.
  path = find_in_parent_folders()
}

terraform {
  source = "../../../infra-modules/app-environment"

  extra_arguments "conditional_vars" {
     # função embutida para obter automaticamente a lista de
     # todos os comandos que aceitam os argumentos -var-file e -var
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-lock-timeout=10m"
    ]

    required_var_files = [
      "${get_parent_terragrunt_dir()}/sensitive.tfvars"
    ]
  }
}
