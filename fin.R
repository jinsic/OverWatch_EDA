setwd("C:\\Users\\JinSic\\Documents\\OverWatch_EDA\\dataSet")
library(psych)
library(RColorBrewer)
library(plyr)
library(ggplot2)
data1 = read.csv("OV_EDA.csv")
data = data1
data = data[data$score != "SkllRag",]
data = data[data$Games != 1 ,]
data = data[data$mostRole1 == "Tank" |data$mostRole1 == "Support" |data$mostRole1 == "Offense" |data$mostRole1 == "Defense" ,]
data = data[data$kill < 50 & data$death < 30,]

data$score = as.numeric(as.character(data$score))
data$totalT = (as.numeric(as.character(data$mostRole1.time))+
                           as.numeric(as.character(data$mostRole2.time))+
                                        as.numeric(as.character(data$mostRole3.time))+
                                                     as.numeric(as.character(data$mostRole4.time)))/10000

data$mostRole1.time = as.numeric(as.character(data$mostRole1.time))
data$mostRole1.winrate = as.numeric(as.character(data$mostRole1.winrate))
data$mostRole2.time = as.numeric(as.character(data$mostRole2.time))
data$mostRole2.winrate = as.numeric(as.character(data$mostRole2.winrate))
data$mostRole3.time = as.numeric(as.character(data$mostRole3.time))
data$mostRole3.winrate = as.numeric(as.character(data$mostRole3.winrate))
data$mostRole4.time = as.numeric(as.character(data$mostRole4.time))
data$mostRole4.winrate = as.numeric(as.character(data$mostRole4.winrate))

data$most1HeroWin = as.numeric(as.character(data$most1HeroWin))
data$most1mission = as.numeric(as.character(data$most1mission))
data$most1PJ = as.numeric(as.character(data$most1PJ))
data$most1Time = as.numeric(as.character(data$most1Time))
data$most2HeroWin = as.numeric(as.character(data$most2HeroWin))
data$most2mission = as.numeric(as.character(data$most2mission))
data$most2PJ = as.numeric(as.character(data$most2PJ))
data$most2Time = as.numeric(as.character(data$most2Time))
data$most3HeroWin = as.numeric(as.character(data$most3HeroWin))
data$most3mission = as.numeric(as.character(data$most3mission))
data$most3PJ = as.numeric(as.character(data$most3PJ))
data$most3Time = as.numeric(as.character(data$most3Time))

data[is.na(data)] <- 0

summary(data)

windows()
pairs.panels(data[,c("score","win","drow", "lose", "kill", "death","Games","totalT")], 
             data=data)

GM_data = as.data.frame(data[data$score >= 4000,])
M_data = as.data.frame(data[data$score < 4000 & data$score >= 3500,])
D_data = as.data.frame(data[data$score < 3500 & data$score > 3000,])
P_data = as.data.frame(data[data$score < 3000 & data$score > 2500,])

windows()
pairs.panels(GM_data[,c("score","win","drow", "lose", "kill", "death","Games","totalT")], 
             data=GM_data)
windows()
pairs.panels(M_data[,c("score","win","drow", "lose", "kill", "death","Games","totalT")], 
             data=M_data)
windows()
pairs.panels(D_data[,c("score","win","drow", "lose", "kill", "death","Games","totalT")], 
             data=D_data)
windows()
pairs.panels(P_data[,c("score","win","drow", "lose", "kill", "death","Games","totalT")], 
             data=P_data)

x = count(GM_data$mostRole1)
x2 = count(GM_data$mostRole2)
x3 = count(GM_data$mostRole3)
x
GMD = as.integer(x$freq[1]+x2$freq[1]+x3$freq[1])
GMO = as.integer(x$freq[2]+x2$freq[2]+x3$freq[2])
GMS = as.integer(x$freq[3]+x2$freq[3]+x3$freq[3])
GMT = as.integer(x$freq[4]+x2$freq[4]+x3$freq[4])
a <- list(c("Defense","Offense","Support","Tank"), c(GMD,GMO,GMS,GMT))

GM_R = as.data.frame(col.names = c("Role","count"),a)

GM_R_name = paste(as.character(GM_R$Role),",",round(GM_R$count/sum(GM_R$count)*100,1),"%",sep="")




x = count(M_data$mostRole1)
x2 = count(M_data$mostRole2)
x3 = count(M_data$mostRole3)

GMD = as.integer(x$freq[1]+x2$freq[1]+x3$freq[1])
GMO = as.integer(x$freq[2]+x2$freq[2]+x3$freq[2])
GMS = as.integer(x$freq[3]+x2$freq[3]+x3$freq[3])
GMT = as.integer(x$freq[4]+x2$freq[4]+x3$freq[4])
a <- list(c("Defense","Offense","Support","Tank"), c(GMD,GMO,GMS,GMT))

M_R = as.data.frame(col.names = c("Role","count"),a)

M_R_name = paste(as.character(M_R$Role),",",round(M_R$count/sum(M_R$count)*100,1),"%",sep="")





x = count(D_data$mostRole1)
x2 = count(D_data$mostRole2)
x3 = count(D_data$mostRole3)

GMD = as.integer(x$freq[1]+x2$freq[1]+x3$freq[1])
GMO = as.integer(x$freq[2]+x2$freq[2]+x3$freq[2])
GMS = as.integer(x$freq[3]+x2$freq[3]+x3$freq[3])
GMT = as.integer(x$freq[4]+x2$freq[4]+x3$freq[4])
a <- list(c("Defense","Offense","Support","Tank"), c(GMD,GMO,GMS,GMT))

D_R = as.data.frame(col.names = c("Role","count"),a)

D_R_name = paste(as.character(D_R$Role),",",round(D_R$count/sum(D_R$count)*100,1),"%",sep="")

x = count(P_data$mostRole1)
x2 = count(P_data$mostRole2)
x3 = count(P_data$mostRole3)

GMD = as.integer(x$freq[1]+x2$freq[1]+x3$freq[1])
GMO = as.integer(x$freq[2]+x2$freq[2]+x3$freq[2])
GMS = as.integer(x$freq[3]+x2$freq[3]+x3$freq[3])
GMT = as.integer(x$freq[4]+x2$freq[4]+x3$freq[4])
a <- list(c("Defense","Offense","Support","Tank"), c(GMD,GMO,GMS,GMT))

P_R = as.data.frame(col.names = c("Role","count"),a)

P_R_name = paste(as.character(P_R$Role),",",round(P_R$count/sum(P_R$count)*100,1),"%",sep="")



windows()
par(mfcol=c(2,2))
pie(GM_R$count,labels = GM_R_name,col = brewer.pal(4,"RdGy"), main="그마구간 역할군")
pie(M_R$count,labels = M_R_name,col = brewer.pal(4,"RdGy"), main="마스터구간 역할군")
pie(D_R$count,labels = D_R_name,col = brewer.pal(4,"RdGy"), main="다이아구간 역할군")
pie(P_R$count,labels = P_R_name,col = brewer.pal(4,"RdGy"), main="플레구간 역할군")





GM_most = count(GM_data$most1Hero)
M_most = count(M_data$most1Hero)
D_most = count(D_data$most1Hero)
P_most = count(P_data$most1Hero)
P_most
GM_most
windows()
ggplot(GM_most, aes(x = reorder(x, -freq), y=freq))+
  geom_bar(stat = "identity")+
  labs(title="그마구간 영웅 픽",x = "hero", y = "pick_amount")
windows()
ggplot(M_most, aes(x = reorder(x, -freq), y=freq))+
  geom_bar(stat = "identity")+
  labs(title="마스터구간 영웅 픽",x = "hero", y = "pick_amount")
windows()
ggplot(D_most, aes(x = reorder(x, -freq), y=freq))+
  geom_bar(stat = "identity")+
  labs(title="다이아구간 영웅 픽",x = "hero", y = "pick_amount")
windows()
ggplot(P_most, aes(x = reorder(x, -freq), y=freq))+
  geom_bar(stat = "identity")+
  labs(title="플레구간 영웅 픽",x = "hero", y = "pick_amount")


GM_GTWH = GM_most[GM_most$x=="Genji"|GM_most$x=="Tracer"|GM_most$x=="Widowmaker"|GM_most$x=="Hanzo",]
M_GTWH = M_most[M_most$x=="Genji"|M_most$x=="Tracer"|M_most$x=="Widowmaker"|M_most$x=="Hanzo",]
D_GTWH = D_most[D_most$x=="Genji"|D_most$x=="Tracer"|D_most$x=="Widowmaker"|D_most$x=="Hanzo",]
P_GTWH = P_most[P_most$x=="Genji"|P_most$x=="Tracer"|P_most$x=="Widowmaker"|P_most$x=="Hanzo",]

GM_GTWH_name = paste(as.character(GM_GTWH$x),",",round(GM_GTWH$freq/sum(GM_GTWH$freq)*100,1),"%",sep="")
M_GTWH_name = paste(as.character(M_GTWH$x),",",round(M_GTWH$freq/sum(M_GTWH$freq)*100,1),"%",sep="")
D_GTWH_name = paste(as.character(D_GTWH$x),",",round(D_GTWH$freq/sum(D_GTWH$freq)*100,1),"%",sep="")
P_GTWH_name = paste(as.character(P_GTWH$x),",",round(P_GTWH$freq/sum(P_GTWH$freq)*100,1),"%",sep="")



windows()
par(mfcol=c(2,2))
pie(GM_GTWH$freq,labels = GM_GTWH_name,col = brewer.pal(4,"RdGy"), main="그마구간 겐트위한 픽률")
pie(M_GTWH$freq,labels = M_GTWH_name,col = brewer.pal(4,"RdGy"), main="마스터구간 겐트위한 픽률")
pie(D_GTWH$freq,labels = D_GTWH_name,col = brewer.pal(4,"RdGy"), main="다이아구간 겐트위한 픽률")
pie(P_GTWH$freq,labels = P_GTWH_name,col = brewer.pal(4,"RdGy"), main="플레구간 겐트위한 픽률")




count(D_data$most2Hero)
count(P_data$most2Hero)

#원챔장인
oneCindex = c("GM","M","D","P")
oneC = c(count(GM_data$most2Hero)$freq[1]/length(GM_data$score)*100,
count(M_data$most2Hero)$freq[1]/length(M_data$score)*100,
count(D_data$most2Hero)$freq[1]/length(D_data$score)*100,
count(P_data$most2Hero)$freq[1]/length(P_data$score)*100)

a <- list(c("GM","M","D","P"), oneC)
oneCD = as.data.frame(col.names = c("Tier","count"),a)
windows()
ggplot(oneCD, aes(x = reorder(Tier,-count), y=count))+
  geom_bar(stat = "identity")+
  ylim(0,1)+
  labs(title="구간별 원챔장인",x = "Tier", y = "Persent(%)")













