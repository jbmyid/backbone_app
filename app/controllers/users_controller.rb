class UsersController < ApplicationController
  layout "public"
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
    render json: {status: !user.errors.any?, errors: user.errors.full_messages}
    # respond_to do |format|
    #   format.json {  render json: {status: !user.errors.any?, errors: user.errors.full_messages} }
    # end
  end

  def show
    user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render js: user.to_json }
    end
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_params)
    render json: {status: !user.errors.any?, errors: user.errors.full_messages}
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :age)
  end

end
