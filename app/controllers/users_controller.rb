class UsersController < ApplicationController


  def view
  	@user = User.find(params[:id])
  	@pics = Pic.user_keyword_search(params[:id])
  end


end
