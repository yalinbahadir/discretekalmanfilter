
# Kalman Filtresi

## Giriş


Filtrelerin genel operasyon prensibi, bir denklem veya olay sonucundan istenilen parçaların en iyi şekilde elde edilmesi veya istenilmeyen parçaların olay sonucu gözlenecek verinin dışında tutulması olarak özetlenebilir. Örneğin düşük bant filtresi, denklem içerisindeki yüksek frekansa sahip parçaları, filtrenin operasyonu sonrası gözlemememizi sağlar. Kalman da aynı bu tip bir filtre gibi davranır, gerekli bilgi içerisine geçmiş olan hata/rassallık veya kesinlik barındırmayan parçaları filtre sonrasında elimine etmeyi ya da işlemin ön gördüğü doğrultuda yeteri kadar azaltmayı amaçlar. 

Kalman Filtresi sistemi üzerinde çalışmak için doğrusal durum uzayı formatında tasarlanır:

    (1) ![1](https://latex.codecogs.com/gif.latex?%5Ctextbf%7Bx%7D_k%20%3D%20%5Ctextbf%7BK%7D_%7Bk-1%7D%20%5Ctextbf%7Bx%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7BG%7D_%7Bk-1%7D%20%5Ctextbf%7Bu%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7Bw%7D_%7Bk-1%7D)
    (2) ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7By%7D_k%20%3D%20%5Ctextbf%7BH%7D_k%20%5Ctextbf%7Bx%7D_k%20&plus;%20%5Ctextbf%7Bv%7D_k)
