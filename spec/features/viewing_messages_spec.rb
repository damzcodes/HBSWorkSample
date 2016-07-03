feature 'Viewing messages' do

  scenario 'user views messages' do
    when_a_user_visits_the_homepage
    then_they_should_see_the_list_of_messages
  end

  def when_a_user_visits_the_homepage
    create :message, message: 'first thing is first, i am the realist', author: 'Lola'
    visit root_path
  end

  def then_they_should_see_the_list_of_messages
    expect(page).to have_content('first thing is first, i am the realist')
  end

end