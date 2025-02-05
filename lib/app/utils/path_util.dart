import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ollama_ai_chatbox/app/constants.dart';
import 'package:ollama_ai_chatbox/app/notifiers/app_notifier.dart';
import 'package:ollama_ai_chatbox/app/services/app_path_services.dart';

String getBasename(String path) {
  return path.split('/').last;
}

String getHomePath() {
  return createDir(appRootPathNotifier.value);
}

String getConfigPath() {
  return createDir('${getHomePath()}/config');
}

String getLibaryPath() {
  return createDir('${getHomePath()}/libary');
}

String getDatabasePath() {
  return createDir('${getHomePath()}/database');
}

String getDatabaseSourcePath() {
  return createDir('${getHomePath()}/databaseSource');
}

String getCachePath() {
  if (Platform.isAndroid) {
    return createDir('${appDataRootPathNotifier.value}/cache');
  } else {
    return createDir('${getHomePath()}/cache');
  }
}

String getSourcePath() {
  return createDir('${getHomePath()}/source');
}

String getOutPath() {
  if (Platform.isLinux) {
    String download = createDir('${getAppExternalRootPath()}/Downloads');
    return createDir('$download/${appName}_out');
  }
  return createDir('${getAppExternalRootPath()}/${appName}_out');
}

String createDir(String path) {
  try {
    if (path.isEmpty) path;
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync();
    }
  } catch (e) {
    debugPrint('createDir: ${e.toString()}');
  }
  return path;
}
