import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SafeArea(
        child: Scaffold(body: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scrollPosition = 0.0;
  bool reachedToTop = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          print("Scroll${scrollInfo.metrics.pixels}");

          if (scrollInfo is ScrollUpdateNotification) {
            setState(() {
              _scrollPosition = scrollInfo.metrics.pixels;
            });

            if (_scrollPosition >= 400.0) {
              reachedToTop = true;
              return false;
            } else {
              reachedToTop = false;
              return true;
            }
          }
          return true;
        },
        child: Stack(
          children: [
            SizedBox(
              height: 450,
              child: Container(
                  color: Colors.transparent,
                  child: Image.network(
                    "https://picsum.photos/seed/picsum/200",
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                physics: reachedToTop
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Container(color: Colors.transparent),
                    ),
                    // ============================ tab ===

                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.deepOrangeAccent,
                            child: const TabBar(
                              tabs: [
                                Tab(text: 'Tab 1'),
                                Tab(text: 'Tab 2'),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              // Ensures the SingleChildScrollView takes the remaining height
                              child: TabBarView(
                                // physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Tab 1 content
                                  GridView.builder(
                                    // physics: reachedToTop
                                    //     ? const AlwaysScrollableScrollPhysics()
                                    //     : const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.blue,
                                        child: Center(
                                          child: Text('Item $index'),
                                        ),
                                      );
                                    },
                                  ),

                                  // Tab 2 content
                                  GridView.builder(
                                    // physics: reachedToTop
                                    //     ? const AlwaysScrollableScrollPhysics()
                                    //     : const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.green,
                                        child: Center(
                                          child: Text('Item $index'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ====================================
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.amber[200],
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const BackButton(color: Colors.black),
                    const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
