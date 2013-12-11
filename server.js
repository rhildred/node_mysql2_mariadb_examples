var TestRunner = require('assert-runner'),
assert = require('assert'),
renderAsync = require('render-async'),
renderFile = renderAsync.__express,
jQuery = require('js-toolbox')._jQuery,
johnyDrop = require('./js/johnyDrop.js').johnyDrop;

//now we need a server for this so that we can test include
var app= renderAsync.express();
app.set('views', __dirname + '/public');

// add a route for Johny Drop table

app.get("/johnyDrop", function(req, res){johnyDrop(req, res);});

//server everything index.html welcome file
app.use(renderAsync.webServer);


//set ipaddress from openshift, to command line or to localhost:8080
var ipaddr = process.env.OPENSHIFT_NODEJS_IP || "127.0.0.1";
var port = process.env.OPENSHIFT_NODEJS_PORT || parseInt(process.argv.pop()) || 8080;

//start the server listening for requests
app.listen(port, ipaddr);
