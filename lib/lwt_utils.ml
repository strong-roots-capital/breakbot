(*
 * Copyright (c) 2012 Vincent Bernardoff <vb@luminar.eu.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)

let (>>=)      = Lwt.bind
let (=<<) f g  = Lwt.bind g f
let (>|=) f g  = Lwt.map g f
let (=|<) f g  = Lwt.map f g

module Lwt = struct
  include Lwt

  let wrapopt = function
    | Some v -> return v
    | None   -> raise_lwt Not_found

  let bind_opt m =
    bind m (function Some v -> return v | None -> raise_lwt Not_found)
end

module Lwt_io = struct
  include Lwt_io
  open Lwt_unix

  let sockaddr_of_dns
      ?(gaiopts = [AI_FAMILY(PF_INET); AI_SOCKTYPE(SOCK_STREAM)])
      node service =
    (match_lwt getaddrinfo node service gaiopts with
     | h::t -> Lwt.return h
     | []   -> raise_lwt Not_found)
    >|= fun ai -> ai.ai_addr
end
