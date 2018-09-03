using HTTP, Gumbo, DataStructures

url = "https://liquipedia.net/starcraft2/Copa_America_2018/Season_3"
ha = replace(split(url, "https://liquipedia.net/starcraft2/")[2], "/" => "_")

raw_html = HTTP.request("GET", url)

parsed_html = parsehtml(String(raw_html))

local_path = joinpath(splitdir(@__DIR__)[1],"texts/")
if !isdir(local_path)
    mkdir(local_path)
end

url_to_txt = replace(split(url, "https://liquipedia.net/starcraft2/")[2], "/" => "_") * ".txt"
open(local_path * url_to_txt, "w") do file
    println(file, parsed_html.root)
end

a = parsed_html.root
b = a.children[2]
c = b.children
d = c[23]
e = tag(d)
f = attrs(d)
function find_tag(tag::String, childs::Array{HTMLNode,1})
    1
end

find_tag("ha", c)

for i in 1:length(c)
    if isa(c[i], HTMLText)
        continue
    end
    for child in c[i].children
        if isa(child, HTMLText)
            continue
        end
        if haskey(attrs(child), "class") && get(attrs(child), "class", "") == "container-fluid main-content"
            println(i)
        end
    end
    # if isa(c[i], HTMLElement{:div})
    #     println(attrs(c[i]))
    # end
end

g = children(c[63])

node_stack = Stack{HTMLNode}()
desired_nodes = Array{HTMLNode, 1}()

function find_all(document::HTMLDocument, attribute::String)
    root = document.root

    node_stack = Stack{HTMLNode}()
    desired_nodes = Array{HTMLNode, 1}()

    for node in children(root)
        push!(node_stack, node)
    end

    while !isempty(node_stack)
        node = pop!(node_stack)
        # println(node)

        if isa(node, HTMLText)
            continue
        end

        # println(attrs(node))
        if haskey(attrs(node), attribute)
            push!(desired_nodes, node)
        end

        for node_child in children(node)
            push!(node_stack, node_child)
        end
    end

    return desired_nodes
end

function find_all(m_node::HTMLNode, attribute::String)
    node_stack = Stack{HTMLNode}()
    desired_nodes = Array{HTMLNode, 1}()

    push!(node_stack, m_node)

    while !isempty(node_stack)
        node = pop!(node_stack)
        # println(node)

        if isa(node, HTMLText)
            continue
        end

        # println(attrs(node))
        if haskey(attrs(node), attribute)
            push!(desired_nodes, node)
        end

        for node_child in children(node)
            push!(node_stack, node_child)
        end
    end

    return desired_nodes
end

y = find_all(parsed_html, "class")
