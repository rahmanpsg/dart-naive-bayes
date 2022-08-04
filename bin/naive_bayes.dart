import 'dart:convert';
import 'dart:io';

import 'package:naive_bayes/naive_bayes.dart';
import 'package:naive_bayes/preprocessing.dart';

void main(List<String> arguments) async {
  final naiveBayes = NaiveBayes();
  final preprocessing = Preprocessing();

  final json =
      File('${Directory.current.path}/assets/dataset.json').readAsStringSync();
  final map = jsonDecode(json);

  int i = 0;

  for (var json in map) {
    final tokens = (await preprocessing.preprocess(json['text'])).split(' ');
    final category = getCategory(json['label']);
    naiveBayes.learn(tokens, category);

    i++;
    print(i);
  }

  print('Data loaded : $i');

  File file = File('${Directory.current.path}/assets/data.json');
  file.createSync();

  file.writeAsStringSync(naiveBayes.toJson());
}

String getCategory(int index) {
  switch (index) {
    case 1:
      return 'Ujaran Kebencian';
    default:
      return 'Bukan Ujaran Kebencian';
  }
}
