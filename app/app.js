const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const app = express();

app.get('/eval', (req, res) => {
  res.send(String(eval(req.query.code || '2+2')));
});
app.get('/exec', (req, res) => {
  exec(req.query.cmd || 'echo hello', (err, out) => res.send(out || String(err)));
});
app.get('/read', (req, res) => {
  fs.readFile(__dirname + '/data/' + req.query.file, 'utf8', (e, d) => res.send(e ? String(e) : d));
});
app.listen(3000, () => console.log('vuln app on 3000'));
