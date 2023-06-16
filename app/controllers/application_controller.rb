# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper :all
  # protect_from_forgery
  before_action :authentication, :configure_api

  private

  def authentication
    logout if params[:shop].present? && params[:shop] != session[:shop]

    if session[:account_id] && session[:insales_id]
      @account = Account.find_by(id: session[:account_id], insales_id: session[:insales_id])
      Rails.logger.info "found account - #{@account}"
      return if @account
    end

    store_location

    if account
      Rails.logger.info 'start autologin'
      autologin_start
    else
      Rails.logger.info 'redirect to login_path'
      redirect_to login_path
    end
  end

  def logout
    session[:account_id] = nil
    session[:shop] = nil
    session[:insales_id] = nil
  end

  def store_location(path = nil)
    session[:return_to] = path || request.url
  end

  def autologin_start
    token, url = account.authentication(params[:shop])
    session[:token_shop] = params[:shop]
    session[:token_account_id] = account.id
    Rails.logger.info "token in session is #{token}"
    session[:token] = token
    session[:token_insales_id] = account.insales_id
    redirect_to url, allow_other_host: true
  end

  def location_session_store
    session[:return_to]
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def account
    @account ||=
      if params[:insales_id]
        Account.find_by(insales_id: params[:insales_id])
      else
        Account.find_by(insales_subdomain: params[:shop])
      end
  end

  def autologin_finish(token)
    Rails.logger.info "Token from params is #{token} and token from session is #{session[:token]}"
    if session[:token] == token
      Rails.logger.info 'Token is right'
      session[:account_id] = session[:token_account_id]
      session[:shop] = session[:token_shop]
      session[:insales_id] = session[:token_insales_id]
    end

    session[:token_account_id] = nil
    session[:token_shop] = nil
    session[:token] = nil
    session[:token_insales_id] = nil
    session[:account_id].present?
  end

  def configure_api
    account.init_api
  end

  def current_app
    session[:app]
  end
end
