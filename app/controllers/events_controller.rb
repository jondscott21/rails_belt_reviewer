class EventsController < ApplicationController
  before_action :check_login
  def index
    @otherstate = Event.where('state!=?', current_user.state)
    @userstate = Event.where('state=?', current_user.state)

  end
  def create
    event = Event.new(event_params)
    if event.save
      redirect_back(fallback_location: :back)
    else
      flash[:errors] = event.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def show
    @event = Event.find(params[:id])
    @comments = Comment.all
  end
  def plan
    event = Event.find(params[:id])
    user = User.find(session[:user_id])
    Plan.create(user: user, event: event)
    redirect_back(fallback_location: :back)
  end
  def cancel
    plan = Plan.where('user_id=? AND event_id=?', session[:user_id], params[:id])
    plan.first.destroy
    redirect_back(fallback_location: :back)
  end
  def comment
    comment = Comment.new(comment_params)
    if comment.save
      redirect_back(fallback_location: :back)
    else
      flash[:errors] = comment.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def edit
    @event = Event.find(params[:id])
  end
  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      redirect_to '/events'
    else
      flash[:errors] = event.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_back(fallback_location: :back)
  end
  private
  def event_params
    params.require(:event).permit(:name, :date, :location, :state).merge(user: current_user)
  end
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, event_id: params[:id])
  end
end
