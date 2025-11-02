#!/usr/bin/env bash
# 發生錯誤時退出
set -o errexit

# 安裝 gems
bundle install

# 預編譯前端靜態資源 (Assets Precompilation)
bundle exec rake assets:precompile
bundle exec rake assets:clean

# 執行資料庫遷移 (Migrations)
bundle exec rake db:migrate