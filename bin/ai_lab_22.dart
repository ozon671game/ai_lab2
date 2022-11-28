void main() {
  /// init
  List<Dot> gameField = [];

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      gameField.add(Dot(x: i, y: j));
    }
  }

  Dot minDot = Dot(x: 0, y: 0);
  Dot maxDot = Dot(x: 8, y: 8);

  Dot startDot = Dot(x: 5, y: 5);

  gameField =
      changeSingleDotInGameField(gameField, Dot(x: 3, y: 3, cell: Cell.my));
  gameField =
      changeSingleDotInGameField(gameField, Dot(x: 4, y: 4, cell: Cell.my));
  gameField =
      changeSingleDotInGameField(gameField, Dot(x: 3, y: 4, cell: Cell.enemy));
  gameField =
      changeSingleDotInGameField(gameField, Dot(x: 4, y: 3, cell: Cell.enemy));

  bool end = false;

  /// start

  // while(end){
  //
  // }

  // check(
  //     minDot,
  //     maxDot,
  //     step(
  //         moving: Moving(value: 4, direction: Direction.top),
  //         startDot: startDot));
  // for (var element in gameField) {
  //   print('${element.x}, ${element.y}, ${element.curCell}');
  // }
  // print('--------');
  // var newField =
  //     changeSingleDotInGameField(gameField, Dot(x: 1, y: 1, cell: Cell.my));
  // for (var element in newField) {
  //   print('${element.x}, ${element.y}, ${element.curCell}');
  // }
}

potentialMoved(List<Dot> gameField) {
  for (var element in gameField) {
    if (element.curCell == Cell.my) {
      for (var direction in directionList) {
        int i = 0;
        do {
          i++;
        } while (check(
            gameField.first,
            gameField.last,
            step(
                moving: Moving(value: i, direction: direction),
                startDot: element)));
        if (i > 2) {
          for (int j = 0; j < i; j++) {
            var newDot = step(
                moving: Moving(value: i, direction: direction),
                startDot: element);
            changeSingleDotInGameField(
                gameField, Dot(x: newDot.x, y: newDot.y, cell: Cell.my));
          }
          return gameField;
        }
      }
    }
  }
}

bool check(Dot minDot, Dot maxDot, Dot futureDot) {
  if (futureDot.x < minDot.x || futureDot.x > maxDot.x) {
    return false;
  }
  if (futureDot.y < minDot.y || futureDot.y > maxDot.y) {
    return false;
  }
  if (futureDot.curCell == Cell.enemy) {
    return true;
  } else {
    return false;
  }
}

List<Dot> changeSingleDotInGameField(List<Dot> gameField, Dot newDot) {
  List<Dot> newGameField = [];
  for (var element in gameField) {
    if (element.x == newDot.x && element.y == newDot.y) {
      newGameField.add(newDot);
      continue;
    }
    newGameField.add(element);
  }
  return newGameField;
}

Dot step({required Moving moving, required Dot startDot}) {
  switch (moving.direction) {
    case Direction.top:
      return Dot(
          x: startDot.x, y: startDot.y + moving.value, cell: startDot.cell);
    case Direction.bottom:
      return Dot(
          x: startDot.x, y: startDot.y - moving.value, cell: startDot.cell);
    case Direction.right:
      return Dot(
          x: startDot.x + moving.value, y: startDot.y, cell: startDot.cell);
    case Direction.left:
      return Dot(
          x: startDot.x - moving.value, y: startDot.y, cell: startDot.cell);
    case Direction.topRight:
      return Dot(
          x: startDot.x + moving.value,
          y: startDot.y + moving.value,
          cell: startDot.cell);
    case Direction.topLeft:
      return Dot(
          x: startDot.x - moving.value,
          y: startDot.y + moving.value,
          cell: startDot.cell);
    case Direction.bottomRight:
      return Dot(
          x: startDot.x + moving.value,
          y: startDot.y - moving.value,
          cell: startDot.cell);
    case Direction.bottomLeft:
      return Dot(
          x: startDot.x - moving.value,
          y: startDot.y - moving.value,
          cell: startDot.cell);
  }
}

class Dot {
  Dot({
    required this.x,
    required this.y,
    this.cell,
  });

  Cell get curCell => cell ?? Cell.empty;

  final Cell? cell;
  final int x, y;
}

const List<Direction> directionList = [
  Direction.top,
  Direction.bottom,
  Direction.right,
  Direction.left,
  Direction.topRight,
  Direction.topLeft,
  Direction.bottomRight,
  Direction.bottomLeft
];

enum Direction {
  top,
  bottom,
  right,
  left,
  topRight,
  topLeft,
  bottomRight,
  bottomLeft
}

enum Cell { empty, my, enemy, cursor }

class Moving {
  Moving({required this.value, required this.direction});

  final Direction direction;
  final int value;
}