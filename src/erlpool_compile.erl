-module(erlpool_compile).

-export([compile_settings/1]).

-define(SIZE_TABLE, erlpool_sizes).

compile_settings(SettingsList) ->
    % Ensure the ETS table exists
    case ets:info(?SIZE_TABLE) of
        undefined ->
            ets:new(?SIZE_TABLE, [named_table, public, {read_concurrency, true}]);
        _ ->
            ok
    end,
    % Update the ETS table with the new settings
    lists:foreach(fun({Name, Size, _PoolArgs}) ->
        ets:insert(?SIZE_TABLE, {Name, Size})
    end, SettingsList),
    ok.