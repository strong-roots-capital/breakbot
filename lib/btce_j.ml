(* Auto-generated from "btce.atd" *)


type order_book = Btce_t.order_book = {
  bids: float list list;
  asks: float list list
}

let write__1 = (
  Ag_oj_run.write_list (
    Yojson.Safe.write_float
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    Ag_oj_run.read_number
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    write__1
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    read__1
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_order_book = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"bids\":";
    (
      write__2
    )
      ob x.bids;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"asks\":";
    (
      write__2
    )
      ob x.asks;
    Bi_outbuf.add_char ob '}';
)
let string_of_order_book ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_order_book ob x;
  Bi_outbuf.contents ob
let read_order_book = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let x =
      {
        bids = Obj.magic 0.0;
        asks = Obj.magic 0.0;
      }
    in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 4 then (
            match String.unsafe_get s pos with
              | 'a' -> (
                  if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'k' && String.unsafe_get s (pos+3) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 'b' -> (
                  if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 's' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
          )
          else (
            -1
          )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            let v =
              (
                read__2
              ) p lb
            in
            Obj.set_field (Obj.repr x) 0 (Obj.repr v);
            bits0 := !bits0 lor 0x1;
          | 1 ->
            let v =
              (
                read__2
              ) p lb
            in
            Obj.set_field (Obj.repr x) 1 (Obj.repr v);
            bits0 := !bits0 lor 0x2;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            if len = 4 then (
              match String.unsafe_get s pos with
                | 'a' -> (
                    if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'k' && String.unsafe_get s (pos+3) = 's' then (
                      1
                    )
                    else (
                      -1
                    )
                  )
                | 'b' -> (
                    if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 's' then (
                      0
                    )
                    else (
                      -1
                    )
                  )
                | _ -> (
                    -1
                  )
            )
            else (
              -1
            )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              let v =
                (
                  read__2
                ) p lb
              in
              Obj.set_field (Obj.repr x) 0 (Obj.repr v);
              bits0 := !bits0 lor 0x1;
            | 1 ->
              let v =
                (
                  read__2
                ) p lb
              in
              Obj.set_field (Obj.repr x) 1 (Obj.repr v);
              bits0 := !bits0 lor 0x2;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields [| !bits0 |] [| "bids"; "asks" |];
        Ag_oj_run.identity x
      )
)
let order_book_of_string s =
  read_order_book (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
