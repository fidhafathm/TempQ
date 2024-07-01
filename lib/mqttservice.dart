import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/foundation.dart';

class Mqttservice {
  final MqttServerClient client =
      MqttServerClient('test.mosquitto.org', 'qwerty123');
  // StreamController<String> streamController = StreamController<String>.broadcast();
  // Stream<String> get messageStream => streamController.stream;
  // ValueNotifier<String> payloadmsg =
  //     ValueNotifier<String>(''); //hold my temperature value

  var pongCount = 0;
  var subtopic = "temperature13567";
  ValueNotifier<String> temperature = ValueNotifier<String>('');

  Mqttservice() {
    client.setProtocolV311();
    client.keepAlivePeriod = 150;
    client.connectTimeoutPeriod = 60;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.pongCallback = pong;
  }

  Future<int> ConnectBroker() async {
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('socket exception - $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('client connected');
    } else {
      print(
          'client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }
    return 0;
  }

  void publish(bool state) {
    const pubTopic = 'device12345';
    final builder = MqttClientPayloadBuilder();
    builder.addBool(val: state);
    client.subscribe(pubTopic, MqttQos.exactlyOnce);
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
    print('published $state');
  }

  void subcribe() async {
    client.subscribe(subtopic, MqttQos.exactlyOnce);
    print("subscribed to $subtopic");
  }

  void listen() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final String payloadmsg =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      //print(pt);
      temperature.value = payloadmsg;
      print(temperature.value);
    });
    //temperature = '$pt';
    //return pt;
  }

  // void receiveMessage(String message) {
  //   streamController.add(message);
  // }

  void disconnect() {
    client.disconnect();
  }

  void onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('OnDisconnected callback is solicited, this is correct');
    } else {
      print(
          'OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
      exit(-1);
    }
    if (pongCount == 3) {
      print('Pong count is correct');
    } else {
      print('Pong count is incorrect, expected 3. actual $pongCount');
    }
  }

  void onConnected() {
    print('Client connection was successful');
  }

  void pong() {
    print('connection still alive');
    pongCount++;
  }
}
