require 'spec_helper'

describe Event do
  it { should validate_presence_of :description }
  it { should ensure_length_of(:description).is_at_most(150)}

  describe '.all_date_order' do
    it 'should return future events only ordered by start date' do
      event1 = Event.create(:description => 'eat1', :location => 'here', :start => '2014/03/28 12:00', :end => '2014/03/28 12:30')
      event2 = Event.create(:description => 'eat2', :location => 'over there', :start => '2014/03/26 12:00', :end => '2014/03/26 12:30')
      event3 = Event.create(:description => 'eat3', :location => 'there', :start => '2014/03/28 10:00', :end => '2014/03/28 10:30')
      Event.all_date_order.should eq [event3, event1]
    end
  end

  describe '.view_current_events' do
    it 'should return dates equal to input' do
      event1 = Event.create(:description => 'eat1', :location => 'here', :start => '2014/03/27 12:00', :end => '2014-03-27 12:30')
      event2 = Event.create(:description => 'eat2', :location => 'over there', :start => '2014/04/28 12:00', :end => '2014-04-28 12:30')
      event3 = Event.create(:description => 'eat3', :location => 'there', :start => '2014/03/27 10:00', :end => '2014-03-27 10:30')
      event4 = Event.create(:description => 'eat4', :location => 'somewhere over there', :start => '2014/03/29 12:00', :end => '2014-03-29 12:30')
      event5 = Event.create(:description => 'eat5', :location => 'Right there', :start => '2014/03/07 10:00', :end => '2014-03-07 10:30')
      Event.view_current_events('D').should eq [event1, event3]
      Event.view_current_events('w').should eq [event1, event3, event4]
      Event.view_current_events('m').should eq [event1, event3, event4, event5]
    end
  end

end
