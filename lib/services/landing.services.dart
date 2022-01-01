import 'package:flutter/cupertino.dart';

class LandingServices extends ChangeNotifier {
  bool isLoading = false;
  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // number of questions controlls:
  int selectedNumOfQuest = 0;
  List<bool> numOfQuestTabs = List.filled(2, false);
  updateNumOfQuestTabs(index) {
    for (var i = 0; i < numOfQuestTabs.length; i++) {
      numOfQuestTabs[i] = false;
    }
    numOfQuestTabs[index] = true;
    notifyListeners();
  }

  // difficulty controlls:
  String selecteddifficulty = "";
  List<bool> difficultyTabs = List.filled(3, false);
  updatedifficultyTabs(index) {
    for (var i = 0; i < difficultyTabs.length; i++) {
      difficultyTabs[i] = false;
    }
    difficultyTabs[index] = true;
    notifyListeners();
  }
}
