const farmerRouter = require('./farmer');
const cropRouter = require('./crop');
const cattleRouter = require('./cattle');
const { createContext } = require('vm');

const defaultRouter = require('koa-router')({
    prefix: '/stardewApi/v1'
});

defaultRouter.get('/,', (ctx) => {
    ctx.body = 'This is the Stardew Valley Farm Api';
});

defaultRouter.use(
    farmerRouter.routes(),
    cropRouter.routes(),
    cattleRouter.routes()
);

module.exports = api => {
    api.use(defaultRouter.routes());
    api.use(defaultRouter.allowedMethods());
}