class User < ActiveRecord::Base
  validates :firstname, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 2}
  validates :password, presence: true

  has_secure_password
  has_many :todos

end
