Mailtime.Views.Homes ||= {}

class Mailtime.Views.Homes.IndexView extends Backbone.View
  template: JST["backbone/templates/homes/index"]

  events:
    'click button': 'submit'

  submit: (e) ->
    e.preventDefault()

    @username = @$('.username').val()
    @password = @$('.password').val()

    $.post '/users', {username: @username, password: @password}, (data) ->
      received_hours = {}
      sent_hours = {}

      received_days = {}
      sent_days = {}

      _.each data.received, (d) ->
        date = new Date(d * 1000)

        hour = date.getHours()
        if received_hours[hour]
          received_hours[hour] += 1
        else
          received_hours[hour] = 1

        day = date.getDay()
        if received_days[day]
          received_days[day] += 1
        else
          received_days[day] = 1

      _.each data.sent, (d) ->
        date = new Date(d * 1000)

        hour = date.getHours()
        if sent_hours[hour]
          sent_hours[hour] += 1
        else
          sent_hours[hour] = 1

        day = date.getDay()
        if sent_days[day]
          sent_days[day] += 1
        else
          sent_days[day] = 1

      Mailtime.DaysMax = _.max(_.map(received_days, (d) -> d).concat(_.map(sent_days, (d) -> d)))
      Mailtime.Days = [
        { Date: "Sunday", Incoming: received_days[0], Outgoing: sent_days[0]},
        { Date: "Monday", Incoming: received_days[1], Outgoing: sent_days[0]},
        { Date: "Tuesday", Incoming: received_days[2], Outgoing: sent_days[0]},
        { Date: "Wednesday", Incoming: received_days[3], Outgoing: sent_days[0]},
        { Date: "Thursday", Incoming: received_days[4], Outgoing: sent_days[0]},
        { Date: "Friday", Incoming: received_days[5], Outgoing: sent_days[0]},
        { Date: "Saturday", Incoming: received_days[6], Outgoing: sent_days[0]},
      ]
      Mailtime.HoursMax = _.max(_.map(received_hours, (d) -> d).concat(_.map(sent_hours, (d) -> d)))
      Mailtime.Hours = [
        { Date: "0", Incoming: received_hours[0], Outgoing: sent_hours[0]},
        { Date: "1", Incoming: received_hours[1], Outgoing: sent_hours[1]},
        { Date: "2", Incoming: received_hours[2], Outgoing: sent_hours[2]},
        { Date: "3", Incoming: received_hours[3], Outgoing: sent_hours[3]},
        { Date: "4", Incoming: received_hours[4], Outgoing: sent_hours[4]},
        { Date: "5", Incoming: received_hours[5], Outgoing: sent_hours[5]},
        { Date: "6", Incoming: received_hours[6], Outgoing: sent_hours[6]},
        { Date: "7", Incoming: received_hours[7], Outgoing: sent_hours[7]},
        { Date: "8", Incoming: received_hours[8], Outgoing: sent_hours[8]},
        { Date: "9", Incoming: received_hours[9], Outgoing: sent_hours[9]},
        { Date: "10", Incoming: received_hours[10], Outgoing: sent_hours[10]},
        { Date: "11", Incoming: received_hours[11], Outgoing: sent_hours[11]},
        { Date: "12", Incoming: received_hours[12], Outgoing: sent_hours[12]},
        { Date: "13", Incoming: received_hours[13], Outgoing: sent_hours[13]},
        { Date: "14", Incoming: received_hours[14], Outgoing: sent_hours[14]},
        { Date: "15", Incoming: received_hours[15], Outgoing: sent_hours[15]},
        { Date: "16", Incoming: received_hours[16], Outgoing: sent_hours[16]},
        { Date: "17", Incoming: received_hours[17], Outgoing: sent_hours[17]},
        { Date: "18", Incoming: received_hours[18], Outgoing: sent_hours[18]},
        { Date: "19", Incoming: received_hours[19], Outgoing: sent_hours[19]},
        { Date: "20", Incoming: received_hours[20], Outgoing: sent_hours[20]},
        { Date: "21", Incoming: received_hours[21], Outgoing: sent_hours[21]},
        { Date: "22", Incoming: received_hours[22], Outgoing: sent_hours[22]},
        { Date: "23", Incoming: received_hours[23], Outgoing: sent_hours[23]},
      ]

      window.location.hash = '!/days'
      $('#links').show()

    @initJuggernautHook()

  totalCountProcess: (msg) ->
    json = JSON.parse(msg)
    Mailtime.TotalCount = json.count
    window.location.hash = '!/clock'

  currentCountProcess: (msg) ->
    json = JSON.parse(msg)
    Mailtime.CurrentCount = Mailtime.CurrentCount + json.count

  initJuggernautHook: ->
    # for all the new notifications
    Mailtime.Juggernaut.subscribe("/start/#{@username}", @totalCountProcess)
    Mailtime.Juggernaut.subscribe("/update/#{@username}", @currentCountProcess)

  render: ->
    $(@el).html(@template())
    $('#clock').html("")
    $('#title').css
      color: 'black'

    @

