class User < ActiveRecord::Base
  validates :name, :age, presence: true
  validates :email, presence: true, uniqueness: true


  def validation_errors
    errors_hash = {}
    self.errors.messages.each do |key, values|
      errors = []
      values.each{|e| errors << "#{key.capitalize} #{e}" }
      errors_hash[key] = errors.join(", ")
    end
    errors_hash
  end

end
