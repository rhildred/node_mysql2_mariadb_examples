var mysql = require('mysql2'), connection = mysql.createConnection({
	user : 'root',
	database : 'marvel'
});

module.exports.insertStudent = function(req, res, next, callback) {
	var sStudentNum = req.body.studentNum;
	var sFirst = req.body.first;
	var sLast = req.body.last;
	var sSQL = "INSERT INTO student(StudentNumber, FirstName, LastName) VALUES(?,?,?)";
	connection.query(sSQL, [sStudentNum, sFirst, sLast], function(err, rows){
		if(err)
			callback(err);
		res.setHeader("Content-Type", "application/json");
		res.end(JSON.stringify(rows));
		if (callback)
			callback(null);
	});
};