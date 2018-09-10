using HTTP, Gumbo, DataStructures, LightGraphs, MetaGraphs, GraphPlot

function find_vertice(graph::MetaGraph, name::String)
    for vertice in vertices(graph)
        if haskey(props(graph, vertice), :name) && props(graph, vertice)[:name] == name
            return true
        end
    end

    return false
end

function add_player_vertice(graph::MetaGraph, name::String)
    if find_vertice(graph, name)
        return false
    end

    if add_vertex!(G)
        set_prop!(G, nv(G), :name, name)
        return true
    end

    return false
end
