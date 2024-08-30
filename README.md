# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version `3.0.0`
* Rails `7.1.4`
* For database setup and migrations run: `rails db:setup`
* For Server run command: `bin/dev`
  
Implementation Explaintaion
* Models:

* User: Uses Devise for authentication, handling sign-ups and logins. It’s connected to posts and likes.
* Post: Includes title and content, and is linked to the user. It also supports liking functionality.
* Like: Allows users to like posts and can be associated with different models thanks to its polymorphic setup.
* Routes:
* Devise manages user authentication.
* CRUD operations for posts are set up, and a simple route for creating likes.

* Scaffolding and Turbo Frames:
* Scaffolding quickly set up the basic functionality for posts.
* Turbo Frames make the like button and like counts update in real-time without refreshing the page.
* Keeping Like button and likes count in a partial for DRY.
* Testing Gems:
* RSpec: For writing and running tests.
* Factory Bot: For creating test data.
* Shoulda Matchers: For simplifying tests on validations and associations.
* SimpleCov: To check how much of the code is covered by tests.
* Rails Controller Testing: Enhances testing for controller actions.
* Testing Approach
* Model Tests:
* Ensure Post model have proper validations and associations.
* Controller Tests:
* Verify CRUD operations for posts work as expected.
* Used Tailwind CSS for styling
