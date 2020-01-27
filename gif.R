library(magick)
#tuto : https://cran.r-project.org/web/packages/magick/vignettes/intro.html

setwd("./DATA/imageR")

#### Tuto ensemble ####

bigdata <- image_read('https://jeroen.github.io/images/bigdata.jpg')
frink <- image_read("https://jeroen.github.io/images/frink.png")
logo <- image_read("https://jeroen.github.io/images/Rlogo.png")
img <- c(bigdata, logo, frink)
img <- image_scale(img, "300x300")
image_info(img)
image_mosaic(img) #images l'une sur l'autre, en étendant la taille
image_flatten(img) #taille de la 1re image
image_flatten(img, 'Minus')

#mettre les images côte à côte
image_append(image_scale(img, "x200"))
#les une au-dessus des autres avec stack = TRUE
image_append(image_scale(img, "100"), stack = TRUE)

#animer l'ensemble des images
image_animate(image_scale(img, "200x200"), fps = 1, dispose = "previous")

#avec du morphing pour une transition douce
newlogo <- image_scale(image_read("https://jeroen.github.io/images/Rlogo.png"))
oldlogo <- image_scale(image_read("https://developer.r-project.org/Logo/Rlogo-3.png"))
image_resize(c(oldlogo, newlogo), '200x150!') %>%
  image_background('white') %>%
  image_morph() %>%
  image_animate()

#### GIF complet ####

# Foreground image
banana <- image_read("https://jeroen.github.io/images/banana.gif")
banana <- image_scale(banana, "150")
image_info(banana)

# Background image
background <- image_background(image_scale(logo, "200"), "white", flatten = TRUE)

# Combine and flatten frames
frames <- image_composite(background, banana, offset = "+70+30")

# Turn frames into animation
animation <- image_animate(frames, fps = 10)
print(animation)


#### Test GIF perso ####

# Images sources
carte1 <- image_read("seuil9000habitants1.png")
carte1 <- image_scale(carte1, "800")

carte2 <- image_read("seuil9000habitants2.png")
carte2 <- image_scale(carte2, "800")

#Associer les images dans un vecteur
carte <- c(carte2, carte1)

#Créer le gif
cartegif <- image_animate(image_scale(carte, "800"), fps = 1, dispose = "previous")
image_write(cartegif, "carteseuil.gif")
