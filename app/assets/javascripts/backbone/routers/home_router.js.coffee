class Mailtime.Routers.HomesRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "!/": "index"

  index: ->
    @view = new Mailtime.Views.Homes.IndexView()
    $("#main").html(@view.render().el)

