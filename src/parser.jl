using Gumbo, DataStructures

function find_all_attr(document::HTMLDocument, attribute::String)
    node_stack = Stack{HTMLNode}()
    desired_nodes = Array{HTMLNode, 1}()

    push!(node_stack, document.root)

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

function find_all_attr(document::HTMLDocument, attribute::String, value::String)
    node_stack = Stack{HTMLNode}()
    desired_nodes = Array{HTMLNode, 1}()

    push!(node_stack, document.root)

    while !isempty(node_stack)
        node = pop!(node_stack)
        # println(node)

        if isa(node, HTMLText)
            continue
        end

        # println(attrs(node))
        if haskey(attrs(node), attribute)
            if get(attrs(node), attribute, "") == value
                push!(desired_nodes, node)
            end
        end

        for node_child in children(node)
            push!(node_stack, node_child)
        end
    end

    return desired_nodes
end

function find_all_attr(m_node::HTMLElement, attribute::String, value::String)
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
            if get(attrs(node), attribute, "") == value
                push!(desired_nodes, node)
            end
        end

        for node_child in children(node)
            push!(node_stack, node_child)
        end
    end

    return desired_nodes
end

function find_all_attr(m_node::HTMLElement, attribute::String)
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

function has_attr(m_node::HTMLElement, attribute::String)
    return haskey(attrs(m_node), attribute)
end

function find_all_tag(m_node::HTMLElement, desired_tag::String)
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
        if String(tag(node)) == desired_tag
            push!(desired_nodes, node)
        end

        for node_child in children(node)
            push!(node_stack, node_child)
        end
    end

    return desired_nodes
end

function find_all_tag(document::HTMLDocument, desired_tag::String)
    node_stack = Stack{HTMLNode}()
    desired_nodes = Array{HTMLNode, 1}()

    push!(node_stack, document.root)

    while !isempty(node_stack)
        node = pop!(node_stack)
        # println(node)

        if isa(node, HTMLText)
            continue
        end

        # println(attrs(node))
        if String(tag(node)) == desired_tag
            push!(desired_nodes, node)
        end

        for node_child in children(node)
            push!(node_stack, node_child)
        end
    end

    return desired_nodes
end
