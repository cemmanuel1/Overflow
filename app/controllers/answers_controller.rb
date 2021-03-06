class AnswersController < ApplicationController
  def new
    @answerable = Answer.find(params[:answer_id])
    @answer = Answer.new

    render :json => render_to_string(partial: 'form_answer', locals: {answerable: @answerable, answer: @answer}).to_json
  end

  def create
    @answer = Answer.create(params[:answer])
    render :json => render_to_string(partial: 'answer', locals: {answer: @answer}).to_json
  end
end
