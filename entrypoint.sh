#!/bin/bash
set -e

# Railsのために、既に存在しうる server.pid を削除
rm -f /myapp/tmp/pids/server.pid

# コンテナのメインプロセスを実行
exec "$@"
