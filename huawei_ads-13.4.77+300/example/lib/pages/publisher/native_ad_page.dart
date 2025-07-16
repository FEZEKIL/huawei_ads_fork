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

class NativeAdPage extends StatefulWidget {
  const NativeAdPage({Key? key}) : super(key: key);

  @override
  State<NativeAdPage> createState() => _NativeAdPageState();
}

class _NativeAdPageState extends State<NativeAdPage> {
  static const String _imageTestAdSlotId = 'testu7m3hc4gvm'; // Image
  static const String _videoTestAdSlotId = 'testy63txaom86'; // Video ad
  static const String _appDownloadTestAdSlotId = 'testy63txaom86';
  final List<String> logs = [];

  NativeAdController createVideoAdController() {
    NativeAdController controller = NativeAdController(
      adParam: AdParam(tMax: 500).addBiddingParamMap(
        _videoTestAdSlotId,
        BiddingParam(),
      ),
      adConfiguration: NativeAdConfiguration(
        configuration: VideoConfiguration(
          startMuted: true,
          autoPlayNetwork: AutoPlayNetwork.bothWifiAndData,
        ),
      ),
    );

    controller.listener = (AdEvent event, {int? errorCode}) {
      if (event == AdEvent.loaded) {
        testNative(controller);
      }
    };
    return controller;
  }

  Future<void> getBiddingInfo(NativeAdController controller) async {
    BiddingInfo? biddingInfo = await controller.getBiddingInfo();
    debugPrint('getBiddingInfo : ${biddingInfo.toString()}');
  }

  void testNative(NativeAdController controller) async {
    VideoOperator? operator = await (controller.getVideoOperator());
    operator?.setVideoLifecycleListener =
        (VideoLifecycleEvent event, {bool? isMuted}) {
      debugPrint('VideoLifeCycle event : $event');
      setState(() {
        logs.add('${getCurrentTime()} VideoLifeCycle event : ${event.name}');
      });
    };
    bool? hasVideo = await operator?.hasVideo();
    debugPrint('Operator has video : $hasVideo');

    String? title = await controller.getTitle();
    debugPrint('Ad Title : $title');

    String? callToAction = await controller.getCallToAction();
    debugPrint('Ad action : $callToAction');

    String? source = await controller.getAdSource();
    debugPrint('Ad source : $source');

    String? getAdSign = await controller.getAdSign();
    debugPrint('Ad sign : $getAdSign');

    String? whyThisAd = await controller.getWhyThisAd();
    debugPrint('Why this ad : $whyThisAd');

    String? uniqueId = await controller.getUniqueId();
    debugPrint('uniqueId : $uniqueId');

    String? transparencyTplUrl = await controller.transparencyTplUrl();
    debugPrint('transparencyTplUrl : $transparencyTplUrl');

    bool? isTransparencyOpen = await controller.isTransparencyOpen();
    debugPrint('isTransparencyOpen : $isTransparencyOpen');

    PromoteInfo? promoteInfo = await controller.getPromoteInfo();
    debugPrint('getPromoteInfo : ${promoteInfo.toString()}');

    AppInfo? appInfo = await controller.getAppInfo();
    debugPrint('getAppInfo: ${appInfo.toString()}');
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
          'Huawei Ads - Native',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 20),
                    //   color: Colors.pinkAccent,
                    //   child: const Center(
                    //     child: Text(
                    //       'My Ad',
                    //       style: Styles.headerTextStyle,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   color: Colors.blueAccent,
                    //   height: 300,
                    //   margin: const EdgeInsets.only(bottom: 20.0),
                    //   child: NativeAd(
                    //     adSlotId: _imageTestAdSlotId,
                    //     controller: defaultController(),
                    //     type: NativeAdType.video,
                    //     styles: NativeStyles()
                    //       ..setTitle(fontWeight: NativeFontWeight.boldItalic)
                    //       ..setCallToAction(fontSize: 8)
                    //       ..setFlag(fontSize: 10)
                    //       ..setSource(fontSize: 11),
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Banner Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 450,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 40.0),
                      child: NativeAd(
                        adSlotId: _imageTestAdSlotId,
                        controller: NativeAdController(
                          adConfiguration: NativeAdConfiguration(
                            choicesPosition:
                                NativeAdChoicesPosition.BOTTOM_RIGHT,
                          ),
                          listener: (AdEvent event, {int? errorCode}) {
                            debugPrint('Native Ad event : $event');
                            setState(() {
                              logs.add(
                                  '${getCurrentTime()} Native Ad event : ${event.name}');
                            });
                          },
                        ),
                        type: NativeAdType.banner,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Small Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _imageTestAdSlotId,
                        controller: NativeAdController(),
                        type: NativeAdType.full,
                        styles: NativeStyles()
                          ..setTitle(fontWeight: NativeFontWeight.boldItalic)
                          ..setCallToAction(fontSize: 8)
                          ..setFlag(fontSize: 10)
                          ..setSource(fontSize: 11),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Full Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _imageTestAdSlotId,
                        controller: NativeAdController(),
                        type: NativeAdType.full,
                        styles: NativeStyles()
                          ..setSource(color: Colors.redAccent)
                          ..setCallToAction(
                            color: Colors.white,
                            bgColor: Colors.redAccent,
                          ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Video Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 270,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _videoTestAdSlotId,
                        controller: createVideoAdController(),
                        type: NativeAdType.video,
                        styles: NativeStyles()
                          ..setCallToAction(fontSize: 10)
                          ..setFlag(fontSize: 10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Ad with App Download Button',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _appDownloadTestAdSlotId,
                        controller: createVideoAdController(),
                        type: NativeAdType.app_download,
                        styles: NativeStyles()
                          ..setAppDownloadButtonNormal(fontSize: 10)
                          ..setAppDownloadButtonProcessing(fontSize: 12)
                          ..setAppDownloadButtonInstalling(fontSize: 14)
                          ..setCallToAction(fontSize: 10)
                          ..setFlag(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
