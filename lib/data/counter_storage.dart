import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CounterStorage {
  Future<String> get _localPath async {
    // Untuk Android, kita akan menggunakan getExternalStorageDirectory()
    // yang tidak memerlukan permission khusus pada Android 10+
    Directory directory;

    if (Platform.isAndroid) {
      try {
        // Coba gunakan external storage directory dulu
        directory =
            await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      } catch (e) {
        // Fallback ke application documents directory
        directory = await getApplicationDocumentsDirectory();
      }
    } else {
      // Untuk platform lain (iOS, etc), gunakan documents directory
      directory = await getApplicationDocumentsDirectory();
    }

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
}
