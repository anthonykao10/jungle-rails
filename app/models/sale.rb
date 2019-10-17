class Sale < ActiveRecord::Base
  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    starts_on < Date.current && ends_on > Date.current
  end
end
