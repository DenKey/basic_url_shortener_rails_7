# frozen_string_literal: true

class Link < ApplicationRecord
  REGEX_URL_VALIDATION = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  SHORTCODE_SIZE = 8
  GENERAL_ERROR_MESSAGE = 'Something went wrong'.freeze

  validates_presence_of :url
  validates_format_of :url, with: REGEX_URL_VALIDATION, multiline: true

  around_create :generate_shortcode

  def shorten_url
    Rails.application.routes.url_helpers.shortcode_url(shortcode: self.shortcode)
  end

  def format_error
    if errors.present?
      errors.full_messages.join('')
    else
      GENERAL_ERROR_MESSAGE
    end
  end

  private

  def generate_shortcode
    begin
      self.shortcode = SecureRandom.uuid[0..(SHORTCODE_SIZE - 1)] # 2.8211099e+12 variants
    end while self.class.exists?(shortcode: self.shortcode)

    yield
  end
end
