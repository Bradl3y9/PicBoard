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

		if params['tags']
			params['tags'].each do |tag|
				temp = PicTag.create(:pic_id => @pic.id, :tag_id => Tag.where(:name => tag).first.id)
				if temp.valid?
					temp.save
				end
			end
		end
	end

	def edit
	end

	def goToUser
		redirect_to /users/
	end

	def update
		if @pic.update(pic_params)
			redirect_to @pic, notice: "Pic was Successfully updated"
		else
			render 'edit'
		end

		PicTag.where(:pic_id => @pic.id).destroy_all
		if params['tags']
			params['tags'].each do |tag|
				temp = PicTag.create(:pic_id => @pic.id, :tag_id => Tag.where(:name => tag).first.id)
				if temp.valid?
					temp.save
				end
			end
		end
	end

	def destroy
		@pic.destroy
		redirect_to root_path
	end

	def search #display search form
	end

	def search_results #Siplay search
		pics_from_tags = Pic.all
		if params['tags'] #if tags selected an exclusive-search is performed
			params[:tags].each do |tag|
				pics_from_tags = pics_from_tags.where(:id => PicTag.where(:tag_id => tag).map{|u| u.pic_id})
			end
		end
		@found_pics  = pics_from_tags.keyword_search(params[:search_keywords])
		@user_keywords = params[:search_keywords]
		@pics = Pic.all
	
	end

	private

	def pic_params
		params.require(:pic).permit(:title, :description, :image, tags: [])
	end

	def find_pic
		@pic = Pic.find(params[:id])
	end
end
