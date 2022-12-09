const connection = require('../database/connection');

class FarmerController{
    constructor() {
        console.log('Farmer Controller Initialized');
    }

    //prints all listed farmers in database (GET)
    static getAllFarmers(ctx){
        return new Promise((resolve, reject) => {
            const query = 'SELECT * FROM Farmer';
            connection.query(query, (err, res) => {
                if(err){
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'Nothing in Farmers Table!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }

    //Adds a new farmer to the Farmer table (POST)
    static createNewFarmer(ctx){
        return new Promise((resolve, reject) => {
            const Farmer = ctx.request.body;
            const query = `INSERT INTO Farmer (player_ID, address, cabin_number, dob, gender)
                           VALUES (?, ?, ?, ?, ?) gold = 0`;
            connection.query({
                sql: query,
                values: [Farmer.player_ID, Farmer.address, Farmer.cabin_number, Farmer.dob, Farmer.gender]
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

    //Update which farmer buys certain seed (PUT)
    static updateWhichFarmerBuysSeed(ctx){
        return new Promise((resolve, reject) => {
            const Farmer_Buys_Seeds = ctx.request.body;
            const query = `UPDATE Farmer_Buys_Seeds SET farmer = ? WHERE crop_ID = ?;`;
            connection.query({
                sql: query, 
                values: [Farmer_Buys_Seeds.farmer, ctx.params.crop_ID]
            },(err, res) => {
                if(err){
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

    //Update which farmer plants certain seed(PUT)
    static updateWhichFarmerPlantsSeed(ctx){
        return new Promise((resolve, reject) => {
            const Farmer_Plants = ctx.request.body;
            const query = `UPDATE Farmer_Plants SET farmer = ? WHERE crop_ID = ?;`;
            connection.query({
                sql: query,
                values: [Farmer_Plants.farmer, ctx.params.crop_ID]
            }, (err, res) =>{
                if(err){
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

    //Which farmer bought seeds and have not yet planted them(GET)
    static farmerNotYetPlantedSeeds(ctx){
        return new Promise((resolve, reject) => {
            const query = `SELECT X.farmer, X.crop_ID, Y.quality, Y.type_of_crop 
                           FROM Farmer_Buys_Seeds AS X JOIN Crops AS Y
                           ON X.crop_ID = Y.crop_ID
                           JOIN Farmer_Plants AS Z
                           ON X.crop_ID = Z.crop_ID
                           WHERE Y.quantity = 0 AND X.farmer = Z.farmer
                           ORDER BY farmer;`;
            connection.query(query, (err, res) => {
                if(err){
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'All seeds are currently planted!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }

    //cannot delete farmer from DB because we are not killing people

    
}

module.exports = FarmerController;