View = require '../index'

class FirstView extends View
  render: (node) ->
    html = """
    <div class="first-view">
      First View
    </div>
    """

    node.html(html)

module.exports = FirstView
