class Poem < ApplicationRecord
    validates :title, presence: true
    validates :stanzas, presence: true
    validates :complete, inclusion: {in: [true, false]}

    belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
end
