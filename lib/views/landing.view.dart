import 'package:flutter/material.dart';
import 'package:quiz_app/api/fetch_data.dart';
import 'package:quiz_app/components/choice_card.dart';
import 'package:quiz_app/const.dart';
import 'package:quiz_app/model/quiz.model.dart';
import 'package:quiz_app/services/landing.services.dart';
import 'package:quiz_app/services/quiz.services.dart';
import 'package:quiz_app/views/quiz.view.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  final LandingServices landingServices = LandingServices();
  final QuizServices quizServices = QuizServices();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Result> data = [];
    return AnimatedBuilder(
        animation: Listenable.merge([landingServices]),
        builder: (context, snapshot) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: GestureDetector(
              onTap: () async {
                if (landingServices.selectedNumOfQuest == 0 ||
                    landingServices.selecteddifficulty == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "make sure to check all the tabs",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                } else {
                  landingServices.updateLoadingStatus(true);
                  data = await fetchData(
                    numOfQuest: landingServices.selectedNumOfQuest,
                    difficulty: landingServices.selecteddifficulty,
                  ).whenComplete(
                    () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(quizData: data),
                        ),
                      );
                      landingServices.updateLoadingStatus(false);
                    },
                  );
                }
              },
              child: Container(
                width: size.width * 0.75,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffCE9D2A),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: landingServices.isLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Load Quiz",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(width: kDefaultPadding),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        gradient: kBackgroundColor,
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Let's start the ",
                                  style: TextStyle(fontSize: 30),
                                ),
                                TextSpan(
                                  text: "Quiz",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding / 4),
                          const Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          const SizedBox(height: kDefaultPadding * 1.5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Number Of Questions: ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                              Row(
                                children: [
                                  const Spacer(flex: 3),
                                  ChoiceCard(
                                    choice: "5",
                                    onPress: () {
                                      landingServices.updateNumOfQuestTabs(0);
                                      landingServices.selectedNumOfQuest = 5;
                                    },
                                    isAcitve: landingServices.numOfQuestTabs[0],
                                  ),
                                  const SizedBox(width: kDefaultPadding),
                                  ChoiceCard(
                                    choice: "10",
                                    onPress: () {
                                      landingServices.updateNumOfQuestTabs(1);
                                      landingServices.selectedNumOfQuest = 10;
                                    },
                                    isAcitve: landingServices.numOfQuestTabs[1],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding * 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Difficulty: ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                              Row(
                                children: [
                                  const Spacer(),
                                  ChoiceCard(
                                    choice: "Easy",
                                    onPress: () {
                                      landingServices.updatedifficultyTabs(0);
                                      landingServices.selecteddifficulty =
                                          "easy";
                                    },
                                    isAcitve: landingServices.difficultyTabs[0],
                                  ),
                                  const SizedBox(width: kDefaultPadding / 2),
                                  ChoiceCard(
                                    choice: "Medium",
                                    onPress: () {
                                      landingServices.updatedifficultyTabs(1);
                                      landingServices.selecteddifficulty =
                                          "medium";
                                    },
                                    isAcitve: landingServices.difficultyTabs[1],
                                  ),
                                  const SizedBox(width: kDefaultPadding / 2),
                                  ChoiceCard(
                                    choice: "Hard",
                                    onPress: () {
                                      landingServices.updatedifficultyTabs(2);
                                      landingServices.selecteddifficulty =
                                          "hard";
                                    },
                                    isAcitve: landingServices.difficultyTabs[2],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          );
        });
  }
}
