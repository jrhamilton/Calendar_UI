require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def start_menu
  system 'clear'
  puts "Do events"
  events_menu
end

def events_menu
  puts "What's up?"
  choice = nil
  until choice == 0
    list_events
    puts "\n-----------------\n"
    puts "1 - to create events"
    puts "2 - to edit events"
    puts "3 - to delete events"
    puts "0 - to Quit"
    choice = gets.chomp.to_i
    puts choice
    puts "*************"
    case choice
    when 1
      create_events
    when 2
      edit_events
    when 3
      delete_events
    else
      if choice != 0
        puts "Invalid Option"
      end
    end
  end
  puts "Peace out"
end

def create_events
  another_event = 1
  until another_event == 0
    puts "Description of event?"
    description = gets.chomp
    puts "Location of event?"
    location = gets.chomp
    puts "Start time of event in YYYY/MM/DD HH:MM format?"
    start_date = gets.chomp
    puts "End time of event in YYYY/MM/DD HH:MM format?"
    end_date = gets.chomp
    event = Event.create(:description => description, :location => location, :start => start_date, :end => end_date)
    puts "Event has been created."
    puts "Would you like to create another event?"
    puts "1 for YES, 0 for NO"
    another_event = gets.chomp.to_i
  end
end

def edit_events
  system 'clear'
  edit_another = 1
  until edit_another == 0
    list_events
    puts "Choose the Index Number corresponding to the Event you want to edit or 0 to go back to main Events Menu"
    event_i = gets.chomp.to_i - 1
    if event_i < 0
      edit_another == 0
      system 'clear'
      events_menu
    else
      event = Event.all[event_i]
      continue_edit = 1
      until continue_edit == 0
        system 'clear'
        event_i = event.id
        puts "1 - Description: #{event.description}"
        puts "2 - Location: #{event.location}"
        puts "3 - Start Time: #{event.start}"
        puts "4 - End Time: #{event.end}"
        puts "0 - to go back to Events"
        description = event.description
        location = event.location
        start_time = event.start
        end_time = event.end
        puts "\nPick a number to edit"
        edit_choice = gets.chomp
        case edit_choice
        when '1'
          puts "New Description Name?"
          description = gets.chomp
        when '2'
          puts "new Location?"
          location = gets.chomp
        when '3'
          puts "New Start Time?"
          start_time = gets.chomp
        when '4'
          puts "New End Time?"
          end_time = gets.chomp
        when '0'
          continue_edit = 0
          edit_another = 0
          system 'clear'
          events_menu
        else
          puts "Invalide Option"
        end
        event.update(:description => description, :location => location, :start => start_time, :end => end_time)
        system 'clear'
        puts "Event Updated. Continue editing?"
        puts "1 for YES, 0 for NO"
        continue_edit = gets.chomp.to_i
      end
      puts "Edit another Event?"
      puts "1 for YES, 0 for NO"
      edit_another = gets.chomp.to_i
      end
    end
end

def delete_events

end

def list_events
  Event.all_date_order.each_with_index do |e, i|
    puts "#{i + 1}: #{e.description}\n\tLocation: #{e.location}\n\tStarts: #{e.start}\tEnds: #{e.end}\n\n"
  end
end


start_menu
