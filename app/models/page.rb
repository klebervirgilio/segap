class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates :title, uniqueness: true
  validates :title, :content, presence: true

  def self.ordered(field="published_on",order='desc')
    order("#{field} #{order}")
  end

  def self.published
    where('published_on <= :now and published_on is not null', now: Time.now)
  end

  def self.unpublished
    where('published_on > :now or published_on is null', now: Time.now)
  end

  def total_words
    title.split(/\s+/).size + content.split(/\s+/).size
  end
end
