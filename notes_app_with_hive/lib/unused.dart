// FutureBuilder(
//     future: Hive.openBox("faizan"),
//     builder: (context, snapshot) {
//       return Column(
//         children: [
//           Card(
//             child: ListTile(
//               title: Text(snapshot.data!.get("name".toString())),
//               subtitle: Text(
//                   snapshot.data!.get("details")["pro"].toString()),
//               trailing: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       snapshot.data!
//                           .put("name", "Muhammad Faizan Aslam");
//                     });
//                   },
//                   icon: Icon(Icons.pentagon)),

// ListView.builder(
// itemCount: box.length,
// itemBuilder: (context, index) {
// return Card(
// child: ListTile(
// title: Text(data[index].title.toString()),
// subtitle: Text(data[index].description.toString()),
// // subtitle: Text(data.description.toString()),
// ),
// );
// });
// actions: [
//   TextButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       child: Text("Add")),
//   TextButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       child: Text("Add")),
// ],
