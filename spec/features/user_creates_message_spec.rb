feature 'Authorised user submits link' do

  scenario 'a user submits a message' do
    when_an_authorised_user_submits_a_message
    then_they_should_be_able_to_see_the_message
  end

  # scenario 'a user submits a message without the text' do
  #   when_an_authorised_user_does_not_fill_in_the_title
  #   then_the_form_should_be_invalid
  # end

  # scenario 'a user submits a message without the name' do
  #   when_an_authorised_user_does_not_fill_in_the_url
  #   then_the_form_should_be_invalid
  # end

  def when_an_authorised_user_submits_a_message
    visit root_path
    fill_in :text, with: message.text
    fill_in :author, with: message.author
    click_button 'Create'
  end

  def then_they_should_be_able_to_see_the_message
    expect(page).to have_content(message.text)
  end

  # def when_an_authorised_user_does_not_fill_in_the_title
  #   visit new_link_path
  #   fill_in :link_title, with: ''
  #   fill_in :link_url, with: 'http//example.com'
  #   click_button 'Create'
  # end

  # def then_the_form_should_be_invalid
  #   expect(page).to have_content("can't be blank")
  # end

  # def when_an_authorised_user_does_not_fill_in_the_url
  #   visit new_link_path
  #   fill_in :link_title, with: 'link title'
  #   fill_in :link_url, with: ''
  #   click_button 'Create'
  # end

  # def then_the_form_should_be_invalid
  #   expect(page).to have_content("can't be blank")
  # end
  let(:message)  { create :message, text: 'first thing is first, i am the realist', author: 'Lola'}

end