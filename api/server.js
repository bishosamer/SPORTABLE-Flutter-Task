const express = require("express");
const bodyParser = require("body-parser");
const router = express.Router();
const cors = require("cors")
const app = express();
const port = 9000;
const { uuid } = require("uuidv4");
const fs = require('fs');
const path = require('path');
const filePath = 'dishes.json';
// setup middleware
app.use(bodyParser.json());
app.use(cors());

//
var _dishes = [];

// get dishes
router.get('/dishes', (req, res) => {
    res.json({
        status: "OK",
        data: _dishes
    });
});

// clear dishes
router.get('/dishes/clear', (req, res) => {
    _dishes = [];
    fs.writeFile( filePath, JSON.stringify(_dishes), function(err) {
        if (err) {
            return console.log(err);
        }
    });
    res.json({
        status: "OK"
    });
});

// get dish by id
router.get('/dishes/:_id', (req, res) => {
    const dish = _dishes.find(x => x._id === req.params._id);

    res.json({
        status: "OK",
        data: dish ? dish : null
    });
});

// insert/update dish
router.put('/dishes', (req, res) => {
    if (req.body == null) {
        res.json({
            status: "Failed",
            message: "No content provided"
        });
    }
    else {
        let dish = req.body,
            status = "OK";
        
        if (!dish._id) {
            //
            dish._id = uuid();
            dish._Created = new Date();
            dish._Changed = null;

            //
            _dishes.push(dish);
          

            

        }
        else {
            //
            const dishIndex = _dishes.findIndex(x => x._id === dish._id);

            //
            if (dishIndex >= 0) {
                //
                dish._Changed = new Date();

                //
                _dishes[dishIndex] = dish;
            }
            else {
                //
                status = `dish not found for _id ${dish._id}`;
            }
        }
       
        fs.writeFile( filePath, JSON.stringify(_dishes), function(err) {
            if (err) {
                return console.log(err);
            }
        });
        res.json({
            status: status,
            data: dish
        });
    }
});

// delete dish
router.delete('/dishes/:_id', (req, res) => {
    let dishIndex = _dishes.findIndex(x => x._id === req.params._id);

    if (dishIndex !== -1) {
        _dishes.splice(dishIndex, 1);
        fs.writeFile( filePath, JSON.stringify(_dishes), function(err) {
            if (err) {
                return console.log(err);
            }
        });
    }
    
    res.json({
        status: "OK",
        message: dishIndex !== -1 ? "Dish deleted" : "Dish not found"
    });
});


//
app.use(router);

//
app.listen(port, () => {
    console.log(`api is ready on http://localhost:${port}`)
    // get dishes from json file
    
   
    fs.readFile(`${filePath}`, { encoding: 'utf-8' }, function(err, data) {
        if (!err) {
            _dishes = JSON.parse(data);
        }
    });

});
