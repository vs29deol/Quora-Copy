class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = Answer.where(question_id: @question.id)
  end

  # GET /questions/new
  def new
    @question = current_user.questions.build
  end

  def follow
    # binding.pry
    user_id = current_user.id.to_i
    if params[:question][:user_id].present?
      f_users = current_user.following_users
      respond_to do |format|
        if f_users.include?(user_id)
          f_users.delete(user_id)
          current_user.save
          format.html { redirect_to :back, notice: 'User Unfollowed' }
        else
          f_users << user_id
          current_user.save
          format.html { redirect_to :back, notice: 'User Followed' }
        end
      end
    else
      topic = Topic.find(params[:question][:topic_id].to_i)
      respond_to do |format|
        if topic.following_users.include?(user_id)
          topic.following_users.delete(user_id)
          topic.save
          format.html { redirect_to :back, notice: 'Topic Unfollowed' }
        else
          topic.following_users. << user_id
          topic.save
          format.html { redirect_to :back, notice: 'Topic Followed' }
        end
      end
    end
  end

  # def follow_topic
  #   binding.pry
  #   f_users = current_user.topics.following_users
  #   user_id = current_user.id.to_i
  #   respond_to do |format|
  #     if f_users.include?(user_id)
  #       f_users.delete(user_id)
  #       current_user.save
  #       format.html { redirect_to :back, notice: 'Topic Unfollowed' }
  #     else
  #       f_users << user_id
  #       current_user.save
  #       format.html { redirect_to :back, notice: 'Topic Followed' }
  #     end
  #   end 
  # end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.fetch(:question, {}).permit(:name,:topic_id)
    end
end
