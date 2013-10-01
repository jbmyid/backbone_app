class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  %w(user).each do |name|
    define_method "find_#{name}" do
      obj = instance_variable_set("@#{name}", name.camelize.constantize.find_by_id(params[:id]))
      unless obj
        flash[:alert] = "#{name.camelize} not found"
        respond_to do |format|
          format.html{ redirect_to "/#{name.pluralize}" }
          format.js{ render js: "window.location='/#{name.pluralize}'" }
        end
      end
    end
  end

end
