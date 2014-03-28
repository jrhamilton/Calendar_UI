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

  #def next_events(t)

  def self.todays_events(events, time)
    Event.all.each do |e|
      if e.start.strftime("%Y %m %d") == time.strftime("%Y %m %d")
        events << e
      end
    end
    events
  end

  def self.this_weeks_events(events, time)
    Event.all.each do |e|
      if e.start.strftime("%Y %U") == time.strftime("%Y %U")
        events << e
      end
    end
    events
  end

  def self.this_months_events(events, time)
    Event.all.each do |e|
      if e.start.month == time.month
        events << e
      end
    end
    events
  end

  def self.next_days_events(events, day)
    todays_events(events, day + 1.day)
  end

  def self.next_weeks_events(events, week)
    this_weeks_events(events, week + 1.week)
  end

  def self.next_months_events(events, month)
    Event.this_months_events(events, month + 1.month)
  end

  def self.current_events(t)
    t = t.upcase
    time = Time.now
    case t
    when 'D'
      events = Event.todays_events([], time)
    when 'W'
      events = Event.this_weeks_events([], time)
    when "M"
      events = Event.this_months_events([], time)
    else
      events = []
    end
    events
  end

  def self.next_events(events, time, t)
    t = t.upcase
    case t
    when 'D'
      events = Event.next_days_events(events, time)
    when 'W'
      events = Event.next_weeks_events(events, time)
    when 'M'
      events = Event.next_months_events(events, time)
    else
      events = []
    end
    events
  end




end


