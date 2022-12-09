const farmerController = require('../controller/farmerController');
const farmerRouter = require('koa-router')({
    prefix: '/farmer'
});

// curl -X GET http://localhost:8041/stardewApi/v1/farmer/
farmerRouter.get('/', farmerController.getAllFarmers);

// curl -X GET http://localhost:8041/stardewApi/v1/farmer/notPlanted
farmerRouter.get('/notPlanted', farmerController.farmerNotYetPlantedSeeds);

//curl -X POST -H 'Content-type: application/json' -d 
//'{"player_ID": "Jimbob", "address":"Stardew Valley Farm", "cabin_number":"3", "dob":"1999-03-04", "gender":"M"}' http://localhost:8041/stardewApi/v1/farmer/add
farmerRouter.post('/add', farmerController.createNewFarmer);

//curl -X PUT -H 'Content-type: application/json' -d 
//'{"farmer":"Andy"}' http://localhost:8041/stardewApi/v1/farmer/buysSeed/48
farmerRouter.put('/buysSeed/:crop_ID', farmerController.updateWhichFarmerBuysSeed);

//curl -X PUT -H  'Content-type: application/json' -d '{"farmer":"Holland"}' 
//http://localhost:8041/stardewApi/v1/farmer/plantsSeed/25
farmerRouter.put('/plantsSeed/:crop_ID', farmerController.updateWhichFarmerPlantsSeed);

module.exports = farmerRouter;