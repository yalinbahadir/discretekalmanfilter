# Discrete Kalman Filter
Kalman Filtresi

## Giriş


Filtrelerin genel operasyon prensibi, bir denklem veya olay sonucundan istenilen parçaların en iyi şekilde elde edilmesi veya istenilmeyen parçaların olay sonucu gözlenecek verinin dışında tutulması olarak özetlenebilir. Örneğin düşük bant filtresi, denklem içerisindeki yüksek frekansa sahip parçaları, filtrenin operasyonu sonrası gözlemememizi sağlar. Kalman da aynı bu tip bir filtre gibi davranır, gerekli bilgi içerisine geçmiş olan hata/rassallık veya kesinlik barındırmayan parçaları filtre sonrasında elimine etmeyi ya da işlemin ön gördüğü doğrultuda yeteri kadar azaltmayı amaçlar. 

Kalman Filtresi sistemi üzerinde çalışmak için doğrusal durum uzayı formatında tasarlanır:
