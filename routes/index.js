const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('Home.html');
});

router.get('/Home.html', (req, res) => {
    res.render('Home.html');
});

router.get('/Profile.html', (req, res) => {
    res.render('Profile.html');
});

router.get('/quotes.html', (req, res) => {
    res.render('quotes.html');
});

router.get('/MyProjects.html', (req, res) => {
    res.render('MyProjects.html');
});

router.get('/ChgPassword.html', (req, res) => {
    res.render('ChgPassword.html');
});

router.get('/About.html', (req, res) => {
    res.render('About.html');
});

router.get('/Partners.html', (req, res) => {
    res.render('Partners.html');
});


module.exports = router;