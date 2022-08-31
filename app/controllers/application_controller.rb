class ApplicationController < ActionController::API
  around_action :run_action

  STATUS_SERVER_ERROR = 500

  def run_action
    begin
      yield
    rescue => e
      Rails.logger.error(e)
      puts e.inspect
      render json: {
        error: 'Something went wrong. Please try later.'
      }, status: STATUS_SERVER_ERROR
    end
  end
end
