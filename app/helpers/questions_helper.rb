module QuestionsHelper
  COLORS = %i[bg-success bg-primary bg-secondary bg-danger bg-warning bg-info bg-dark]
  
  def bg_color_cycle
    @bg_color_index ||= -1
    @bg_color_index = (@bg_color_index + 1) % COLORS.size

    COLORS[@bg_color_index]
  end

  def bg_color_cycle_warrning
    "bg-warning"
  end
end