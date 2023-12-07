import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.red,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> selectedClothes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clothes App 192041',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: selectedClothes.isEmpty
          ? const Center(
        child: Text(
          'No Clothes',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: selectedClothes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedClothes[index], style: const TextStyle(color: Colors.red, fontSize: 19, fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    _editClothing(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.green),
                  onPressed: () {
                    _deleteClothing(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectClothing();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _selectClothing() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectClothingScreen(),
        fullscreenDialog: true,
      ),
    );

    if (result != null) {
      setState(() {
        selectedClothes.add(result);
      });
    }
  }

  void _editClothing(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectClothingScreen(initialClothing: selectedClothes[index]),
        fullscreenDialog: true,
      ),
    );

    if (result != null) {
      setState(() {
        selectedClothes[index] = result;
      });
    }
  }

  void _deleteClothing(int index) {
    setState(() {
      selectedClothes.removeAt(index);
    });
  }
}

class SelectClothingScreen extends StatelessWidget {
  final String? initialClothing;
  final List<String> clothingOptions = ['T-Shirt', 'Shirt', 'Jeans', 'Pants', 'Shorts',"Sneakers","Hat"];

  SelectClothingScreen({super.key, this.initialClothing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Clothing',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'What would you like to wear?',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          const SizedBox(height: 20),
          for (var clothing in clothingOptions)
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context, clothing);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    clothing,
                    style: const TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            style: ElevatedButton.styleFrom(
               backgroundColor: Colors.red,
            ),
            child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white, fontSize: 22)
            ),
          ),
        ],
      ),
      ),
    );
  }
}
