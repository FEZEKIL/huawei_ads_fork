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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huawei_ads/huawei_ads.dart';
import 'package:huawei_ads_example/utils/constants.dart';

class RewardAdPage extends StatefulWidget {
  const RewardAdPage({Key? key}) : super(key: key);

  @override
  State<RewardAdPage> createState() => _RewardAdPageState();
}

class _RewardAdPageState extends State<RewardAdPage> {
  final String _testAdSlotId = 'testx9dtjwj8hp';
  final AdParam _adParam = AdParam();
  RewardAd? _rewardAd;
  int _score = 0;
  final List<String> logs = [];

  /* *
  * Alternatively, load status can be set when a RewardAdEvent.loaded
  * event is caught.
  * *
  * NOTE: A reward is not issued every time
  * */
  RewardAd createAd() {
    return RewardAd(
      rewardVerifyConfig: RewardVerifyConfig(
        userId: "123123",
        data: "CUSTOM_DATA_1",
      ),
      listener: (RewardAdEvent? event, {Reward? reward, int? errorCode}) {
        debugPrint('RewardAd event : $event');
        setState(() {
          logs.add('${getCurrentTime()} Reward Ad event : ${event!.name}');
        });
        if (event == RewardAdEvent.rewarded) {
          debugPrint('Received reward : ${jsonEncode(reward!.toJson())}');
          setState(() {
            logs.add(
                '${getCurrentTime()} Received reward amount : : ${reward.amount}');
            _score += reward.amount != 0 ? reward.amount! : 10;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.4,
                    minChildSize: 0.2,
                    maxChildSize: 0.5,
                    builder: (context, scrollController) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Log Viewer',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                letterSpacing: 0.5,
                                wordSpacing: 2.0,
                                height: 1.4,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey.shade400,
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                  )
                                ]),
                          ),
                          automaticallyImplyLeading: false,
                          actions: [
                            IconButton(
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.black45,
                                size: 27,
                              ),
                              onPressed: () {
                                setState(() {
                                  logs.clear();
                                });
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        body: logs.isEmpty
                            ? SizedBox.shrink()
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: logs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(12.0),
                                      child: SelectableText(
                                        logs[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          letterSpacing: 0.25,
                                          wordSpacing: 1.5,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(
              Icons.bug_report,
              color: Colors.black45,
              size: 27,
            ),
          ),
        ],
        title: const Text(
          'Huawei Ads - Reward',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 50,
                      ),
                      child: Text('Your score : $_score'),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Load Ad',
                    style: Styles.adControlButtonStyle,
                  ),
                  onPressed: () async {
                    await _rewardAd?.destroy();
                    _rewardAd = createAd();
                    await _rewardAd!.loadAd(
                      adSlotId: _testAdSlotId,
                      adParam: _adParam,
                    );
                    await _rewardAd!.show();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _rewardAd?.destroy();
    _rewardAd = null;
  }
}
