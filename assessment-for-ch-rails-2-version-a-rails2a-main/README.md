# Rails Assessment 2A

**Do not share this repo or post any parts of it publicly. App Academy will take
violations very seriously.**

You will have **2 hours** to complete this assessment. This assessment consists
of a Poem Application with User Authentication.

## Scoring and time estimates

| Component             | Maximum Points | Estimated Time (minutes) |
| --------------------- | -------------- | ------------------------ |
| Poem Application      | 74             | 2 hours                  |

The maximum number of points for this entire assessment is **74**. Your final
score will be calculated as the percentage of points awarded over the maximum
number of points:

The passing score for this evaluation is 59 / 74.

## Overall File Structure

You will start with a standard Rails file structure that includes specs. **Do
not alter any of the spec files.**

## Scoring & Objective for Poem Application

Each passing spec will award one point, for a total of 74 points. This component
of the assessment is estimated to take **2 hours**. Your objective
is to pass as many specs as possible.

## Getting Started

Before you begin running the specs, make sure that you create your database:

```sh
rails db:create
```

## Database Config

Every time you run `rails db:migrate`, also run `rails db:test:load`.
`db:migrate` only updates the development database; `db:test:load` updates the
test DB schema to mirror the development DB.

You can combine both commands into one:

```sh
rails db:migrate db:test:load
```

### Resources

You will create migrations, models, routes, controllers, and views for the
following data types:

1. `Users` will have a `username` that is a string, a `session_token` that is
   a string, and a `password_digest` that is a string.
2. `Poems` will have a `title` that is a string, `stanzas` that is a text, a
   column named `complete` that is either `true` or `false` (use `t.boolean` in
   the migration), and will belong to a `User` (name this association `author`).

A `User` has many `Poem`s, and a `Poem` belongs to a `User`. Any `User` can
create and update their own `Poem`s, but one `User` cannot update another
`User`'s `Poem`.

Logged-in `User`s will be able to view a list of `Poem`s and create and update
`Poem`s. If a `User` is not logged in, they will be taken to the `Sign In` page.

For further details and requirements, run the specs.

#### User Authentication Tips

- **Use BCrypt**. You must not store passwords in the DB.
- `BCrypt::Password.create(password)` digests a password and builds a `Password`
  object.
- `BCrypt::Password.new(digest)` builds a `Password` object for the digest.
- `BCrypt::Password#is_password?(password)` checks if a password matches a
  digest.

## Specs

As you progress though this assessment, it is recommended that you complete and
run all the **Model** specs, then the **Request** and **View** specs, and then
the **System** Specs. Note that some of the Request specs test that something
works when a user is logged in. You will need to get your Auth up and running
before those specs will pass. Finally, do not put "Sign Up" or "Sign In"
links/buttons in your __application.html.erb__ file as this could cause some of
the Request specs to fail.

If a failing spec confuses you, look at the spec file to see if you can discern
what it is asking of you. You may also wish to add `debugger`s for RSpec files
or `save_and_open_page` for Capybara specs to see what Capybara sees.

Note that a common mistake relates to capitalization: Capybara needs to have the
text of links and buttons exactly match what it expects.

As ever, please ask your TAs any questions. If you get stuck or don't know why
something is failing; ask. TAs will let you know whether they can answer your
question, so ask anything. **Do NOT use the internet or prior notes.**

### Running Specs

- `bundle install` to install dependencies
- `bundle exec rspec` to run the entire spec suite
- `bundle exec rspec spec/<spec_file_name>` to run all specs in a given spec
  file

  - for example: `bundle exec rspec spec/models/user_spec.rb`

- The tests are intended to be run in this order:
  - `bundle exec rspec spec/models/user_spec.rb`
  - `bundle exec rspec spec/models/poem_spec.rb`
  - `bundle exec rspec spec/requests/application_controller_spec.rb`
  - `bundle exec rspec spec/requests/users_spec.rb`
  - `bundle exec rspec spec/requests/sessions_spec.rb`
  - `bundle exec rspec spec/requests/poems_spec.rb`
  - `bundle exec rspec spec/views/poems/index.html.erb_spec.rb`
  - `bundle exec rspec spec/system/auth_spec.rb`
  - `bundle exec rspec spec/system/poems_spec.rb`

- `bundle exec rspec spec/<spec_file_name>:<line_number>` to run the spec(s) in
  the block that contains the given line number of a given spec file
  - for example: `bundle exec rspec spec/models/user_spec.rb:1`

## Submission

- Rename the directory `"#{first_name}_#{last_name}"`.
- **Remove the `tmp` and `vendor`** folders to ensure your file won't be too
  big.
- ZIP it. (Mac users can use OS X's built in zip functionality.)
- Make sure you submit a `.zip`; no boutique formats please :-).

Good luck!

**Copyright App Academy. Please do not post online.**