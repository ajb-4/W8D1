require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject (:jasmine) { User.create!(username: 'jasmine', password: 'abcdef') }
  let (:jack) { User.create!(username: 'jackyboy', password: 'abcdef') }

  describe 'GET /users/new (#new)' do
    it 'renders the "Sign Up" form' do
      get new_user_url
      expect(response.body).to include("Sign Up")
      expect(response.body).not_to include("Sign In")
      expect(response.body).not_to include("All Users")
      expect(response.body).not_to include("Poems for")
    end
  end

  describe 'POST /users (#create)' do
    context 'with blank username' do
      it 'returns to the "Sign Up" page and appropriately stores "Username can\'t be blank" error message for display' do
        post users_url, params: { user: { username: '', password: 'abcdef' } }
        expect(response.body).to include("Sign Up")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("All Users")
        expect(response.body).not_to include("Poems for")
        expect(flash.now[:errors]).to eq(["Username can't be blank"])
      end
    end

    context 'with too-short password' do
      it 'returns to the "Sign Up" page and appropriately stores "Password is too short (minimum is 6 characters)" for display' do
        post users_url, params: { user: { username: 'jack_bruce', password: 'short' } }
        expect(response.body).to include("Sign Up")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("All Users")
        expect(response.body).not_to include("Poems for")
        expect(flash.now[:errors]).to eq(["Password is too short (minimum is 6 characters)"])
      end
    end

    context 'with valid params' do
      it 'redirects to the poem index' do
        post users_url, params: { user: { username: 'jack_bruce', password: 'password' } }
        expect(response).to redirect_to(poems_url)
      end

      it 'logs in the user' do
        post users_url, params: { user: { username: 'jack_bruce', password: 'abcdef' } }
        user = User.find_by_username('jack_bruce')
        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end
end
