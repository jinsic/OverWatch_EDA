import requests
import re
import bs4 as bf
from six import string_types

target = 'https://overlog.gg'
for total in range(1,100):
    req = requests.get(target+'/leaderboards/global/rank/'+str(total))

    html = req.text

    soup = bf.BeautifulSoup(html, 'html.parser')

    users = soup.select(
    'td.ContentCell.ContentCell-Player > a'
    )

    index = 0
    parse = ""
    stringx = ""
    for iter in users:
        index +=1
        detreq = requests.get(target+iter.get('href'))
        html = detreq.text
        soup = bf.BeautifulSoup(html, 'html.parser')
        rate = soup.select(
            'div > div > div > div > div.SkillRating > h2 > b'
        )


        for x in rate:
            parse = re.sub('[ \t\n\r\f\v,Points]','',x.text)
            if parse != "SkillRag":
                stringx += parse
                stringx += ','
                #print(parse + ',', end=" ")
        print(stringx.encode(), end=",")

        if index > 5:
            break
