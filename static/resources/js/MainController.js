app.controller('MainController', function($scope,$http) {

  $http.get("http://localhost:8000/system_recommender/artworks")
  .then(function(response) {
    $scope.steps_1 = response.data.slice(0,6);
    $scope.steps_2 = response.data.slice(6,12);
    $scope.steps_3 = response.data.slice(12,18);
    $scope.steps_4 = response.data.slice(18,24);
    $scope.steps_5 = response.data.slice(24,30);
  }, function (rejection) {
      console.log("Rechazado");
  });

  $scope.user_id = ""
  $scope.recommendations = [];

  var index = -1;
  $scope.changeSurvey = function(){
    $("#user_id").hide()
    if (index==4) {
      getRecommendations();
    }else{
      var images = $("#drop-panel"+index).find("img")
      if (index==-1 || images.length == 6) {
        index = index+1;
        $("#main"+(index-1)).hide();
        $("#main"+index).show();
        setTimeout(
          function() {
              var container = $("#clone-container"+index);
              var scrollBox = $("#scroll-box"+index);
              var dropPanel = $("#drop-panel"+index);
              var tiles     = $(".tile"+index);
              var threshold = "50%";

              tiles.each(function() {

                var element = $(this);
                var wrapper = element.parent();
                var offset  = element.position();

                var scope = {
                  clone   : element.clone().addClass("clone").prependTo(container),
                  element : element,
                  wrapper : wrapper,
                  width   : wrapper.outerWidth(),
                  dropped : false,
                  moved   : false,
                  get x() { return getPosition(wrapper, offset).x; },
                  get y() { return getPosition(wrapper, offset).y; }
                };

                scope.draggable = createDraggable(scope);

                element.on("mousedown touchstart", scope, startDraggable);
              });

              // START DRAGGABLE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
              function startDraggable(event) {

                var tile = event.data;

                TweenLite.set(tile.element, { autoAlpha: 0 });
                TweenLite.set(tile.clone, { x: tile.x, y: tile.y, autoAlpha: 1 });

                tile.draggable.startDrag(event.originalEvent);
              }

              // CREATE DRAGGABLE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
              function createDraggable(tile) {

                var clone   = tile.clone;
                var wrapper = tile.wrapper;

                tile.draggable = new Draggable(clone, {
                  onPress   : setActive,
                  onDrag    : collapseSpace,
                  onRelease : dropTile
                });

                return tile.draggable;
                ///////

                function setActive() {
                  TweenLite.to(clone, 0.15, { scale: 1.2, autoAlpha: 0.75 });
                }

                function collapseSpace() {
                  if (!tile.moved) {
                    if (!this.hitTest(wrapper)) {
                      tile.moved = true;
                      TweenLite.to(wrapper, 0.3, { width: 0 });
                    }
                  }
                }

                function dropTile() {

                  var className = undefined;

                  if (this.hitTest(dropPanel, threshold) && !tile.dropped) {
                    dropPanel.append(wrapper);
                    tile.dropped = true;
                    className = "+=dropped";
                  }

                  moveBack(tile, className);
                }
              }

              // MOVE BACK :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
              function moveBack(tile, className) {

                var clone   = tile.clone;
                var element = tile.element;
                var wrapper = tile.wrapper;

                TweenLite.to(wrapper, 0.2, { width: tile.width });
                TweenLite.to(clone, 0.3, { scale: 1, autoAlpha: 1, x: tile.x, y: tile.y, onComplete: done });

                if (className) TweenLite.to([element, clone], 0.3, { className: className });

                function done() {
                  tile.moved = false;
                  TweenLite.set(clone, { autoAlpha: 0 });
                  TweenLite.set(element, { autoAlpha: 1 });
                }
              }

              // GET POSITION ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
              function getPosition(wrapper, offset) {

                var position1 = wrapper.offset();
                var position2 = container.offset();

                return {
                  x: position1.left - position2.left + offset.left,
                  y: position1.top  - position2.top  + offset.top
                };
              }

          }, 1000);
      }else{
        alert($scope.user_id + ", debes mover las 6 imagenes en el orden que muestre tu preferencia")
      }
    }
  }

  var getRecommendations = function(){
    $('.modal').modal('show');
    var survey = []
    for(var i = 0; i<5;i++){
      var images = $("#drop-panel"+i).find("img")
      var score = 10
      for(var j=0; j<6;j++){
          survey.push({"piece":images[j].alt,"score":score})
          score = score - 2;
      }
    }
    $http.post("http://localhost:8000/system_recommender/recommendations/",
      {"survey":survey,"user_id":$scope.user_id})
    .then(function(response) {
      console.log(response);
        $scope.recommendations = response.data;
        $('.modal').modal('hide');
        $("#main4").hide();
        $("#main5").show();
    }, function (rejection) {
          alert(rejection)
    });
  }
});
