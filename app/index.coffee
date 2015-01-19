$ = require 'jquery'

Scheduler = require './scheduler'
FirstView = require './view/first'
SecondView = require './view/second'

init = ->
  first = new FirstView()
  second = new SecondView()

  schedule = new Array(
    {view: first, duration: 1000},
    {view: second, duration: 1000},
  )

  scheduler = new Scheduler($('#cortex-main'), schedule)
  scheduler.run()

module.exports = init()
