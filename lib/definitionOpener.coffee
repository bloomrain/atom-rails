class DefinitionOpener
  getDefinition: ->
    activeEditor = atom.workspace.getActiveEditor()
    cursor = activeEditor.cursors[0]
    activeEditor.getCursor()
    activeEditor.getTextInRange(cursor.getCurrentWordBufferRange())

  openOrIgnore: (callback)->
    @potentialPath (path)->
      atom.workspaceView.open(path)

  potentialPath: (callback)-> # it does not trigger callback if no path found
    definition = @getDefinition()
    regexp = new RegExp(" *((class)|(module)){1}( +)#{definition}[^\\w]")
    potentialPath = null
    atom.project.scan regexp, {}, (result, error) ->
      return if potentialPath?

      result ||= {}
      potentialPath = result.filePath
      callback(potentialPath) if potentialPath?


module.exports = DefinitionOpener
