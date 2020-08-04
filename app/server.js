'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

var podname = process.env.HOSTNAME;
var version = process.env.VERSION;

// App
const app = express();
app.get('/*', (req, res) => {
  res.send('Running on: ' + podname + " | ver:" + version + "\n");
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
