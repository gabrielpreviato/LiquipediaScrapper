from bs4 import BeautifulSoup
import requests

html_doc = requests.get('https://liquipedia.net/starcraft2/Copa_America_2018/Season_3')
soup = BeautifulSoup(html_doc.text, 'html.parser')

with open('/home/previato/Dropbox/julia_projects/LiquipediaScrapper.jl/textsCopa_America_2018_Season_3.html', 'w') as file:
    file.write(soup.prettify())
