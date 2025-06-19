// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag & Drop Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DragDropDemo(),
    );
  }
}

class DragDropDemo extends StatefulWidget {
  const DragDropDemo({super.key});

  @override
  _DragDropDemoState createState() => _DragDropDemoState();
}

class _DragDropDemoState extends State<DragDropDemo> {
  List<DragItem> leftItems = [
    DragItem(id: 1, name: 'Apple', color: Colors.red),
    DragItem(id: 2, name: 'Banana', color: Colors.yellow),
    DragItem(id: 3, name: 'Orange', color: Colors.orange),
    DragItem(id: 4, name: 'Grape', color: Colors.purple),
  ];

  List<DragItem> rightItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag & Drop Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Drag items from left container to right container',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  // Left Container (Source) - Now also a target
                  Expanded(
                    child: DragTarget<DragItem>(
                      onAcceptWithDetails: (details) {
                        setState(() {
                          rightItems.remove(details.data);
                          leftItems.add(details.data);
                        });
                        // You can access additional drag details:
                        print('Dropped at offset: ${details.offset}');
                      },
                      onWillAcceptWithDetails:
                          (details) => !leftItems.contains(details.data),
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  candidateData.isNotEmpty
                                      ? Colors.green
                                      : Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      candidateData.isNotEmpty
                                          ? Colors.green
                                          : Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  candidateData.isNotEmpty
                                      ? 'Drop Here!'
                                      : 'Source Container',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child:
                                    leftItems.isEmpty
                                        ? Center(
                                          child: Text(
                                            'All items moved!\nDrag them back.',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                        : ListView.builder(
                                          padding: EdgeInsets.all(8),
                                          itemCount: leftItems.length,
                                          itemBuilder: (context, index) {
                                            final item = leftItems[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: Draggable<DragItem>(
                                                data: item,
                                                feedback: Material(
                                                  elevation: 4,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: _buildItemCard(
                                                    item,
                                                    isDragging: true,
                                                  ),
                                                ),
                                                childWhenDragging:
                                                    _buildItemCard(
                                                      item,
                                                      isPlaceholder: true,
                                                    ),
                                                child: _buildItemCard(item),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(width: 16),

                  // Right Container (Target)
                  Expanded(
                    child: DragTarget<DragItem>(
                      onAcceptWithDetails: (details) {
                        setState(() {
                          leftItems.remove(details.data);
                          rightItems.add(details.data);
                        });
                        // Access additional drag details available in the new API
                        print(
                          'Item ${details.data.name} dropped at offset: ${details.offset}',
                        );
                      },
                      onWillAcceptWithDetails:
                          (details) => !rightItems.contains(details.data),
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  candidateData.isNotEmpty
                                      ? Colors.green
                                      : Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      candidateData.isNotEmpty
                                          ? Colors.green
                                          : Colors.orange,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  candidateData.isNotEmpty
                                      ? 'Drop Here!'
                                      : 'Target Container',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child:
                                    rightItems.isEmpty
                                        ? Center(
                                          child: Text(
                                            'Drop items here',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                        : ListView.builder(
                                          padding: EdgeInsets.all(8),
                                          itemCount: rightItems.length,
                                          itemBuilder: (context, index) {
                                            final item = rightItems[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: Draggable<DragItem>(
                                                data: item,
                                                feedback: Material(
                                                  elevation: 4,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: _buildItemCard(
                                                    item,
                                                    isDragging: true,
                                                  ),
                                                ),
                                                childWhenDragging:
                                                    _buildItemCard(
                                                      item,
                                                      isPlaceholder: true,
                                                    ),
                                                child: _buildItemCard(item),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      leftItems.addAll(rightItems);
                      rightItems.clear();
                    });
                  },
                  child: Text('Reset All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      leftItems = [
                        DragItem(id: 1, name: 'Apple', color: Colors.red),
                        DragItem(id: 2, name: 'Banana', color: Colors.yellow),
                        DragItem(id: 3, name: 'Orange', color: Colors.orange),
                        DragItem(id: 4, name: 'Grape', color: Colors.purple),
                      ];
                      rightItems.clear();
                    });
                  },
                  child: Text('Reload Items'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(
    DragItem item, {
    bool isDragging = false,
    bool isPlaceholder = false,
  }) {
    return Container(
      width: isDragging ? 150 : double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            isPlaceholder
                ? Colors.grey.withOpacity(0.3)
                : item.color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        boxShadow:
            isDragging
                ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
      ),
      child: Row(
        mainAxisSize: isDragging ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Icon(
            Icons.circle,
            color: isPlaceholder ? Colors.grey : item.color,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            item.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isPlaceholder ? Colors.grey : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DragItem {
  final int id;
  final String name;
  final Color color;

  DragItem({required this.id, required this.name, required this.color});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DragItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
