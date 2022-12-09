const cropController = require('../controller/cropsController');
const cropRouter = require('koa-router')({
    prefix: '/crop'
});

// curl -X GET http://localhost:8041/stardewApi/v1/crop/
cropRouter.get('/', cropController.getAllCrops);

// curl -X GET http://localhost:8041/stardewApi/v1/crop/noProfit
cropRouter.get('/noProfit', cropController.showNonProfitCrops);

// curl -X GET http://localhost:8041/stardewApi/v1/crop/profitFrom/55
cropRouter.get('/profitFrom/:crop_ID', cropController.totalProfitFromCrop);

//curl -X PUT -H 'Content-type: application/json' -d 
//'{"quality":"2", "type_of_crop": "Coffee Beans", "season":"Summer", "growth_time_days":"44", "price_each":"52", "quantity":"32"}' 
//http://localhost:8041/stardewApi/v1/crop/update/75
cropRouter.put('/update/:crop_ID', cropController.updateCrop);

// curl -X POST -H 'Content-type: application/json' -d 
// '{"crop_ID":"85", "quality":"0", "type_of_crop":"Amaranth", "season":"Fall", "growth_time_days":"7", "price_each":"150", "quantity":"12"}'
// http://localhost:8041/stardewApi/v1/crop/add 
cropRouter.post('/add', cropController.insertNewCrop);

// curl -X DELETE http://localhost:8041/stardewApi/v1/crop/remove/85
cropRouter.delete('/remove/:crop_ID', cropController.deleteCrop);

module.exports = cropRouter;