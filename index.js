const express = require('express');
const morgan = require('morgan');
const path = require('path');
const exphbs = require('express-handlebars');
const session = require('express-session');
const validator = require('express-validator');
const passport = require('passport');
const flash = require('connect-flash');
const MySQLStore = require('express-mysql-session')(session);
const bodyParser = require('body-parser');
const multer = require('multer');

const { v4: uuid } = require('uuid');
uuid();
const { database } = require('./keys');

// Initializations
const app = express();
require('./lib/passport');

// Settings
app.set('port', process.env.PORT || 3050);
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');

// MySql heroku
// const connection = mysql.createConnection({
//     host: 'us-cdbr-east-05.cleardb.net',
//     user: 'b0678c97880259',
//     password: '3ee47a8d',
//     database: 'heroku_e41262fc0f6ee1e'
// });

// Middlewares
app.use(session({
    secret: 'faztmysqlnodesession',
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore(database)
}));

const storage = multer.diskStorage({
    destination: 'public/uploads',
    filename: (req, file, cb) =>{
        cb(null, uuid() + path.extname(file.originalname).toLocaleLowerCase());
    }
});

app.use(multer({
    storage,
    dest: 'public/uploads',
    limits: {fileSize: 2000000},
    fileFilter: (req, file, cb) => {
        const filetypes = /jpeg|jpg|png/;
        const mimetype = filetypes.test(file.mimetype);
        const extname = filetypes.test(path.extname(file.originalname));
        if (mimetype && extname){
            return cb(null, true);
        }
        cb("Error: El Archivo debe ser una imagen valida")
    }
}).single('image'));

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.use(session({
  secret: 'faztmysqlnodemysql',
  resave: false,
  saveUninitialized: false,
  store: new MySQLStore(database)
}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());


// Global Variables
app.use((req, res, next) => {
    app.locals.success = req.flash('success');
    app.locals.message = req.flash('message');
    app.locals.user = req.user;
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