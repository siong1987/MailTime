#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Mailtime =
  CurrentCount: 0
  TotalCount: 0
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Public:
    initJuggernaut: ->
      jug = new Juggernaut({host: "localhost"})
      Mailtime.Juggernaut = jug

$(document).ready ->
  window.router = new Mailtime.Routers.HomesRouter()
  Backbone.history.start()
  Mailtime.Public.initJuggernaut()

