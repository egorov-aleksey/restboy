-module(restboy_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
  logger:notice("~s:~s | starts restboy supervisor", [?MODULE, ?FUNCTION_NAME]),

  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  Flags = #{
    strategy => one_for_one,
    intensity => 1,
    period => 5
  },

  GeneratorSpec = #{
    id => restboy_generator,
    start => {restboy_generator, start_link, []},
    restart => permanent,
    shutdown => brutal_kill,
    type => worker,
    modules => [restboy_generator]
  },

  Procs = [
    GeneratorSpec
  ],

  {ok, {Flags, Procs}}.
