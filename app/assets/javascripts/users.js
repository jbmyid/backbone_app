//Routes
var Router = Backbone.Router.extend({
  routes: {
    '': 'home',
    'users': 'home',
    'users/new': "editUser",
    'users/:id/edit': "editUser"
  }
});

//Models
var Users = Backbone.Collection.extend({
  url: "/users"
});
var User = Backbone.Model.extend({
  urlRoot: "/users"
});

// Views
var UserList = Backbone.View.extend({
  el: ".page",
  render: function(){
    var that = this;
    var users = new Users();
    users.fetch({
      success: function(){
        var template = _.template($("#usersList").html(), {users: users.models});
        that.$el.html(template);
      }
    })
  }
});

var EditUser = Backbone.View.extend({
  el: '.page',
  render: function(options){
    hideFlash();
    var that = this;
    if(options.id){
      var user = new User({id: options.id});
      user.fetch({
        success: function(user){
          var template = _.template($("#editUser").html(), {user: user});
          that.$el.html(template);
        },
        error: function() {
          displayFlash("Something went wrong, please try after some time", "alert-danger");
          router.navigate("", {trigger: true});
        }
      })
    }
    else{
      var template = _.template($("#editUser").html(), {user: null});
      this.$el.html(template);
    }
  }
  ,
  events: {
    "submit .editUserForm": "saveUser"
  },
  saveUser: function(e){
    toggleDoms($(".editUserForm img.dn"), $(".editUserForm button[type='submit']"))
    var userDetail = $(e.currentTarget).serializeForm();
    var user = new User();
    user.save(userDetail,{
      success: function(response){
        toggleDoms($(".editUserForm button[type='submit']"), $(".editUserForm img"));
        if (response.get('status')){
          router.navigate("", {trigger: true}); // Redirect to root i.e. Users#index page
          displayFlash("User created successfully", 'alert-success');
        }
        else
          displayFlash(response.get("errors").join(", "), 'alert-danger');
      },
      error: function() {
        displayFlash("Something went wrong, please try after some time", "alert-danger");
        router.navigate("", {trigger: true});
      }
    })
    return false;
  }
});

//Events
var router = new Router();

var userList = new UserList();
var editUser = new EditUser();
router.on("route:home", function(){
  userList.render();
});
router.on("route:editUser", function(id){
  editUser.render({id: id});
});

Backbone.history.start();