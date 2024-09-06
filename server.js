const express = require("express");
const app = express();
var exec = require("child_process").exec;
const os = require("os");
var fs = require("fs");
var path = require("path");

app.get("/", function (req, res) {
  res.send("Hello Node");
});

exec("bash entry.sh", function (err, stdout, stderr) {
  if (err) {
    console.error(err);
    return;
  }
  console.log(stdout);
});

app.listen(3000, () => console.log(`3000`));
