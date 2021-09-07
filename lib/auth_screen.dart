import 'dart:math';

import 'package:auth_screen/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/login_form.dart';
import 'widgets/signup_form.dart';
import 'widgets/social_buttons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isShowingSignup = false;
  late AnimationController _animationController;
  //late Animation<double> _animation;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: kDefaultDuration);
    //_animation = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      isShowingSignup = !isShowingSignup;
    });
    isShowingSignup
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          //stream: null,
          builder: (context, snapshot) {
            return Stack(
              children: [
                //Login Form
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: isShowingSignup ? -_size.width * 0.76 : 0,
                  child: Container(
                    color: kLoginBackground,
                    child: LoginForm(),
                  ),
                ),
                //Signup Form
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left:
                      isShowingSignup ? _size.width * 0.12 : _size.width * 0.88,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: kSignupBackground,
                      child: SignUpForm(),
                    ),
                  ),
                ),
                //logo
                AnimatedPositioned(
                    duration: kDefaultDuration,
                    top: _size.height * 0.1, //10* of total height
                    left: 0,
                    right: isShowingSignup
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 25,
                      child: SvgPicture.asset(
                        'assets/sa_app_logo.svg',
                        color: isShowingSignup
                            ? kSignupBackground
                            : kLoginBackground,
                      ),
                    )),
                //Social Media Buttons
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  child: SocialButtons(),
                  bottom: _size.height * 0.1,
                  width: _size.width,
                  right: isShowingSignup
                      ? -_size.width * 0.06
                      : _size.width * 0.06,
                ),
                //Login Text
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  bottom: isShowingSignup
                      ? (_size.height / 2) - 110
                      : _size.height * 0.3,
                  //(width of login screen is _size.width * 0.88 and width of the text container is 160)
                  left: isShowingSignup ? 0 : _size.width * 0.44 - 80,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: isShowingSignup ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: isShowingSignup ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: isShowingSignup ? (270 * pi / 180) : 0,
                      alignment: isShowingSignup
                          ? Alignment.topLeft
                          : Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (isShowingSignup) {
                            updateView();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding * 0.75),
                          width: 160,
                          //color: Colors.yellow,
                          child: Text(
                            kLoginText.toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Signup Text
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  bottom: !isShowingSignup
                      ? (_size.height / 2) - 110
                      : _size.height * 0.3,
                  //(width of login screen is _size.width * 0.88 and width of the text container is 160)
                  //left: isShowingSignup ? 0 : _size.width * 0.44 - 80,
                  right: !isShowingSignup ? 0 : _size.width * 0.44 - 80,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: !isShowingSignup ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color:
                            !isShowingSignup ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: !isShowingSignup ? (90 * pi / 180) : 0,
                      alignment: !isShowingSignup
                          ? Alignment.topRight
                          : Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (!isShowingSignup) {
                            updateView();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding * 0.75),
                          width: 160,
                          //color: Colors.white70,
                          child: Text(
                            kSignupText.toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
