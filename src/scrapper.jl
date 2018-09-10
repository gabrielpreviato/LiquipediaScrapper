using HTTP, Gumbo, DataStructures, LightGraphs, MetaGraphs, GraphPlot

include("parser.jl")
include("graph.jl")

url = "https://liquipedia.net/starcraft2/2018_WCS_Montreal"
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

o = find_all_tag(parsed_html.root, "tr")

l = HTMLNode[]
for i in o
    for j in children(i)
        if !isa(j, HTMLText) && haskey(attrs(j), "class") && get(attrs(j), "class", "") == "matchlistslot"
            push!(l, i)
            break
        end
    end
end

#dict = Dict{String, Array{Int64, 1}}()
G = MetaGraph()
set_indexing_prop!(G, :name)
add_vertex!(G)

ne(G)
nv(G)

a = G["Kelazhur", :name]

for k in l
    #p = [text(children(i)[1]) for i in find_all(k, "style", "white-space:pre")]
    p = [text(k[1][1][1]), text(k[4][3][1])]
    println(p)
    #s = [text(children(i)[1]) for i in vcat(find_all(k, "style", "width:6%;text-align:center"), find_all(z, "style", "width:6%;text-align:center;font-weight:bold"))]
    s = [text(k[2][1]), text(k[3][1])]
    s = map(x->tryparse(Int64,x),s)
    if isa(s, Array{Nothing})
        s = [0, 0]
    end

    println(s)

    key = p[1] < p[2] ? p[1] * "-" * p[2] : p[2] * "-" * p[1]

    score = p[1] < p[2] ? [s[1], s[2]] : [s[2], s[1]]
    sum_score = score[1] + score[2]

    old_score = get!(dict, key, [0, 0])

    total_score = sum_score + old_score[1] + old_score[2]
    dict[key] = score + old_score
end
