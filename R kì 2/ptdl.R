# import library
library('ggplot2')
library('stringr')


# import csv file
data <- read.csv('Lnfix.csv', header = TRUE, encoding = 'UTF-8')


## Task 1: Mo ta du lieu lay ve

# a. So luong dong du lieu

nrow(data)

#b. Danh sach cac truong du lieu

# Xem 20 dong dau tien
head(data, 20)
# Ten cac truong du lieu
names(data)
# danh sach cac truong cua du lieu
str(data)              
View(data)

## Task 2: Thong ke mo ta

# a. Tinh cac chi so thong ke co ban

# ham tinh mode (yeu vi)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Tinh mean, mode, median cua heart (luot theo doi)

df_heart <-data$heart

mean(df_heart)
median(df_heart)
getmode(df_heart)


# tinh mean, mode, median cua star (danh gia)

df_star <- data$star

mean(df_star)
getmode(df_star)
median(df_star)


# tinh mean, mode, median cua view (so luot xem)

df_view <- data$view

mean(df_view)
getmode(df_view)
median(df_view)


# tinh mean, mode, median cua words (so luong tu)

df_words <- data$words

mean(df_words)
getmode(df_words)
median(df_words)


# tong quan ve du lieu
summary(data)

# b. Ve bieu do

# hàm dem so luong cua moi the loai

number_gerne <- function(y){
  count = 0
  df_1 <- data$gernes
  for (i in df_1){
    A = FALSE
    t = strsplit(i, ',') # tach thanh cac chuoi
    for (x in t){
      x <- str_trim(x)  # xoa khoang trang dau cuoi
      if (y %in% x){
        A = TRUE
      }    
    }
    if (A == TRUE){
      count = count + 1
    }
  }
  return (count)
}

number_gerne('Romance')

# ham lay ra cac the loai 
#gerne <- character()
#df_2 <- data$gernes[1:2]
#for (i in df_2){
  #t = strsplit(i, ',')
  #for (x in t){
    #x <- str_trim(x)
      #a <- c(x)
      #b <- c(gerne, a)
  #}
#}
gernes <- c('Action', 'Adapted to Anime', 'Adapted to Manga', 
            'Adult', 'Adventure', 'Comedy', 'Cooking', 'Drama', 'Ecchi', 'Fantasy', 'Game', 'Gender Bender', 'Harem', 'Historical', 
'Horror', 'Incest', 'Isekai', 'Josei', 'Korean Novel', 'Magic', 'Martial Arts', 'Mature', 'Mecha', 'Military', 
'Mystery', 'One shot', 'Otome Game', 'Psychological', 'Reverse Harem', 'Romance', 'School Life', 
'Science Fiction', 'Seinen', 'Shoujo', 'Shoujo ai', 'Shounen', 'Shounen ai', 'Slice of Life', 'Sports', 
'Super Power', 'Supernatural', 'Tragedy', 'Web Novel', 'Yuri')

gernes_count <- c(939, 64, 203, 105, 831, 1022, 22, 621, 327, 1187, 
                  58, 86, 615, 43, 87, 17, 332, 45, 131, 213, 64, 182, 44, 43, 200, 
                  74, 31, 210, 6, 1182, 508, 117, 211, 144, 75, 271, 8, 526, 3, 156, 335, 209, 564, 53)


data_1 <- data.frame(gernes, gernes_count)

# Plot 1: Bieu do ve the loai va so luong truyen co the loai do
ggplot(data_1, aes(x = gernes, y= gernes_count)) + 
  geom_bar(stat = "identity") +
  labs( title = 'BIEU DO VE THE LOAI VA SO LUONG TRUYEN CO THE LOAI DO',
        x = 'THE LOAI', y = 'SO LUONG') +
  coord_flip()


# plot 2, 3:

df_2 <- data$words
x <- c()

for (i in df_2){
  if (i <= 30000){
    x <- append(x, 'Low')
  } else if (30000 < i & i <= 70000){
    x <- append(x, 'Medium')
  } else if (i > 70000 & i <= 150000){
    x <- append(x, "High")
  } else if (i > 150000 & i <= 250000){
    x <- append(x, "Super_High")
  } else{
    x <- append(x, "Mega_High")
  }
}
Type_words <- x

a = 0
b = 0
c = 0
d = 0
e = 0
for (i in Type_words){
  if (i == "Low"){
    a = a +1
  } else if (i == "Medium"){
    b = b + 1
  } else if (i == 'High'){
    c = c + 1
  } else if (i == 'Super_High'){
    d = d + 1
  } else{
    e = e + 1
  }
}

sum <- a + b + c + d + e
a <- round((a/sum)*100,2)
b <- round((b/sum)*100,2)
c <- round((c/sum)*100,2)
d <- round((d/sum)*100,2)
e <- round((e/sum)*100,2)

Percent_2 <- c(a,b,c,d,e)
Type <- c('Low', 'Medium', 'High', 'Super_High', 'Mega_High')

df_3 <- data$view
a = 0
b = 0
c = 0
d = 0
e = 0
for (i in df_3){
  if (i <= 50000){
    a = a +1
  } else if (50000 <i & i <= 150000){
    b = b + 1
  } else if (i > 150000 & i <= 250000){
    c = c + 1
  } else if (i > 250000 & i <= 350000){
    d = d + 1
  } else{
    e = e + 1
  }
}
sum <- a + b + c + d + e
a <- round((a/sum)*100,2)
b <- round((b/sum)*100,2)
c <- round((c/sum)*100,2)
d <- round((d/sum)*100,2)
e <- round((e/sum)*100,2)

Percent_3 <- c(a,b,c,d,e)
a <-c(1,2,3,4,5)
data_2 <- data.frame(Type, a, Percent_2, Percent_3)
data_2
## plot 2:

ggplot(data_2, aes(x= a)) + 
  geom_line(aes(y = Percent_2), color = "red") + 
  labs(title = 'BIEU DO VE TI LE SO TU', x = 'Type', y = 'Percent')

## Plot 3:

ggplot(data_2, aes(x= a)) + 
  geom_line(aes(y = Percent_3), color = "red") + 
  labs(title = 'BIEU DO VE TI LE SO LUOT XEM', x = 'Type', y = 'Percent')

## Plot 4;

ggplot(data = data, mapping = aes(x = heart)) +
  geom_histogram(color = 'black',
                 fill = "red", binwidth = 300) +
  labs(title = 'BIEU DO VE VE HEART', x = 'So luot theo doi')