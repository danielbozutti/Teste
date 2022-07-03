# Clustering

# Importando os pacotes
getwd()
library(plyr)
library(factoextra)
library(clustertend)

# Carregando e ajustando os dados
df = readxl::read_xlsx("Pasta1.xlsx")
rename(df, c("chocolate"= "chcolate", 
             "prestígio"= "prestigio", 
             "nutella"= "nutella", 
             "ninho com nutella" = "ninho_com_nutella", 
             "frutas vermelhas"= "frutas_vermelhas"))

# Verificando pertinência de clusterização

hopkins::hopkins(df)
# Valor é 0.6617 , sendo maior do que 0.5, sendo clusterizável

# Encontrando o valor ótimo para o número de clusters
fviz_nbclust(df, kmeans, method = "wss", k.max = 10)+
  geom_vline(xintercept = 2, linetype = 2)

# Vamos considerar 2 clusters

modelo <- kmeans(df, 2)

# Visualizando os clusters

fviz_cluster(modelo, data=df,
             ellipse.type="euclid",
             star.plot=TRUE,
             repel=TRUE,
             ggtheme=theme_minimal(),
)

# Verificando os cluster por clientes

resultado <- data.frame(modelo$cluster)
resultado$clientes <- c(1:100)
rename(resultado, c("modelo.cluster" = "cluster", "cliente" = "cliente"))

View(resultado)

