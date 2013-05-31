class AdminController < ApplicationController
  
  skip_before_filter :has_info
  
  def dashboard
  end
  
  def get_all_users
    @users = User.all
    render :partial => "layouts/admin/get_all_users"
  end
  
  def get_user
    @user = User.find_by_id(params[:admin_id].to_s)
    arr = ["true", "false"]
    @admin_select = @user.admin ? arr : arr.reverse
    render :partial => "layouts/admin/get_user"
  end
  
  def update_user
    user = User.find_by_id(params[:admin_id])
    if user
      user.update_attributes(params[:user].reject { |k| k == ("password" || "password_confirmation") })
      pass = params[:user][:password]
      user.password = pass if !(pass.blank?)
      user.save!
      message = true
    end
    respond_to do |format|
      format.json { render :json => { :msg => message ? "success" : "failure"} }
    end
  end
  
  def delete_user
    user = User.find_by_id(params[:admin_id])
    if user && !(current_user.user_id == user.user_id)
      user.delete
      message = true
    end
    respond_to do |format|
      format.json { render :json => { :msg => message ? "success" : "failure"} }
    end
  end
  
end
