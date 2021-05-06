class HomeController < ApplicationController
  def home_page
    render json: {message: 'Hi, I am message board'}
  end
end