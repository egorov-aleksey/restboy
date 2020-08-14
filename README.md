# restboy

REST API on Erlang Cowboy

`curl -D - -X GET http://127.0.0.1:5000/api`

`curl -D - -X PUT -H "Content-Type: application/json" -d '{"cmd":"run"}' http://127.0.0.1:5000/api`

`curl -D - -X PUT -H "Content-Type: application/json" -d '{"cmd":"stop"}' http://127.0.0.1:5000/api`
