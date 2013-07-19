class QuestionsController < ApplicationController
  
  def index
    @user = current_user
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @question.viewed!
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(params[:question])
    redirect_to question_path(@question)
  end
end
