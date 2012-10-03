Router = Backbone.Router.extend

  routes:
    "": "init"
    "start": "startGame"
    "game/:id": "joinGame"

  init: ->
    self = @
    $('[role="go-to-game"]').live 'click', -> self.navigate 'game/' + $(@).data('id'), trigger: true
    $('.fields td').live 'click', -> 
      item = Games.findOne(_id: Session.get('game')).fields
      pindex = $(this).parent()[0].rowIndex
      item[pindex][$(this).index()] = Session.get('player')
      Games.update {_id: Session.get('id')}, $set: fields: item


  startGame: ->
    id = Games.insert secondPlayer: false, fields: [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    $('.container .fields').append Meteor.render -> 
      Template.fields.game = Games.findOne(_id: id)
      Template.fields()
    Session.set 'player', 1
    Session.set 'game', id
    @navigate 'game/' + id

  joinGame: (id) ->
    Session.set 'player', 2
    Session.set 'game', id
    Games.update {_id: id}, $set: secondPlayer: true 
    $('.container .fields').append Meteor.render -> 
      Template.fields.game = Games.findOne(_id: id)
      Template.fields()