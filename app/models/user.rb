class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }
  validates :email, :name, presence: true
  has_secure_password

  def self.authenticate_with_credentials (email, password)
    # remove any whitespace and convert to lowercase 
    formatEmail = email.strip.downcase
    
    @user = User.find_by_email(formatEmail)

    if @user 
      if @user.authenticate(password)
        return @user
      end
    else
      return nil
    end

  end
end
