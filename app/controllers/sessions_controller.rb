class SessionsController < ApplicationController
  def new
    # 顯示登入表單
  end

  def create
    # 處理登入
    user = User.find_by(account: params[:account])
    
    if user && user.password == params[:password]
      # 登入成功
      session[:user_id] = user.id
      redirect_to root_path, notice: '登入成功！'
    else
      # 登入失敗
      flash.now[:alert] = '帳號或密碼錯誤'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # 處理登出
    session[:user_id] = nil
    redirect_to root_path, notice: '已成功登出'
  end
end