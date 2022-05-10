require 'rails_helper'

RSpec.describe "New User", type: :feature do
  it 'has a form to create new user' do
    visit "/users/new"

    fill_in(:name, with: "Jim")
    fill_in(:email, with: "Jim@mail.com")
    click_on "Register"
    new_user = User.last

    expect(current_path).to eq("/users/#{new_user.id}")
  end

  it 'rejects duplicate emails' do
    visit "/users/new"

    User.create!(name: "Tim", email: "Jim@mail.com")

    fill_in(:name, with: "Jim")
    fill_in(:email, with: "Jim@mail.com")
    click_on "Register"

    expect(current_path).to eq("/users/new")
    expect(page).to have_content("Error: User already exists with this email")
  end

end