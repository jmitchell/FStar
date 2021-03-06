open Prims
type ident = {
  idText: Prims.string ;
  idRange: FStar_Range.range }[@@deriving yojson,show]
let (__proj__Mkident__item__idText : ident -> Prims.string) =
  fun projectee  -> match projectee with | { idText; idRange;_} -> idText 
let (__proj__Mkident__item__idRange : ident -> FStar_Range.range) =
  fun projectee  -> match projectee with | { idText; idRange;_} -> idRange 
type path = Prims.string Prims.list
type lident =
  {
  ns: ident Prims.list ;
  ident: ident ;
  nsstr: Prims.string ;
  str: Prims.string }[@@deriving yojson,show]
let (__proj__Mklident__item__ns : lident -> ident Prims.list) =
  fun projectee  -> match projectee with | { ns; ident; nsstr; str;_} -> ns 
let (__proj__Mklident__item__ident : lident -> ident) =
  fun projectee  ->
    match projectee with | { ns; ident; nsstr; str;_} -> ident
  
let (__proj__Mklident__item__nsstr : lident -> Prims.string) =
  fun projectee  ->
    match projectee with | { ns; ident; nsstr; str;_} -> nsstr
  
let (__proj__Mklident__item__str : lident -> Prims.string) =
  fun projectee  -> match projectee with | { ns; ident; nsstr; str;_} -> str 
type lid = lident[@@deriving yojson,show]
let (mk_ident : (Prims.string * FStar_Range.range) -> ident) =
  fun uu____34462  ->
    match uu____34462 with
    | (text,range) -> { idText = text; idRange = range }
  
let (reserved_prefix : Prims.string) = "uu___" 
let (_gen : ((unit -> Prims.int) * (unit -> unit))) =
  let x = FStar_Util.mk_ref (Prims.parse_int "0")  in
  let next_id uu____34499 =
    let v1 = FStar_ST.op_Bang x  in
    FStar_ST.op_Colon_Equals x (v1 + (Prims.parse_int "1")); v1  in
  let reset uu____34595 = FStar_ST.op_Colon_Equals x (Prims.parse_int "0")
     in
  (next_id, reset) 
let (next_id : unit -> Prims.int) =
  fun uu____34653  -> FStar_Pervasives_Native.fst _gen () 
let (reset_gensym : unit -> unit) =
  fun uu____34666  -> FStar_Pervasives_Native.snd _gen () 
let (gen : FStar_Range.range -> ident) =
  fun r  ->
    let i = next_id ()  in
    mk_ident ((Prims.op_Hat reserved_prefix (Prims.string_of_int i)), r)
  
let (range_of_id : ident -> FStar_Range.range) = fun id1  -> id1.idRange 
let (id_of_text : Prims.string -> ident) =
  fun str  -> mk_ident (str, FStar_Range.dummyRange) 
let (text_of_id : ident -> Prims.string) = fun id1  -> id1.idText 
let (text_of_path : path -> Prims.string) =
  fun path  -> FStar_Util.concat_l "." path 
let (path_of_text : Prims.string -> path) =
  fun text  -> FStar_String.split [46] text 
let (path_of_ns : ident Prims.list -> path) =
  fun ns  -> FStar_List.map text_of_id ns 
let (path_of_lid : lident -> path) =
  fun lid  ->
    FStar_List.map text_of_id (FStar_List.append lid.ns [lid.ident])
  
let (ids_of_lid : lident -> ident Prims.list) =
  fun lid  -> FStar_List.append lid.ns [lid.ident] 
let (lid_of_ns_and_id : ident Prims.list -> ident -> lident) =
  fun ns  ->
    fun id1  ->
      let nsstr =
        let uu____34767 = FStar_List.map text_of_id ns  in
        FStar_All.pipe_right uu____34767 text_of_path  in
      {
        ns;
        ident = id1;
        nsstr;
        str =
          (if nsstr = ""
           then id1.idText
           else Prims.op_Hat nsstr (Prims.op_Hat "." id1.idText))
      }
  
let (lid_of_ids : ident Prims.list -> lident) =
  fun ids  ->
    let uu____34787 = FStar_Util.prefix ids  in
    match uu____34787 with | (ns,id1) -> lid_of_ns_and_id ns id1
  
let (lid_of_str : Prims.string -> lident) =
  fun str  ->
    let uu____34808 = FStar_List.map id_of_text (FStar_Util.split str ".")
       in
    lid_of_ids uu____34808
  
let (lid_of_path : path -> FStar_Range.range -> lident) =
  fun path  ->
    fun pos  ->
      let ids = FStar_List.map (fun s  -> mk_ident (s, pos)) path  in
      lid_of_ids ids
  
let (text_of_lid : lident -> Prims.string) = fun lid  -> lid.str 
let (lid_equals : lident -> lident -> Prims.bool) =
  fun l1  -> fun l2  -> l1.str = l2.str 
let (ident_equals : ident -> ident -> Prims.bool) =
  fun id1  -> fun id2  -> id1.idText = id2.idText 
let (range_of_lid : lident -> FStar_Range.range) =
  fun lid  -> range_of_id lid.ident 
let (set_lid_range : lident -> FStar_Range.range -> lident) =
  fun l  ->
    fun r  ->
      let uu___350_34882 = l  in
      {
        ns = (uu___350_34882.ns);
        ident =
          (let uu___352_34884 = l.ident  in
           { idText = (uu___352_34884.idText); idRange = r });
        nsstr = (uu___350_34882.nsstr);
        str = (uu___350_34882.str)
      }
  
let (lid_add_suffix : lident -> Prims.string -> lident) =
  fun l  ->
    fun s  ->
      let path = path_of_lid l  in
      let uu____34899 = range_of_lid l  in
      lid_of_path (FStar_List.append path [s]) uu____34899
  
let (ml_path_of_lid : lident -> Prims.string) =
  fun lid  ->
    let uu____34910 =
      let uu____34914 = path_of_ns lid.ns  in
      let uu____34918 =
        let uu____34922 = text_of_id lid.ident  in [uu____34922]  in
      FStar_List.append uu____34914 uu____34918  in
    FStar_All.pipe_left (FStar_String.concat "_") uu____34910
  
let (string_of_ident : ident -> Prims.string) = fun id1  -> id1.idText 
let (string_of_lid : lident -> Prims.string) =
  fun lid  -> let uu____34946 = path_of_lid lid  in text_of_path uu____34946 