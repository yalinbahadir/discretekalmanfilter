# Gereksinimler

  MATLAB

# Kalman Filtresi

## 1. Giriş


Filtrelerin genel operasyon prensibi, bir denklem veya olay sonucundan istenilen parçaların en iyi şekilde elde edilmesi veya istenilmeyen parçaların olay sonucu gözlenecek verinin dışında tutulması olarak özetlenebilir. Örneğin düşük bant filtresi, denklem içerisindeki yüksek frekansa sahip parçaları, filtrenin operasyonu sonrası gözlemememizi sağlar. Kalman da aynı bu tip bir filtre gibi davranır, gerekli bilgi içerisine geçmiş olan hata/rassallık veya kesinlik barındırmayan parçaları filtre sonrasında elimine etmeyi ya da işlemin ön gördüğü doğrultuda yeteri kadar azaltmayı amaçlar. Ek olarak Kalman, üzerinde uğraşılan probleme göre, zamana bağlı veya iterasyona bağlı bir metottur. Yani uygulanmaya başlamadan önce 'ne zaman' duracağı veya 'hangi adımda' duracağı belirlenmelidir.

Kalman Filtresi sistemi üzerinde çalışmak için doğrusal durum uzayı formatında tasarlanır:

 ![1](https://latex.codecogs.com/gif.latex?%5Ctextbf%7Bx%7D_k%20%3D%20%5Ctextbf%7BK%7D_%7Bk-1%7D%20%5Ctextbf%7Bx%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7BG%7D_%7Bk-1%7D%20%5Ctextbf%7Bu%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7Bw%7D_%7Bk-1%7D)     (1) 
 
 ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7By%7D_k%20%3D%20%5Ctextbf%7BH%7D_k%20%5Ctextbf%7Bx%7D_k%20&plus;%20%5Ctextbf%7Bv%7D_k)     (2)
 
Burada **x** durum vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X 1'dir. **y** ise çıktı vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_y) X 1'dir. **u**, girdi vektörüdür ve boyutu ![](https://latex.codecogs.com/gif.latex?n_u) X 1'dir. **w** ve **v** sırasıyla süreç gürültü vektörü ve ölçüm gürültü vektörleridir ve sırasıyla boyutları durum vektörü ve çıktı vektörüyle aynıdır. **F** duruma ait sistem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X ![](https://latex.codecogs.com/gif.latex?n_x)'dir, **G** ise girdinin sistem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_x) X ![](https://latex.codecogs.com/gif.latex?n_u) 'dur. Son olarak **H** gözlem matrisidir ve boyutu ![](https://latex.codecogs.com/gif.latex?n_y) X ![](https://latex.codecogs.com/gif.latex?n_x)'dir. Burada fark edilmesi gereken şey; gözlem matrisi ve sistem matrisi bağımsız elemanlardır ve kare matris oluşturmak zorunda değillerdir, ancak durum matrisi, boyutlarından da anlaşılabileceği üzere, bir kare matris oluşturmalıdır.

### 1.1 Değişkenler ve Açıklamaları

- ![](https://latex.codecogs.com/gif.latex?x) durum vektörü, filtre tarafından tahmin edilecek değerleri tutan vektördür. Yani bu vektörün elemanlarıı, filtreden geçmesi arzu edilenlerdir. Diğer filtre işlemleri baz alındığında genel olarak çıktı, ne elde edilmeye çalışıldığını gösterir ancak durum tahmin probleminde Kalman kullanılıyorsa, durumlar hangi sonucun arzu edildiğini söyler. Örneğin bir yolda giden aracın doğru zamanda doğru yerde olmasını, o aracın hızıyla ilişkilendirirsem; çıktım değil durumum hız olur.

- Çıktı vektörü olan ![](https://latex.codecogs.com/gif.latex?y) ise, ne aranıldığını değil, neyin ölçülebileceğini gösterir. Ölçümler durum nezninden yapılmalı ki, aranılan şeye ne kadar yakın olduğu bilinebilsin. Çıktı vektörünü oluşturan değerler hem matematiksel olarak durumlardan hem de bazı bağımsız ölçüm sistemleri ile hesaplanabilmelidir. Ek olarak bahsedilen bu ölçümler, filtrenin başka hiçbir yerine kullanılmaz.

- ![](https://latex.codecogs.com/gif.latex?u) girdi vektörü, Kalman'ın inceleyenlerce en hata yapmaya veya yanlış anlamaya yatkın olduğu kısımdır. Bu vektör filtreye gelerek sistem dinamiklerini tanımlayan bilgiyi içerir. BU bilgi sensörlerden gelebilir, ancak bu değerler içerisinde rassallığın da barındığına dikkat etmek gerekmektedir. Genel bir deyişle, sistem denklemi (1) ve (2) tanımlandığında, gerekli durumların tanımlanması sonrası, filtredeki durumlar gibi tahmin edilmesi gerekmeyen diğer tüm terimler girdi olarak adlandırılabilir. Örneğin hız durumunun dinamikleri için, ivme ölçümü de bir girdidir.

- ![](https://latex.codecogs.com/gif.latex?v) ve ![](https://latex.codecogs.com/gif.latex?w) yani süreç ve ölçüm vektörleri direkt olarak denklemin ilgili kısımlarında kendilerini göstermez, bunun yerine denkelm içerisindeki rastgeleliği ve/veya gürültüyü modellemek için kullanılır. Bu modelleme kendini farklı şekilde göstebilir. Örneğin temel fizik kurallarında yok sayılabilirken, daha sezgisel şekilde kurulan bir denklemin güvenilirliğine doğrudan etki edebilirler. Bu tip durumlarda, belirgin ölçüde hata sistemde   ![](https://latex.codecogs.com/gif.latex?v) ve ![](https://latex.codecogs.com/gif.latex?w) olarak yer alır. Hatanın bir başka şekli ise, sensöz ölçümlerindeki denklemlerde kullanılan hatadır. İki hata vektörüi sensöz ölçümlerinin sonuç aldığı hatalardır denilebilir. Aslında, bu hata ![](https://latex.codecogs.com/gif.latex?v) 'nin çıktı denkemlerinde yer alan ve hatayı o denkelmlerde gösteren en yaygın halidir. Şu önemlidir ki, bu hata denklemin kendisinde barınmaz, ancak denklemin ölçüm için ne kadar kullanışlı ve güvenilir olduğunu temsil eder ve bu anlamda doğruluğunun ölçümü adına kaynak sağlar. ![](https://latex.codecogs.com/gif.latex?v) ve ![](https://latex.codecogs.com/gif.latex?w) aslında denklem (1) ve (2) içinde barınmaz, ancak süreç ve ölçüm kovaryanslarını
(![](https://latex.codecogs.com/gif.latex?Q), ![](https://latex.codecogs.com/gif.latex?R)) tanımlamak için kullanılırlar ve sıfır ortalamalı hatalar olarak varsayılırlar.

![](https://latex.codecogs.com/gif.latex?F) ,  ![](https://latex.codecogs.com/gif.latex?G) ve ![](https://latex.codecogs.com/gif.latex?H) vektörlerine gelindiğinde ise, bu matrisler üzerinde uğraşılan problemlerle alakalıdır, denklemin ve girdilerin doğrusal durumlarını temsil ederler.

- ![](https://latex.codecogs.com/gif.latex?F) , durum dinamiğinde durum terimlerinin katsayılarını içerir.

- ![](https://latex.codecogs.com/gif.latex?G) , durum dinamiğinde girdi terimlerinin katsayılarını içerir.

- ![](https://latex.codecogs.com/gif.latex?H) ise, durum dinamiğinde çıktı terimlerinin katsayılarını içerir.

Yukarıda bahsedilen 3 matris genelde zamana bağımlı matrislerdir, durum ve girdinin değişiminden etkilenmezler. Buna ek olarak, bir çok problemde bu matrisler sabit kabul edilir.

## 2. Kalman Filtre Algoritması

Kalman Filtresi, filtrenin durumlarını tanımlamak için tahmini takip eden doğrulama sürecinden oluşan bir yinelemeli, bir başka deyişle iteratif, bir yöntemdir. Bazen bu süreç tahminleyici-doğrulayıcı veya tahminleyici-güncelleyici olarak da anılır. Kalman Filtresi'nin temel çalışma mantığı şu şekilde ilerler: "Eğer daha önce nerede olduğum biliniyorsa ve hangi hızla gittiğim belliyse, bir sonraki varacağım noktayı tahmin edebilirim." Bu örnekte 'daha önce nerede olduğum' kısmı, Kalman notasyonunda 'önceki durum', 'gittiğim hız' durum dinamiği ve 'bir sonraki varacağım nokta' ise bir sonraki durum olarak nitelendirilir.

Başlangıç durum tahmini, ![](https://latex.codecogs.com/gif.latex?%5Chat%7Bx%7D_0) ve başlangıç kovaryans matrisi ![](https://latex.codecogs.com/gif.latex?P_0), tahmin-düzeltme formatı yinelenerek her adımda uygulanır. İlk olarak durum vektörü, durum dinamiği denklemi kullanılarak tahmin edilir.

  ![](https://latex.codecogs.com/gif.latex?%5Chat%7B%5Ctextbf%7Bx%7D%7D_%7Bk%7C%7Bk-1%7D%7D%20%3D%20%5Ctextbf%7BF%7D_%7Bk-1%7D%20.%20%5Chat%7B%5Ctextbf%7Bx%7D%7D_%7Bk-1%7D%20&plus;%20%5Ctextbf%7BG%7D_%7Bk-1%7D%20.%20%5Ctextbf%7Bu%7D)     (3)
  
  Burada ![](https://latex.codecogs.com/gif.latex?%5Chat%7B%5Ctextbf%7Bx%7D%7D_%7Bk%7C%7Bk-1%7D%7D) bir önceki adımda tahmin edilmiş durum vektörüdür, yani 'k-1 inci adımdaki sonuca göre k ıncı x' olarak adlandırılabilir. ![](https://latex.codecogs.com/gif.latex?%5Chat%7B%5Ctextbf%7Bx%7D%7D_%7Bk-1%7D) ise bir önceki adımda tahmin edilmiş durum vektörüdür. Yukarıdaki (3) denklem sonrasında ise, durum hata kovaryansı da tahmin edilmelidir:
  
  ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_%7Bk%7C%7Bk-1%7D%7D%20%3D%20%5Ctextbf%7BF%7D_%7Bk-1%7D%20%5Ctextbf%7BP%7D_%7Bk-1%7D%20%5Ctextbf%7BF%7D%5ET_%7Bk-1%7D%20&plus;%20%5Ctextbf%7BQ%7D_%7Bk-1%7D)     (4)
  
  Burada ise ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_%7Bk%7C%7Bk-1%7D%7D) önceki adımda tahmin edilmiş hata kovaryansı baz alınarak, mevcut adımda tahmin edilen hata kovaryansını temsil eder. ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_%7Bk-1%7D) bir önceki tahminde durum hata kovaryans matrisini gösterir ve son olarak ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BQ%7D) süreç gürültüsünün kovaryans matrisidir. Tahmin edilmesi gereken değerler hesaplandıktan sonra Kalman Kazancı da hesaplanabilir: 
  
  ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BK%7D_k%20%3D%20%5Ctextbf%7BP%7D_%7Bk%7C%7Bk-1%7D%7D%20%5Ctextbf%7BH%7D%5ET_k%20%28%5Ctextbf%7BH%7D_k%20%5Ctextbf%7BP%7D_%7Bk%7C%7Bk-1%7D%7D%20%5Ctextbf%7BH%7D%5ET_k%20&plus;%20%5Ctextbf%7BR%7D_k%29%5E%7B-1%7D)     (5)
  
  ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BH%7D) matrisi, çıktı denklemini tanımlamak için gereklidir ve ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BR%7D) ise ölçüm gürültüsünün kovaryansını temsil eder. Bu adım sonrasında, durum vektörü bir 'yenileme' ile güncellenir. Basitçe bu yenileme işeminde, eski durum vektörü üzerine Kalman Kazancı ile çıktının ölçümü, ki biz buna denklemde ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7Bz%7D_k) diyeceğiz, ve tahmin edilen çıktı ölçeklendirilir:
  
  ![](https://latex.codecogs.com/gif.latex?%5Chat%7B%5Ctextbf%7Bx%7D%7D_k%20%3D%20%5Chat%7B%5Ctextbf%7Bx%7D%7D_%7Bk%7C%7Bk-1%7D%7D%20&plus;%20%5Ctextbf%7BK%7D_k%28%5Ctextbf%7Bz%7D_k%20-%20%5Ctextbf%7BH%7D_k%20.%20%5Chat%7B%5Ctextbf%7Bx%7D%7D_%7Bk%7C%7Bk-1%7D%7D%29)     (6)
  
  Benzer durumda, yani sürecin geldiği mevcut noktada, hata kovaryansının da güncellenmesi gerekir:
  
  ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_k%20%3D%20%28%5Ctextbf%7BI%7D%20-%20%5Ctextbf%7BK%7D_k%5Ctextbf%7BH%7D_k%29%20%5Ctextbf%7BP%7D_%7Bk%7C%7Bk-1%7D%7D)     (7)
  
  Burada kullanılan ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BI%7D) birim matristir.
  
  ## 3. Gürültü Kovaryanslarının Etkileri
  
  ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BQ%7D%2C%5Ctextbf%7BR%7D) ve ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_0) kovaryans matrisleri seçimleri Kalman Filtresinin tahmin performansı açısından yüksek önem arz edebilir. İlk olarak ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_0) 'ın seçimine dikkat edersek, başlangıç durumunda filtrenin anlamlanması açısından önemlidir ve genelde bu matris süreç içerisinde çok fazla önem taşımaz; hatta başlangıç sürecinin kolaylanabilirliği açısından ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_0) matrisi birim matris olarak alınır. Fakat, geriye kalan iki kovaryans matrisi ,![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BQ%7D%2C%5Ctextbf%7BR%7D) ve ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BP%7D_0), filtrenin genel performansı üzerinde çok daha büyük etkiye sahiptir. Bunun en basit yoldan görülebileceği yer, bu denklemlerin tahmin (durum) ve ölçüm (çıktı) denklemleri üzerindeki ağırlaştırma faktörlerini gözlemlemektir. Bu oran, Kalman kazancı denkleminde(5) açıkça görülebilir. Yüksek değere sahip olan bir ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BQ%7D) durum denklemlerinde yüksek rastgeleliğe sahip olacaktır; bu, kullanıldığı denklemlerdeki sonucun güvenilirliğini arttıracaktır ve bunun sonucunda da ölçüm güncellemesi daha doğru yapılacaktır. Öte yandan, ![](https://latex.codecogs.com/gif.latex?%5Ctextbf%7BR%7D) için aynı senaryo düşünüldüğünde filtre, ölçüm güncellemesi konusundan daha hatalı sonuç barındıracaktır. Yani kısaca, süreç gürültüsünün kovaryans matrisi arttıkça, güncellemenin güvenilirliği artacak; ölçüm gürültüsünün kovaryans matrisi arttıkça, güncellemenin güvenilirliği azalacaktır.
  
  ## 4. Sonuç
  
  Kalman Filtresi, görüldüğü üzere, diğer filtreler gibi isteneni sürecin dışında tutma, istenmeyeni ise süreçten uzaklaştırma özelliğine sahiptir. Bu filtrenin fonksiyonunun diğerlerine göre, örneğin en küçük kareleri hesaplama yöntemi, daha karışık olmasının sebebi ise stokastik kuramı içinde barındırıyor oluşudur, fakat bu kuram aynı zamanda filtrenin gündelik hayatta daha kullanışlı olmasını sağlar. Kullanılan uygulamaların çoğunun sayısal bilgisayarlarda olması sebebiyle, sürekli zamanda kullanılan Kalman filtresi bir çok uygulamada pratik değildir. Ancak bu, sürekli sistemlere sayısal Kalman Filtresi ile yaklaşılamayacağı anlamına gelmez. Bunun ötesinde, Kalman Filtresi yalnızca doğrusal sistemlere uygulanabileceğinden, doğrusal olmayan sistemler içerisinde 'Geliştirilmiş Kalman Filtresi' kullanılabilir.
