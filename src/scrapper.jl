using HTTP, Gumbo, DataStructures

url = "https://liquipedia.net/starcraft2/Copa_America_2018/Season_3"
ha = replace(split(url, "https://liquipedia.net/starcraft2/")[2], "/" => "_")

raw_html = HTTP.request("GET", url)

parsed_html = parsehtml(String(raw_html))
t = tag(parsed_html.root)

#open(pwd()+""

local_path = joinpath(splitdir(@__DIR__)[1],"texts")
if !isdir(local_path)
    mkdir(local_path)
end

url_to_txt = replace(split(url, "https://liquipedia.net/starcraft2/")[2], "/" => "_") * ".txt"
open(local_path * url_to_txt, "w") do file
    println(file, parsed_html.root)
end
