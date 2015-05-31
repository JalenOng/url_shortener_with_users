class User < ActiveRecord::Base
  has_many :urls
  validates :username, :password, presence: true
  validates :username, uniqueness: true

  def self.authenticate(username, password)
    @user = User.find_by_username(username)
    if @user == []
      nil
    elsif @user.password == password
      @user
    else
      nil
    end
  end
end
