
# Kalman Filtresi

## 1. Giriş


Filtrelerin genel operasyon prensibi, bir denklem veya olay sonucundan istenilen parçaların en iyi şekilde elde edilmesi veya istenilmeyen parçaların olay sonucu gözlenecek verinin dışında tutulması olarak özetlenebilir. Örneğin düşük bant filtresi, denklem içerisindeki yüksek frekansa sahip parçaları, filtrenin operasyonu sonrası gözlemememizi sağlar. Kalman da aynı bu tip bir filtre gibi davranır, gerekli bilgi içerisine geçmiş olan hata/rassallık veya kesinlik barındırmayan parçaları filtre sonrasında elimine etmeyi ya da işlemin ön gördüğü doğrultuda yeteri kadar azaltmayı amaçlar. 

Kalman Filtresi sistemi üzerinde çalışmak için doğrusal durum uzayı formatında tasarlanır:

 ![1](https://latex.codecogs.com/gif.latex?%5Ctextbf%7Bx%7D_k%20%3D%20%5Ctextbf%7BK%7D_%7Bk-1%7D%20%5Ctextbf%7Bx%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7BG%7D_%7Bk-1%7D%20%5Ctextbf%7Bu%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7Bw%7D_%7Bk-1%7D)     (1) 
 
 ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7By%7D_k%20%3D%20%5Ctextbf%7BH%7D_k%20%5Ctextbf%7Bx%7D_k%20&plus;%20%5Ctextbf%7Bv%7D_k)     (2)
 
Burada **x** durum vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X 1'dir. **y** ise çıktı vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_y) X 1'dir. **u**, girdi vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_u) X 1'dir. **w** ve **v** sırasıyla süreç gürültü vektörü ve ölçüm gürültü vektörleridir ve sırasıyla boyutları durum vektörü ve çıktı vektörüyle aynıdır. **F** duruma ait sistem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X ![](https://latex.codecogs.com/gif.latex?n_x)'dir, **G** ise girdinin sistem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X ![](https://latex.codecogs.com/gif.latex?n_u) 'dur. Son olarak **H** gözlem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_y) X ![](https://latex.codecogs.com/gif.latex?n_x)'dir. Burada fark edilmesi gereken şey; gözlem matrisi ve sistem matrisi bağımsız elemanlardır ve kare matris oluşturmak zorunda değillerdir, ancak durum matrisi, boyutlarından da anlaşılabileceği üzere, bir kare matris oluşturmalıdır.

### Değişkenler ve Açıklaması

- ![](https://latex.codecogs.com/gif.latex?x) durum vektörü, filtre tarafından tahmin edilecek değerleri tutan vektördür. Yani bu vektörün elemanlarıı, filtreden geçmesi arzu edilenlerdir. Diğer filtre işlemleri baz alındığında genel olarak çıktı, ne elde edilmeye çalışıldığını gösterir ancak durum tahmin probleminde Kalman kullanılıyorsa, durumlar hangi sonucun arzu edildiğini söyler. Örneğin bir yolda giden aracın doğru zamanda doğru yerde olmasını, o aracın hızıyla ilişkilendirirsem; çıktım değil durumum hız olur.

- Çıktı vektörü olan ![](https://latex.codecogs.com/gif.latex?y) ise, ne aranıldığını değil, neyin ölçülebileceğini gösterir. Ölçümler durum nezninden yapılmalı ki, aranılan şeye ne kadar yakın olduğu bilinebilsin. Çıktı vektörünü oluşturan değerler hem matematiksel olarak durumlardan hem de bazı bağımsız ölçüm sistemleri ile hesaplanabilmelidir. Ek olarak bahsedilen bu ölçümler, filtrenin başka hiçbir yerine kullanılmaz.

- ![](https://latex.codecogs.com/gif.latex?u) girdi vektörü, Kalman'ın inceleyenlerce en hata yapmaya veya yanlış anlamaya yatkın olduğu kısımdır. Bu vektör filtreye gelerek sistem dinamiklerini tanımlayan bilgiyi içerir. BU bilgi sensörlerden gelebilir, ancak bu değerler içerisinde rassallığın da barındığına dikkat etmek gerekmektedir. Genel bir deyişle, sistem denklemi (1) ve (2) tanımlandığında, gerekli durumların tanımlanması sonrası, filtredeki durumlar gibi tahmin edilmesi gerekmeyen diğer tüm terimler girdi olarak adlandırılabilir. Örneğin hız durumunun dinamikleri için, ivme ölçümü de bir girdidir.

- ![](https://latex.codecogs.com/gif.latex?v) ve ![](https://latex.codecogs.com/gif.latex?w) yani süreç ve ölçüm vektörleri direkt olarak denklemin ilgili kısımlarında kendilerini göstermez, bunun yerine denkelm içerisindeki rastgeleliği ve/veya gürültüyü modellemek için kullanılır. Bu modelleme kendini farklı şekilde göstebilir. Örneğin temel fizik kurallarında yok sayılabilirken, daha sezgisel şekilde kurulan bir denklemin güvenilirliğine doğrudan etki edebilirler. Bu tip durumlarda, belirgin ölçüde hata sistemde   ![](https://latex.codecogs.com/gif.latex?v) ve ![](https://latex.codecogs.com/gif.latex?w) olarak yer alır. Hatanın bir başka şekli ise, sensöz ölçümlerindeki denklemlerde kullanılan hatadır. İki hata vektörüi sensöz ölçümlerinin sonuç aldığı hatalardır denilebilir. Aslında, bu hata ![](https://latex.codecogs.com/gif.latex?v) 'nin çıktı denkemlerinde yer alan ve hatayı o denkelmlerde gösteren en yaygın halidir. Şu önemlidir ki, bu hata denklemin kendisinde barınmaz, ancak denklemin ölçüm için ne kadar kullanışlı ve güvenilir olduğunu temsil eder ve bu anlamda doğruluğunun ölçümü adına kaynak sağlar. ![](https://latex.codecogs.com/gif.latex?v) ve ![](https://latex.codecogs.com/gif.latex?w) aslında denklem (1) ve (2) içinde barınmaz, ancak süreç ve ölçüm kovaryanslarını
(![](https://latex.codecogs.com/gif.latex?Q), ![](https://latex.codecogs.com/gif.latex?R)) tanımlamak için kullanılırlar ve sıfır ortalamalı hatalar olarak varsayılırlar.

![](https://latex.codecogs.com/gif.latex?F) ,  ![](https://latex.codecogs.com/gif.latex?G) ve ![](https://latex.codecogs.com/gif.latex?H) vektörlerine gelindiğinde ise, bu matrisler üzerinde uğraşılan problemlerle alakalıdır, denklemin ve girdilerin doğrusal durumlarını temsil ederler.

- (https://latex.codecogs.com/gif.latex?F) , durum dinamiğinde durum terimlerinin katsayılarını içerir.

- (https://latex.codecogs.com/gif.latex?G) , durum dinamiğinde girdi terimlerinin katsayılarını içerir.

- (https://latex.codecogs.com/gif.latex?H) ise, durum dinamiğinde çıktı terimlerinin katsayılarını içerir.

Yukarıda bahsedilen 3 matris genelde zamana bağımlı matrislerdir, durum ve girdinin değişiminden etkilenmezler. Buna ek olarak, bir çok problemde bu matrisler sabit kabul edilir.
