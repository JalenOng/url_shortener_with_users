class Url < ActiveRecord::Base
  before_create :shorten
  validates :long_url, presence: true
  validates :short_url, uniqueness: true



  def shorten
    rand_str = [*'0'..'9',*'A'..'Z',*'a'..'z'].sample(5).join

    unique_shorten_url = Url.where(short_url: rand_str)
    if unique_shorten_url == []
      self.short_url = "/#{rand_str}"
    else
      shorten
    end
  end

  def visit
    self.click_count += 1
    self.save
  end

end
