class RegistrationsController < Devise::RegistrationsController
  before_filter :new_account, :only => [:new]

  def new_account
    @account = Account.new
  end
  
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end         

end
