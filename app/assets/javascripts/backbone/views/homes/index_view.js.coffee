Mailtime.Views.Homes ||= {}

class Mailtime.Views.Homes.IndexView extends Backbone.View
  template: JST["backbone/templates/homes/index"]

  events:
    'click button': 'submit'

  submit: (e) ->
    e.preventDefault()

    username = @$('.username').val()
    password = @$('.password').val()

    $.post '/users', {username: username, password: password}, (data) ->
      console.log data

  render: ->
    $(@el).html(@template())
    @
