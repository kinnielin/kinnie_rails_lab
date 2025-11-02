class BlogsController < ApplicationController
  before_action :find_blog, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user # 自動設定當前用戶

    if @blog.save
      redirect_to @blog, notice: "Blog 已成功建立。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog 已成功更新。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "Blog 已成功刪除。"
  end

  private

  def find_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
