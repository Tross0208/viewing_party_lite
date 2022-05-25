require 'rails_helper'

RSpec.describe "Login User", type: :feature do
  it "can log in with valid credentials" do
    user = User.create!(name: "Amy", email: 'amy@mail.com', username: "BubbaGump", password: "passpass")
    #binding.pry
    visit root_path

    click_on "Login"

    expect(current_path).to eq("/login")

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.username}")
  end

  it "cannot log in with bad credentials" do
  user = User.create!(name: "Amy", email: 'amy@mail.com', username: "BubbaGump", password: "passpass")

  visit login_path

  fill_in :username, with: user.username
  fill_in :password, with: "incorrect password"

  click_on "Log In"

  expect(current_path).to eq(login_path)

  expect(page).to have_content("Sorry, your credentials are bad.")
end


end
