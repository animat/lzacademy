class CampController < ApplicationController
  def locations
  end

  def schedule
    @young_camp_courses = Course.camp(2012).younger.all
    @old_camp_courses = Course.camp(2012).older.all
  end
  
  def typical_day
  end

  def discounts
  end

  def register
  end

end
