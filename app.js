var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var cookieParser = require('cookie-parser');

var client = require('twilio')(
  'Twilio Account SID',
  'Twilio Account Token'
);


app.listen(8080,function(){
	console.log('magic happens at 8080');
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cookieParser());

app.post('/send',function(req,res){
	console.log("Inside send")
	console.log("req: ", req.body)
	client.messages.create({
	  from: '+13366061653',
	  to: req.body.to,
	  body: req.body.message,
	}).then((message) => console.log(message.sid));
  res.send("OK");
});

app.get('/',function(req,res){
	res.send("HI")	
});

