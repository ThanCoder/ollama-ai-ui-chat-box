import 'dart:io';

import 'package:ollama_ai_chatbox/app/constants.dart';
import 'package:ollama_ai_chatbox/app/notifiers/app_notifier.dart';
//external path ကိုဆိုလိုတာ
String getAppExternalRootPath() {
  String res = "";
  if (Platform.isAndroid) {
    res = androidRootPath;
  } else if (Platform.isLinux) {
    res = Platform.environment["HOME"] ?? "";
  }

  return res;
}

//external path ကိုဆိုလိုတာ
String getAppRootPath() {
  return appRootPathNotifier.value;
}
