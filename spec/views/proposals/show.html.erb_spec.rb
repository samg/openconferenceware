require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/proposals/show.html.erb" do
  before do
    @controller.stub!('can_edit?').and_return(false)
  end
  
  before :each do
    @proposal = stub_model(Proposal, :status => "proposed", :users => OpenStruct.new)
    @event = stub_model(Event, :id => 1, :title => "Event 1", :proposal_status_published => false);
  end
  
  %w(proposed accepted confirmed rejected junk).each do |status|
    it "should should not show the status for #{status} proposals if statuses are not published" do
      @event.proposal_status_published = false
      @proposal.status = status
      
      assigns[:event]  = @event
      assigns[:proposal] = @proposal
    
      render "/proposals/show.html.erb"
      response.should_not have_tag("div.proposal-status")
    end
  end
  
  it "should show the proposal status for a confirmed proposal if statuses are published" do
    @event.proposal_status_published = true
    @proposal.status = 'confirmed'
    
    assigns[:event]  = @event
    assigns[:proposal] = @proposal
    
    render "/proposals/show.html.erb"
    response.should have_tag("div.proposal-status")
  end
  
  %w(proposed accepted rejected junk).each do |status|
    it "should should not show the status for #{status} proposals even if statuses are published" do
      @event.proposal_status_published = true
      @proposal.status = status
      
      assigns[:event]  = @event
      assigns[:proposal] = @proposal
    
      render "/proposals/show.html.erb"
      response.should_not have_tag("div.proposal-status")
    end
  end
end

