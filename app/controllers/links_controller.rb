class LinksController < ApplicationController
  before_action :find_link, only: %i[show]

  def show
    if @link.nil?
      redirect_to('/page/not_found')
      return
    end

    redirect_to(@link.url, allow_other_host: true)
  end

  def create
    @link = Link.create(link_params)

    render '/api/links/create'
  end

  def not_found
    render '/api/links/not_found'
  end

  private

  def link_params
    params.permit(:url, :format).except(:format)
  end

  def find_link
    @link = Link.find_by(shortcode: params[:shortcode])
  end
end
