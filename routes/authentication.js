const express = require('express');
const router = express.Router();

const passport = require('passport');

//SIGNUP
router.get('/signup', (req, res) => {
    res.render('Profile.html')

});


router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/signup',
    failureFlash: true
}));

// SINGIN
router.get('/signin', (req, res) => {
    res.render('/');
});

router.post('/signin', (req, res, next) => {

    passport.authenticate('local.signin', {
        successRedirect: '/profile',
        failureRedirect: '/',
        failureFlash: true
    })(req,res, next);
});

router.get('/profile', (req, res) => {
    res.render('/Profile');
});

module.exports = router;