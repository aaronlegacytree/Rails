FROM ruby:3.2.2-slim



RUN apt-get update -qq \
    && apt-get install -y git build-essential libpq-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version "$BUNDLE_VERSION" \
    && bundle config set force_ruby_platform true \
    && bundle install --jobs 20 --retry 5

COPY . /app

EXPOSE 8080

ENTRYPOINT ["sh","./docker-entrypoint.sh"]
