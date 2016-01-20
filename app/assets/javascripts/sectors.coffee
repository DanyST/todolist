# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

myApp = angular.module('myapplication', [
  'ngRoute'
  'ngResource'
])

#Factory
myApp.factory 'Sectors', [
  '$resource'
  ($resource) ->
    $resource '/sectors.json', {},
      query:
        method: 'GET'
        isArray: true
      create: method: 'POST'
]
myApp.factory 'Sector', [
  '$resource'
  ($resource) ->
    $resource '/sectors/:id.json', {},
      show: method: 'GET'
      update:
        method: 'PUT'
        params: id: '@id'
      delete:
        method: 'DELETE'
        params: id: '@id'
]
#Controller
myApp.controller 'UserListCtr', [
  '$scope'
  '$http'
  '$resource'
  'Sectors'
  'Sector'
  '$location'
  ($scope, $http, $resource, Sectors, Sector, $location) ->
    $scope.sectors = Sectors.query()

    $scope.deleteSector = (sectorId) ->
      if confirm('Estas seguro de eliminar?')
        Sector.delete { id: sectorId }, ->
          $scope.sectors = Sectors.query()
          $location.path '/'
          return
      return

    return
]
myApp.controller 'UserUpdateCtr', [
  '$scope'
  '$resource'
  'Sector'
  '$location'
  '$routeParams'
  ($scope, $resource, Sector, $location, $routeParams) ->
    $scope.sector = Sector.get(id: $routeParams.id)

    $scope.update = ->
      if $scope.sectorForm.$valid
        Sector.update { id: $scope.sector.id }, { sector: $scope.sector }, (->
          $location.path '/'
          return
        ), (error) ->
          console.log error
          return
      return

   
]
myApp.controller 'UserAddCtr', [
  '$scope'
  '$resource'
  'Sectors'
  '$location'
  ($scope, $resource, Sectors, $location) ->
    $scope.sector = addresses: [ {
    } ]

    $scope.save = ->
      if $scope.sectorForm.$valid
        Sectors.create { sector: $scope.sector }, (->
          $location.path '/'
          return
        ), (error) ->
          console.log error
          return
      return

   
]
#Routes
myApp.config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider.when '/sectors',
      templateUrl: '/templates/sectors/index.html.erb'
      controller: 'UserListCtr'
    $routeProvider.when '/sectors/new',
      templateUrl: '/templates/sectors/new.html'
      controller: 'UserAddCtr'
    $routeProvider.when '/sectors/:id/edit',
      templateUrl: '/templates/sectors/edit.html'
      controller: 'UserUpdateCtr'
    $routeProvider.otherwise redirectTo: '/sectors'
    return
]



