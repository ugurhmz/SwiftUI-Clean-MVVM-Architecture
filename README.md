# 🎬 SwiftUI MVVM - Modern Movie App

Bu proje, **The Movie Database (TMDB)** API'sini kullanarak popüler filmleri listeleyen, **iOS 16+** standartlarına uygun, ölçeklenebilir ve modern bir iOS uygulamasıdır.

Proje geliştirilirken **Clean Architecture**, **MVVM (Model-View-ViewModel)** desenleri ve **Protocol-Oriented Programming** prensipleri temel alınmıştır. Performans (Infinite Scroll, Image Caching) ve güvenlik (API Key Protection) konularına production-level çözümler üretilmiştir.

## 🏗 Mimari ve Tasarım Desenleri

Bu projemiz Separation of Concerns prensibiyle tasarlanmış, ölçeklenebilir iOS film uygulamasıdır. Karmaşıklığı yönetmek ve modüler büyümeyi (örn: TV Series, Cast entegrasyonları) desteklemek amacıyla Feature-Based klasörleme yapısı ve katmanlı mimari (Clean Architecture & MVVM) kullanılarak geliştirilmiştir.

- MVVM (Model–View–ViewModel)
- Dependency Injection (Bağımlılık Enjeksiyonu)
- Repository / Service Pattern
- DTO (Data Transfer Object) & Mapper Pattern
- Router / Endpoint Pattern (Protocol-Oriented Networking)
- Observer Pattern
- Adapter / Wrapper Pattern
- Actor Model (Concurrency)

### Veri Akış Şeması
<img width="1536" height="1024" alt="flowdata" src="https://github.com/user-attachments/assets/157d4eeb-9c67-4ed9-b3e3-eb9b41333577" />



## 📂 Klasör Yapısı (Folder Structure)

Proje, "Feature-Based" (Özellik Bazlı) bir klasörleme yapısına sahiptir. Bu sayede proje büyüdükçe (örn: Diziler, Oyuncular eklendikçe) karmaşıklık yönetilebilir kalır.

```text
SwiftUI-MVMM
├── Secrets.xcconfig               # API Key'lerin saklandığı gizli dosya
├── SwiftUI-MVMM
│   ├── App
│   │   ├── Assets.xcassets        # Görsel materyaller ve renkler
│   │   └── SwiftUI_MVMMApp.swift  # Uygulama giriş noktası (@main)
│   │
│   ├── Core                       # Uygulamanın genel çekirdek yapıları
│   │   ├── Constants
│   │   │   └── APIConstants.swift # Base URL ve Token yönetimi
│   │   └── Networking             # Ağ katmanı
│   │       ├── EndpointProtocol.swift
│   │       ├── NetworkError.swift
│   │       └── NetworkManager.swift
│   │
│   ├── Data                       # Ham veri katmanı
│   │   ├── Models
│   │   │   └── MovieResponseModel.swift # Backend'den gelen ham JSON modeli
│   │   └── MoviesEndpoint.swift   # API Endpoint tanımları
│   │
│   └── Features                   # Özellik bazlı modüller (Scalable Part)
│       └── Movies
│           ├── Mappers            # Data -> Domain dönüşümü
│           │   └── MovieMapper.swift
│           ├── Models             # UI için optimize edilmiş DTO'lar
│           │   └── MovieDTO.swift
│           ├── ViewModels         # Business Logic & State Management
│           │   └── MoviesViewModel.swift
│           ├── Views              # UI Katmanı
│           │   ├── Components     # Parçalanmış UI bileşenleri
│           │   │   ├── MoviePosterView.swift
│           │   │   └── MovieRowView.swift
│           │   └── MovieListView.swift
│           └── Services           # Feature'a özel servis çağrıları
│               └── MovieService.swift
│
└── Info.plist

```

## 🚀 Öne Çıkan Özellikler

* **Infinite Scroll (Pagination):** Kullanıcı listeyi kaydırdıkça veriler performanslı bir şekilde yüklenir. "Threshold" (Eşik) kontrolü ve yapay zeka destekli yükleme indikatörü içerir.
* **Image Caching (Kingfisher):** Görseller disk ve bellek üzerinde önbelleklenir. Kaydırma performansı (FPS) maksimize edilmiştir.
* **Secure API Key Management:** API Token'ları kod içinde (Hardcoded) tutulmaz. `.xcconfig` dosyası üzerinden okunur ve GitHub'a pushlanmaz.
* **Modern UI (iOS 16+):** `NavigationStack`, `Task` ve modern List yapıları kullanılmıştır.
* **Error Handling:** Kullanıcı dostu hata mesajları ve "Tekrar Dene" mekanizması.

## 🛠 Kullanılan Teknolojiler
* **Dil:** Swift 5
* **UI Framework:** SwiftUI (NavigationStack)
* **Minimum Target:** iOS 16.0
* **Networking:** Alamofire & Async/Await (Generic Network Layer)
* **Image Loading:** Kingfisher (Disk & Memory Cache)
* **Architecture:** MVVM (Feature-Based & Protocol-Oriented)
* **Concurrency:** Swift Concurrency (Task, Actor, MainActor)
* **Data Format:** JSON (Codable / Decodable)

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
