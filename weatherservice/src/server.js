const grpc = require('grpc');
const WeatherService = require('./interface');
const weatherServiceImpl = require('./weatherService');

const server = new grpc.Server();
const WEATHER_SERVICE = (process.env.WEATHER_SERVICE_NAME || '127.0.0.1') + ':9090';

server.addService(WeatherService.service, weatherServiceImpl);

server.bind(WEATHER_SERVICE, grpc.ServerCredentials.createInsecure());

console.log(`gRPC server running at http://${WEATHER_SERVICE}`);

server.start();