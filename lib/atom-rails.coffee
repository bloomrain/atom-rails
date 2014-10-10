Model = require './model'
Related = require './related'
DefinitionOpener = require './definitionOpener'

module.exports =
  atomRailsView: null

  activate: (state) ->
    atom.workspaceView.command "atom-rails:switch-to-model", => @switchToModel()
    atom.workspaceView.command "atom-rails:related", => @related()
    atom.workspaceView.command "atom-rails:open-definition-file", =>
      @openDefinitionFile()

  switchToModel: ->
    currentFile = atom.workspace.getActiveEditor().getPath()
    file = new Model(currentFile).path()
    atom.workspaceView.open(file) if file?

  openDefinitionFile: ->
    opener = new DefinitionOpener
    opener.openOrIgnore()


  related: ->
    currentFile = atom.workspace.getActiveEditor().getPath()
    file = new Related(currentFile).path()
    atom.workspaceView.open(file) if file?
