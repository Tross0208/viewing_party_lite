require 'rails_helper'

RSpec.describe "New User", type: :feature do
  it 'has a form to create new user' do
    visit "/users/register"

    fill_in(:name, with: "Jim")
    fill_in(:email, with: "Jim@mail.com")
    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"
    new_user = User.last

    expect(current_path).to eq("/users/dashboard")
    expect(page).to have_content("Welcome, #{new_user.username}!")
  end

  it 'rejects new user with unmatched password confirmation' do
    visit "/users/register"

    fill_in(:name, with: "Jim")
    fill_in(:email, with: "Jim@mail.com")
    username = "funbucket13"
    password = "test"
    bad_password = "not test"

    fill_in :username, with: username
    fill_in :password, with: password
    fill_in :password_confirmation, with: bad_password
    click_on "Register"
    new_user = User.last

    expect(current_path).to eq("/users/register")
    expect(page).to have_content("Error: Passwords do not match")
  end

  it 'rejects duplicate emails' do
    visit "/users/register"

    User.create!(name: "Tim", email: "Jim@mail.com", username: "BubbaGump", password: "passpass")

    username = "funbucket13"
    password = "test"
    fill_in(:name, with: "Jim")
    fill_in(:email, with: "Jim@mail.com")
    fill_in :username, with: username
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"

    expect(current_path).to eq("/users/register")
    expect(page).to have_content("Error: User already exists with this email")
  end

  it 'rejects new user with no name' do
    visit "/users/register"


    fill_in(:email, with: "Jim@mail.com")
    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"

    expect(current_path).to eq("/users/register")
    expect(page).to have_content("Error: Please Enter Your Name")

  end

  it 'rejects new user with no username' do
    visit "/users/register"

    fill_in(:name, with: "Jim")
    fill_in(:email, with: "Jim@mail.com")
    username = ""
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"

    expect(current_path).to eq("/users/register")
    expect(page).to have_content("Error: Please Enter A Username")
  end

end
