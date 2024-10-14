-module(erlpool_globals).

-export([size/1]).

-define(SIZE_TABLE, erlpool_sizes).

size(Name) ->
    case ets:lookup(?SIZE_TABLE, Name) of
        [{Name, Size}] ->
            {ok, Size};
        [] ->
            {error, not_found}
    end.