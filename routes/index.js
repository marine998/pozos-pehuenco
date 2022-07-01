const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('Home.html');
});

// Register link
router.post('/add', (req, res) => {
res.send('received');
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

router.get('/ChgPassword.html', (req, res) => {
    res.render('ChgPassword.html');
});

router.get('/About.html', (req, res) => {
    res.render('About.html');
});

router.get('/Partners.html', (req, res) => {
    res.render('Partners.html');
});

router.get('/AdmLogin.html', (req, res) => {
    res.render('AdmLogin.html');
});

router.get('/AdmMenu.html', (req, res) => {
    res.render('AdmMenu.html');
});

router.get('/AdmPartners.html', (req, res) => {
    res.render('AdmPartners.html');
});

router.get('/AdmProjects.html', (req, res) => {
    res.render('AdmProjects.html');
});

router.get('/AdmPublications.html', (req, res) => {
    res.render('AdmPublications.html');
});

router.post('/upload', (req, res) => {
    console.log(req.file);
    res.render('AdmPublications.html');
});

router.get('/Proyect.html', (req, res) => {
    res.render('Proyect.html');
});

module.exports = router;