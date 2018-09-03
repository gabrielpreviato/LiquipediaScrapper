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
