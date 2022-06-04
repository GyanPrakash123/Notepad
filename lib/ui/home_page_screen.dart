import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:personal_notebook/controller/task_controller.dart';
import 'package:personal_notebook/models/task.dart';
import 'package:personal_notebook/services/notificationServices.dart';
import 'package:personal_notebook/services/themeServices.dart';
import 'package:personal_notebook/ui/add_task_page.dart';
import 'package:personal_notebook/ui/themes.dart';
import 'package:personal_notebook/widgets/button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:personal_notebook/widgets/task_file.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TaskController _taskController = Get.put(TaskController());
  var notifyHelper;
  var themeServices;
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    themeServices = ThemeServices();
  }

  @override
  Widget build(BuildContext context) {
    //ThemeServices().switchTheme();
    print(Get.isDarkMode);

    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (context, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if (task.repeat == 'Daily') {
                /*DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                print(myTime);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);*/

                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("tapped");
                              _showBottomSheet(
                                  context, _taskController.taskList[index]);
                            },
                            child: TaskTile(_taskController.taskList[index]),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("tapped");
                              _showBottomSheet(
                                  context, _taskController.taskList[index]);
                            },
                            child: TaskTile(_taskController.taskList[index]),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _bottomSheetButton(
      {String? label,
      Color? clr,
      Function()? onTap,
      bool isClose = false,
      BuildContext? context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        //iska matlab hai ki hmko kewal 90% hi width chaiye total ka
        width: MediaQuery.of(context!).size.width * .9,
        decoration: BoxDecoration(
          border:
              Border.all(color: isClose == true ? Colors.grey : clr!, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr!,
        ),
        child: Center(
            child: isClose == true
                ? Text(
                    label!,
                    style: TextStyle(color: Colors.grey[400]),
                  )
                : Text(label!)),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * .24
            : MediaQuery.of(context).size.height * .32,
        color: Get.isDarkMode ? darkGreyColor : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400],
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    clr: primaryClr,
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      _taskController.getTasks();
                      Get.back();
                    },
                    context: context),
            _bottomSheetButton(
                label: "Delete Task",
                clr: Colors.red[300],
                onTap: () {
                  _taskController.delete(task);
                  _taskController.getTasks();
                  Get.back();
                },
                context: context),
            _bottomSheetButton(
                label: "Close",
                clr: Colors.grey,
                isClose: true,
                onTap: () {
                  Get.back();
                },
                context: context),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          setState(() {
            ThemeServices().switchTheme();
          });

          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode == true
                ? "Activated Light Theme"
                : "Activated Dark Theme",
          );
          //notifyHelper.scheduledNotification();
        },
        child: Get.isDarkMode == false
            ? Icon(Icons.wb_sunny_outlined)
            : Icon(
                Icons.nightlight_round,
                size: 20,
              ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: CircleAvatar(
            backgroundImage: AssetImage("images/gyan.jpg"),
          ),
        ),
      ],
    );
  }

  _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 20),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 16),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 14),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(
            label: "+ Add Task",
            onTap: () async {
              await Get.to(() => AddTaskPage());
              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }
}
