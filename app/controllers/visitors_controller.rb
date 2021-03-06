class VisitorsController < ApplicationController
  def index
    @user = current_user
    @short_urls = nil
    if @user
      @new_url = @user.short_urls.new
      @short_urls = @user.short_urls.order('created_at desc').paginate(page: params[:page])
    end
  end
end
