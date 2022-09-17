FROM node:14.17
FROM ruby:3.1.1

# コンテナにyarn, node, node_modulesを追加する
COPY --from=node /opt/yarn-* /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/

# npm, npx, yarnコマンドを実行できるように関連付ける
RUN ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx \
  && ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

# 必要なパッケージをインストールする
RUN apt-get update -qq \
  && apt-get install -y build-essential libpq-dev postgresql-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# 作業環境用の新しいディレクトリを作成
RUN mkdir /myapp
WORKDIR /myapp

# Gemfileから必要なgemをインストールする
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY . /myapp

# コンテナ立ち上げ時に毎回実行するスクリプトを追加
# pidファイルが存在するときにRailsサーバが起動しないことがあるので、この問題を修正する
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Railsアプリケーションを立ち上げる
CMD ["rails", "server", "-b", "0.0.0.0"]
