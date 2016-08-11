/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
 ***/
var app = angular.module("customers", ['ngRoute','templates']);

app.config([
        "$routeProvider",
        function($routeProvider){
            $routeProvider.when("/",{
                controller:     "CustomerSearchController",
                templateUrl:    "customer_search.html"
            }).when("/:id",{
                controller: "CustomerDetailController",
                templateUrl: "customer_detail.html"
            });
        }
    ]);


app.controller("CustomerSearchController", [
    "$scope", "$http","$location",
    function($scope, $http, $location) {
        var page = 0;
        $scope.customers = [];
        $scope.search = function(searchTerm) {
        	if(searchTerm.length < 3){
        		return;
        	}
            $scope.searchedFor = searchTerm;
            $http.get("/customers.json", { "params": { "keywords": searchTerm, "page": page } }).then(function(response) {
                    $scope.customers = response.data
                }, function(response) {
                    alert("There was a problem: " + response.status);
                }

            );
        }

        $scope.previousPage = function(){
        	if(page > 0){
        		page = page - 1;
        		$scope.search($scope.keywords);
        	}
        }

        $scope.nextPage = function(){
        	page = page + 1;
        	$scope.search($scope.keywords);
        }

        $scope.viewDetails = function(customer){
            $location.path("/"+customer.id);
        }
    }
]);

app.controller("CustomerDetailController", [
    "$scope", "$http", "$routeParams",
    function($scope, $http, $routeParams){
        var customerId = $routeParams.id;
        $scope.customer = {};

        $http.get("/customers/"+customerId+".json")
            .then(
                function(response){
                    $scope.customer = response.data;
                },function(response){
                    alert("There was a problem: "+ response.status);
                }
            );

    }
    ]);
