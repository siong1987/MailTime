Mailtime.Views.Homes ||= {}

class Mailtime.Views.Homes.ClockView extends Backbone.View
  initialize: ->
    $('#main').html("")
    w = 400
    h = 400
    r = Math.min(w, h) / 1.8
    s = .4
    fields = ->
      arc = Mailtime.CurrentCount / Mailtime.TotalCount

      return [
        {value: arc,  index: .3, text: "#{Mailtime.CurrentCount}/#{Mailtime.TotalCount}"},
      ]

    fill = d3.scale.linear()
      .range(["hsl(-180, 50%, 50%)", "hsl(180, 50%, 50%)"])
      .interpolate(d3.interpolateHsl);

    arc = d3.svg.arc()
      .startAngle(0)
      .endAngle((d) ->
        return d.value * 2 * Math.PI
      )
      .innerRadius((d) ->
        return d.index * r
      )
      .outerRadius((d) ->
        return (d.index + s) * r
      )

    vis = d3.select("#clock").append("svg")
      .attr("width", w)
      .attr("height", h)
      .append("g")
      .attr("transform", "translate(" + w / 2 + "," + h / 2 + ")")

    g = vis.selectAll("g")
      .data(fields)
      .enter().append("g");

    g.append("path")
      .style("fill", (d) ->
        color = fill(d.value)
        $('#title').css
          color: color
        return color
      )
      .attr("d", arc)

    g.append("text")
      .attr("text-anchor", "middle")
      .text((d) ->
        return d.text
      )

    d3.timer( ->
      g = vis.selectAll("g")
        .data(fields)

      g.select("path")
        .style("fill", (d) ->
          color = fill(d.value)
          $('#title').css
            color: color
          return color
        )
        .attr("d", arc)

      g.select("text")
        .text((d) ->
          return d.text
        )
      return
    )

