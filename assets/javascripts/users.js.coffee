class app.Users extends app.Page
  constructor: (options = {}) ->
    @url = options.url || throw new Error "You must specify project url"
    @object_name = "users"
    super

  events: (selector) ->
    _self = @
    $("#{selector}").on "click", ->
      $("#{selector}").removeClass "active"
      $(this).addClass "active"
      _self.update_form(_.first _.where _self.collection[_self.object_name], {id: $(this).attr('id')})

  organize: (data) ->
    _self = @
    _self.collection = data

  render: (options) ->
    _self = @
    if _self.collection[_self.object_name].length > 0
      for record in _self.collection[_self.object_name]
        _self.add_item(record)
      _self.update_form(_self.collection[_self.object_name][0])
      $("#users-list li:first").addClass 'active'
    else
      $('.fetching-message').hide()
      $('.empty-block').show()
    @events("#users-list li")

  add_item: (record) ->
    record.created_at = moment(record.created_at).format('MMM D, YYYY')
    $("#users-list").append JST["templates/users/list"](record)
    $('.fetching-message').hide()
    $("#users-list").fadeIn()

  update_form: (record) ->
    el = $("#user-form").html JST["templates/users/form"](record)

    $('.btn-state').on 'click', ->
      $(this).button('loading')

    new app.ButtonConfirm({parent: el})
  
  Users

$ ->
  if $('#users_index').length > 0
    app.user = new app.Users(
      url: "/users"
    )