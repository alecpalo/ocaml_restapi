# ocaml restapi

To run:
dune exec -- ocaml_restapi

## What is this?
I want to learn OCaml and I want to brush up on restapis.

This is going to be a restapi todo list where you can Post todos, get the list of todos, and remove todos

## Definitions

"/" -> gets all tasks
"/:title" -> returns only the task where title == :title, if no task == :title returns nothing
"/add" -> returns 200 if succeeded, else returns error
    - Body will be a JSON where "title": title, "description": description, "deadline": deadline
"/remove" -> returns 200 on suceed, else returns error
    - Body will be a JSON where "title": title
