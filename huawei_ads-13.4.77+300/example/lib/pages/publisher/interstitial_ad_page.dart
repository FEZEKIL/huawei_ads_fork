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
import 'package:huawei_ads_example/utils/constants.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({Key? key}) : super(key: key);

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  static const String _imageTestAdSlotId = 'teste9ih9j0rc3'; // Image ad
  static const String _videoTestAdSlotId = 'testb4znbuh3n2'; // Video ad
  final AdParam _adParam = AdParam();
  String? adSlotId = _imageTestAdSlotId;
  InterstitialAd? _interstitialAd;
  final List<String> logs = [];

  void changeSlotId(String? slotId) {
    setState(() {
      _interstitialAd = null;
      adSlotId = slotId;
    });
  }

  InterstitialAd createAd() {
    return InterstitialAd(
      adSlotId: adSlotId!,
      adParam: _adParam,
      listener: (AdEvent event, {int? errorCode}) {
        debugPrint('Interstitial Ad event : $event');
        setState(() {
          logs.add('${getCurrentTime()} Interstitial Ad event : ${event.name}');
        });
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
          'Huawei Ads - Interstitial',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Interstitial Image'),
                          trailing: Radio<String>(
                            groupValue: adSlotId,
                            value: _imageTestAdSlotId,
                            onChanged: changeSlotId,
                          ),
                        ),
                        ListTile(
                          title: const Text('Interstitial Video'),
                          trailing: Radio<String>(
                            groupValue: adSlotId,
                            value: _videoTestAdSlotId,
                            onChanged: changeSlotId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Load Ad',
                    style: Styles.adControlButtonStyle,
                  ),
                  onPressed: () async {
                    await _interstitialAd?.destroy();
                    _interstitialAd = createAd();
                    await _interstitialAd!.loadAd();
                    await _interstitialAd!.show();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.destroy();
    super.dispose();
  }
}
