import 'package:flutter/material.dart';
import 'package:quiz_app/const.dart';
import 'package:quiz_app/services/quiz.services.dart';
import 'package:quiz_app/views/landing.view.dart';

class ReslutsScreen extends StatelessWidget {
  const ReslutsScreen({Key? key, required this.quizServices}) : super(key: key);
  final QuizServices quizServices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
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
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${quizServices.score}/${quizServices.quizData.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 1.5),
                  const Text(
                    "CORRECT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 1.5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LandingScreen()));
                    },
                    child: Container(
                      width: constraints.maxWidth * 0.75,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffCE9D2A),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "New Quiz",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
