Games = new Meteor.Collection 'games'
# if Meteor.isServer
#   Meteor.publish 'one-game', (id) ->
#     @set 'game', Games.findOne gid: id

if Meteor.isClient
  $(document).ready ->
    router = new Router()
    Backbone.history.start pushState: true
    $('[role="start-game"]').live 'click', ->
      router.navigate 'start', trigger: true