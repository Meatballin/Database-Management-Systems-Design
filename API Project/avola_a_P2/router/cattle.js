const cattleController = require('../controller/cattleController');
const cattleRouter = require('koa-router')({
    prefix: '/cattle'
});

// curl -X GET http://localhost:8041/stardewApi/v1/cattle
cattleRouter.get('/', cattleController.getAllCattle);

// curl -X GET http://localhost:8041/stardewApi/v1/cattle/producesThreeOrMore
cattleRouter.get('/producesThreeOrMore', cattleController.producesThreeOrMore);

// curl -X GET http://localhost:8041/stardewApi/v1/cattle/producesNothing
cattleRouter.get('/producesNothing', cattleController.producesNothing);

// curl -X POST -H 'Content-type: application/json' -d
// '{"farm_building_id":"stable", "animal_species":"Alpaca", "time_to_mature_days": "29"}'
// http://localhost:8041/stardewApi/v1/cattle/add
cattleRouter.post('/add', cattleController.bringInNewAnimal);

// curl -X DELETE http://localhost:8041/stardewApi/v1/remove/Alpaca
cattleRouter.delete('/remove/:animal_species',cattleController.removeAnimal);

module.exports = cattleRouter;