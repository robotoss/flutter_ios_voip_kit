import 'package:flutter/material.dart';
import 'package:flutter_ios_voip_kit/flutter_ios_voip_kit.dart';
import 'package:uuid/uuid.dart';

class OutgoingCallPage extends StatefulWidget {
  const OutgoingCallPage({super.key});

  static const routeName = '/outgoing_call_page';

  @override
  State<OutgoingCallPage> createState() => _OutgoingCallPageState();
}

class _OutgoingCallPageState extends State<OutgoingCallPage> {
  final voIPKit = FlutterIosVoipKit();
  bool isOutgoing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤙 Your Caller'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: isOutgoing
                ? const Text(
                    '🤙 Calling the callee device.\n\nNotifies the callee device of VoIP notifications if there is a server to post to APNs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                : const Text(
                    '👇 Tap to start call to the callee device.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(isOutgoing ? Icons.cancel : Icons.call),
        label: Text(
          isOutgoing ? 'Cancel call' : 'Start call',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: isOutgoing ? Colors.red : Colors.blue,
        onPressed: () async {
          (isOutgoing)
              ? await voIPKit.endCall()
              : await voIPKit.startCall(
                  uuid: const Uuid().v4(),
                  targetName: 'Dummy Tester',
                );
          setState(() {
            isOutgoing = !isOutgoing;
          });
        },
      ),
    );
  }
}
