class ChatMessage {
  final String text;
  final bool isUser;
  final bool isLoading;
  final String? error;
  ChatMessage({required this.text, required this.isUser, this.isLoading = false, this.error});
}
