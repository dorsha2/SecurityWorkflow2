const express = require('express');
const _ = require('lodash');
const { exec } = require('child_process');
const fs = require('fs');

const app = express();

app.get('/eval', (req, res) => {
  const code = req.query.code || '2+2';
  res.send(String(eval(code))); // INSECURE: eval על קלט משתמש
});

app.get('/exec', (req, res) => {
  const cmd = req.query.cmd || 'echo hello';
  exec(cmd, (err, out, err2) => res.type('text').send(out || String(err || err2))); // INSECURE
});

app.get('/read', (req, res) => {
  const p = __dirname + '/data/' + req.query.file; // INSECURE: path traversal
  fs.readFile(p, 'utf8', (e, d) => res.type('text').send(e ? String(e) : d));
});

app.listen(3000, () => console.log('vuln app on 3000'));
