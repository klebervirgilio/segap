require 'spec_helper'

describe Api::PagesController do

  describe "GET index" do
    let!(:pages){ FactoryGirl.create_list(:published_page,3) }

    context "json" do
      it "should return all pages given the format" do

        get :index, format: :json
        pages.map(&:id).each {|page_id| response.body.should match "\"id\":#{page_id}"}
      end
    end

    context "xml" do
      it "should assigns all pages given the format" do

        get :index, format: :xml
        pages.map(&:id).each {|page_id| response.body.should match "<id type=\"integer\">#{page_id}</id>"}
      end
    end
  end

  describe "GET show" do
    let!(:valid_page) { FactoryGirl.create(:valid_page)}
    context 'json' do
      it "should show the attributes for a page given the id" do

        get :show, id: valid_page.id, format: :json
        response.body.should match "\"id\":#{valid_page.id}"
      end
    end

    context 'xml' do
      it "should show the attributes for a page given the id" do

        post :show, id: valid_page.id, format: :xml
        response.body.should match "<id type=\"integer\">#{valid_page.id}</id>"
      end
    end
  end

  describe "PUT update" do
    let!(:valid_page) { FactoryGirl.create(:valid_page)}
    
    it "should update the page" do
      expect{
        put :update, {id: valid_page.id, page: {title: "updated title"}, format: :json}
      }.to change{[valid_page.reload.title, valid_page.reload.updated_at]}
    end
  end

  describe "DELETE destroy" do
    let!(:valid_page) { FactoryGirl.create(:valid_page)}

    it "should destroy a page given the id" do
      expect{
        delete :destroy, id: valid_page.id
      }.to change{Page.count}.by(-1)
    end
  end

  describe "POST create" do
    it "should create a new page given the params" do
      expect{
        post :create, page: FactoryGirl.attributes_for(:valid_page)
      }.to change{Page.count}.by(1)
    end
  end

  describe "GET total_of_words" do
    let(:page){mock(Page, total_words: 100)}

    before do
      Page.stub(find_by_id: page)
    end
    
    context 'json' do
      it "should return the total of words" do
      
        get :total_words, id: 1, format: :json
        assigns(:page).should eq(page)
        response.status.should eq(200)
        response.body.should match(/100/)
      end
    end
    
    context 'xml' do
      it "should return the total of words" do

        get :total_words, id: 1, format: :xml
        assigns(:page).should eq(page)
        response.status.should eq(200)
        response.body.should match(/100/)
      end
    end
  end

  describe "POST publish" do
    let!(:valid_page) { FactoryGirl.create(:valid_page)}
    context 'json' do
      it "should set published_on with current time of the null" do

        post :publish, id: valid_page.id, format: :json
        response.status.should eq 201
        response.body.should_not match '"published_on\":null'
      end
    end

    context 'xml' do
      it "should set published_on with current time of the null" do

        post :publish, id: valid_page.id, format: :xml
        response.status.should eq 201
        valid_page.reload.published_on.should_not be_nil
        response.body.should match(/#{valid_page.reload.published_on.xmlschema}/)
      end
    end
  end

  describe "GET published" do
    context 'json' do
      it "should return all pages published ordered" do
        
        Page.should_receive(:published).and_return(Page.scoped)
        Page.should_receive(:ordered).and_return(Page.scoped)

        get :published, format: :json
        response.status.should eq 200
      end
    end

    context 'xml' do
      it "should return all pages published ordered" do
        
        Page.should_receive(:published).and_return(Page.scoped)
        Page.should_receive(:ordered).and_return(Page.scoped)

        get :published, format: :xml
        response.status.should eq 200
      end
    end
  end

  describe "GET unpublished" do
    context 'json' do
      it "should return all pages unpublished ordered" do
        
        Page.should_receive(:unpublished).and_return(Page.scoped)
        Page.should_receive(:ordered).and_return(Page.scoped)

        get :unpublished, format: :json
        response.status.should eq 200
      end
    end

    context 'xml' do
      it "should return all pages unpublished ordered" do
        
        Page.should_receive(:unpublished).and_return(Page.scoped)
        Page.should_receive(:ordered).and_return(Page.scoped)

        get :unpublished, format: :xml
        response.status.should eq 200
      end
    end
  end
end