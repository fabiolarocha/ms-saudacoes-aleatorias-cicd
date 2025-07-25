terraform {
  required_providers {
    koyeb = {
      source = "koyeb/koyeb"
    }
  }
}

provider "koyeb" {
  # O KOYEB_TOKEN é lido da variável de ambiente, então não precisa de nada aqui.
}

# Define o aplicativo Koyeb (uma coleção de serviços)
# O nome do aplicativo precisa ser único na sua organização do Koyeb.
resource "koyeb_app" "ms_saudacoes_aleatorias" {
  name = "ms-saudacoes-aleatorias-app"
}

# Define o serviço Koyeb que executa a imagem Docker
resource "koyeb_service" "ms-saudacoes-aleatorias-service" {
  # Vincula este serviço ao aplicativo criado acima
  app_name = koyeb_app.ms_saudacoes_aleatorias.name 

  # Definição do serviço em si
  definition {
    # O nome do serviço dentro do aplicativo.
    name = var.service_name # Usando a variável service_name

    # Define o tipo de instância (free é o plano gratuito)
    instance_types {
      type = var.instance_type # Usando a variável instance_type
    }

    # Configuração das portas do contêiner
    ports {
      port     = var.container_port # Usando a variável container_port
      protocol = "http"
    }

    # Configuração de escalabilidade (min 0, max 1 para o plano free)
    scalings {
      min = 0
      max = 1
    }

    # Configuração das rotas que direcionam tráfego para o serviço
    routes {
      path = "/" # Mantém fixo conforme correção anterior do health check
      port = var.container_port # Usando a variável container_port
    }

    # Configuração da verificação de saúde (health check)
    health_checks {
      http {
        port = var.container_port # Usando a variável container_port
        path = "/" # Mantém fixo conforme correção anterior
      }
    }

    # Regiões onde o serviço será implantado
    regions = ["was"] # Mantém fixo por ser uma região específica

    # Configuração do Docker: imagem e comando de entrada
    docker {
      # Construindo o nome completo da imagem usando as variáveis
      image = "docker.io/${var.docker_user_name}/${var.docker_image_name}:${var.docker_image_tag}" 
    }
  }

  # Garante que o aplicativo seja criado antes do serviço
  depends_on = [
    koyeb_app.ms-saudacoes-aleatorias-app
  ]
} 