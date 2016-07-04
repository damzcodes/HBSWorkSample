feature 'User deletes entry' do
  scenario 'a user deletes a message' do
    when_an_authorised_user_deletes_an_entry
    then_the_message_should_be_deleted
  end

  def when_an_authorised_user_deletes_an_entry
    message
    visit root_path
    click_link('Destroy')
  end

  def then_the_message_should_be_deleted
    expect(page).not_to have_content(message.text)
    expect(page).not_to have_content(message.author)
    expect(page).to have_content("Your message has been deleted!")
  end
  let(:message) { create :message, text: 'first thing is first, i am the realist', author: 'Lola' }
end
