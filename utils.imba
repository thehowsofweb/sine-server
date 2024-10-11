import sqlite3 from 'sqlite3'
const sql3 = sqlite3.verbose()

# connect to db

const connected = do(err)
	if err then console.log err.message
	console.log 'connected'

# const DB = new sql3.Database(':memory', sql3.OPEN_READWRITE, connected) # data in memory
# const DB = new sql3.Database('', sql3.OPEN_READWRITE, connected) # anonymous file
# const DB = new sql3.Database('./data.db', sql3.OPEN_READWRITE, connected) # file base

const db = new sql3.Database './Db.db', connected
	
# CREATE table
def createUsers
	const sql = ' CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, username, password, email)'
	db.run sql, do(err)
		if err
			console.log err.message
		else
			console.log 'users table created'
createUsers()



# to list all tables
const getTables = do
	const sql = "SELECT name FROM sqlite_master WHERE type='table'"
	db.all(sql, [], do(err, tables)
		if err then console.log err.message
		for table in tables
			console.log table
		)
getTables()

# INSERT data
def insertUser username\string, password\string, email\string, callback\Function
	const sql = "INSERT INTO users(username, password, email) VALUES (?,?,?)"
	db.run sql, [username, password, email], callback

# insertUser "jian", "123", "jian@adorable.com", do(err\Error)
# 	if err then console.log err


# GET users
def getUsers callback
	const sql = 'SELECT * FROM users'
	db.all sql, [], callback

# GET user
def getUser id, callback
	const sql = 'SELECT * FROM users WHERE id = ?'
	db.get sql, [id], callback

# UPDATE user data
def updateUser
	const sql = 'UPDATE users SET username = ? WHERE id = ?'
	db.run sql, ['jianbantot', 1], do(err)
		if err 
			console.log err.message
		else
			console.log 'username updated'
# updateUser()

# DELETE user
def deleteUser id, callback
	const sql = "DELETE FROM users WHERE id = ?"
	db.run sql, [id], callback

# deleteUser()

# drop table
def dropTable table
	db.run "DROP TABLE {table}", do(err)
		if err
			console.log err.message
		else
			console.log "{table} table dropped"

# dropTable 'users'

# ENDPOINTS


