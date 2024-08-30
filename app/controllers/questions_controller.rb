class QuestionsController < ApplicationController
  before_action :set_all_questions, only: [:index, :play, :check_answer]

  def index
  end

  def play
    session[:question_check] ||= 0
    session[:errors] ||= 0
    session[:correct_answers] ||= 0

    @question = @questions.shuffle.first

    session[:current_question_id] = @question.id
  end

  def check_answer
    selected_answer = params[:selected_answer]
    question_id = session[:current_question_id]

    correct_answer_from_question = @questions.find(question_id)

    #проверкa правильного ответа:
    if selected_answer == correct_answer_from_question.answer["1"]
      session[:correct_answers] += 1
      session[:question_check] += 1
    else
      session[:errors] += 1
    end
    
    # Перенаправление на результат или следующий вопрос
    if session[:errors] >= 2 || session[:question_check] == 10
      redirect_to result_questions_path
    else
      redirect_to play_questions_path
    end
  end

  def result
    @correct_answers = session[:correct_answers]
    @errors = session[:errors]

    reset_session
  end

  private

  def set_all_questions
    @questions = Question.all
  end
end
