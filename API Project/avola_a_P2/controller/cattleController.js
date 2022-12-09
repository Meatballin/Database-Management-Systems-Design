const connection = require('../database/connection');

class CattleController{
    constructor() {
        console.log('Cattle Controller Initialized');
    }
    //prints all listed crops in database (GET)
    static getAllCattle(ctx){
        return new Promise((resolve, reject) => {
            const query = 'SELECT * FROM Cattle';
            connection.query(query, (err, res) => {
                if(err){
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'Nothing in Cattle Table!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }

    //Show which cattle produce 3 or more products(GET)
    static producesThreeOrMore(ctx){
        return new Promise((resolve, reject) => {
            const query = `SELECT farm_building_id AS "Farm Building",  animal_species AS "Produces 3 or more products" 
                           FROM Cattle_Produces
                           GROUP BY farm_building_id, animal_species
                           HAVING COUNT(produces) >= 3;`
            connection.query(query, (err, res) => {
                if(err) {
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'No cattle produces 3 or more products!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }
    //Show which cattle produce nothing for the farm(pets)(GET)
    static producesNothing(ctx){
        return new Promise((resolve, reject) => {
            const query = `SELECT animal_species FROM Cattle
                           WHERE animal_species IN 
                           (SELECT animal_species FROM Cattle_Produces WHERE produces = 'nothing');`;
            connection.query(query, (err, res) => {
                if(err){
                    ctx.status = 204;
                    ctx.body = err.sqlMessage ?? 'All cattle currently produce something!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }

    //Insert a new animal into farm(POST)
    static bringInNewAnimal(ctx){
        return new Promise((resolve, reject) => {
            const Cattle = ctx.request.body;
            const query = `INSERT INTO Cattle VALUES (?, ?, ?);`;
            connection.query({
                sql: query,
                values: [Cattle.farm_building_id, Cattle.animal_species, Cattle.time_to_mature_days]
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
    //Delete animal because we are running out of room on the farm(DELETE)
    static removeAnimal(ctx){
        return new Promise((resolve, reject) => {
            const Cattle = ctx.request.body;
            const query = `DELETE FROM Cattle WHERE animal_species = ?;`;
            connection.query({
                sql: query,
                values: [ctx.params.animal_species]
            },(err, res) => {
                if(err){
                    ctx.status = 404;
                    ctx.body = err.sqlMessage ?? 'Could not find animal_species to delete!';
                    reject(err);
                }
                ctx.body = res;
                ctx.status = 200;
                resolve(res);
            });
        });
    }
}

module.exports = CattleController;