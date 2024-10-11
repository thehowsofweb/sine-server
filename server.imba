import express from 'express'
import {DB} from './connect'
import cors from 'cors'

const app = express()
const port = process.env.PORT or 3000

app.use(cors())
app.use(express.json())

app.get '/api/users', do(req, res)
	const sql = "SELECT * FROM users"
	DB.all sql, [], do(err, users)
		if err then res.send err.message
		res.json users

app.post '/api/users', do(req, res)
	console.log(req.body)
	const {username, password, email} = req.body
	const sql = "INSERT INTO users(username, password, email) VALUES (?,?,?)"
	DB.run sql, [username, password, email], do(err, user)
		if err then res.send err.message
		res.redirect "/api/users"

app.delete '/api/users/:id', do(req, res)
	const {id} = req.params
	const sql = "DELETE FROM users WHERE id = ?"
	DB.run sql, [id], do(err) 
		if err then res.send err.message
		res.redirect "/api/users"

app.patch '/api/users/:id', do(req, res)
	let {id} = req.params
	const updates = req.body
	delete updates.id
	const fields = Object.keys(updates).map do(field) "{field}=?"
	console.log fields
	const values = Object.values(updates)
	console.log values
	const sql = "UPDATE users SET ${fields.join(', ')} WHERE id = ?";
	DB.run sql, [...values, id], do(err) # values here has id why this code doesn't work?
		if err then return res.send err.message
		console.log 'user updated'
		res.send "user updated"


app.post '/auth/login', do(req, res)
	const {username, password} = req.body
	const sql = "SELECT * FROM users WHERE username=?"
	DB.run sql, [username], do(err, user)
		if err then res.send "no user found"
		if password !== user.password then res.send "invalid credentials"
		res.send('you are logged in')


# ENDPOINTS
# app.get '/user/:id', do(req, res)
# 	const id = req.params.id
# 	getUser id, do(err, user)
# 		if err then res.json err.message
# 		if !user then res.json 'no user found'
# 		res.send user

# app.get '/users/add', do(req, res)
# 	insertUser 'raeann', '123', 'raeann@adorable.com', do(err, user)
# 		if err
# 			res.json "encountered {err.message}"
# 		res.redirect '/'
		

# app.get '/', do(req, res)
# 	getUsers do(err, user)
# 		if err then res.send err.message
# 		res.json user

# app.get '/delete/:id', do(req, res)
# 	const id = req.params.id
# 	deleteUser id, do(err)
# 		if err then res.send err.message
# 		res.redirect '/'

imba.serve app.listen(port)
