require 'uri'

class ShortUrl < ActiveRecord::Base
  validates :user_id, presence: true
  validates :url,     presence: true
  validate :acceptable_url
  belongs_to :user

  def ShortUrl.valid_url?(url)
    begin
      uri = URI.parse(url)
      if !uri.scheme
        url = 'http://' + url
        uri = URI.parse(url)
      end

      if !(uri.host)
        false
      elsif !/.+\..+/.match(uri.host)
        false
      else
        url
      end
    rescue #URI::InvalidURIError
      false
    end
  end

  private

  def acceptable_url
    processed_url = ShortUrl.valid_url?(url)
    if !processed_url
      errors.add(:url, "is not valid")
    else
      self.url = processed_url
    end
  end

end
