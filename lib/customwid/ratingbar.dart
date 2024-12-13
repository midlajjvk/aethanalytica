import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final int starCount;
  final double initialRating;
  final Color activeColor;
  final Color inactiveColor;
  final double starSize;
  final void Function(double) onRatingChanged;

  const RatingBar({
    Key? key,
    this.starCount = 5,
    this.initialRating = 0.0,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.starSize = 40.0,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  Widget _buildStar(int index) {
    bool isActive = index < _currentRating;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentRating = index + 1;
        });
        widget.onRatingChanged(_currentRating);
      },
      child: Icon(
        Icons.star,
        size: widget.starSize,
        color: isActive ? widget.activeColor : widget.inactiveColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, _buildStar),
    );
  }
}

void main() {
  runApp(const Ratingbar());
}

class Ratingbar extends StatelessWidget {
  const Ratingbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Rating Bar')),
        body: Center(
          child: RatingBar(
            initialRating: 3.0,
            starSize: 50.0,
            onRatingChanged: (rating) {
              debugPrint('Rating selected: $rating');
            },
          ),
        ),
      ),
    );
  }
}
