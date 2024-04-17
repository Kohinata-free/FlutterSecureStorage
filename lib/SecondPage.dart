import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_stor/main.dart';

final prov2 = StateProvider<String>((ref) {
  return 'prov2';
});

class SecondPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final txt1 = ref.watch(prov1);
    final txt2 = ref.watch(prov2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Container(
          padding: EdgeInsets.only(top: 15),
          child: Text('SecondPage'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'prov1=$txt1',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey,
              ),
              child: Text(
                'prov2=$txt2',
                style: TextStyle(
                  color: Colors.white,
                  // backgroundColor: Colors.yellow,
                  fontSize: 20,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(prov1.notifier).state = 'prov1更新!';
                ref.read(prov2.notifier).state = 'prov2更新!';
              },
              child: Text('更新'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, '戻った');
              },
              child: Text('戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
