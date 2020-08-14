-module(restboy_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  Port = application:get_env(restboy, port, 5000),

  Dispatch = cowboy_router:compile([
    {'_', [
      {"/api", restboy_rest_handler, []}
    ]}
  ]),

  {ok, _} = cowboy:start_clear(restboy_http_listener,
    [{port, Port}],
    #{env => #{dispatch => Dispatch}}
  ),

  restboy_sup:start_link().

stop(_State) ->
  ok = cowboy:stop_listener(restboy_http_listener).