const { ApolloServer } = require("@apollo/server");
const express = require('express');
const { expressMiddleware } = require('@apollo/server/express4');
const { ApolloServerPluginDrainHttpServer } = require("@apollo/server/plugin/drainHttpServer");
const { dbConnect } = require("./db_connect.js");
const { typeDefs } = require("./schema.js");
const { resolvers } = require("./resolvers.js");
const cors = require('cors');
const bodyParser = require("body-parser");

const startServer = async () => {
  dbConnect();
  const app = express();
  const server = new ApolloServer({
     typeDefs,
     resolvers,
     plugins: [ApolloServerPluginDrainHttpServer({httpServer: app})]
  });

  await server.start();

  app.use(
    '/graphql',
    cors(),
    bodyParser.json(),
    expressMiddleware(server)
  );

  app.listen(2000,()=>{
    console.log('Server running at http://192.168.1.5:2000/graphql');
  });
};

startServer();
