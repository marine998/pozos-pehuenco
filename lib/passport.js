const { decodeBase64 } = require('bcryptjs');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('../lib/helpers');
const { get } = require('../routes');

// User Login Admin
passport.use('local.signinadm', new LocalStrategy({
    usernameField: 'correo_electronico_login',
    passwordField: 'contrasena_login',
    passReqToCallback: true
}, async (req, username, password, done) => {


    const rows = await pool.query('SELECT * FROM usuario WHERE correo_electronico = ?', [username]);
    if (rows.length > 0){
        const user = rows[0];
        const admin = user.administrador;
        const validPassword = await helpers.matchPassword(password, user.contrasena );
        console.log(password);
        console.log(user.contrasena);
        console.log(validPassword);
        if (admin && validPassword) {
            done(null, user, req.flash('success','usuario administrador existe'));
            console.log('1');
        } else {
            done(null, false, req.flash('message','contraseña incorrecta o administrador no habilitado'))
            console.log('2');
        }
    } else {
        console.log('3');
        return done(null, false, req.flash('message','El usuario administrador ingresado no existe'))
    }
}));

// User Login
passport.use('local.signin', new LocalStrategy({
    usernameField: 'correo_electronico_login',
    passwordField: 'contrasena_login',
    passReqToCallback: true
}, async (req, username, password, done) => {


    const rows = await pool.query('SELECT * FROM usuario WHERE correo_electronico = ?', [username]);
    if (rows.length > 0){
        const user = rows[0];
        const validPassword = await helpers.matchPassword(password, user.contrasena );
        console.log(password);
        console.log(user.contrasena);
        console.log(validPassword);
        if (validPassword) {
            done(null, user, req.flash('success','usuario existe'));
            console.log('1');
        } else {
            done(null, false, req.flash('message','Contraseña incorrecta'))
            console.log('2');
        }
    } else {
        console.log('3');
        return done(null, false, req.flash('message','El usuario ingresado no existe'))
    }
}));
// User SignUp
passport.use('local.signup', new LocalStrategy({
    usernameField: 'correo_electronico',
    passwordField: 'contrasena',
    passReqToCallback: true
}, async(req, username, password, done) =>{
    const { nombre } = req.body;
    const { apellido } = req.body;
    const { numero_telefono } = req.body;
    const { direccion } = req.body;

    const newUser = {
        correo_electronico: username,
        contrasena: password,
        nombre: nombre,
        apellido: apellido,
        numero_telefono: numero_telefono,
        direccion: direccion
    };
    newUser.contrasena = await helpers.encryptPassword(password)
    const result = await pool.query('INSERT INTO usuario SET ?', [newUser])
    return done(null, newUser);
}));


passport.serializeUser((user,done) => {
    done(null, user.correo_electronico);

});

passport.deserializeUser(async (correo,done) => {
   const rows = await pool.query('SELECT * FROM usuario Where correo_electronico = ?',[correo])
   done(null, rows[0]);
});