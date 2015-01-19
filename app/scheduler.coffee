class Scheduler
  next: 0

  constructor: (@root, @schedule) ->

  run: ->
    @showNext()

  showNext: ->
    if @next >= @schedule.length
      @next = 0

    current = @schedule[@next]
    current.view.render(@root)

    @next = @next + 1
    @timer = setTimeout(@showNext.bind(@), current.duration)

module.exports = Scheduler
