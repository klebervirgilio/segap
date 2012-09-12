FactoryGirl.define do
  factory :valid_page, :class => Page do
    sequence :title do |n|
      "Pretty creative title #{n}"
    end
    content 'Pretty interesting content'
  end

  factory :published_page, :class => Page do
    sequence :title do |n|
      "Pretty creative published title  #{n}"
    end
    content 'Pretty interesting published content'
    published_on Time.now
  end


end