class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
            
  has_secure_password
  validates :password, presence: true, length: {minimum: 6 }
  
  def User.digest(string)
    cost = ActivaModel::SecurePassword.min_cost ?
            BCrypt::Eingine::MIN_COST
            : BCrypt::Eingine.cost
    BCrypt::Password.create(string, cost: cost)       
  end
end
