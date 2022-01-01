import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/model/quiz.model.dart';

Future fetchData({required int numOfQuest, required String difficulty}) async {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };
  String baseUrl =
      "https://opentdb.com/api.php?amount=${numOfQuest.toString()}&category=9&difficulty=$difficulty&type=multiple";
  final Uri uri = Uri.parse(baseUrl);
  final http.Response response = await client.get(
    uri,
    headers: headers,
  );
  final statusCode = response.statusCode;
  final body = response.body;

  if (statusCode == 200) {
    var modelledData = QuizData.fromJson(jsonDecode(body));
    var quizCode = modelledData.responseCode;
    if (quizCode == 0) {
      var quizData = modelledData.results;
      // print(quizData[0].correctAnswer);
      return quizData;
    }
  }
}
