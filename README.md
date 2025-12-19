# 🎬 SwiftUI MVVM - Modern Movie App

Bu proje, **The Movie Database (TMDB)** API'sini kullanarak popüler filmleri listeleyen, **iOS 16+** standartlarına uygun, ölçeklenebilir ve modern bir iOS uygulamasıdır.

Proje geliştirilirken **Clean Architecture**, **MVVM (Model-View-ViewModel)** desenleri ve **Protocol-Oriented Programming** prensipleri temel alınmıştır. Performans (Infinite Scroll, Image Caching) ve güvenlik (API Key Protection) konularına production-level çözümler üretilmiştir.

## 🏗 Mimari ve Tasarım Desenleri

Proje, sorumlulukların net bir şekilde ayrıldığı (Separation of Concerns) katmanlı bir yapıya sahiptir:

* **MVVM (Model-View-ViewModel):** UI ve İş mantığı (Business Logic) birbirinden tamamen ayrılmıştır.
* **Protocol-Oriented Network Layer:** Ağ katmanı, test edilebilir ve mocklanabilir `Protocol` yapıları üzerine kurulmuştur.
* **DTO (Data Transfer Object) Pattern:** API'den gelen ham veri (`ResponseModel`) ile UI'ın ihtiyaç duyduğu veri (`MovieDTO`) birbirinden ayrılmış, arada bir **Mapper** katmanı kullanılmıştır.
* **Dependency Injection:** Servisler ve ViewModel'ler, dışarıdan enjekte edilebilir şekilde tasarlanmıştır.

### Veri Akış Şeması

`API (JSON) -> ResponseModel -> Mapper -> MovieDTO -> ViewModel -> View`

## 📂 Klasör Yapısı (Folder Structure)

Proje, "Feature-Based" (Özellik Bazlı) bir klasörleme yapısına sahiptir. Bu sayede proje büyüdükçe (örn: Diziler, Oyuncular eklendikçe) karmaşıklık yönetilebilir kalır.

```text
SwiftUI-MVMM
├── Core
│   ├── Constants
│   │   └── APIConstants.swift    # Base URL ve Secure Token yönetimi
│   └── Extensions
│       └── ...
├── Features
│   └── Movies
│       ├── Models
│       │   ├── MovieDTO.swift    # UI katmanı için temizlenmiş model
│       │   └── MovieMapper.swift # Response -> DTO dönüşüm katmanı
│       ├── ViewModels
│       │   └── MoviesViewModel.swift # State yönetimi ve Pagination lojiği
│       ├── Views
│       │   ├── Components
│       │   │   ├── MovieRowView.swift      # Liste elemanı tasarımı
│       │   │   ├── MoviePosterView.swift   # Kingfisher destekli resim bileşeni
│       │   │   └── MovieFooterLoader.swift # Sonsuz kaydırma yükleyicisi
│       │   └── MovieListView.swift         # Ana liste ekranı
│       └── Services
│           └── MovieService.swift # Film özelindeki API çağrıları
├── Services (Network Layer)
│   ├── NetworkManager.swift       # Generic Network Request yapısı (Alamofire)
│   ├── EndpointProtocol.swift     # URL yönetimi için Protocol
│   ├── NetworkError.swift         # Hata yönetimi
│   └── Models
│       └── MovieResponseModel.swift # API'den dönen ham veri (Codable)
└── Application
    └── SwiftUI_MVMMApp.swift

```

## 🚀 Öne Çıkan Özellikler

* **Infinite Scroll (Pagination):** Kullanıcı listeyi kaydırdıkça veriler performanslı bir şekilde yüklenir. "Threshold" (Eşik) kontrolü ve yapay zeka destekli yükleme indikatörü içerir.
* **Image Caching (Kingfisher):** Görseller disk ve bellek üzerinde önbelleklenir. Kaydırma performansı (FPS) maksimize edilmiştir.
* **Secure API Key Management:** API Token'ları kod içinde (Hardcoded) tutulmaz. `.xcconfig` dosyası üzerinden okunur ve GitHub'a pushlanmaz.
* **Modern UI (iOS 16+):** `NavigationStack`, `Task` ve modern List yapıları kullanılmıştır.
* **Error Handling:** Kullanıcı dostu hata mesajları ve "Tekrar Dene" mekanizması.

## 🛠 Kullanılan Teknolojiler

* **Dil:** Swift 5
* **UI Framework:** SwiftUI
* **Minimum Target:** iOS 16.0
* **Networking:** Alamofire & Async/Await
* **Image Loading:** Kingfisher
* **Concurrency:** Swift Concurrency (Task, Actor, MainActor)

## 🔒 Kurulum ve Güvenlik (Önemli)

Bu proje API anahtarlarını gizlemek için `.xcconfig` dosyası kullanır. Projeyi çalıştırmak için:

1. Projeyi klonlayın.
2. Ana dizinde (Project Root) `Secrets.xcconfig` adında bir dosya oluşturun.
3. İçerisine kendi TMDB API Token'ınızı ekleyin:
```text
TMDB_TOKEN = sizin_uzun_bearer_tokeniniz_buraya

```


4. Projeyi derleyin (`Cmd + R`).

---

### 👨‍💻 Geliştirici Notları

Bu proje; modülerlik, okunabilirlik ve performans ön planda tutularak, gerçek bir production uygulamasının sahip olması gereken standartlarda geliştirilmiştir. **Magic String** ve **Magic Number** kullanımından kaçınılmış, `Enum` ve `Constant` yapıları tercih edilmiştir.
