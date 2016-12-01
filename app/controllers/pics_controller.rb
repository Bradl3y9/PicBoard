class PicsController < ApplicationController
	before_action :find_pic, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@pics = Pic.all.order("created_at DESC")
	end

	def userpics
		@pics = Pic.where(user_id) 
	end

	def show
	end

	def new
		@pic = current_user.pics.build
	end

	def create
		@pic = current_user.pics.build(pic_params)

		if @pic.save
			redirect_to @pic, notice: "Successfully created new Pic"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @pic.update(pic_params)
			redirect_to @pic, notice: "Pic was Successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
		@pic.destroy
		redirect_to root_path
	end

	def search #display search form
	end

	def search_results #Siplay search
		@found_pics  = Pic.keyword_search(params[:search_keywords])
		@user_keywords = params[:search_keywords]
		@pics = Pic.all
	
	end

	private

	def pic_params
		params.require(:pic).permit(:title, :description, :image)
	end

	def find_pic
		@pic = Pic.find(params[:id])
	end
end
