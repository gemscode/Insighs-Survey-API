const express = require('express');
const app = express();
const path = require('path');
const queries = require('./data/queries')

app.use(express.static(path.join(__dirname, 'build')));
app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(3000);