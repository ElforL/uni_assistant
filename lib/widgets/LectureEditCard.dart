part of widgets;

class LectureEditCard extends StatefulWidget {
  final Lecture lecture;
  final CourseEditScreenState parent;

  LectureEditCard({
    Key key,
    this.lecture,
    this.parent,
  }) : super(key: key);

  @override
  _LectureEditCardState createState() => _LectureEditCardState();
}

class _LectureEditCardState extends State<LectureEditCard> {
  int dayVal;
  int repeatVal;
  MyTimeOfDay startVal;
  MyTimeOfDay endVal;
  String roomVal;

  @override
  Widget build(BuildContext context) {
    dayVal = widget.lecture.day;
    repeatVal = widget.lecture.repeatType;
    startVal = widget.lecture.startTime;
    endVal = widget.lecture.endTime;
    roomVal = widget.lecture.room;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFe7e7e7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 10,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    widget.parent.setState(() {
                      widget.parent.widget.course.lectures.remove(widget.lecture);
                    });
                  },
                ),
              )
            ],
          ),

          ////// Day and Repeat
          Row(
            children: [
              // Day
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'DAY',
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 12,
                      ),
                    ),
                    DropdownButton<int>(

                        /// Colors
                        // Underline
                        underline: Container(
                          height: 1.0,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF828282),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        // Icon and text
                        iconEnabledColor: Color(0xFF828282),
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        dropdownColor: Color(0xffe7e7e7),

                        /// Values
                        value: dayVal,
                        elevation: 1,
                        onChanged: (int newVal) {
                          setState(() {
                            dayVal = newVal;
                            widget.lecture.day = newVal;
                          });
                        },
                        items: List<DropdownMenuItem<int>>.generate(6, (index) {
                          return DropdownMenuItem<int>(
                            value: (index + 1),
                            child: Text(widget.lecture.getDayName(index + 1)),
                          );
                        })),
                  ],
                ),
              ),

              SizedBox(width: 30),

              // Repeat
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'REPEAT',
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 12,
                      ),
                    ),
                    DropdownButton<int>(
                        isExpanded: true,

                        /// Colors
                        // Underline
                        underline: Container(
                          height: 1.0,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF828282),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        // Icon and text
                        iconEnabledColor: Color(0xFF828282),
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        dropdownColor: Color(0xffe7e7e7),

                        /// Values
                        value: repeatVal,
                        elevation: 1,
                        onChanged: (int newVal) {
                          setState(() {
                            repeatVal = newVal;
                            widget.lecture.repeatType = newVal;
                          });
                        },
                        items: [
                          DropdownMenuItem<int>(
                            value: (0),
                            child: Text('Weekly'),
                          ),
                          DropdownMenuItem<int>(
                            value: (1),
                            child: Text('Odd'),
                          ),
                          DropdownMenuItem<int>(
                            value: (2),
                            child: Text('Even'),
                          ),
                        ]),
                  ],
                ),
              ),

              Expanded(child: Container()),
            ],
          ),

          SizedBox(height: 20),

          // Start and end times
          Row(
            children: [
              // Start
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'START TIME',
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 12,
                      ),
                    ),
                    DropdownButton<MyTimeOfDay>(
                      isExpanded: true,

                      /// Colors
                      // Underline
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF828282),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      // Icon and text
                      iconEnabledColor: Color(0xFF828282),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      dropdownColor: Color(0xffe7e7e7),

                      /// Values
                      value: startVal,
                      elevation: 1,
                      onChanged: (MyTimeOfDay newStartVal) {
                        setState(() {
                          startVal = newStartVal;
                          if (!(newStartVal < widget.lecture.endTime))
                            widget.lecture.endTime =
                                MyTimeOfDay(hour: newStartVal.hour + 2, minute: newStartVal.minute);
                          widget.lecture.startTime = newStartVal;
                        });
                      },
                      items: List<DropdownMenuItem<MyTimeOfDay>>.generate(32, (index) {
                        var time = MyTimeOfDay(hour: 7 + index ~/ 2, minute: 30 * (index % 2));
                        return DropdownMenuItem<MyTimeOfDay>(
                          value: time,
                          child: Text('${DateFormat('hh:mm a').format(time)}'),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 30),

              // End
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'END TIME',
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 12,
                      ),
                    ),
                    DropdownButton<MyTimeOfDay>(
                      isExpanded: true,

                      /// Colors
                      // Underline
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF828282),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      // Icon and text
                      iconEnabledColor: Color(0xFF828282),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      dropdownColor: Color(0xffe7e7e7),

                      /// Values
                      value: endVal,
                      elevation: 1,
                      onChanged: (MyTimeOfDay newEndVal) {
                        setState(() {
                          endVal = newEndVal;
                          if (widget.lecture.startTime < newEndVal) widget.lecture.endTime = newEndVal;
                        });
                      },
                      items: List<DropdownMenuItem<MyTimeOfDay>>.generate(32, (index) {
                        var time = MyTimeOfDay(hour: 9 + index ~/ 2, minute: 30 * (index % 2));
                        return DropdownMenuItem<MyTimeOfDay>(
                          value: time,
                          child: Text('${DateFormat('hh:mm a').format(time)}'),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              Expanded(child: Container())
            ],
          ),

          // Room
          TextField(
            controller: TextEditingController(text: widget.lecture.room),
            decoration: InputDecoration(
              labelText: 'ROOM',
              labelStyle: TextStyle(
                color: Color(0xFF828282),
              ),
              counterStyle: TextStyle(color: Color(0xff828282)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF828282)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF828282)),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF828282)),
              ),
            ),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            maxLength: 10,
            onChanged: (value) {
              widget.lecture.room = value;
            },
          )
        ],
      ),
    );
  }
}
