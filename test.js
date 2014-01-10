var TestRunner = require('assert-runner'),
assert = require('assert'),
mysql = require('mysql2'),
johnyDrop = require('./js/johnyDrop.js').johnyDrop,
insertStudent = require('./js/insertStudent.js').insertStudent,
marvelData = require('./js/marvelData.js').marvelData;

var tests = {
	"Test of nothing": function(){
		assert(true == true);
		
	},
	"Test of Johny drop": function(done){
		var req = new TestRunner.TestRequest();
		var res = new TestRunner.TestResponse();
		johnyDrop(req, res, null, function(err){
			assert(err == null);
			assert(res.sBody != "");
			done();
		});
	},
	"Test of Johny drop with q": function(done){
		var req = new TestRunner.TestRequest();
		req.params['q'] = 'Frodo';
		var res = new TestRunner.TestResponse();
		johnyDrop(req, res, null, function(err){
			assert(err == null);
			assert(res.sBody == '[{"id":1,"name":"Frodo","address":"Bag End","city":"Shire","state":"Middle Earth","post_code":"123456"}]');
			done();
		});
	},
	"Test of Johny drop with SQL injection": function(done){
		var req = new TestRunner.TestRequest();
		req.params['q'] = "Johny';DROP TABLE test2;#";
		var res = new TestRunner.TestResponse();
		johnyDrop(req, res, null, function(err){
			connection = mysql.createConnection({
				user : 'root',
				database : 'test2'
			});
			connection.query("SELECT * FROM test2", function(err, rows) {
				assert(err == null);
				done();				
			});
		});
	},
	"Test of marvel": function(done){
		var req = new TestRunner.TestRequest();
		var res = new TestRunner.TestResponse();
		marvelData(req, res, null, function(err){
			assert(err == null);
			assert(res.sBody != "");
			console.log(res.sBody);
			done();
		});
	},
	"Test of marvel with params": function(done){
		var req = new TestRunner.TestRequest();
		req.params['f'] = "Rich";
		req.params['l'] = "Hildred";
		var res = new TestRunner.TestResponse();
		marvelData(req, res, null, function(err){
			assert(err == null);
			assert(res.sBody != "");
			console.log(res.sBody);
			done();
		});
	},
	"Test insert of new student": function(done){
		var req = new TestRunner.TestRequest();
		req.body = {};
		req.body.studentNum = 987;
		req.body.first = 'The';
		req.body.last = 'Bard';
		var res = new TestRunner.TestResponse();
		insertStudent(req, res, null, function(err){
			console.log(err);
			assert(err == null);
			assert(res.sBody != "");
			console.log(res.sBody);
			done();
		});
	}
};

new TestRunner(tests).again(0);
