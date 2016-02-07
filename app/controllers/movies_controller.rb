class MoviesController < ApplicationController

  # def index
  #   unless params[:runtime_in_minutes] || params[:title] || params[:director]
  #     @movies = Movie.all
  #   end
  #   @movies = Movie.duration(params[:runtime_in_minutes]).search(params[:title], params[:director])
  # end

  def index
    unless params[:search] || params[:runtime_in_minutes]
      @movies = Movie.all
    end
    @movies = Movie.duration(params[:runtime_in_minutes]).search(params[:search])
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :description, :image, :remote_image_url
    )
  end

end
