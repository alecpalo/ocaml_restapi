open Opium

class task (title : string) (description : string) (deadline : string) = object
  val mutable title = title
  val mutable description = description
  val mutable deadline = deadline
  
  method getTitle = title
  method setTitle newTitle = title <- newTitle

  method getDescription = description
  method setDescription newDescription = description <- newDescription 

  method getDeadline = deadline
  method setDeadline newDeadline = deadline <- newDeadline

  method toJson : Yojson.Safe.t = 
    `Assoc [
      ("title", `String title);
      ("description", `String description);
      ("deadline", `String deadline)
    ]
end;;

let tasks : task list ref = ref [];;

let taskToJson taskList =
  `List (List.map (fun t -> t#toJson) taskList)
;;

let removeTask title = 
  tasks := List.filter(fun t -> t#getTitle <> title) !tasks
;;

let addTask title description deadline =
  tasks := !tasks @ [new task title description deadline]
;;

(* get all the tasks *)
let getTasksHandler _req = 
  let json = taskToJson !tasks in
  Response.of_json json |> Lwt.return
;;

(* add a task to the list *)
let addTaskHandler req =
  let body = Request.to_json in 
   
  Printf.sprintf "Hello, Alec" |> Response.of_plain_text |> Lwt.return 
;;

(* remove one task from your list *)
let removeTaskHandler req =
  let title = Router.param req "title" in 
  removeTask title;
  let json = `Assoc [
    ("deteled", `String title);
  ] in
  Response.of_json json |> Lwt.return
;;

(* This is to get one task *)
let getTaskHanlder req = 
  let title = Router.param req "title" in
  Response.of_json (`Assoc [ "message", `String title ]) |> Lwt.return
;;

let () =
    App.empty
    |> App.get "/" getTasksHandler 
    |> App.get "/:title" getTaskHanlder
    |> App.post "/add" addTaskHandler 
    |> App.post "/remove" removeTaskHandler 
    |> App.run_command
    |> ignore
;;
