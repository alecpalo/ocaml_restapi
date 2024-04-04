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
end;;


let tasks : task list = [];;

let getList _req = 
  Response.of_plain_text |> Lwt.return

let addTask req =
    let name = Router.param req "name" in
    Printf.sprintf "Hello, %s" name |> Response.of_plain_text |> Lwt.return

let removeTask req =
  let task = Router.param req "task" in 
  let temp = `Assoc [
    ("deteled", `String task);
  ] in
  Response.of_json temp |> Lwt.return

let () =
    App.empty
    |> App.get "/" getList 
    |> App.get "/add/:name" addTask 
    |> App.get "/remove/:task" removeTask 
    |> App.run_command
    |> ignore
