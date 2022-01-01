// To parse this JSON data, do
//
//     final quizData = quizDataFromJson(jsonString);

import 'dart:convert';

QuizData quizDataFromJson(String str) => QuizData.fromJson(json.decode(str));

String quizDataToJson(QuizData data) => json.encode(data.toJson());

class QuizData {
  QuizData(
    this.responseCode,
    this.results,
  );

  int responseCode;
  List<Result> results;

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        json["response_code"],
        List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result(
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  );

  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        json["category"],
        json["type"],
        json["difficulty"],
        json["question"],
        json["correct_answer"],
        List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "type": type,
        "difficulty": difficulty,
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
      };
}
