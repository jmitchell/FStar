open Prims
let (is_cache_file : Prims.string -> Prims.bool) =
  fun fn  ->
    let uu____50339 = FStar_Util.get_file_extension fn  in
    uu____50339 = ".cache"
  
type fragment =
  | Empty 
  | Modul of FStar_Parser_AST.modul 
  | Decls of FStar_Parser_AST.decl Prims.list 
let (uu___is_Empty : fragment -> Prims.bool) =
  fun projectee  ->
    match projectee with | Empty  -> true | uu____50364 -> false
  
let (uu___is_Modul : fragment -> Prims.bool) =
  fun projectee  ->
    match projectee with | Modul _0 -> true | uu____50376 -> false
  
let (__proj__Modul__item___0 : fragment -> FStar_Parser_AST.modul) =
  fun projectee  -> match projectee with | Modul _0 -> _0 
let (uu___is_Decls : fragment -> Prims.bool) =
  fun projectee  ->
    match projectee with | Decls _0 -> true | uu____50398 -> false
  
let (__proj__Decls__item___0 : fragment -> FStar_Parser_AST.decl Prims.list)
  = fun projectee  -> match projectee with | Decls _0 -> _0 
let (parse_fragment : FStar_Parser_ParseIt.input_frag -> fragment) =
  fun frag  ->
    let uu____50420 =
      FStar_Parser_ParseIt.parse (FStar_Parser_ParseIt.Toplevel frag)  in
    match uu____50420 with
    | FStar_Parser_ParseIt.ASTFragment (FStar_Util.Inl modul,uu____50422) ->
        Modul modul
    | FStar_Parser_ParseIt.ASTFragment (FStar_Util.Inr [],uu____50439) ->
        Empty
    | FStar_Parser_ParseIt.ASTFragment (FStar_Util.Inr decls,uu____50457) ->
        Decls decls
    | FStar_Parser_ParseIt.ParseError (e,msg,r) ->
        FStar_Errors.raise_error (e, msg) r
    | FStar_Parser_ParseIt.Term uu____50482 ->
        failwith
          "Impossible: parsing a Toplevel always results in an ASTFragment"
  
let (parse_file :
  Prims.string ->
    (FStar_Parser_AST.file * (Prims.string * FStar_Range.range) Prims.list))
  =
  fun fn  ->
    let uu____50503 =
      FStar_Parser_ParseIt.parse (FStar_Parser_ParseIt.Filename fn)  in
    match uu____50503 with
    | FStar_Parser_ParseIt.ASTFragment (FStar_Util.Inl ast,comments) ->
        (ast, comments)
    | FStar_Parser_ParseIt.ASTFragment
        (FStar_Util.Inr uu____50540,uu____50541) ->
        let msg = FStar_Util.format1 "%s: expected a module\n" fn  in
        let r = FStar_Range.dummyRange  in
        FStar_Errors.raise_error (FStar_Errors.Fatal_ModuleExpected, msg) r
    | FStar_Parser_ParseIt.ParseError (e,msg,r) ->
        FStar_Errors.raise_error (e, msg) r
    | FStar_Parser_ParseIt.Term uu____50593 ->
        failwith
          "Impossible: parsing a Filename always results in an ASTFragment"
  