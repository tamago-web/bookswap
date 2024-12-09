# Rubyバージョン指定
FROM ruby:3.0.2

# Node.jsのバージョンを指定（Bootstrapのために必要）
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# アプリケーション用ディレクトリ作成
RUN mkdir /myapp
WORKDIR /myapp

# Gemfileをコピーしてbundle install
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp

# SASSとBootstrapのために必要なパッケージをインストール
RUN yarn add bootstrap jquery popper.js

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート3000を公開
EXPOSE 3000

# Railsサーバー起動
CMD ["rails", "server", "-b", "0.0.0.0"]
