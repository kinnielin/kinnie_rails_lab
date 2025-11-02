#!/usr/bin/env bash
# 發生錯誤時退出
set -o errexit

echo "開始構建過程..."

# 安裝 gems
echo "安裝 gems..."
bundle config set --local deployment 'true'
bundle config set --local without 'development test'
bundle install

# 檢查資料庫連線
echo "檢查資料庫連線..."
bundle exec rails runner "ActiveRecord::Base.connection"

# 預編譯前端靜態資源 (Assets Precompilation)
echo "預編譯靜態資源..."
bundle exec rake assets:precompile
bundle exec rake assets:clean

# 執行資料庫遷移 (Migrations)
echo "執行資料庫遷移..."
bundle exec rake db:create db:migrate

echo "構建完成！"