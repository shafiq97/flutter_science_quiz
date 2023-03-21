import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your quiz!'),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background.jpeg'), // Replace with the path to your background image
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/manusia");
                          },
                          child: const FancyCard(
                            title: 'Manusia',
                            subtitle: 'Bab 2',
                            color: Colors.pink,
                            animation: 'assets/manusia.json',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/bahan");
                          },
                          child: const FancyCard(
                            title: 'Bahan',
                            subtitle: 'Bab 8',
                            color: Colors.purple,
                            animation: 'assets/bahan.json',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/bumi");
                          },
                          child: const FancyCard(
                            title: 'Bumi',
                            subtitle: 'Bab 9',
                            color: Colors.blue,
                            animation: 'assets/bumi.json',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/sistem");
                          },
                          child: const FancyCard(
                            title: 'Sistem Rangka Manusia',
                            subtitle: 'Bab 5',
                            color: Colors.teal,
                            animation: 'assets/skeleton.json',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FancyCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String animation;

  const FancyCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.animation,
  }) : super(key: key);

  @override
  _FancyCardState createState() => _FancyCardState();
}

class _FancyCardState extends State<FancyCard> {
  bool _isHovered = false;
  double _elevation = 8;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
        _elevation = 16;
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
        _elevation = 8;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Card(
          elevation: _elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset(widget.animation),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
