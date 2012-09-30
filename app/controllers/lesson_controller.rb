class LessonController < ApplicationController
  def lesson_show

     #exception handling required!

    @lesson = Lesson.where(:id => params[:id])
    .includes(:objectives, :references, :category , :lesson_ratings)
    .first

    @categories = Category.where(:parent_id => nil).includes(:sub_categories)

    @lesson_questions = Question.find(:all,
                                      :select => "questions.* , avg(question_ratings.rating) as rating_average",
                                      :conditions => ["questions.lesson_id=" + @lesson.id.to_s],
                                      :joins => "left outer join question_ratings ON question_ratings.question_id = questions.id",
                                      :group => "questions.id",:offset => 0 , :limit => 5)

    @avg_rate = @lesson.lesson_ratings.average("rating")
  end
end