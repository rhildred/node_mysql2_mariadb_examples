var mysql = require('mysql2'), connection = mysql.createConnection({
	user : 'root',
	database : 'test2'
});
module.exports.babySleep = function(req, res, next, callback) {
	var sName = req.param('q') || '%';
	connection.query('CALL babysleepsum()', function(err, rows) {
		if (err && callback)
			callback(err);
		// now we want the rows
		res.setHeader("Content-Type", "application/json");
		res.end(JSON.stringify(rows[0]));
		if (callback)
			callback(null);
	});

};