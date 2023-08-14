module PoemSystemHelper
  def make_poem(title = 'Moonpie', stanzas = 'through the ages you haunt', complete = 'false')
    visit new_poem_url
    fill_in 'Title', with: title
    fill_in 'Stanzas', with: stanzas
    choose(option: complete)
    click_button 'Create Poem'
  end
end
