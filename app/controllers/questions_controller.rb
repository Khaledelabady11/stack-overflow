class QuestionsController < ApplicationController


  def index
    @questions = Question.all
  end


  def show
    @question = Question.find(params[:id])
    render json: {
      question: @question,
      answers: @question.answers
    }
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    if @question.save!

      @answer = ChatgptService.call(@question.body)
      Answer.create(body: @answer,question_id: @question.id)
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
