require 'rails_helper'

RSpec.describe Poem, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:stanzas) }
  it { should allow_value(true, false).for(:complete) }
  it { should belong_to(:author).class_name(:User) }
end
