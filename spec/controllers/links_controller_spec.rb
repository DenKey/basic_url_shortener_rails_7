require 'rails_helper'

RSpec.describe LinksController do
  describe "POST create" do
    let(:url) { 'http://www.google.com' }

    it "creates a new Link item" do
      expect {
        post :create, params: { url: url, format: :json}
      }.to change(Link, :count).by(1)
    end

    it "renders the correct result json" do
      post :create, params: { url: url, format: :json }

      last = Link.last
      result = { url: last.url, shorten_url: last.shorten_url }.to_json

      expect(response.body).to eq(result)
    end

    it 'renders the error if url is invalid' do
      post :create, params: { url: 'wrigdfd.url', format: :json }

      result = { error: "Url is invalid" }.to_json

      expect(response.body).to eq(result)
    end
  end

  describe "GET show" do
    let(:url) { 'http://example.com' }

    it "redirect to valid short url" do
      link = Link.create(url: url)

      get :show, params: { shortcode: link.shortcode, format: :json }
      expect(response).to redirect_to(url)
    end

    it "redirect to not found page for invalid short url" do
      get :show, params: { shortcode: 'ddsafsdgsfghfdgfg', format: :json }
      expect(response).to redirect_to('/page/not_found')
    end
  end
end
