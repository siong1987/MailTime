Mailtime.Views.Homes ||= {}

class Mailtime.Views.Homes.HoursView extends Backbone.View
  initialize: ->
    $('#main').remove()
    $('#clock').remove()
    $('span').remove()
    mail = Mailtime.Hours

    width = 700
    height = 700
    innerRadius = 50
    outerRadius = 300

    Direction =
      Incoming: "rgb(10, 50, 100)"
      Outgoing: "rgb(200, 70, 50)"
    Net =
      Incoming: "rgb(10, 50, 100)"
      Outgoing: "rgb(200, 70, 50)"

    min = 0
    max = Mailtime.HoursMax
    a = (outerRadius - innerRadius) / (max - min)
    b = innerRadius
    radius = (mic) ->
      a * mic + b

    bigAngle = 2.0 * Math.PI / (mail.length)
    smallAngle = bigAngle / 7

    vis = new pv.Panel()
      .width(width)
      .height(height)
      .bottom(100)

    bg = vis.add(pv.Wedge)
      .data(mail)
      .left(width / 2)
      .top(height / 2)
      .innerRadius(innerRadius)
      .outerRadius(outerRadius)
      .angle(bigAngle)
      .startAngle((d) ->
        @index * bigAngle + bigAngle / 2 - Math.PI / 2
      )
      .fillStyle((d) ->
        Net[d.gram]
      )

    bg.add(pv.Wedge)
        .angle(smallAngle)
        .startAngle((d) ->
          @proto.startAngle() + 1.5 * smallAngle
        )
        .outerRadius((d) ->
          radius(d.Incoming)
        )
        .fillStyle(Direction.Incoming)
      .add(pv.Wedge)
        .startAngle((d) ->
          @proto.startAngle() + 3 * smallAngle
        )
        .outerRadius((d) ->
          radius(d.Outgoing)
        )
        .fillStyle(Direction.Outgoing)

    bg.add(pv.Dot)
        .data(pv.range(0, Mailtime.HoursMax))
        .fillStyle(null)
        .strokeStyle("#eee")
        .lineWidth(1)
        .visible((i) ->
          (i%50) == 0
        )
        .size((i) ->
          Math.pow(radius((i)), 2)
        )
      .anchor("top").add(pv.Label)
        .visible((i) ->
          (i%50) == 0
        )
        .textBaseline("middle")
        .text((i) -> i)

    bg.add(pv.Wedge)
      .data(pv.range(mail.length))
      .innerRadius(innerRadius - 10)
      .outerRadius(outerRadius + 10)
      .fillStyle(null)
      .strokeStyle("black")
      .angle(0)

    bg.anchor("outer").add(pv.Label)
      .textAlign("center")
      .textBaseline("bottom")
      .text((d) ->
        d.Date
      )
      .textAngle(->
        @anchorTarget().midAngle() + Math.PI / 2
      )

    vis.add(pv.Dot)
        .data(pv.keys(Net))
        .left(width / 2 - 20)
        .bottom(->
          -60 + @index * 12
        )
        .fillStyle((d) ->
          Net[d]
        )
        .strokeStyle(null)
        .size(30)
      .anchor("right").add(pv.Label)
        .textMargin(6)
        .textAlign("left")
        .text((d) ->
          "Mail-" + d
        )

    vis.render();

