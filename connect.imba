import sqlite3 from 'sqlite3'
const sql3 = sqlite3.verbose()

# connect to db

const connected = do(err)
	if err then console.log err.message
	console.log 'connected'

export const DB = new sql3.Database './Db.db', sqlite3.OPEN_READWRITE, connected
	
# CREATE table
def createTable tableName
	const sql = "CREATE TABLE IF NOT EXISTS {tableName}(id INTEGER PRIMARY KEY, title, body)"
	DB.run sql, do(err)
		if err
			console.log err.message
		else
			console.log "{tableName} table created"

createTable 'posts'

def dropTable table
	DB.run "DROP TABLE {table}", do(err)
		if err
			console.log err.message
		else
			console.log "{table} table dropped"
