class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  scope :search, -> (search_movies) {
    where(['title LIKE ? OR director LIKE ?', "%#{search_movies}%", "%#{search_movies}%"])
  }

  # scope :duration, -> (length_from_select) { 
  #   case length_from_select.to_i
  #   when 1
  #     where('runtime_in_minutes < 90')
  #   when 2
  #     where('runtime_in_minutes > 90 AND runtime_in_minutes < 120')
  #   when 3
  #     where('runtime_in_minutes > 120')
  #   else
  #     all
  #   end
  # }

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end