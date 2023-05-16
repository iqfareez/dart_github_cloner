import 'package:dart_github_cloner/cloner.dart';

void main(List<String> arguments) async {
  Cloner cloner = Cloner(owner: 'iqfareez', repo: 'masjidTV-waktusolat');

  var savedLoc = await cloner.downladArchive();
  print(savedLoc);
}
