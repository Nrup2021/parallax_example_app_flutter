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
  final ScrollController _scrollController = ScrollController();
  double gridViewHeight = 0.0;
  late bool isReachedToTop;

  @override
  void initState() {
    // gridViewHeight = MediaQuery.of(context).size.height;
    super.initState();
    isReachedToTop = false;
  }

  @override
  Widget build(BuildContext context) {
    gridViewHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
          height: 400,
          child: Container(
              color: Colors.transparent,
              child: Image.network(
                "https://picsum.photos/seed/picsum/200",
                fit: BoxFit.fill,
              )),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollUpdateNotification) {
              print("Tag_scrollController.offset ${_scrollController.offset}");
              print("Tag_pixel ${scrollInfo.metrics.pixels}");
              if (_scrollController.offset >= 172) {
                // If scroll position is at or beyond 200, prevent further scrolling up
                _scrollController.jumpTo(172);
                setState(() {
                  isReachedToTop = true;
                });
                return true; // Consume the notification to prevent further handling
              } else {
                setState(() {
                  isReachedToTop = false;
                });
              }
            }
            return false;
          },
          child: ListView(
            controller: _scrollController,
            children: [
              SizedBox(
                height: 300,
                child: Container(
                  color: Colors.blueAccent,
                  child: Text("ListView SizeBox"),
                ),
              ),
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  print("Tag_Grid Scroll = ${scrollInfo.metrics.pixels}");
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ColoredBox(
                        color: Colors.greenAccent,
                        child: SizedBox(
                          height: 200,
                          child: Text("SCSV"),
                        ),
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
                                height: gridViewHeight-400,
                                // Ensures the SingleChildScrollView takes the remaining height
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    // Tab 1 content
                                    GridView.builder(
                                      physics: isReachedToTop
                                          ? const AlwaysScrollableScrollPhysics()
                                          : const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                      ),
                                      itemCount: 30,
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
                                      physics: isReachedToTop
                                          ? const AlwaysScrollableScrollPhysics()
                                          : const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                      ),
                                      itemCount: 20,
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
            ],
          ),
        ),
      ],
    );
  }
}
