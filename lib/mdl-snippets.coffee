MdlSnippetsView = require './mdl-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = MdlSnippets =
  mdlSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @mdlSnippetsView = new MdlSnippetsView(state.mdlSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @mdlSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mdl-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mdlSnippetsView.destroy()

  serialize: ->
    mdlSnippetsViewState: @mdlSnippetsView.serialize()

  toggle: ->
    console.log 'MdlSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
