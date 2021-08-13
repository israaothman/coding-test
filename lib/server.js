'use strict'

const express = require('express');
const cors = require('cors');

// const apiRouter = require('./routs/api-v1')

const app = express();

//========Global Middlewere============\\
//    express middleware 
app.use(express.json());
//    3rd party middleware
app.use(cors());

//========Routs============\\
app.get('/',(req,res)=>{
    res.send('Working ... :p');
  });

 //input : 
  // {
  //   city: 'Dubai',
  //   date: {start, end},
  //   flexible: {type, months},
  //   "apartmentType": null,
  //   amenities: ["WiFi", "Pool"]
  //   }

app.get('/search',(req,res)=>{
  
})






















  
// app.use(apiRouter);


//========Middlewere============\\

// const notFound = require('../middleware/404');
// const serverError = require('../middleware/500');



// app.use('*', notFound); 
// app.use(serverError); 


module.exports = {
  server : app, 
  start : (port) =>{
    const PORT = port || process.env.PORT || 3030;
    app.listen(PORT, () => { console.log(`Listening on port ${PORT}`); });
  },
};