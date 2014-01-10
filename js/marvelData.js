var mysql = require('mysql2'), connection = mysql.createConnection({
	user : 'root',
	database : 'marvel'
});

module.exports.marvelData = function(req, res, next, callback) {
	var sFirst = req.param('f');
	var sLast = req.param('l');
	var sSQL = "SELECT * FROM student WHERE FirstName = ? AND LastName = ?";
	connection.query(sSQL, [sFirst, sLast], function(err, rows){
		if(err)
			callback(err);
		res.setHeader("Content-Type", "application/json");
		res.end(JSON.stringify(rows));
		if (callback)
			callback(null);		
	});
};

