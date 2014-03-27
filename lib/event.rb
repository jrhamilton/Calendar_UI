class Event < ActiveRecord::Base
  validates :description, :presence => true, :length => { :maximum => 150 }

  def self.all_date_order
    now = Time.new
    puts "************************"
    puts "#{now}"
    future_events_ordered = []
    Event.all.order(:start).each do |event|
      if event.start > now
        future_events_ordered << event
      end
    end
    future_events_ordered
  end

  # def self.view_current_events(t)
  #   t = t.upcase
  #   time = Time.new()
  #   case t
  #   when 'D'
  #     #this_day = Time.strftime("%Y-%m-%d 00:00")
  #     events = Event.where(:start.strftime("%Y-%m-%d 00:00") == time.strftime("%Y-%m-%d 00:00"))
  #   when 'W'
  #     #this_week = Time.strftime("%Y %U")
  #     events = Event.where(DateTime.parse('start').to_time.strftime("%Y %U") == time.strftime("%Y %U"))
  #   when 'M'
  #     this_month = Time.strftime("%Y-%m")
  #     events = Event.where(:start.this_month == time.this_month)
  #   else
  #     events = []
  #   end
  #   events
  # end

  def self.view_current_events(t)
    t = t.upcase
    time = Time.now
    events = []
    case t
    when 'D'
      Event.all.each do |e|
        #puts "#{e.start.strftime("%Y %m %d")} ******* #{time.strftime("%Y %m %d")}"
        if e.start.strftime("%Y %m %d") == time.strftime("%Y %m %d")
          events << e
        end
      end
    when 'W'
      Event.all.each do |e|
        if e.start.strftime("%Y %U") == time.strftime("%Y %U")
          events << e
        end
      end
    when "M"
      Event.all.each do |e|
        if e.start.month == time.month
          events << e
        end
      end
    else
      events = []
    end
    events
  end


end


