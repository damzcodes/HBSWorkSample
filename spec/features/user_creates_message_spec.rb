feature 'Authorised user submits link' do
  scenario 'a user submits a message' do
    when_an_authorised_user_submits_a_message
    then_they_should_be_able_to_see_the_message
  end

  scenario 'a user submits a message without the text' do
    when_an_authorised_user_does_not_fill_in_the_text
    then_the_form_should_be_invalid
  end

  def when_an_authorised_user_submits_a_message
    visit messages_path
    fill_in :message_text, with: message.text
    fill_in :message_author, with: message.author
    click_button 'Create'
  end

  def then_they_should_be_able_to_see_the_message
    expect(page).to have_content(message.text)
    expect(page).to have_content('Thank You For Signing!')
  end

  def when_an_authorised_user_does_not_fill_in_the_text
    visit messages_path
    fill_in :message_text, with: ''
    fill_in :message_author, with: 'Tracy'
    click_button 'Create'
    binding.pry
    puts 1
  end

  def then_the_form_should_be_invalid
    expect(page).to have_content('can/t be blank.')
  end

  let(:message) { create :message, text: 'first thing is first, i am the realist', author: 'Lola' }
end
