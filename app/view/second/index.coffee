View = require '../index'

class SecondView extends View
  render: (node) ->
    html = """
    <div class="second-view">
      Second View
    </div>
    """

    node.html(html)

module.exports = SecondView
