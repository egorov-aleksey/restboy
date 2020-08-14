-module(restboy_rest_handler).
-behavior(cowboy_rest).

-export([init/2]).
-export([allowed_methods/2]).
-export([content_types_provided/2, content_types_accepted/2]).
-export([from_json/2, to_json/2]).

init(Req, State) ->
  logger:notice("~s:~s | http rest api request ~p", [?MODULE, ?FUNCTION_NAME, Req]),
  {cowboy_rest, Req, State}.

allowed_methods(Req, State) ->
  {[<<"GET">>, <<"PUT">>, <<"HEAD">>, <<"OPTIONS">>], Req, State}.

content_types_accepted(Req, State) ->
  Result = [
    {{<<"application">>, <<"json">>, []}, from_json}
  ],
  {Result, Req, State}.

content_types_provided(Req, State) ->
  Result = [
    {{<<"application">>, <<"json">>, []}, to_json}
  ],
  {Result, Req, State}.

to_json(Req, State) ->
  GeneratorState = gen_server:call(restboy_generator, state),
  Result = jsx:encode(GeneratorState),
  {Result, Req, State}.

from_json(Req0, State) ->
  {ok, Data, _} = cowboy_req:read_body(Req0),
  Json = jsx:decode(Data, [{labels, atom}]),
  Body = jsx:encode(handle_json(Json)),
  Req = cowboy_req:set_resp_body(Body, Req0),
  {true, Req, State}.

handle_json(#{cmd := <<"run">>}) ->
  gen_server:cast(restboy_generator, run),
  #{result => ok};
handle_json(#{cmd := <<"stop">>}) ->
  gen_server:cast(restboy_generator, stop),
  #{result => ok};
handle_json(_Json) ->
  logger:warning("~s:~s | json \"~p\"", [?MODULE, ?FUNCTION_NAME, _Json]),
  #{error => unexpected}.
