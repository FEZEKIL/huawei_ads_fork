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

part of '../../huawei_ads.dart';

class ReferrerDetails {
  /// Bundle key for install referrer information.
  static const String keyInstallReferrer = 'install_referrer';

  /// Bundle key for the ad click timestamp.
  static const String keyReferrerClickTimeStamp =
      'referrer_click_timestamp_seconds';

  /// Bundle key for the app installation timestamp.
  static const String keyInstallBeginTimeStamp =
      'install_begin_timestamp_seconds';

  /// Bundle key for channel information.
  static const String keyInstallChannel = 'install_channel';

  late Bundle _bundle;

  ReferrerDetails(Bundle referrerBundle) {
    _bundle = referrerBundle;
  }

  /// Obtains install referrer information.
  String? get getInstallReferrer {
    return _bundle.getString(keyInstallReferrer);
  }

  /// Obtains the ad click timestamp, in milliseconds.
  int? get getReferrerClickTimestampMillisecond {
    return _bundle.getInt(keyReferrerClickTimeStamp);
  }

  /// Obtains the app installation timestamp, in milliseconds.
  int? get getReferrerBeginTimeStampMillisecond {
    return _bundle.getInt(keyInstallBeginTimeStamp);
  }

  /// Obtains channel information.
  String? get getInstallChannel {
    return _bundle.getString(keyInstallChannel);
  }
}
