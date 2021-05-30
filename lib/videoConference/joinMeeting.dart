import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../variable.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      userName = userdoc.data()['userName'];
    });
  }

  joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
      var options = JitsiMeetingOptions(room: roomController.text)
        ..userDisplayName =
            nameController.text == '' ? userName : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              'Room Code:',
              style: myStyle(20),
            ),
            SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              controller: roomController,
              autoDisposeControllers: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
              animationDuration: Duration(milliseconds: 300),
              length: 6,
              onChanged: (value) {},
              appContext: context,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: myStyle(20),
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name(Leave if you want your username)",
                  labelStyle: myStyle(15)),
            ),
            SizedBox(
              height: 16,
            ),
            CheckboxListTile(
              value: isVideoMuted,
              onChanged: (value) {
                setState(() {
                  isVideoMuted = value;
                });
              },
              title: Text(
                "Video Muted",
                style: myStyle(18, Colors.black),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            CheckboxListTile(
              value: isAudioMuted,
              onChanged: (value) {
                setState(() {
                  isAudioMuted = value;
                });
              },
              title: Text(
                "Audio Muted",
                style: myStyle(18, Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Of course you can customise settings in the meeting",
              style: myStyle(15),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 48,
              thickness: 2.0,
            ),
            InkWell(
              onTap: () => joinMeeting(),
              child: Container(
                width: double.maxFinite,
                height: 64,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger)),
                child: Center(
                  child: Text(
                    "Join Meeting",
                    style: myStyle(20, Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
