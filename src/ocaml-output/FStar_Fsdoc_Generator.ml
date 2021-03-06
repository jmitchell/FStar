open Prims
let (one_toplevel :
  FStar_Parser_AST.decl Prims.list ->
    (FStar_Parser_AST.decl * FStar_Parser_AST.decl Prims.list)
      FStar_Pervasives_Native.option)
  =
  fun decls  ->
    let uu____53611 =
      FStar_List.partition
        (fun d  ->
           match d.FStar_Parser_AST.d with
           | FStar_Parser_AST.TopLevelModule uu____53624 -> true
           | uu____53626 -> false) decls
       in
    match uu____53611 with
    | (top,nontops) ->
        (match top with
         | t::[] -> FStar_Pervasives_Native.Some (t, nontops)
         | uu____53663 -> FStar_Pervasives_Native.None)
  
type mforest =
  | Leaf of (Prims.string * Prims.string) 
  | Branch of mforest FStar_Util.smap 
let (uu___is_Leaf : mforest -> Prims.bool) =
  fun projectee  ->
    match projectee with | Leaf _0 -> true | uu____53706 -> false
  
let (__proj__Leaf__item___0 : mforest -> (Prims.string * Prims.string)) =
  fun projectee  -> match projectee with | Leaf _0 -> _0 
let (uu___is_Branch : mforest -> Prims.bool) =
  fun projectee  ->
    match projectee with | Branch _0 -> true | uu____53746 -> false
  
let (__proj__Branch__item___0 : mforest -> mforest FStar_Util.smap) =
  fun projectee  -> match projectee with | Branch _0 -> _0 
let (htree : mforest FStar_Util.smap) =
  FStar_Util.smap_create (Prims.parse_int "50") 
let string_of_optiont :
  'Auu____53777 'Auu____53778 .
    ('Auu____53777 -> 'Auu____53778) ->
      'Auu____53778 ->
        'Auu____53777 FStar_Pervasives_Native.option -> 'Auu____53778
  =
  fun f  ->
    fun y  ->
      fun xo  ->
        match xo with
        | FStar_Pervasives_Native.Some x -> f x
        | FStar_Pervasives_Native.None  -> y
  
let (string_of_fsdoco :
  (Prims.string * (Prims.string * Prims.string) Prims.list)
    FStar_Pervasives_Native.option -> Prims.string)
  =
  fun d  ->
    string_of_optiont
      (fun x  ->
         let uu____53871 =
           let uu____53873 = FStar_Parser_AST.string_of_fsdoc x  in
           Prims.op_Hat uu____53873 "*)"  in
         Prims.op_Hat "(*" uu____53871) "" d
  
let (string_of_termo :
  FStar_Parser_AST.term FStar_Pervasives_Native.option -> Prims.string) =
  fun t  -> string_of_optiont FStar_Parser_AST.term_to_string "" t 
let (code_wrap : Prims.string -> Prims.string) =
  fun s  -> Prims.op_Hat "```fsharp\n" (Prims.op_Hat s "\n```\n") 
let (string_of_tycon : FStar_Parser_AST.tycon -> Prims.string) =
  fun tycon  ->
    match tycon with
    | FStar_Parser_AST.TyconAbstract uu____53910 -> "abstract"
    | FStar_Parser_AST.TyconAbbrev uu____53922 -> "abbrev"
    | FStar_Parser_AST.TyconRecord (id1,_bb,_ko,fields) ->
        let uu____53968 =
          let uu____53970 =
            let uu____53972 =
              let uu____53974 =
                FStar_All.pipe_right fields
                  (FStar_List.map
                     (fun uu____54032  ->
                        match uu____54032 with
                        | (id2,t,doco) ->
                            let uu____54088 = string_of_fsdoco doco  in
                            let uu____54090 =
                              let uu____54092 =
                                let uu____54094 =
                                  FStar_Parser_AST.term_to_string t  in
                                Prims.op_Hat ":" uu____54094  in
                              Prims.op_Hat id2.FStar_Ident.idText uu____54092
                               in
                            Prims.op_Hat uu____54088 uu____54090))
                 in
              FStar_All.pipe_right uu____53974 (FStar_String.concat "; ")  in
            Prims.op_Hat uu____53972 " }"  in
          Prims.op_Hat " = { " uu____53970  in
        Prims.op_Hat id1.FStar_Ident.idText uu____53968
    | FStar_Parser_AST.TyconVariant (id1,_bb,_ko,vars) ->
        let uu____54146 =
          let uu____54148 =
            let uu____54150 =
              FStar_All.pipe_right vars
                (FStar_List.map
                   (fun uu____54219  ->
                      match uu____54219 with
                      | (id2,trmo,doco,u) ->
                          let uu____54287 = string_of_fsdoco doco  in
                          let uu____54289 =
                            let uu____54291 =
                              let uu____54293 =
                                string_of_optiont
                                  FStar_Parser_AST.term_to_string "" trmo
                                 in
                              Prims.op_Hat ":" uu____54293  in
                            Prims.op_Hat id2.FStar_Ident.idText uu____54291
                             in
                          Prims.op_Hat uu____54287 uu____54289))
               in
            FStar_All.pipe_right uu____54150 (FStar_String.concat " | ")  in
          Prims.op_Hat " = " uu____54148  in
        Prims.op_Hat id1.FStar_Ident.idText uu____54146
  
let (string_of_decl' : FStar_Parser_AST.decl' -> Prims.string) =
  fun d  ->
    match d with
    | FStar_Parser_AST.TopLevelModule l ->
        Prims.op_Hat "module " l.FStar_Ident.str
    | FStar_Parser_AST.Open l -> Prims.op_Hat "open " l.FStar_Ident.str
    | FStar_Parser_AST.Include l -> Prims.op_Hat "include " l.FStar_Ident.str
    | FStar_Parser_AST.Friend l -> Prims.op_Hat "friend " l.FStar_Ident.str
    | FStar_Parser_AST.ModuleAbbrev (i,l) ->
        Prims.op_Hat "module "
          (Prims.op_Hat i.FStar_Ident.idText
             (Prims.op_Hat " = " l.FStar_Ident.str))
    | FStar_Parser_AST.TopLevelLet (uu____54324,pats) ->
        let termty =
          FStar_List.map
            (fun uu____54362  ->
               match uu____54362 with
               | (p,t) ->
                   let uu____54375 = FStar_Parser_AST.pat_to_string p  in
                   let uu____54377 = FStar_Parser_AST.term_to_string t  in
                   (uu____54375, uu____54377)) pats
           in
        let termty' =
          FStar_List.map
            (fun uu____54395  ->
               match uu____54395 with
               | (p,t) -> Prims.op_Hat p (Prims.op_Hat ":" t)) termty
           in
        Prims.op_Hat "let " (FStar_String.concat ", " termty')
    | FStar_Parser_AST.Main uu____54412 -> "main ..."
    | FStar_Parser_AST.Assume (i,t) ->
        let uu____54416 =
          let uu____54418 =
            let uu____54420 = FStar_Parser_AST.term_to_string t  in
            Prims.op_Hat ":" uu____54420  in
          Prims.op_Hat i.FStar_Ident.idText uu____54418  in
        Prims.op_Hat "assume " uu____54416
    | FStar_Parser_AST.Tycon (uu____54424,tc,tys) ->
        let s = if tc then "class" else "type"  in
        let uu____54455 =
          let uu____54457 =
            FStar_All.pipe_right tys
              (FStar_List.map
                 (fun uu____54510  ->
                    match uu____54510 with
                    | (t,d1) ->
                        let uu____54563 = string_of_tycon t  in
                        let uu____54565 =
                          let uu____54567 = string_of_fsdoco d1  in
                          Prims.op_Hat " " uu____54567  in
                        Prims.op_Hat uu____54563 uu____54565))
             in
          FStar_All.pipe_right uu____54457 (FStar_String.concat " and ")  in
        Prims.op_Hat s uu____54455
    | FStar_Parser_AST.Val (i,t) ->
        let uu____54577 =
          let uu____54579 =
            let uu____54581 = FStar_Parser_AST.term_to_string t  in
            Prims.op_Hat ":" uu____54581  in
          Prims.op_Hat i.FStar_Ident.idText uu____54579  in
        Prims.op_Hat "val " uu____54577
    | FStar_Parser_AST.Exception (i,uu____54586) ->
        Prims.op_Hat "exception " i.FStar_Ident.idText
    | FStar_Parser_AST.NewEffect (FStar_Parser_AST.DefineEffect
        (i,uu____54593,uu____54594,uu____54595)) ->
        Prims.op_Hat "new_effect " i.FStar_Ident.idText
    | FStar_Parser_AST.NewEffect (FStar_Parser_AST.RedefineEffect
        (i,uu____54606,uu____54607)) ->
        Prims.op_Hat "new_effect " i.FStar_Ident.idText
    | FStar_Parser_AST.SubEffect uu____54613 -> "sub_effect"
    | FStar_Parser_AST.Pragma uu____54615 -> "pragma"
    | FStar_Parser_AST.Splice (ids,t) ->
        let uu____54623 = FStar_Parser_AST.term_to_string t  in
        Prims.op_Hat "splice " uu____54623
    | FStar_Parser_AST.Fsdoc (comm,uu____54627) -> comm
  
let (decl_documented : FStar_Parser_AST.decl -> Prims.bool) =
  fun d  ->
    let tycon_documented tt =
      let tyconvars_documented tycon =
        match tycon with
        | FStar_Parser_AST.TyconAbstract uu____54684 -> false
        | FStar_Parser_AST.TyconAbbrev uu____54696 -> false
        | FStar_Parser_AST.TyconRecord
            (uu____54710,uu____54711,uu____54712,fields) ->
            FStar_List.existsb
              (fun uu____54754  ->
                 match uu____54754 with
                 | (_id,_t,doco) -> FStar_Util.is_some doco) fields
        | FStar_Parser_AST.TyconVariant
            (uu____54771,uu____54772,uu____54773,vars) ->
            FStar_List.existsb
              (fun uu____54831  ->
                 match uu____54831 with
                 | (_id,_t,doco,_u) -> FStar_Util.is_some doco) vars
         in
      FStar_List.existsb
        (fun uu____54869  ->
           match uu____54869 with
           | (tycon,doco) ->
               (tyconvars_documented tycon) || (FStar_Util.is_some doco)) tt
       in
    match d.FStar_Parser_AST.doc with
    | FStar_Pervasives_Native.Some uu____54884 -> true
    | uu____54886 ->
        (match d.FStar_Parser_AST.d with
         | FStar_Parser_AST.Fsdoc uu____54890 -> true
         | FStar_Parser_AST.Tycon (uu____54892,uu____54893,ty) ->
             tycon_documented ty
         | uu____54915 -> false)
  
let (document_decl : (Prims.string -> unit) -> FStar_Parser_AST.decl -> unit)
  =
  fun w  ->
    fun d  ->
      if decl_documented d
      then
        let uu____54936 = d  in
        match uu____54936 with
        | { FStar_Parser_AST.d = decl; FStar_Parser_AST.drange = uu____54938;
            FStar_Parser_AST.doc = fsdoc;
            FStar_Parser_AST.quals = uu____54940;
            FStar_Parser_AST.attrs = uu____54941;_} ->
            ((let uu____54945 =
                let uu____54947 = string_of_decl' d.FStar_Parser_AST.d  in
                code_wrap uu____54947  in
              w uu____54945);
             (match fsdoc with
              | FStar_Pervasives_Native.Some (doc1,_kw) ->
                  w (Prims.op_Hat "\n" doc1)
              | uu____54971 -> ());
             w "")
      else ()
  
let document_toplevel :
  'Auu____54984 .
    'Auu____54984 ->
      FStar_Parser_AST.decl ->
        (Prims.string FStar_Pervasives_Native.option * Prims.string
          FStar_Pervasives_Native.option)
  =
  fun name  ->
    fun topdecl  ->
      match topdecl.FStar_Parser_AST.d with
      | FStar_Parser_AST.TopLevelModule uu____55005 ->
          (match topdecl.FStar_Parser_AST.doc with
           | FStar_Pervasives_Native.Some (doc1,kw) ->
               let uu____55036 =
                 FStar_List.tryFind
                   (fun uu____55054  ->
                      match uu____55054 with | (k,v1) -> k = "summary") kw
                  in
               (match uu____55036 with
                | FStar_Pervasives_Native.None  ->
                    (FStar_Pervasives_Native.None,
                      (FStar_Pervasives_Native.Some doc1))
                | FStar_Pervasives_Native.Some (uu____55094,summary) ->
                    ((FStar_Pervasives_Native.Some summary),
                      (FStar_Pervasives_Native.Some doc1)))
           | FStar_Pervasives_Native.None  ->
               (FStar_Pervasives_Native.None, FStar_Pervasives_Native.None))
      | uu____55122 ->
          FStar_Errors.raise_err
            (FStar_Errors.Fatal_NotTopLevelModule, "Not Top-level Module")
  
let (document_module : FStar_Parser_AST.modul -> FStar_Ident.lident) =
  fun m  ->
    let uu____55141 =
      match m with
      | FStar_Parser_AST.Module (n1,d) -> (n1, d, "module")
      | FStar_Parser_AST.Interface (n1,d,uu____55172) -> (n1, d, "interface")
       in
    match uu____55141 with
    | (name,decls,_mt) ->
        let uu____55192 = one_toplevel decls  in
        (match uu____55192 with
         | FStar_Pervasives_Native.Some (top_decl,other_decls) ->
             let on1 =
               FStar_Options.prepend_output_dir
                 (Prims.op_Hat name.FStar_Ident.str ".md")
                in
             let fd = FStar_Util.open_file_for_writing on1  in
             let w = FStar_Util.append_to_file fd  in
             let no_summary = "fsdoc: no-summary-found"  in
             let no_comment = "fsdoc: no-comment-found"  in
             let uu____55229 = document_toplevel name top_decl  in
             (match uu____55229 with
              | (summary,comment) ->
                  let summary1 =
                    match summary with
                    | FStar_Pervasives_Native.Some s -> s
                    | FStar_Pervasives_Native.None  -> no_summary  in
                  let comment1 =
                    match comment with
                    | FStar_Pervasives_Native.Some s -> s
                    | FStar_Pervasives_Native.None  -> no_comment  in
                  ((let uu____55269 =
                      FStar_Util.format "# module %s" [name.FStar_Ident.str]
                       in
                    w uu____55269);
                   (let uu____55275 = FStar_Util.format "%s\n" [summary1]  in
                    w uu____55275);
                   (let uu____55281 = FStar_Util.format "%s\n" [comment1]  in
                    w uu____55281);
                   FStar_List.iter (document_decl w) other_decls;
                   FStar_Util.close_file fd;
                   name))
         | FStar_Pervasives_Native.None  ->
             let uu____55294 =
               let uu____55300 =
                 FStar_Util.format1 "No singleton toplevel in module %s"
                   name.FStar_Ident.str
                  in
               (FStar_Errors.Fatal_NonSingletonTopLevel, uu____55300)  in
             FStar_Errors.raise_err uu____55294)
  
let (generate : Prims.string Prims.list -> unit) =
  fun files  ->
    let modules =
      FStar_List.map
        (fun fn  ->
           let uu____55324 = FStar_Parser_Driver.parse_file fn  in
           FStar_Pervasives_Native.fst uu____55324) files
       in
    let mods = FStar_List.map document_module modules  in
    let on1 = FStar_Options.prepend_output_dir "index.md"  in
    let fd = FStar_Util.open_file_for_writing on1  in
    FStar_List.iter
      (fun m  ->
         let uu____55354 = FStar_Util.format "%s\n" [m.FStar_Ident.str]  in
         FStar_Util.append_to_file fd uu____55354) mods;
    FStar_Util.close_file fd
  