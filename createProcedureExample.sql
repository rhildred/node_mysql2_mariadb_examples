CREATE PROCEDURE babysleepsum() SELECT babyname, DATEDIFF(NOW(), sleepstarttime) AS sleepday,   
SUM(sleepduration) AS duration FROM babysleeps, babies 
WHERE DATEDIFF(NOW(), sleepstarttime) < 8 AND babies.id = babysleeps.babyid
GROUP BY 1,2 ORDER BY 1,2;