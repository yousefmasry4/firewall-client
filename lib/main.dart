import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? sourceIP, sourcePort,mask,destIP,destPort;
  Flag? flag;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Firewall Client"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            SizedBox(
              height: 300,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  SizedBox(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'source IP',
                          hintText: 'source IP',
                        ),
                        onChanged: (String s){
                          setState(() {
                            sourceIP=s;
                          });
                        }
                    ),
                    width: 150,
                  ),
                  SizedBox(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'source Port',
                          hintText: 'source Port',
                        ),
                        onChanged: (String s){
                          setState(() {
                            sourcePort=s;
                          });
                        }
                    ),
                    width: 120,
                  ),
                  SizedBox(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'mask',
                          hintText: 'mask',
                        ),
                        onChanged: (String s){
                          setState(() {
                            mask=s;
                          });
                        }
                    ),
                    width: 120,
                  ),
                  SizedBox(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'dest IP',
                          hintText: 'dest IP',
                        ),
                        onChanged: (String s){
                          setState(() {
                            destIP=s;
                          });
                        }
                    ),
                    width: 150,
                  ),
                  SizedBox(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'dest Port',
                          hintText: 'dest Port',
                        ),
                        onChanged: (String s){
                          setState(() {
                            destPort=s;
                          });
                        }
                    ),
                    width: 100,
                  ),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Radio<Flag>(
                            value: Flag.Start,
                            groupValue: flag,
                            onChanged: (Flag? value) {
                              setState(() {
                                flag = value;
                              });
                            },
                          ),
                          const Text('start'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<Flag>(
                            value: Flag.Continue,
                            groupValue: flag,
                            onChanged: (Flag? value) {
                              setState(() {
                                flag = value;
                              });
                            },
                          ),
                          const Text('Continue'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<Flag>(
                            value: Flag.End,
                            groupValue: flag,
                            onChanged: (Flag? value) {
                              setState(() {
                                flag = value;
                              });
                            },
                          ),
                          const Text('End'),
                        ],
                      ),
                    ],
                  ),

                  InkWell(
                      onTap: () async {
                        if(sourceIP != null && sourcePort != null && mask != null && destIP != null && destPort != null && flag != null){
                          String f=flag == Flag.End?"end":flag == Flag.Continue?"continue":"start";
                          print(f);
                          final response = await http
                              .get(Uri.parse('http://$destIP:$destPort/fireWall/$sourceIP/$mask/$sourcePort/$f'));

                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('accepted'),backgroundColor: Colors.green,));

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('bloc'),backgroundColor: Colors.red,));

                          }

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('add all values'),backgroundColor: Colors.orange,));
                        }

                      },
                      child: Container(
                          width: 60,
                          height: 30,
                          color: Colors.red,
                          child: const Center(child:  Text("Send"),)
                      )
                  )


                ],
              ),
            ),
          ],
        )
      ),

    );
  }
}

enum Flag{
  Start,Continue,End
}
