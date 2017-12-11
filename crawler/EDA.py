import requests
import re
import bs4 as bf
from six import string_types

target = 'https://overlog.gg'
for total in range(1,6738):
    req = requests.get(target+'/leaderboards/global/rank/'+str(total))

    html = req.text

    soup = bf.BeautifulSoup(html, 'html.parser')

    users = soup.select(
    'td.ContentCell.ContentCell-Player > a'
    )


    '''
    for title in users:
        # Tag안의 텍스트
        print(title.text)
        # Tag의 속성을 가져오기(ex: href속성)
        print(title.get('href'))
    '''
    f = open("C:/testP/test.txt", 'w')
    index = 0
    parse = ""
    stringx = ""
    for iter in users:
        stringx = ""
        detreq = requests.get(target+iter.get('href'))
        html = detreq.text
        soup = bf.BeautifulSoup(html, 'html.parser')
        hero_name = soup.select(
            'div > div.MainContent > div.ChampionStatsTable > table > tbody > tr'# > td.ContentCell.ContentCell-Hero'#챔피언
        )

        hero_winrate = soup.select(
            'div > div > div > div > div.PlayerSummaryStats > div > em'
        )

        rate = soup.select(
            'div > div > div > div > div.SkillRating > h2 > b'
        )
        id = soup.select(
            'div > div.PlayerInfo > div.PlayerName > span'
        )
        #PlayerLayoutContent > div > div.MainContent > div.ChampionStatsTable > table > tbody > tr:nth-child(1)

        molra = soup.select(
            'div > div > div > table > tbody > tr > td'
        )



        for x in id:
            parse = re.sub('[ \t\n\r\f\v]','',x.text)
            #parse = re.sub('[\n]',' ',parse)
            #print(parse + ',', end=" ")
            stringx += parse
            stringx += ','
        #print("\n")
        for x in rate:
            parse = re.sub('[ \t\n\r\f\v,Points]','',x.text)
            #parse = re.sub('[\n]',' ',parse)
            #print(parse + ',', end=" ")
            stringx += parse
            stringx += ','
        #print("\n")
        for x in hero_winrate:
            parse = re.sub('[ \t\n\r\f\v]','',x.text)
            parse = re.sub('[WDL/]',',',parse)
            #승 무 패 킬 뎃 게임
            #print(parse + ',', end=" ")
            stringx += parse
            stringx += ','
        #print("\n")
        for x in molra:
            parse = re.sub('[ \t\n\r\f\v]','',x.text)

            #parse = re.sub['%WL'],',',parse)
            #parse = re.sub('[\n]',' ',parse)
            #parse = re.sub('[\n]',' ',parse)
            #parse = re.sub('Tank',' ',parse)
            #print(parse + ',', end=" ")
            stringx += parse
            stringx += ','
        print(stringx.encode())
		index++
		if index > 5:
			break
        #print("\n")

    #PlayerLayoutContent > div > div:nth-child(1) > div:nth-child(2) > table > tbody > tr:nth-child(1) > td:nth-child(2)
    #PlayerLayoutContent > div > div:nth-child(1) > div:nth-child(2) > table > tbody > tr:nth-child(2) > td:nth-child(2)
