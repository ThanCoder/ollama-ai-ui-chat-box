import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ollama_ai_chatbox/app/constants.dart';
import 'package:ollama_ai_chatbox/app/models/message_model.dart';
import 'package:ollama_ai_chatbox/app/notifiers/chat_notifier.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String resText = '';
  TextEditingController chatController = TextEditingController();
  FocusNode chatFocusNode = FocusNode();
  StreamSubscription<String>? _subscription; // StreamSubscription ကို ထားမယ်
  bool isResponse = false;
  List<MessageModel> messageList = [];

  @override
  void initState() {
    super.initState();
    chatController.text = 'hello';
  }

  void _chat() async {
    try {
      if (chatController.text.isEmpty) return;
      final request = http.Request("POST", Uri.parse(chaptApiUrl))
        ..headers["Content-Type"] = "application/json"
        ..body = jsonEncode({
          "model": currentChatModelNotifier.value!.model,
          "prompt": chatController.text,
          "stream": true, // Streaming Mode
        });
      //clear text
      chatController.text = '';
      FocusScope.of(context).requestFocus(chatFocusNode);

      final response = await http.Client().send(request);
      final stream = response.stream.transform(utf8.decoder);

      setState(() {
        isResponse = true;
      });
      //create new chat
      final newMsg = MessageModel(
        text: '',
        isUser: false,
        date: DateTime.now().millisecondsSinceEpoch,
      );
      messageList.add(newMsg);

      // Stream ကို subscription နဲ့ listen လုပ်မယ်
      _subscription = stream.listen(
        (chunk) {
          // debugPrint(chunk);
          String res = jsonDecode(chunk)['response'] ?? '';
          if (res.isEmpty) return;
          setState(() {
            resText += res;
            messageList.last.text = resText;
          });
        },
        onError: (error) {
          debugPrint("Streaming error: $error");
          setState(() {
            isResponse = false;
          });
        },
        onDone: () {
          debugPrint("Streaming completed.");
          setState(() {
            isResponse = false;
          });
        },
      );

      resText = '';
      //add chat
    } catch (e) {
      debugPrint('_chat: ${e.toString()}');
    }
  }

  // Force Stop Function
  void _stopResponse() {
    _subscription?.cancel(); // Stream ကို cancel လုပ်မယ်
    _subscription = null;
    setState(() {
      isResponse = false;
    });
    debugPrint("Streaming Stopped.");
  }

  void _sendModel() {
    final newMsg = MessageModel(
      text: chatController.text,
      isUser: true,
      date: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      messageList.add(newMsg);
    });
    _chat();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentChatModelNotifier,
      builder: (context, model, child) {
        if (model == null) {
          return Text('Please Choose Model');
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //menu
                Row(
                  children: [
                    Text(model.name),
                    const Spacer(),
                    //chat clear
                    IconButton(
                      onPressed: () {
                        setState(() {
                          messageList = [];
                        });
                      },
                      tooltip: 'Chat Clear',
                      icon: const Icon(Icons.clear_all),
                    ),
                  ],
                ),
                //response
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      final message = messageList[index];
                      return Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SelectableText(
                            message.text,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //chat form
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 56, 56, 56),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      //chat
                      TextField(
                        controller: chatController,
                        focusNode: chatFocusNode,
                        onSubmitted: (value) => _sendModel(),
                      ),
                      //menu
                      Row(
                        children: [
                          const Spacer(),
                          //stop
                          isResponse
                              ? IconButton(
                                  onPressed: _stopResponse,
                                  icon: const Icon(Icons.stop_circle),
                                )
                              :
                              //send
                              IconButton(
                                  onPressed: _sendModel,
                                  icon: const Icon(Icons.send),
                                ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
