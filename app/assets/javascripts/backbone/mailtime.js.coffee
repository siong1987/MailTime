#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Mailtime =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$(document).ready ->
  window.router = new Mailtime.Routers.HomesRouter()
  Backbone.history.start()

