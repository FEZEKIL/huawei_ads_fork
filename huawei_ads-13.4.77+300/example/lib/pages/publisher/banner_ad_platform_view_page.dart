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

class BannerAdPlatformViewPage extends StatefulWidget {
  const BannerAdPlatformViewPage({Key? key}) : super(key: key);

  @override
  State<BannerAdPlatformViewPage> createState() =>
      _BannerAdPlatformViewPageState();
}

class _BannerAdPlatformViewPageState extends State<BannerAdPlatformViewPage> {
  static const String _testAdSlotId = 'testw6vs28auh3';
  final AdParam _adParam = AdParam();
  BannerViewController? _bannerViewController;
  BannerAdSize? bannerAdSize = BannerAdSize.s320x50;
  final List<String> logs = [];

  void changeSize(BannerAdSize? size) {
    setState(() {
      bannerAdSize = size;
    });
  }

  void testBannerAdSizeMethods() async {
    debugPrint('isFullWidthSize : ${bannerAdSize!.isFullWidthSize}');
    debugPrint('isDynamicSize : ${bannerAdSize!.isDynamicSize}');
    debugPrint('isAutoHeightSize : ${bannerAdSize!.isAutoHeightSize}');

    int? widthPx = await bannerAdSize!.getWidthPx;
    debugPrint('widthPx : $widthPx');

    int? heightPx = await bannerAdSize!.getHeightPx;
    debugPrint('heightPx : $heightPx');

    BannerAdSize currentDir =
        await BannerAdSize.getCurrentDirectionBannerSize(150);
    debugPrint(
      'getCurrentDirectionBannerSize - width ${currentDir.width} : height ${currentDir.height}',
    );

    BannerAdSize landscape = await BannerAdSize.getLandscapeBannerSize(150);
    debugPrint(
      'getLandscapeBannerSize - width ${landscape.width} : height ${landscape.height}',
    );

    BannerAdSize portrait = await BannerAdSize.getPortraitBannerSize(150);
    debugPrint(
      'getPortraitBannerSize - width ${portrait.width} : height ${portrait.height}',
    );
  }

  @override
  void initState() {
    super.initState();
    testBannerAdSizeMethods();
    _bannerViewController = BannerViewController(
      listener: (AdEvent event, {int? errorCode}) {
        debugPrint('Banner Ad event : $event');
        setState(() {
          logs.add('${getCurrentTime()} Banner Ad event : ${event.name}');
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
          'Huawei Ads - Banner',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 60),
              child: SingleChildScrollView(
                child: Container(
                  color: const Color.fromRGBO(242, 242, 242, 1),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Size 320 x 50'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s320x50,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 320 x 100'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s320x100,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 300 x 250'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s300x250,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size SMART'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.sSmart,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size ADVANCED'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.sAdvanced,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 360 x 57'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s360x57,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 360 x 144'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s360x144,
                          onChanged: changeSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BannerView(
              adSlotId: _testAdSlotId,
              size: bannerAdSize!,
              adParam: _adParam,
              backgroundColor: Colors.blueGrey,
              refreshDuration: const Duration(seconds: 30),
              controller: _bannerViewController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
