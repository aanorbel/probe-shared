import "package:ooniengine/abi.pb.dart";
import "package:ooniengine/engine.dart";
import 'package:easy_localization/easy_localization.dart';

/// Parses key-value pairs from a list of strings.
Map<String, String> keyValuePairs(List<String> inputs) {
  var out = Map<String, String>();
  for (final input in inputs) {
    final v = input.split("=");
    if (v.length < 2) {
      throw Exception("cannot find the `=' separator in: ${input}");
    }
    final key = v[0];
    final value = v.sublist(1).join("=");
    out[key] = value;
  }
  return out;
}

var tests = [
  OONIRunV2Descriptor(
    name: 'Test.Websites.Fullname'.tr(),
    description: 'Dashboard.Websites.Card.Description'.tr(),
    author: "Simone Basso <simone@openobservatory.org>",
    nettests: [
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: '{}',
        testName: "web_connectivity",
      ),
    ],
  ),
  OONIRunV2Descriptor(
    name: 'Test.InstantMessaging.Fullname'.tr(),
    description: 'Dashboard.InstantMessaging.Card.Description'.tr(),
    author: "Simone Basso <simone@openobservatory.org>",
    nettests: [
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "facebook_messenger",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "whatsapp",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "telegram",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "signal",
      ),
    ],
  ),
  OONIRunV2Descriptor(
    name: 'Test.Circumvention.Fullname'.tr(),
    description: 'Dashboard.Circumvention.Card.Description'.tr(),
    author: "Simone Basso <simone@openobservatory.org>",
    nettests: [
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "psiphon",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "tor",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "riseupvpn",
      ),
    ],
  ),
  OONIRunV2Descriptor(
    name: 'Test.Performance.Fullname'.tr(),
    description: 'Dashboard.Performance.Card.Description'.tr(),
    author: "Simone Basso <simone@openobservatory.org>",
    nettests: [
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "ndt",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "dash",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "http_header_field_manipulation",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "http_invalid_request_line",
      ),
    ],
  ),
  OONIRunV2Descriptor(
    name: 'Test.Experimental.Fullname'.tr(),
    description: 'Dashboard.Experimental.Card.Description'.tr(),
    author: "Simone Basso <simone@openobservatory.org>",
    nettests: [
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "torsf",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "vanilla_tor",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "stunreachability",
      ),
      OONIRunV2DescriptorNettest(
        annotations: keyValuePairs([]),
        inputs: [],
        options: "{}",
        testName: "dnscheck",
      ),
    ],
  ),
];
