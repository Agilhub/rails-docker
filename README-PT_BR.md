# Rails Docker
Simples configuração para executar Ruby On Rails em um ambiente Docker.

O objetivo deste repositório é fornecer uma maneira simples de começar a trabalhar em um App Ruby On Rails com o PostgreSQL no Docker com etapas simples e poucos arquivos.

Esta solução funciona em Linux, MacOS e Windows, qualquer problema sinta-se livre para criar uma issue.

## Requisitos
  - Ter Instalado a versão mais recente do Docker e do Docker Composer.
  - Conhecimento mínimo sobre Docker e Containers.
  - Conhecimento mínimo sobre linha de comando.

## Para novos projetos
**1 - Crie uma pasta com o nome do seu projeto e vá para ele:**
```
mkdir your-app-name
cd your-app-name
```

**2 - Faça o download dos quatro arquivos necessários:**
```
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Dockerfile -o Dockerfile
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/docker-compose.yml -o docker-compose.yml
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Gemfile -o Gemfile
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Gemfile.lock -o Gemfile.lock
```

### Sobre esses arquivos
 - **DockerFile**: este arquivo contém informações sobre o container usado e os comandos para configurá-lo como ``bundle install``.
 - **docker-compose.yml**: Este arquivo contém informações sobre os serviços do container e o comando para executar o aplicativo Rails.
 - **Gemfile**: este arquivo apenas carrega Rails. Ele será substituído pelo comando ``rails new``.
 - **Gemfile.lock**: apenas um arquivo vazio necessário para construir nosso Dockerfile.

**3 - Abra o DockerFile e o docker-compose.yml no seu editor de texto preferido e substitua todas as ocorrências de "sandbox" por "your-app-name".**

**4 - hora de dar um build no projeto, crie os arquivos do Rails usando ``docker-compose run``:**
```
docker-compose run --rm app rails new . --force --database=postgresql --skip-bundle
```

*4.1 - Se você estiver executando o Docker no Linux, os arquivos criados pelo ``rails new`` são propriedade do root. Isso acontece porque o container é executado como o usuário root. Altere a propriedade dos novos arquivos:*
```
sudo chown -R $USER:$USER .
```

**5 - Neste ponto, o comando ``rails new`` modifica o Gemfile, então precisamos executar o comando ``docker-compose build`` (e sempre que o GemFile for modificado, como novas gems instaladas):**
```
docker-compose build
```

**6 - Agora vamos conectar ao banco de dados, abra o arquivo ``config/database.yml`` e modifique-o para parecer assim:**
```
development:
  <<: *default
  database: your-app-name_development
  username: postgres
  password:
  host: postgres

test:
  <<: *default
  database: your-app-name_test
  username: postgres
  password:
  host: postgres
```

**7 - Agora você pode iniciar o aplicativo com:**
```
docker-compose up
```

**8 - Finalmente, você precisa criar o banco de dados. Em outro terminal, execute:**
```
docker-compose exec app rake db:create
```

**E é isso! Visite http://localhost:3000 para ver a sua nova aplicação Rails em execução.**


## Para projetos existentes
**1 - Você só precisa baixar os dois arquivos necessários**
```
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Dockerfile -o Dockerfile
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/docker-compose.yml -o docker-compose.yml
```

**2 - Abra o DockerFile e o docker-compose.yml no seu editor de texto preferido e substitua todas as ocorrências de "sandbox" por "your-app-name".**

**3 - Agora vamos dar um build no projeto, execute o comando abaixo (e toda vez que o GemFile for modificado, como novas gemas instaladas):**
```
docker-compose build
```

**4 - Vamos conectar ao banco de dados, abra o arquivo ``config/database.yml`` e modifique-o para parecer assim:**
```
development:
  <<: *default
  database: your-app-name_development
  username: postgres
  password:
  host: postgres

test:
  <<: *default
  database: your-app-name_test
  username: postgres
  password:
  host: postgres
```

**5 - Agora você pode iniciar o aplicativo com:**
```
docker-compose up
```

**6 - Finalmente, você precisa criar o banco de dados. Em outro terminal, execute:**
```
docker-compose exec app rake db:create
```

**E é isso! Visite http://localhost:3000 para ver a sua aplicação Rails em execução.**