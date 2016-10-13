WordcountAtomView = require './wordcount-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = WordcountAtom =
  wordcountAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wordcountAtomView = new WordcountAtomView(state.wordcountAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wordcountAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wordcount-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wordcountAtomView.destroy()

  serialize: ->
    wordcountAtomViewState: @wordcountAtomView.serialize()

  toggle: ->
    console.log 'WordcountAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
