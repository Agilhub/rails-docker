# Rails Docker
Simple configuration to run Ruby On Rails in a Docker environment.

## Work In Progress

### Para novo projetos

docker-compose run --rm app rails new . --force --database=postgresql --skip-bundle

sudo chown -R $USER:$USER .

docker-compose build

docker-compose up

docker-compose exec app rake db:create



### Para projetos existentes

docker-compose build

docker-compose up

docker-compose exec app rake db:create