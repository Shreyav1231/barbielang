open Js_of_ocaml

(** Reference to the debug callback function set from JavaScript *)
let debug_callback : (string -> unit) ref = ref (fun _ -> ())

let set_debug_callback callback =
  debug_callback := callback

let run_barbie source =
   try
     let tokens = Barbie_lib.Lexer.tokenize (Js.to_string source) in
     let ast = Barbie_lib.Parser.parse tokens in
     let (output, debug) = Barbie_lib.Eval.run ~on_debug:!debug_callback ast in
     let output_js = List.map Js.string output |> Array.of_list |> Js.array in
     let debug_js = List.map Js.string debug |> Array.of_list |> Js.array in
     Js.Unsafe.obj [|
       ("ok", Js.Unsafe.inject Js._true);
       ("output", Js.Unsafe.inject output_js);
       ("debug", Js.Unsafe.inject debug_js);
       ("error", Js.Unsafe.inject Js.null);
     |]
  with
  | Barbie_lib.Lexer.Lexer_error msg ->
    Js.Unsafe.obj [|
      ("ok", Js.Unsafe.inject Js._false);
      ("output", Js.Unsafe.inject (Js.array [||]));
      ("debug", Js.Unsafe.inject (Js.array [||]));
      ("error", Js.Unsafe.inject (Js.some (Js.string ("Lexer error: " ^ msg))));
    |]
  | Barbie_lib.Parser.Parse_error msg ->
    Js.Unsafe.obj [|
      ("ok", Js.Unsafe.inject Js._false);
      ("output", Js.Unsafe.inject (Js.array [||]));
      ("debug", Js.Unsafe.inject (Js.array [||]));
      ("error", Js.Unsafe.inject (Js.some (Js.string ("Parse error: " ^ msg))));
    |]
  | Barbie_lib.Eval.Runtime_error msg ->
    Js.Unsafe.obj [|
      ("ok", Js.Unsafe.inject Js._false);
      ("output", Js.Unsafe.inject (Js.array [||]));
      ("debug", Js.Unsafe.inject (Js.array [||]));
      ("error", Js.Unsafe.inject (Js.some (Js.string ("Runtime error: " ^ msg))));
    |]
  | e ->
    Js.Unsafe.obj [|
      ("ok", Js.Unsafe.inject Js._false);
      ("output", Js.Unsafe.inject (Js.array [||]));
      ("debug", Js.Unsafe.inject (Js.array [||]));
      ("error", Js.Unsafe.inject (Js.some (Js.string ("Unknown error: " ^ Printexc.to_string e))));
    |]

let set_debug_callback_js callback =
  set_debug_callback (fun msg ->
    ignore (Js.Unsafe.fun_call callback [|Js.Unsafe.inject (Js.string msg)|])
  )

let () =
   let interpreter = Js.Unsafe.obj [|
     ("run", Js.Unsafe.inject (Js.wrap_callback run_barbie));
     ("setDebugCallback", Js.Unsafe.inject (Js.wrap_callback set_debug_callback_js));
   |] in
   Js.Unsafe.set Js.Unsafe.global (Js.string "BarbieInterpreter") interpreter
