class MovieController < ApplicationController
	def search
		if params[:movie_name]
			@movie_result = Movie_Api.new.perform(params[:movie_name])
			session[:movie_name] = @movie_result
		elsif session[:movie_name]
			@movie_result = session[:movie_name]
		else
			@movie_result = nil
		end
	end
end
