import 'package:flutter/cupertino.dart';
import 'package:quiz_app/model/quiz.model.dart';

class QuizServices extends ChangeNotifier {
  List<Result> quizData = [];
  Map<int, List<String>> answers = {};
  int correctIdx = 6;
  int falseIdx = 6;
  int score = 0;
  bool isTapAnswerAllowed = true;

  updateQuizData(List<Result> data) {
    quizData = [...data];
    for (var i = 0; i < quizData.length; i++) {
      answers[i] = [
        quizData[i].correctAnswer,
        ...quizData[i].incorrectAnswers,
      ];
      answers[i]!.shuffle();
    }
    // print(answers);
    notifyListeners();
  }

  updateCorrectIdx(value) {
    correctIdx = value;
    notifyListeners();
  }

  updateFalseIdx(value) {
    falseIdx = value;
    notifyListeners();
  }
}
