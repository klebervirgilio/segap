class Api::ApisController < ActionController::Base
  respond_to :json, :xml

  rescue_from ActiveRecord::RecordInvalid do |e|
    render :json => e, :status => 500
  end
end