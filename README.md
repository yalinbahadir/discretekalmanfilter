
# Kalman Filtresi

## Giriş


Filtrelerin genel operasyon prensibi, bir denklem veya olay sonucundan istenilen parçaların en iyi şekilde elde edilmesi veya istenilmeyen parçaların olay sonucu gözlenecek verinin dışında tutulması olarak özetlenebilir. Örneğin düşük bant filtresi, denklem içerisindeki yüksek frekansa sahip parçaları, filtrenin operasyonu sonrası gözlemememizi sağlar. Kalman da aynı bu tip bir filtre gibi davranır, gerekli bilgi içerisine geçmiş olan hata/rassallık veya kesinlik barındırmayan parçaları filtre sonrasında elimine etmeyi ya da işlemin ön gördüğü doğrultuda yeteri kadar azaltmayı amaçlar. 

Kalman Filtresi sistemi üzerinde çalışmak için doğrusal durum uzayı formatında tasarlanır:

 ![1](https://latex.codecogs.com/gif.latex?%5Ctextbf%7Bx%7D_k%20%3D%20%5Ctextbf%7BK%7D_%7Bk-1%7D%20%5Ctextbf%7Bx%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7BG%7D_%7Bk-1%7D%20%5Ctextbf%7Bu%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7Bw%7D_%7Bk-1%7D)     (1) 
 
 ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7By%7D_k%20%3D%20%5Ctextbf%7BH%7D_k%20%5Ctextbf%7Bx%7D_k%20&plus;%20%5Ctextbf%7Bv%7D_k)     (2)
 
Burada **x** durum vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X 1'dir. **y** ise çıktı vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_y) X 1'dir. **u**, girdi vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_u) X 1'dir. **w** ve **v** sırasıyla süreç gürültü vektörü ve ölçüm gürültü vektörleridir ve sırasıyla boyutları durum vektörü ve çıktı vektörüyle aynıdır. **F** duruma ait sistem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X ![](https://latex.codecogs.com/gif.latex?n_x)'dir, **G** ise girdinin sistem matrisidir ve boyutu $n_x$ X $n_u$ 'dur. Son olarak **H** gözlem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_y) X ![](https://latex.codecogs.com/gif.latex?n_x)'dir. Burada fark edilmesi gereken şey; gözlem matrisi ve sistem matrisi bağımsız elemanlardır ve kare matris oluşturmak zorunda değillerdir, ancak durum matrisi, boyutlarından da anlaşılabileceği üzere, bir kare matris oluşturmalıdır.
