const express = require('express');
const morgan = require('morgan');
const path = require('path');
const mysql = require('mysql');

// Initializations
const app = express();

// Settings
app.set('port', process.env.PORT || 3050);
// app.set('views', path.join(__dirname, 'views'));
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');

// MySql
const connection = mysql.createConnection({
    host: 'us-cdbr-east-05.cleardb.net',
    user: 'b0678c97880259',
    password: '3ee47a8d',
    database: 'heroku_e41262fc0f6ee1e'
});

// Middlewares
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());

// Global Variables
app.use((req, res, next) => {

    next();
});

// Routes
app.use(require('./routes/index'));
app.use(require('./routes/authentication'));
app.use('/links', require('./routes/links'));

// Static Files
app.use(express.static(path.join(__dirname, 'public')));

// Starting the server
app.listen(app.get('port'), () => {
    console.log('Server is in port', app.get('port'));
});