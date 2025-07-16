/*
    Copyright 2020-2025. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:huawei_ads/huawei_ads.dart';
import 'package:huawei_ads_example/pages/ads_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await HwAds.init();
    await VastSdkFactory.init(
      VastSdkConfiguration(isTest: true),
    );
    await VastSdkFactory.userAcceptAdLicense(true);
  } catch (e) {
    debugPrint('EXCEPTION | $e');
  }
  runApp(const HmsAdsDemo());
}

class HmsAdsDemo extends StatelessWidget {
  const HmsAdsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdsMenuPage(),
      theme: ThemeData.light().copyWith(
        platform: TargetPlatform.android,
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
          size: 20.0,
        ),
        dividerTheme: DividerThemeData(
          space: 1.0,
          thickness: 2.0,
          color: Colors.blueGrey.shade200,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.black54,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: TextStyle(color: Colors.white, fontSize: 14),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 10.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
