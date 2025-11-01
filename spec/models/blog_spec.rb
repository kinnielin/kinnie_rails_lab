require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'validations' do
    describe 'required fields' do
      it 'requires title, content, and valid user_id' do
        # 測試 title 不能為空
        blog = Blog.new(title: '', content: '有內容', user_id: 1)
        expect(blog.valid?).to be_falsey
        expect(blog.errors[:title]).to include("標題不可為空")

        # 測試 content 不能為空
        blog = Blog.new(title: '有標題', content: '', user_id: 1)
        expect(blog.valid?).to be_falsey
        expect(blog.errors[:content]).to include("內容不可為空")

        # 測試 user_id 不能為 0
        blog = Blog.new(title: '有標題', content: '有內容', user_id: 0)
        expect(blog.valid?).to be_falsey
        expect(blog.errors[:user_id]).to include("需指定使用者")

        # 測試 user_id 不能為負數
        blog = Blog.new(title: '有標題', content: '有內容', user_id: -1)
        expect(blog.valid?).to be_falsey
        expect(blog.errors[:user_id]).to include("需指定使用者")

        # 測試所有欄位都有效時應該通過
        blog = Blog.new(title: '有標題', content: '有內容', user_id: 1)
        expect(blog.valid?).to be_truthy
      end
    end
  end
end
