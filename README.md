# Rails Docker
Simple configuration to run Ruby On Rails in a Docker environment.

The objective of this repository is provide a simple way to get start work in a Ruby On Rails with PostgreSQL app on Docker by simple steps and minimal files.

This solution works in Linux, MacOS and Windows, any problem feel free to create a issue.

## Requirements
 - Have installed the latest version of Docker and Docker Composer.
 - Minimum knowledge about Docker and Containers.
 - Minimum knowledge about command line.

## For new projects
**1 - Create a folder with your project name and go to it:**
```
mkdir your-app-name
cd your-app-name
```

**2 - Download the four files necessary:**
```
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Dockerfile -o Dockerfile
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/docker-compose.yml -o docker-compose.yml
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Gemfile -o Gemfile
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Gemfile.lock -o Gemfile.lock
```

### About this files
 - **DockerFile**: this file contains information about the container used and the command to configure him like ``bundle install``.
 - **docker-compose.yml**: This file contains informations about the services of the container and the command for run the Rails app.
 - **Gemfile**: this file just loads Rails. It’ll be overwritten by ``rails new`` command.
 - **Gemfile.lock**: only a empty file necessary to build our Dockerfile.

**3 - Open DockerFile and docker-compose.yml in your prefer text editor and replace all occurrences of "sandbox" for "your-app-name".**

**4 - Time to build the project, generate the Rails skeleton app using ``docker-compose run``:**
```
docker-compose run --rm app rails new . --force --database=postgresql --skip-bundle
```

*4.1 - If you are running Docker on Linux, the files rails new created are owned by root. This happens because the container runs as the root user. Change the ownership of the new files:*
```
sudo chown -R $USER:$USER .
```

**5 - At this point, ``rails new`` command modify the Gemfile, so we need to run the ``docker-compose build`` command (and every time GemFile is modified, like new gems installed):**
```
docker-compose build
```

**6 - Now let's connect to the database, open ``config/database.yml`` and modify it to look like this**
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

**7 - You can now boot the app with:**
```
docker-compose up
```

**8 - Finally, you need to create the database. In another terminal, run:**
```
docker-compose exec app rake db:create
```

**So, that's it! visit http://localhost:3000 to see your new Rails App running.**


## For existing Rails projects
**1 - You only need download the two files necessary**
```
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/Dockerfile -o Dockerfile
curl -L https://raw.githubusercontent.com/Agilhub/rails-docker/master/docker-compose.yml -o docker-compose.yml
```

**2 - Open DockerFile and docker-compose.yml in your prefer text editor and replace all occurrences of "sandbox" for "your-app-name".**

**3 - Now let's build the project, run the command below (and every time GemFile is modified, like new gems installed):**
```
docker-compose build
```

**4 - Let's connect to the database, open ``config/database.yml`` and modify it to look like this**
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

**5 - You can now boot the app with:**
```
docker-compose up
```

**6 - Finally, you need to create the database. In another terminal, run:**
```
docker-compose exec app rake db:create
```

**So, that's it! visit http://localhost:3000 to see your existing Rails App running.**