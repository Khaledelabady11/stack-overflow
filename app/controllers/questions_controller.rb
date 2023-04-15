class QuestionsController < ApplicationController


  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.create(question_prams)
    if question.save!
      redirect_to questions_path, notice: 'Question created successfully.'
    else
      render :new
    end
  end

  private

  def question_prams
    params.require(:question).permit(:body)
  end
end
