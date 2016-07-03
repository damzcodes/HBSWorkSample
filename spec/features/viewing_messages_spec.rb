feature 'Viewing messages' do

  scenario 'user views messages' do
    when_a_user_visits_the_homepage
    then_they_should_see_the_list_of_messages
  end

  def when_a_user_visits_the_homepage
    message
    visit root_path
  end

  def then_they_should_see_the_list_of_messages
    expect(page).to have_content(message.text)
    expect(page).to have_content(message.author)
  end

  let(:message) { create :message, text: 'first thing is first, i am the realist', author: 'Lola'}
end