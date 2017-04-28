####
# ATENTION:
# Replace all occurences of sandbox with your project's name
####

# feel free to change ruby version
FROM ruby:2.3.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /sandbox
WORKDIR /sandbox
ADD Gemfile /sandbox/Gemfile
ADD Gemfile.lock /sandbox/Gemfile.lock
RUN bundle install
ADD . /sandbox