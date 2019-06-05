require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza_order')
also_reload('./models/*')

# INDEX
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb (:index)
end

# NEW (must be before SHOW due to routes)
get '/pizza-orders/new' do
  erb(:new)
end

# CREATE
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

# SHOW
get '/pizza-orders/:id' do
  @order = PizzaOrder.find( params[:id].to_i )
  erb(:show)
end


# post '/pizza-orders/:id/delete' do
#   @order = PizzaOrder.find( params[:id].to_i )
#   erb(:delete)
# end

post '/pizza-orders/:id/delete' do
  order = PizzaOrder.find(params[:id].to_i)
  order.delete()
  redirect '/pizza-orders'
end

get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find( params[:id].to_i )
  erb(:edit)
end

# UPDATE
post '/pizza-orders/:id' do
  binding.pry
  @order = PizzaOrder.new( params )
  # @order.first_name = params['first_name']
  # @order.last_name = params['last_name']
  # @order.topping = params['topping']
  # @order.quantity = params['quantity']
  @order.update()
  redirect '/pizza-orders'

end
