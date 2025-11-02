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
bundle exec rake db:create
bundle exec rake db:migrate

# 為 Rails 8 的多資料庫功能設置 schema
echo "設置多資料庫 schema..."
bundle exec rails runner "
begin
  ActiveRecord::Tasks::DatabaseTasks.load_schema_for :cache
  puts 'Cache schema loaded successfully'
rescue => e
  puts 'Cache schema loading skipped or failed: ' + e.message
end

begin
  ActiveRecord::Tasks::DatabaseTasks.load_schema_for :queue
  puts 'Queue schema loaded successfully'
rescue => e
  puts 'Queue schema loading skipped or failed: ' + e.message
end

begin
  ActiveRecord::Tasks::DatabaseTasks.load_schema_for :cable
  puts 'Cable schema loaded successfully'
rescue => e
  puts 'Cable schema loading skipped or failed: ' + e.message
end
"

echo "構建完成！"