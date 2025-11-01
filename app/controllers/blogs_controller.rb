class BlogController < ApplicationController
  before_action :find_blog, only: [ :show, :edit, :update, :destroy ]

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
    redirect_to blog_index_path, notice: "Blog 已成功刪除。"
  end

  private

  def find_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end
end
