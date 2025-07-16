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

class VastAdPage extends StatefulWidget {
  const VastAdPage({Key? key}) : super(key: key);

  @override
  State<VastAdPage> createState() => _VastAdPageState();
}

class _VastAdPageState extends State<VastAdPage> with WidgetsBindingObserver {
  VastAdViewController? _playerController;
  final List<String> logs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _playerController?.resume();
    } else if (state == AppLifecycleState.inactive) {
      _playerController?.pause();
    } else if (state == AppLifecycleState.paused) {
      _playerController?.pause();
    }
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
                useSafeArea: true,
                useRootNavigator: true,
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
          'Huawei Ads - VAST',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.40,
                child: VastAdView(
                  linearAdSlot: LinearAdSlot(
                    slotId: 'testy3cglm3pj0',
                    maxAdPods: 2,
                    totalDuration: 60,
                    requestOptions: VastRequestOptions(),
                  ),
                  onViewCreated: (VastAdViewController controller) async {
                    _playerController = controller;
                  },
                  eventListener: VastAdEventListener(
                    onPlayStateChanged: (int i) {
                      setState(() => logs
                          .add('${getCurrentTime()} onPlayStateChanged: $i'));
                    },
                    onVolumeChanged: (double v) {
                      setState(() =>
                          logs.add('${getCurrentTime()} onVolumeChanged: $v'));
                    },
                    onScreenViewChanged: (int i) {
                      setState(() => logs
                          .add('${getCurrentTime()} onScreenViewChanged: $i'));
                    },
                    onProgressChanged: (int l, int l1, int l2) {
                      setState(() => logs.add(
                          '${getCurrentTime()} onProgressChanged: $l, $l1, $l2'));
                    },
                    onSuccess: (int i) {
                      setState(
                          () => logs.add('${getCurrentTime()} onSuccess: $i'));
                    },
                    onFailed: (int i) {
                      setState(
                          () => logs.add('${getCurrentTime()} onFailed: $i'));
                    },
                    playAdReady: () {
                      setState(
                          () => logs.add('${getCurrentTime()} playAdReady'));
                    },
                    playAdFinish: () {
                      setState(
                          () => logs.add('${getCurrentTime()} playAdFinish'));
                    },
                    playAdError: (int errorCode) {
                      setState(() => logs
                          .add('${getCurrentTime()} playAdError: $errorCode'));
                    },
                    onBufferStart: () {
                      setState(
                          () => logs.add('${getCurrentTime()} onBufferStart'));
                    },
                    onBufferEnd: () {
                      setState(
                          () => logs.add('${getCurrentTime()} onBufferEnd'));
                    },
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('loadLinearAd'),
                onPressed: () async {
                  bool? result = await _playerController?.loadLinearAd();
                  setState(() =>
                      logs.add('${getCurrentTime()} loadLinearAd: $result'));
                },
              ),
              ElevatedButton(
                child: const Text('playLinearAds'),
                onPressed: () async {
                  await _playerController?.playLinearAds();
                },
              ),
              ElevatedButton(
                child: const Text('startLinearAd'),
                onPressed: () async {
                  await _playerController?.startLinearAd();
                },
              ),
              ElevatedButton(
                child: const Text('startAdPods'),
                onPressed: () async {
                  await _playerController?.startAdPods();
                },
              ),
              const Divider(),
              ElevatedButton(
                child: const Text('resume'),
                onPressed: () async {
                  await _playerController?.resume();
                },
              ),
              ElevatedButton(
                child: const Text('pause'),
                onPressed: () async {
                  await _playerController?.pause();
                },
              ),
              ElevatedButton(
                child: const Text('release'),
                onPressed: () async {
                  await _playerController?.release();
                },
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
