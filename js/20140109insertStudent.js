var mysql = require('mysql2'), connection = mysql.createConnection({
	user : 'root',
	database : 'marvel'
});

module.exports.insertStudent = function(req, res, next, callback) {
	var sFirst = req.body.first;
	var sLast = req.body.last;
	var sSQL = "INSERT INTO student(FirstName, LastName) VALUES(?,?)";
	connection.query(sSQL, [sFirst, sLast], function(err, rows){
		if(err)
			callback(err);

		res.setHeader("Content-Type", "application/json");
		res.end('{"success":"true"}');
		if (callback)
			callback(null);
	});
};