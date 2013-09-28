require 'spec_helper'

feature 'broken_auth' do
  before do
    UserFixture.reset_all_users
    @normal_user = UserFixture.normal_user
  end

  scenario 'TMI during login', :js => true do
    visit '/'
    within('.signup') do
      fill_in 'email', :with => @normal_user.email + 'not'
      fill_in 'password', :with => @normal_user.clear_password
    end
    click_on 'Login'
    find('div#flash_notice').text.should == "#{@normal_user.email}not doesn't exist!"

    within('.signup') do
      fill_in 'email', :with => @normal_user.email
      fill_in 'password', :with => @normal_user.clear_password + 'not'
    end
    click_on 'Login'
    find('div#flash_notice').text.should == 'Incorrect Password!'
  end
end