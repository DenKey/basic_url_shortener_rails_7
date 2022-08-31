require 'rails_helper'

RSpec.describe Link, :type => :model do
  subject {
    described_class.new(url: "http://google.com")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if url format is  incorrect" do
    subject.url = 'google.com'
    expect(subject).to_not be_valid
  end
end