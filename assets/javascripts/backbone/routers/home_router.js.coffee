class Mailtime.Routers.HomesRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ""        : "index"
    "!/"      : "index"
    "!/clock" : "clock"
    "!/days"  : "days"
    "!/hours" : "hours"

  index: ->
    @view = new Mailtime.Views.Homes.IndexView()
    $("#main").html(@view.render().el)

  clock: ->
    @view = new Mailtime.Views.Homes.ClockView()

  days: ->
    @view = new Mailtime.Views.Homes.DaysView()

  hours: ->
    @view = new Mailtime.Views.Homes.HoursView()

