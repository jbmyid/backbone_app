class User < ActiveRecord::Base
  validates :name, :age, presence: true
  validates :email, presence: true, uniqueness: true
end
