class GlossaryController < ApplicationController

  def lookup_lesson_terms
    # TODO: exception handling

    words = GlossaryEntry.joins(:lessons).where('lesson_id = ?', params[:id])

    render :json => words.to_json(:only => [:id, :name, :short_definition])
  end

  def lookup_term
    # TODO: exception handling

    word = GlossaryEntry.where(:name => params[:term]).first

    render :json => word.to_json(:only =>
                                     [:name, :short_definition, :full_definition, :image_file, :pronun_file, :ext_link])
  end

end