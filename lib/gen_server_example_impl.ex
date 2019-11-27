defmodule KeyValueStore do
    alias KeyValueStore.Server

    def init do
        Server.start
    end

    def put_value(key, value) do
        Server.put(key, value)
    end
    
    def get_value(key) do
        Server.get(key)
    end

end