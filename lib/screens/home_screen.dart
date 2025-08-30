import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ai_chat_assistant_mobile_app/constant/app_urls.dart';
import 'package:ai_chat_assistant_mobile_app/models/chat_model.dart';
import 'package:ai_chat_assistant_mobile_app/utils/app_colors.dart';
import 'package:ai_chat_assistant_mobile_app/widgets/image_box.dart';
import 'package:ai_chat_assistant_mobile_app/widgets/section_card.dart';
import 'package:ai_chat_assistant_mobile_app/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool isLoading = false;

  // opne ai
  void sendMessageToOpenAI() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      isLoading = true;
    });

    _controller.clear();

    try {
      final apiKey = AppUrls.openApiKey;
      final url = Uri.parse(AppUrls.opneBaseUrl);
      final headers = {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful assistant."},
          ..._messages.map(
            (m) => {"role": m.isUser ? "user" : "assistant", "content": m.text},
          ),
          {"role": "user", "content": text},
        ],
        "temperature": 0.7,
        "max_tokens": 500,
      });

      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        print("response body... ${response}  body ${response.body}");
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'] ?? '';
        setState(() {
          _messages.add(ChatMessage(text: reply, isUser: false));
        });
      } else {
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error']?['message'] ?? 'Unknown error';
        setState(() {
          _messages.add(
            ChatMessage(
              text: 'Error: $errorMsg',
              isUser: false,
              error: response.body,
            ),
          );
        });
      }
    } on SocketException {
      setState(() {
        _messages.add(
          ChatMessage(text: 'No Internet connection.', isUser: false),
        );
      });
    } on TimeoutException {
      setState(() {
        _messages.add(ChatMessage(text: 'Request timed out.', isUser: false));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: 'Error: $e', isUser: false));
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  // gemini
  Future<void> _sendMessageToGemini(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));

      _messages.add(ChatMessage(text: '...', isUser: false, isLoading: true));
      isLoading = true;
    });

    _controller.clear();

    final url = Uri.parse('${AppUrls.geminiBaseUrl}${AppUrls.geminiApiKey}');

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": text},
          ],
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply =
            data['candidates'][0]['content']['parts'][0]['text'] ?? '';

        setState(() {
          _messages.removeWhere((m) => m.isLoading);
          _messages.add(ChatMessage(text: reply, isUser: false));
        });
      } else {
        final error = jsonDecode(response.body);
        final errorMsg = error['error']['message'] ?? 'Unknown error';
        setState(() {
          _messages.removeWhere((m) => m.isLoading);
          _messages.add(ChatMessage(text: 'Error: $errorMsg', isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: 'Error: $e', isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.08,
                vertical: h * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/robot_icon.png',
                        height: w * 0.1,
                      ),
                      SizedBox(width: w * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Assistant",
                            style: TextStyle(
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ImageBox(image: 'assets/svg/volume-high.svg'),
                      SizedBox(width: w * 0.04),
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: ImageBox(image: 'assets/svg/export.svg'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            //
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      ImageBox(image: 'assets/svg/explain.svg'),
                      SizedBox(height: h * 0.01),
                      buildSectionTitle("Explain", w),
                      buildCard(
                        "What are wormholes? Explain like I am 5",
                        "Wormholes are like tunnels in space that can connect two far away places, like magic shortcuts.",
                        w,
                      ),
                      SizedBox(height: h * 0.02),

                      ImageBox(image: 'assets/svg/edit.svg'),
                      SizedBox(height: h * 0.01),
                      buildSectionTitle("Write & Edit", w),
                      buildCard(
                        "Write a tweet about global warming",
                        "Global warming is real! Let's protect our planet before it's too late. #ClimateChange",
                        w,
                      ),
                      SizedBox(height: h * 0.02),

                      ImageBox(image: 'assets/svg/translate.svg'),
                      SizedBox(height: h * 0.01),
                      buildSectionTitle("Translate", w),
                      buildCard(
                        "How do you say “how are you” in Korean?",
                        "In Korean, you say 'Annyeonghaseyo' (안녕하세요).",
                        w,
                      ),
                      SizedBox(height: h * 0.02),

                      //
                      if (_messages.isNotEmpty)
                        ..._messages.map(
                          (msg) => Align(
                            alignment: msg.isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: msg.isUser
                                    ? AppColors.primaryColor
                                    : const Color.fromARGB(91, 99, 0, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: msg.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    )
                                  : Text(
                                      msg.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            //
            Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: ImageBox(image: 'assets/svg/microphone_icon.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () async {
                        // sendMessage();
                        await _sendMessageToGemini(_controller.text.trim());
                      },
                      icon: ImageBox(image: 'assets/svg/send.svg'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
