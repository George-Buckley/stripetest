class SubscribeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
  end

  def new
  end

  def update
    token = params[:stripeToken]
    plan_id = params[:plan_id]
    plan = Stripe::Plan.retrieve(plan_id)

    customer = Stripe::Customer.create(
    :source => token,
    :plan => plan,
    :email => current_user.email
    )

    subscription = Stripe::Subscription.create(
    :customer => customer,
    :plan => plan
    )

    current_user.subscribed = true
    current_user.stripeid = customer.id
    current_user.subid = subscription.id
    current_user.planid = plan_id
    current_user.save

    redirect_to notes_path, :notice => "You're now subscribed"
  end

  def cancel_plan
    customer = Stripe::Customer.retrieve(current_user.stripeid)
    subscription = Stripe::Subscription.retrieve(current_user.subid)
    subscription.delete
    current_user.subscribed = false
    current_user.stripeid = nil
    current_user.subid = nil
    current_user.save
    redirect_to new_subscribe_path, :notice => "You're unsubscribed"
  end
end
