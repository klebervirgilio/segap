class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates :title, uniqueness: true
  validates :title, :content, presence: true

  def self.ordered
    order('published_on desc, created_at desc')
  end

  def self.published
    where('published_on <= :now and published_on is not null', now: Time.now)
  end

  def self.unpublished
    where('published_on > :now or published_on is null', now: Time.now)
  end

  def total_words
    (title.scan(/\S+/) + content.scan(/\S+/)).size
  end
end
