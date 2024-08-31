class QuestionsController < ApplicationController
  before_action :set_all_questions, only: [:index, :play, :check_answer]
  before_action :set_first_questions, only: [:play]

  def index
  end

  def play
    session[:question_check] ||= 0
    session[:errors] ||= 0
    session[:correct_answers] ||= 0

    session[:current_question_id] = @question.id

    @question_answer_rand = @question.answer.to_a.shuffle.to_h
  end

  def check_answer
    selected_answer = params[:selected_answer]
    question_id = session[:current_question_id]

    correct_answer_from_question = @questions.find(question_id)

    # проверкa правильного ответа:
    if selected_answer == correct_answer_from_question.answer["1"]
      flash[:notice] = "Правильный ответ!"

      session[:correct_answers] += 1
      session[:question_check] += 1
    else
      flash[:alert] = "Не правильный ответ!"

      session[:errors] += 1
    end

    # Перенаправление на результат или следующий вопрос
    if session[:errors] >= 2 || session[:question_check] == 20
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

  def set_first_questions 
    @question = @questions.shuffle.first
  end

  def set_all_questions
    @questions = Question.all
  end
end
