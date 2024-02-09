FactoryBot.define do
    factory :post do
        title { Faker::Book.title }
        content { Faker::Lorem.paragraph(sentence_count: 2) }
    end
end
