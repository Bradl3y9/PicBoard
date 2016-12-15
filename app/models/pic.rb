class Pic < ApplicationRecord
	belongs_to :user
	has_attached_file :image, styles: {medium: "300x300>"}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	scope :from_user, lambda { |user|
		joins(:user).where(:user_id => user.id)}

	def self.keyword_search(keywords)
		keywords = "%" + keywords + "%"
		Pic.where("title LIKE ? OR description LIKE ?",  keywords, keywords)
	end
	def self.user_keyword_search(keywords)
		keywords = "%" + keywords + "%"
		Pic.where("user_id LIKE ?",   keywords)
	end

	
end
