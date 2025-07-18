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

/// Advertiser information.
class AdvertiserInfo {
  /// Advertiser information type.
  final String? key;

  /// Advertiser information.
  final String? value;

  /// Advertiser information sequence.
  final int? seq;

  AdvertiserInfo._({
    required this.key,
    required this.value,
    required this.seq,
  });

  factory AdvertiserInfo._fromMap(Map<dynamic, dynamic> map) {
    return AdvertiserInfo._(
      key: map['key'],
      value: map['value'],
      seq: map['seq'],
    );
  }
}
