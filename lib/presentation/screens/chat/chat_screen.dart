import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/2007_Sakura_of_Fukushima-e_007_rotated.jpg/220px-2007_Sakura_of_Fukushima-e_007_rotated.jpg'),
          ),
        ),
        title: const Text('Alfred'),
        centerTitle: false,
      ),
      body: _ChatView(), //appBar:
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                return (message.fromWho == FromWho.hers)
                    ? const HerMessageBubble()
                    : MyMessageBubble(message: message);
              },
            )),

            /// Caja de mensaje de texto
            MessageFieldBox(
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
