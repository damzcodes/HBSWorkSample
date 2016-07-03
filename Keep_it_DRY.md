# Keep it DRY (_sometimes_)

DRY is a methodology of working while programming, it stands for _Don't Repeat Yourself_. When learning to code, you're taught this principal as something to follow religiously, and for good reason. Repetition is tedious for you, can be confusing for people reading your code, but most importantly it can potentially cause performance issues in your app or could be more insidious in nature and lead to things being overwritten or reset unintentionally, which as you can imagine, would be pretty disastrous.

## So, How Do We DRY Up Wet Code?

DRYing code up usually happens in the refactoring stage, where you (_the developer_) go over your code and look for places you can make improvements. A lot of the time you'll see that you've repeated yourself in several places where you could actually just abstract the common code into one place and require or call that code when and where it's needed. A good, and easy place to start this is usually in the CSS file. CSS files get bloated a lot of the time because code is being repeated unncesarily and classes are poorly named and inconsistent. For example, say you have a logo element in your HTML, naturally you may have a corresponding class named `.logo` and you may have a set of rules that look like this:

```css

	.logo {
	  padding: 5px 10px;
	  display: inline-block;
	  background-color: #111111;
	}
		 
	.sub-heading {
	  font-size: 16px;
	  text-align: center;
	  padding: 5px 10px;
	}
		 
	.general-div {
	  background-color: #333333;
	  display: inline-block;
	  padding: 5px 10px;
	  border: 1px red solid;
	}
		 
	.spesific-div {
	  background-color: #ffffff;
	  display: inline-block;
	  padding: 5px 10px;
	  border: 1px red solid;
	}

```

This is clear if you’re just reading the CSS file. Immediately you can see what elements require what rules but this kind of naming means that there’s a lot of repetition, which equates to a bulky CSS file and slow loading speeds. There are ways to get around this, especially if you use SASS which makes it possible to use variables, and my favourite `@extend`, which allows you to combine rules without repeating yourself. But really, the best way around this is to separate your concerns and move repeated code into one place, i.e. DRY things up.

```css

	.padding-5-10 {
	  padding: 5px 10px;
	}
	 
	.inline-block {
	  display: inline-block;
	}
	 
	.border-red {
	  border: 1px red solid;
	}
	 
	========= 
	 
	.logo {
	  background-color: #111111;
	}
	 
	.sub-heading {
	  font-size: 16px;
	  text-align: center;
	}
	 
	.general-div {
	  background-color: #333333;
	}
	 
	.spesific-div {
	  background-color: #ffffff;
	}
```

As you can see all the rules that were repeated before have now been moved into their own definitions and are a lot more flexible as they can be applied to any element. A good place to see this kind of abstraction in full force the bootstrap source code, which has declarations like `.text-center { text-align: center }` which is applied to any text element that needs to be centered. We could also easily go futher and have several background-colour classes that describe the desired background-colour. On larger site, this may leave your HTML looking a bit bloated, however bloated HTML doesn't have the same kind of performance defects as bloated CSS.

## That's Awesome, Let's DRY It _All_

Not so fast. There are some cases where you would want to keep things as wet as possible. One of these instances is in the case of tests. When writing tests, wet really is best. Let's look at an example, assuming I have three separate tests that look like this:

```ruby

	feature 'Viewing links' do
	 
	  scenario 'user views links' do
	    when_a_user_visits_the_homepage
	    then_they_should_see_links
	  end
	 
	  def when_a_user_visits_the_homepage
	    create :link, title: 'first'
	    visit root_path
	  end
	 
	  def then_they_should_see_links
	    expect(page).to have_content('first')
	  end
	 
	end
```

```ruby

	feature 'Visiting links' do

	  scenario 'vistor clicks link' do
	    when_a_visitor_clicks_the_link_title
	    then_they_should_be_taken_to_the_link
	  end

	  def when_a_visitor_clicks_the_link_title
	    create_link
	    visit root_path
	    click_link link.title 
	  end

	  def then_they_should_be_taken_to_the_link
	    expect(page.current_url).to eq(link.url)
	    expect(page.status_code).to eq(200)
	  end

	  let(:link) {create :link, title: 'link'}
	  alias_method :create_link, :link
	end

```

```ruby

	feature 'Social media sharing' do

	  scenario 'visitor shares link' do
	    when_a_visitor_likes_a_link
	    then_they_should_be_able_to_share_the_link
	  end

	  def when_a_visitor_likes_a_link
	    create :link, title: 'first'
	    visit root_path
	  end

	  def then_they_should_be_able_to_share_the_link
	    expect(page).to have_css('.social-share-button')
	  end

	end

```

In each test I’m creating the link and I’m visiting the `root_path` so this bit of code below is repeated three times:

```ruby

	create :link, title: 'first'
		visit root_path

```
So, why don't we just move it into it's own method?

**1.	Tests should be independent:** Your tests shouldn’t be dependent on other things running/working, for them to work themselves. There are instances where you’ll need dependencies like in the use of factories but one test shouldn’t have to run & pass in order for another test to run & pass. This means that if there is a failure, it’s easy to isolate the problem to the correct place. If tests become dependent, you’d also need to test the dependency to make sure that works as it should and then things become excessive and complicated.

**2.	Tests are easier to read:** Having that repeated code block in the tests makes it easier for those who are new or unfamiliar with the codebase, to read and understand what’s going on without getting lost in the codebase.

**3. There is no real added benefit to DRY in tests:** The app is separate from the tests so app performance isn’t affected, your test suite may slow down but I’d argue that if you were really going to DRY up your tests, testing dependencies would add bloat anyway.

## To DRY or Not To DRY?

I love DRY, I might even be a little obsessed, but the point of DRY is to ease the load off of the application and the developer, it means you’ll be updating fewer places when changes happen, and the app will be faster and more dynamic. The moment DRY creates more work than just repeating yourself, it loses its benefits.

