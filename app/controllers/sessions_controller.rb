class SessionsController < ApplicationController
  skip_before_action :authentication, :configure_api, except: [:destroy]
  layout 'login'

  def show
    render action: new
  end

  def create
    @shop = params[:shop]

    if account
      store_location
      autologin_start
    else
      flash.now[:error] = 'Убедитесь, что адрес магазина указан правильно.'
      render action: :new
    end
  end

  def autologin
    if autologin_finish(params[:token])
      Rails.logger.info "Autologin finish, redirect to #{location_session_store} or #{root_path}"
      redirect_to root_path
    else
      Rails.logger.info "Autologin fail, redirect to #{login_path}"
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
