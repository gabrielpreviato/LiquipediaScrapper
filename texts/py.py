from bs4 import BeautifulSoup
import bs4
import requests

html_doc = requests.get('https://liquipedia.net/starcraft2/Copa_America_2018/Season_3')
soup = BeautifulSoup(html_doc.text, 'html.parser')

with open('/home/previato/Dropbox/julia_projects/LiquipediaScrapper.jl/texts/Copa_America_2018_Season_3.html', 'w') as file:
    file.write(soup.prettify())

def has_group_match(tag):
    if tag.name == 'tr':
        for child in tag.children:
            if isinstance(child, bs4.element.Tag) and has_class(child, 'matchlistslot'):
                return True
    return False

def has_class(tag, class_name):
    return tag.has_attr('class') and tag['class'][0] == class_name

for i in soup.find_all(has_group_match):
    print(i.prettify())
