class Api::PagesController < Api::ApisController

  before_filter :find_page, except: [:create, :index, :published_api_pages, :unpublished_api_pages]

  #CRUD ...

  def total_words
    respond_with @page.total_words
  end

  def publish
    @page.update_attribute(:published_on, Time.now)
    respond_with @page, location: api_page_path(@page)
  end

  def published
    respond_with Page.published.ordered.all
  end

  def unpublished
    respond_with Page.unpublished.ordered.all
  end

  private
  def find_page
    @page = Page.find_by_id(params[:id])
  end
end
