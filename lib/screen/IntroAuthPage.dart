import 'package:flutter/material.dart';
import 'package:flutter_zoom/authentication/navigateAuthScreen.dart';
import 'package:flutter_zoom/variable.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroAuthPage extends StatefulWidget {
  @override
  _IntroAuthPageState createState() => _IntroAuthPageState();
}

class _IntroAuthPageState extends State<IntroAuthPage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Welcome to ZoomClone",
          image: Center(
            child: Image.asset(
              'images/welcome.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "Join or Start Meeting",
          body: "Join now",
          image: Center(
            child: Image.asset(
              'images/conference.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "Security",
          body: "Your security is important to us",
          image: Center(
            child: Image.asset(
              'images/secure.jpg',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: () {},
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 45,
      ),
      next: const Icon(Icons.arrow_forward_ios),
      done: Text(
        'Done',
        style: myStyle(20, Colors.black),
      ),
    );
  }
}
