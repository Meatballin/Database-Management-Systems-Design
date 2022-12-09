const connection = require('../database/connection');

class CropController{
    constructor() {
        console.log('Crop Controller Initialized');
    }
    //prints all listed crops in database (GET)
    static getAllCrops(ctx){
        return new Promise((resolve, reject) => {
            const query = `SELECT * FROM Crops`;
            connection.query(query, (err, res) => {
                if(err){
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'Nothing in Crops Table!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }
    //Call to view () (GET)
    static showNonProfitCrops(ctx){
        return new Promise((resolve, reject) => {
            const query = 'SELECT * FROM less_Profit_From_Seed AS `No Profit Crop`;';
            connection.query(query, (err, res) => {
                if(err){
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'No seeds that do not profit!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            })
        })
    }

    //Call to function (GET)
    static totalProfitFromCrop(ctx){
        return new Promise((resolve, reject) => {
            const query = 'SELECT total_Profit_From_Crop(?) AS `Total profit from Crop`;';
            connection.query({
                sql: query,
                values: [ctx.params.crop_ID]
            }, (err, res) => {
                if(err){
                    ctx.status = 400;
                    ctx.body = err.sqlMessage ?? 'Bad crop ID';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }

    //Update an existing crop (PUT)
    static updateCrop(ctx){
        return new Promise((resolve, reject) => {
            const Crop = ctx.request.body;
            const query = `UPDATE Crops SET quality = ?, type_of_crop = ?, season = ?, growth_time_days = ?, price_each = ?, quantity = ? WHERE crop_ID = ?;`;
            connection.query({
                sql: query,
                values: [Crop.quality, Crop.type_of_crop, Crop.season, Crop.growth_time_days, Crop.price_each, Crop.quantity, ctx.params.crop_ID]
            }, (err, res) => {
                if(err) {
                    ctx.status = 400;
                    ctx.body = err.sqlMessage ?? 'Missing data or invalid crop ID!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res); 
            });
        });
    }

    //Create a new crop and insert into Crop table(POST)
    static insertNewCrop(ctx){
        return new Promise((resolve, reject) => {
            const Crop = ctx.request.body;
            const query = `INSERT INTO Crops VALUES (?, ?, ?, ?, ?, ?, ?);`;
            connection.query({
                sql: query,
                values: [Crop.crop_ID, Crop.quality, Crop.type_of_crop, Crop.season, Crop.growth_time_days, Crop.price_each, Crop.quantity]
            }, (err, res) => {
                if(err){
                    ctx.status = 400;
                    ctx.body = err.sqlMessage ?? 'Missing some value!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 201; 
                resolve(res);
            });
        });
    }
    
    //Delete a crop from table (DELETE)
    static deleteCrop(ctx){
        return new Promise((resolve, reject) => {
            const Crop = ctx.request.body;
            const query = `DELETE FROM Crops WHERE crop_ID = ?;`;
            connection.query({
                sql: query,
                values: [ctx.params.crop_ID]
            },(err, res) => {
                if(err){
                    ctx.status = 404;
                    ctx.body = err.sqlMessage ?? 'Could not find crop Id to delete!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }
}

module.exports = CropController;