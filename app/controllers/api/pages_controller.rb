class Api::PagesController < Api::ApisController

  before_filter :find_page, except: [:published_api_pages, :unpublished_api_pages, :index, :create]

  def index
    respond_with Page.ordered
  end

  def update
    @page.update_attributes!(params[:page])   
    respond_to do |format|
      format.any(:xml, :json){ render request.format.to_sym => @page }
    end
  end

  def destroy
    @page.destroy!
    respond_with [@page.destroyed?]
  end

  def create
    @page = Page.create!(params[:page])
    respond_to do |format|
      format.any(:xml, :json){ render request.format.to_sym => @page }
    end
  end

  def show
    respond_with @page, location: api_page_path(@page)
  end

  def total_words
    respond_with [@page.total_words]
  end

  def publish
    @page.update_attribute(:published_on, Time.now)
    respond_with @page, location: api_page_path(@page)
  end

  def published
    respond_with Page.published.ordered
  end

  def unpublished
    respond_with Page.unpublished.ordered
  end

  rescue_from 'ActiveRecord::RecordInvalid' do |e|
    respond_to do |format|
      format.any(:xml, :json){ render request.format.to_sym => e.record.errors.full_messages }
    end
  end

  private
  def find_page
    @page = Page.find_by_id(params[:id])
  end
end
