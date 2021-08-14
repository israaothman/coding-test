'use strict'

const express = require('express');
const cors = require('cors');
const pg = require('pg');
const client = new pg.Client(process.env.DATABASE_URL);


const app = express();
app.use(express.urlencoded({ extended: true }));

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
  //   flexible: {type, months}, // this or the date not both
  //   "apartmentType": null, // this one is optinal // '1bdr'
  //   amenities: ["WiFi", "Pool"] // '{WiFi,Parking}'
  //   }

app.post('/search',(req,res)=>{
  let input = req.body;
  console.log(input);
   
  let sql='SELECT * FROM building;';
  client.query(sql)
  .then(result =>{
    // response.render('./favPage.ejs',{ result :result.rows});
    // res.render('./result.ejs',{result:result.rows})
    console.log(result.rows)

    let match = [];
    // match: [1, 2, 3] where the numbers represent the IDs of units.
    let alternative = [];
    let other = [];


    let options = {match, alternative, other}
    res.send(options)
  })
})


// "match" is an array of one or more units exactly matching the request (within city, matching "date" or "flexible" and any additional filters).
// Example: match: [1, 2, 3] where the numbers represent the IDs of units.

// "alternative", the closest alternative dates if no exact matches were found, for example, if the guest asks for a one-bedroom apartment from June 1st to June 3rd but that date is not available, you should return the closest availability, preferring June 2nd -> June 4th over June 5th -> June 7th if both dates are available.

// Example: alternative: [{id: 1, availableStarting: "2021-06-02"}, {..}]


// "Other" is a further set of suggestions if no matches were found for the same unit type and number of bedrooms, 
// for example, if the request is originally for a one-bedroom apartment during Feb, but that unit is only available starting August, then "other" would include other units (1 bedroom, 2 bedrooms, etc.) that match or are close to the requested filters (but must still be within the same city).






















  
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
    client.connect()
    .then(()=>{
        app.listen(PORT,()=>{
            console.log(`I am listening to ${PORT}`);
        })
    })
   },
};

