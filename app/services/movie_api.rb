class Movie_Api
	def perform(movie_name)
		@movie_result = []
		Tmdb::Api.key(Rails.application.credentials.dig(:ma_cle_api))
		configuration = Tmdb::Configuration.new
		image = configuration.base_url + configuration.poster_sizes[2]
		movie = Tmdb::Movie.find(movie_name)
		movie_id = 0
		movie.each do |movie|
			movie_tanpon = [] 
			movie_tanpon[0] = movie.title
			movie_tanpon[1] = movie.release_date
			u = movie.id
			if realisateur = Tmdb::Movie.crew(u)
				if realisateur = realisateur[0]
					if realisateur = realisateur["name"]
						movie_tanpon[2] = realisateur
					end
				end
			end
			if poster = Tmdb::Movie.images(u)["posters"]
				if poster = poster[0]
					if poster = poster["file_path"]
						movie_tanpon[3] = image + poster
					end
				end
			end
			@movie_result[movie_id] = movie_tanpon
			if movie_id == 20
				return @movie_result
			end
			movie_id += 1 
		end
		return @movie_result
	end
end
