class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :password, presence: true, length: {minimum: 5}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
