{application, 'restboy', [
	{description, "REST API on Erlang Cowboy"},
	{vsn, "0.1.0"},
	{modules, ['restboy_app','restboy_sup']},
	{registered, [restboy_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{mod, {restboy_app, []}},
	{env, []}
]}.