require 'rails_helper'

RSpec.describe "Move Index/Discover Page", type: :feature do
  it 'can search for a movie by title', :vcr do
    user = User.create!(name: "Tim", email: "Tim@mail.com", username: "BubbaGump", password: "passpass")
    visit "/users/#{user.id}/discover"
    fill_in :search, with: "Movie"
    click_on "Search"
  end

end
