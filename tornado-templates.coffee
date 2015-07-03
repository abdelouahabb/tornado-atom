class TornadoTemplates
  desc: "defaultToTornadoTemplatesForFilePathsContaining"

  configKey: "tornado-templates.#{ TornadoTemplates.prototype.desc }"

  config:
    defaultToTornadoTemplatesForFilePathsContaining:
      type: 'array'
      default: []
      items:
        type: 'string'

  activate: (state) ->
    @watchEditors()

  watchEditors: ->
    atom.workspace.observeTextEditors (editor) =>
      path = editor.getPath()
      if path
        if path.indexOf('.html') isnt -1
          matches = false
          for frag in atom.config.get @configKey
            if path.indexOf(frag)
              matches = true
              break
          if matches
            grammar = atom.grammars.grammarForScopeName('text.html')
            editor.setGrammar(grammar)

module.exports = new TornadoTemplates
