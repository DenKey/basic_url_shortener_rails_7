# frozen_string_literal: true

if @link.valid?
  json.extract! @link, :url, :shorten_url
else
  json.error @link.format_error
end
