class UsersController < ApplicationController
  layout "public"
  before_action :find_user, only: [:edit, :show, :destroy]
  def index
    users = User.select("id, name, email, age")
    respond_to do |format|
      format.html
      format.json { render js: users.to_json }
    end
  end

  def create
    user = User.new(user_params)
    user.save
    render json: {status: !user.errors.any?, errors: user.validation_errors}
    # respond_to do |format|
    #   format.json {  render json: {status: !user.errors.any?, errors: user.errors.full_messages} }
    # end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render js: @user.to_json }
    end
  end

  def update
    @user.update_attributes(user_params)
    render json: {status: !@user.errors.any?, errors: @user.validation_errors}
  end

  def destroy
    @user.destroy
    render json: {status: @user.destroy}
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :age)
  end

end
