import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ollama_ai_chatbox/app/components/app_components.dart';
import 'package:ollama_ai_chatbox/app/constants.dart';
import 'package:ollama_ai_chatbox/app/general_server/general_server_noti_button.dart';
import 'package:ollama_ai_chatbox/app/models/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:ollama_ai_chatbox/app/notifiers/chat_notifier.dart';
import 'package:ollama_ai_chatbox/app/widgets/core/index.dart';

class LeftSidePage extends StatelessWidget {
  const LeftSidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Expanded(
            child: _ModelList(),
          ),
          const Divider(),
          const Spacer(),
          //about
          SizedBox(width: 50, height: 50, child: MyImageFile(path: '')),
          GeneralServerNotiButton(),
          Text('Version Name: $appVersionName'),
          const Text('Developer: ThanCoder'),
        ],
      ),
    );
  }
}

class _ModelList extends StatefulWidget {
  const _ModelList();

  @override
  State<_ModelList> createState() => _ModelListState();
}

class _ModelListState extends State<_ModelList> {
  @override
  void initState() {
    super.initState();
    init();
  }

  List<ChatModel> modelList = [];
  bool isLoading = false;

  void init() async {
    try {
      setState(() {
        isLoading = true;
      });

      final res = await http.get(Uri.parse(chaptModelApiUrl));
      final dynamic resObj = jsonDecode(res.body);
      final List<dynamic> resList = resObj['models'] ?? [];

      setState(() {
        modelList = resList.map((map) => ChatModel.fromMap(map)).toList();
      });
      if (modelList.isNotEmpty) {
        setState(() {
          modelList[0].isSelected = true;
          isLoading = false;
        });
        currentChatModelNotifier.value = modelList[0];
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('_ModelList-init: ${e.toString()}');
      _showMsg(e.toString());
    }
  }

  void _showMsg(String msg) {
    showDialogMessage(context, msg);
  }

  void _setCurrent(ChatModel chatModel) {
    final res = modelList.map((mod) {
      if (mod.name == chatModel.name) {
        mod.isSelected = true;
      } else {
        mod.isSelected = false;
      }
      return mod;
    }).toList();
    setState(() {
      modelList = res;
    });
    currentChatModelNotifier.value = chatModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            spacing: 10,
            children: [
              isLoading
                  ? TLoader(size: 20)
                  : IconButton(
                      onPressed: init,
                      icon: const Icon(Icons.refresh),
                    ),
              Text(
                'Select Model',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: modelList.length,
            itemBuilder: (context, index) {
              final model = modelList[index];
              return ListTile(
                onTap: () => _setCurrent(model),
                textColor: model.isSelected ? Colors.teal : null,
                title: Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
