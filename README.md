# Flutter Persistence Learning App

> **Aplikasi pembelajaran untuk memahami berbagai teknik persistensi data di Flutter**

## 📚 Deskripsi Project

Project ini adalah aplikasi pembelajaran yang mendemonstrasikan berbagai metode persistensi data dalam Flutter, mulai dari yang sederhana hingga yang kompleks. Aplikasi ini mengimplementasikan 3 teknik utama penyimpanan data:

1. **SharedPreferences** - untuk data konfigurasi sederhana
2. **File Storage** - untuk penyimpanan file eksternal
3. **SQLite Database** - untuk data relasional yang kompleks

## 🚀 Fitur Utama

### 🔐 **Sistem Login & Session Management**

- Login dengan username dan password
- Persistensi status login menggunakan SharedPreferences
- Auto-login untuk user yang sudah pernah login

### 📊 **Counter dengan File Storage**

- Counter sederhana yang tersimpan dalam file eksternal
- File dapat diakses melalui aplikasi Files bawaan Android
- Implementasi dengan `path_provider`

### 👥 **Student Management (CRUD dengan SQLite)**

- Create: Tambah data mahasiswa baru
- Read: Tampilkan daftar semua mahasiswa
- Update: Edit data mahasiswa yang sudah ada
- Delete: Hapus data mahasiswa dengan konfirmasi

## 🏗️ Struktur Project

```
lib/
├── main.dart                    # Entry point aplikasi
├── pages/
│   ├── login_page.dart         # Halaman login
│   ├── home_page.dart          # Halaman utama dengan counter
│   └── student_page.dart       # Halaman CRUD mahasiswa
└── data/
    ├── user.dart               # Model User
    ├── student.dart            # Model Student
    ├── local_data.dart         # SharedPreferences handler
    ├── counter_storage.dart    # File storage handler
    └── sqlite_data.dart        # SQLite database handler
```

## 📱 Screenshot & Navigasi

### Flow Aplikasi:

1. **Login Page** → Input username/password
2. **Home Page** → Counter + logout + navigasi ke Student Page
3. **Student Page** → CRUD operations untuk data mahasiswa

## 🛠️ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.5.3 # Untuk SharedPreferences
  path_provider: ^2.1.5 # Untuk File Storage
  sqflite: ^2.4.2 # Untuk SQLite Database
  path: ^1.9.1 # Untuk path operations
  change_app_package_name: ^1.5.0
```

## 📚 Konsep Pembelajaran

### 1. **SharedPreferences**

**Kapan digunakan:** Data konfigurasi sederhana, settings, flags

```dart
// Simpan data
final prefs = await SharedPreferences.getInstance();
await prefs.setString('username', 'john_doe');

// Ambil data
String? username = prefs.getString('username');
```

**Implementasi di project:**

- Status login (`isLoggedIn`)
- Data user yang login
- Counter value (backup)

### 2. **File Storage**

**Kapan digunakan:** File yang perlu diakses user, export data, cache

```dart
// Dapatkan direktori
final directory = await getExternalStorageDirectory();
final file = File('${directory!.path}/counter.txt');

// Tulis file
await file.writeAsString('42');

// Baca file
String contents = await file.readAsString();
```

**Implementasi di project:**

- Penyimpanan nilai counter dalam file `counter.txt`
- File dapat diakses melalui aplikasi Files Android

### 3. **SQLite Database**

**Kapan digunakan:** Data relasional, query kompleks, data terstruktur

```dart
// Buat tabel
await db.execute(
  'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)'
);

// Insert data
await db.insert('students', student.toMap());

// Query data
List<Map<String, dynamic>> maps = await db.query('students');
```

**Implementasi di project:**

- Tabel `students` untuk data mahasiswa
- Operasi CRUD lengkap
- Model `Student` dengan serialization

## 🎯 Tujuan Pembelajaran

Setelah mempelajari project ini, Anda akan memahami:

1. **Kapan menggunakan metode persistensi yang tepat**
2. **Cara implementasi SharedPreferences untuk data sederhana**
3. **Cara implementasi File Storage untuk file eksternal**
4. **Cara implementasi SQLite untuk data relasional**
5. **Best practices dalam persistensi data Flutter**
6. **Error handling dalam operasi I/O**

## 🚀 Cara Menjalankan

### Prerequisites

- Flutter SDK (3.9.0+)
- Android Studio / VS Code
- Android device/emulator atau iOS Simulator

### Langkah-langkah:

1. **Clone/Download project**

   ```bash
   git clone [repository-url]
   cd flutter_shared_preferences_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

### 🔑 **Login Credentials:**

- Username: `admin`, Password: `admin`
- Username: `user`, Password: `user`

## 📂 File Locations

### Android:

- **SQLite Database:** `/data/data/[package_name]/databases/schools.db`
- **SharedPreferences:** `/data/data/[package_name]/shared_prefs/`
- **Counter File:** `/storage/emulated/0/Android/data/[package_name]/files/counter.txt`

### iOS:

- **Files:** Application Documents Directory
- **Database & Preferences:** Application Support Directory

## 🔧 Fitur Teknis

### Error Handling

- Try-catch untuk operasi database
- Fallback values untuk data yang tidak ditemukan
- Validasi input sebelum menyimpan data

### State Management

- setState() untuk update UI
- Proper lifecycle management
- Data refresh setelah operasi CRUD

### UI/UX

- Material Design components
- Responsive layout
- Dialog confirmations untuk operasi sensitif
- Loading states untuk operasi async

## 📈 Pengembangan Selanjutnya

Ide untuk mengembangkan project ini:

1. **Tambahkan state management** (Provider, Riverpod, Bloc)
2. **Implementasi backup/restore** data
3. **Tambahkan search & filter** di Student Page
4. **Implementasi pagination** untuk data besar
5. **Tambahkan validasi** input yang lebih robust
6. **Implementasi dark/light theme** dengan SharedPreferences
7. **Tambahkan unit & integration tests**

## 🤝 Kontribusi

Project ini dibuat untuk tujuan pembelajaran. Silakan:

- Fork dan eksperimen dengan kode
- Tambahkan fitur baru
- Perbaiki bug yang ditemukan
- Share knowledge dengan teman-teman

## 📝 Catatan Penting

- **Data SQLite** akan hilang saat app di-uninstall
- **File counter.txt** dapat diakses via Files app di Android
- **SharedPreferences** otomatis tersimpan saat app di-close
- **Selalu handle error** untuk operasi I/O
- **Test di real device** untuk memastikan file storage bekerja

## 📖 Referensi

- [Flutter Persistence Documentation](https://docs.flutter.dev/cookbook/persistence)
- [SharedPreferences Package](https://pub.dev/packages/shared_preferences)
- [Path Provider Package](https://pub.dev/packages/path_provider)
- [SQFlite Package](https://pub.dev/packages/sqflite)

---

**Happy Learning! 🎓✨**

> Dibuat untuk pembelajaran Flutter persistence dengan implementasi praktis dan real-world use cases.
