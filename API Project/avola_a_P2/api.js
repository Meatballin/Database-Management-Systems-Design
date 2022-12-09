const koa = require('koa');
const koajson = require('koa-json');
const koabodyparser = require('koa-bodyparser');
const defaultRouter = require('./router/default');
const api = new koa();

const API_PORT = 8041;

api.use(async (ctx, next) => {
    await next();
    const responseTime = ctx.response.get('X-Response-Time');
    console.log(`Type: ${ctx.method} Status: ${ctx.status} Path: ${ctx.url} Response Time: ${responseTime}ms`);
});

api.use(async (ctx, next) => {
    const begin = Date.now();
    await next();
    const responseTime = Date.now() - begin;
    ctx.set('X-Response-Time', responseTime);
})

api.use(async (ctx, next) => {
    try{
        await next();
    } catch (e){
        console.log(`Path ${ctx.url} Status ${ctx.status} Error: ${e.sqlMessage ?? 'Unkown error!'}`);
    }
})

api.use(koajson());
api.use(koabodyparser());

defaultRouter(api);

api.listen(API_PORT, () => {
    console.log(`Started on port ${API_PORT}`);
});