const express = require('express');
const router = express.Router();

const passport = require('passport');

//SIGNUP
router.get('/signup', (req, res) => {
    res.render('Profile.html')

});


router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/Profile.html',
    failureRedirect: '/Home.html',
    failureFlash: true
}));

// SINGIN
router.get('/signin', (req, res) => {
    res.render('/home.html');
});

router.post('/signin', (req, res, next) => {

    passport.authenticate('local.signin', {
        successRedirect: '/Profile.html',
        failureRedirect: '/Home.html',
        failureFlash: true
    })(req,res, next);
});

router.get('/Profile.html', (req, res) => {
    res.render('/Profile.html');
});

router.post('/editarPerfil', (req, res, next) => {

    passport.authenticate('local.editProfile', {
        successRedirect: '/Profile.html',
        failureRedirect: '/home.html',
        failureFlash: true
    })(req,res, next);
});

module.exports = router;