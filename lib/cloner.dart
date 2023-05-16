import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dotenv/dotenv.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

enum ArhieveType {
  zip('zipball', 'zip'),

  // For now, therse is an issue download as tar (some files are misplaced)
  tar('tarball', 'tar.gz');

  final String apiValue;
  final String fileExtension;

  const ArhieveType(this.apiValue, this.fileExtension);
}

class Cloner {
  /// GitHub Owner
  final String owner;

  /// GitHub Repository
  final String repo;

  Cloner({required this.owner, required this.repo});

  Future<String?> downladArchive(
      {ArhieveType arhieveType = ArhieveType.zip}) async {
    var env = DotEnv()..load();

    final response = await http.get(
      Uri.parse(
          'https://api.github.com/repos/$owner/$repo/${arhieveType.apiValue}/'),
      headers: {
        "Accept": "application/vnd.github+json",
        "Authorization": 'Bearer ${env['GITHUB_PAT']}',
        "X-GitHub-Api-Version": "2022-11-28",
      },
    );
    print('Received');
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // Get the temporary directory path
      final tempFilePath =
          p.join(p.current, 'temp_zip', 'archive.${arhieveType.fileExtension}');

      // Save the downloaded tar file to the temporary directory
      await File(tempFilePath).create(recursive: true);
      await File(tempFilePath).writeAsBytes(bytes);

      // Extract the tar file to the device folder
      final extractPath = p.join(p.current, 'out');
      await extractFileToDisk(tempFilePath, extractPath);

      // Delete the temporary tar file
      // await File(tempFilePath).delete();

      return extractPath;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to download the tar file');
    }
  }
}
