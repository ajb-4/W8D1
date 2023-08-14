require 'rails_helper'

RSpec.describe "Poems", type: :request do
  let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }
  let(:jasmine) { User.create!(username: 'jasmine', password: 'abcdef') }
  let(:jasmine_poem) { Poem.create!(title: 'New Haiku', stanzas: 'i need to be good, at haikus in general, need to get better', complete: 'false', author: jasmine) }

  describe 'GET /poems (#index)' do
    context 'when logged in' do
      before do
        log_in_as(jasmine)
      end

      it 'renders the index page displaying "All Poems"' do
        get poems_url
        expect(response.body).to include("All Poems")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("Sign Up")
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        get poems_url
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
  
  describe 'GET /poems/new (#new)' do
    context "when logged in" do
      before do
        log_in_as(jasmine)
      end

      it 'renders the "Create New Poem" form' do
        get new_poem_url
        expect(response.body).to include("Create New Poem")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("All Poems")
      end
    end

    context "when logged out" do
      it 'redirects to the login page' do
        get new_poem_url
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'POST /poems (#create)' do
    context 'when logged in' do
      before do
        log_in_as(jack)
      end

      context 'with invalid params' do
        it 'appropriately stores error messages for display and returns to the "Create New Poem" form' do
          post poems_url, params: { poem: { title: 'Poem For My Own World', stanzas: "", complete: 'false' } }
          expect(response.body).to include("Create New Poem")
          expect(response.body).not_to include("Sign In")
          expect(response.body).not_to include("Sign Up")
          expect(response.body).not_to include("All Poems")
          expect(flash.now[:errors]).to eq(["Stanzas can't be blank"])
        end
      end

      context 'with valid params' do
        it 'creates the poem and redirects to the poem\'s index page' do
          post poems_url, params: { poem: 
                                      { title: 'The Garden',
                                        stanzas: 'walking daintily I will say, I\'ll walk in the Garden on this day',
                                        complete: 'true' 
                                      } 
                                  }
          expect(response).to redirect_to(poems_url)
          expect(Poem.exists?(title: 'The Garden')).to be true
        end
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        post poems_url, params: { poem: 
                                    { title: 'The Garden',
                                      stanzas: 'walking daintily I will say, I\'ll walk in the Garden on this day',
                                      complete: 'true' 
                                    } 
                                }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET /poems/:id/edit (#edit)" do
    context "when logged in" do
      before do
        log_in_as(jasmine)
      end

      it "renders the \"Edit Poem\" page (even if logged-in user is not the author)" do
        get edit_poem_url(jasmine_poem), params: {id: jasmine_poem.id}
        expect(response.body).to include("Edit Poem")
        expect(response.body).not_to include("All Poems")
        expect(response.body).not_to include("Sign Up")
        expect(response.body).not_to include("Sign In")
        expect(response.body).not_to include("Poems for")
      end
    end

    context "when logged out" do
      it "redirects to the login page" do
        get edit_poem_url(jasmine_poem), params: {id: jasmine_poem.id}
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'PATCH /poems/:id (#update)' do
    context 'when logged in as a different user' do
      before do
        log_in_as(jack)
      end

      it 'does not allow users to update another user\'s poems' do
        patch poem_url(jasmine_poem), params: { id: jasmine_poem.id, poem: { title: 'Jack\'s Poem now!' }}
        edited_poem = Poem.find(jasmine_poem.id)
        expect(edited_poem.title).not_to eq('Jack\'s Poem now!')
      end

      it 'returns to the "Edit Poem" form and appropriately stores error message "Something went wrong!" for display' do
        patch poem_url(jasmine_poem), params: { id: jasmine_poem.id, poem: { title: 'Jack\'s Poem now!' }}
        expect(response.body).to include('Edit Poem')
        expect(flash.now[:errors]).to eq(['Something went wrong!'])
      end
    end

    context 'when logged in as the poem\'s owner' do
      before do
        log_in_as(jasmine)
      end

      it 'updates the poem and redirects to the poem index page' do
        patch poem_url(jasmine_poem), params: { id: jasmine_poem.id, poem: { title: 'Updated Poem Title!' }}
        expect(Poem.exists?(title: 'Updated Poem Title!')).to be true
        expect(response).to redirect_to(poems_url) 
      end
    end

    context 'when logged out' do
      it 'redirects to the login page' do
        patch poem_url(jasmine_poem), params: { id: jasmine_poem.id, poem: { title: 'Updated Poem Title!' }}
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end
