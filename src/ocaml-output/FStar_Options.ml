open Prims
type debug_level_t =
  | Low
  | Medium
  | High
  | Extreme
  | Other of Prims.string[@@deriving show]
let uu___is_Low: debug_level_t -> Prims.bool =
  fun projectee  -> match projectee with | Low  -> true | uu____8 -> false
let uu___is_Medium: debug_level_t -> Prims.bool =
  fun projectee  ->
    match projectee with | Medium  -> true | uu____12 -> false
let uu___is_High: debug_level_t -> Prims.bool =
  fun projectee  -> match projectee with | High  -> true | uu____16 -> false
let uu___is_Extreme: debug_level_t -> Prims.bool =
  fun projectee  ->
    match projectee with | Extreme  -> true | uu____20 -> false
let uu___is_Other: debug_level_t -> Prims.bool =
  fun projectee  ->
    match projectee with | Other _0 -> true | uu____25 -> false
let __proj__Other__item___0: debug_level_t -> Prims.string =
  fun projectee  -> match projectee with | Other _0 -> _0
type option_val =
  | Bool of Prims.bool
  | String of Prims.string
  | Path of Prims.string
  | Int of Prims.int
  | List of option_val Prims.list
  | Unset[@@deriving show]
let uu___is_Bool: option_val -> Prims.bool =
  fun projectee  ->
    match projectee with | Bool _0 -> true | uu____59 -> false
let __proj__Bool__item___0: option_val -> Prims.bool =
  fun projectee  -> match projectee with | Bool _0 -> _0
let uu___is_String: option_val -> Prims.bool =
  fun projectee  ->
    match projectee with | String _0 -> true | uu____71 -> false
let __proj__String__item___0: option_val -> Prims.string =
  fun projectee  -> match projectee with | String _0 -> _0
let uu___is_Path: option_val -> Prims.bool =
  fun projectee  ->
    match projectee with | Path _0 -> true | uu____83 -> false
let __proj__Path__item___0: option_val -> Prims.string =
  fun projectee  -> match projectee with | Path _0 -> _0
let uu___is_Int: option_val -> Prims.bool =
  fun projectee  -> match projectee with | Int _0 -> true | uu____95 -> false
let __proj__Int__item___0: option_val -> Prims.int =
  fun projectee  -> match projectee with | Int _0 -> _0
let uu___is_List: option_val -> Prims.bool =
  fun projectee  ->
    match projectee with | List _0 -> true | uu____109 -> false
let __proj__List__item___0: option_val -> option_val Prims.list =
  fun projectee  -> match projectee with | List _0 -> _0
let uu___is_Unset: option_val -> Prims.bool =
  fun projectee  ->
    match projectee with | Unset  -> true | uu____126 -> false
let mk_bool: Prims.bool -> option_val = fun _0_27  -> Bool _0_27
let mk_string: Prims.string -> option_val = fun _0_28  -> String _0_28
let mk_path: Prims.string -> option_val = fun _0_29  -> Path _0_29
let mk_int: Prims.int -> option_val = fun _0_30  -> Int _0_30
let mk_list: option_val Prims.list -> option_val = fun _0_31  -> List _0_31
type options =
  | Set
  | Reset
  | Restore[@@deriving show]
let uu___is_Set: options -> Prims.bool =
  fun projectee  -> match projectee with | Set  -> true | uu____142 -> false
let uu___is_Reset: options -> Prims.bool =
  fun projectee  ->
    match projectee with | Reset  -> true | uu____146 -> false
let uu___is_Restore: options -> Prims.bool =
  fun projectee  ->
    match projectee with | Restore  -> true | uu____150 -> false
let __unit_tests__: Prims.bool FStar_ST.ref = FStar_Util.mk_ref false
let __unit_tests: Prims.unit -> Prims.bool =
  fun uu____166  -> FStar_ST.op_Bang __unit_tests__
let __set_unit_tests: Prims.unit -> Prims.unit =
  fun uu____217  -> FStar_ST.op_Colon_Equals __unit_tests__ true
let __clear_unit_tests: Prims.unit -> Prims.unit =
  fun uu____268  -> FStar_ST.op_Colon_Equals __unit_tests__ false
let as_bool: option_val -> Prims.bool =
  fun uu___29_319  ->
    match uu___29_319 with
    | Bool b -> b
    | uu____321 -> failwith "Impos: expected Bool"
let as_int: option_val -> Prims.int =
  fun uu___30_324  ->
    match uu___30_324 with
    | Int b -> b
    | uu____326 -> failwith "Impos: expected Int"
let as_string: option_val -> Prims.string =
  fun uu___31_329  ->
    match uu___31_329 with
    | String b -> b
    | Path b -> FStar_Common.try_convert_file_name_to_mixed b
    | uu____332 -> failwith "Impos: expected String"
let as_list': option_val -> option_val Prims.list =
  fun uu___32_337  ->
    match uu___32_337 with
    | List ts -> ts
    | uu____343 -> failwith "Impos: expected List"
let as_list:
  'Auu____349 .
    (option_val -> 'Auu____349) -> option_val -> 'Auu____349 Prims.list
  =
  fun as_t  ->
    fun x  ->
      let uu____365 = as_list' x in
      FStar_All.pipe_right uu____365 (FStar_List.map as_t)
let as_option:
  'Auu____375 .
    (option_val -> 'Auu____375) ->
      option_val -> 'Auu____375 FStar_Pervasives_Native.option
  =
  fun as_t  ->
    fun uu___33_388  ->
      match uu___33_388 with
      | Unset  -> FStar_Pervasives_Native.None
      | v1 ->
          let uu____392 = as_t v1 in FStar_Pervasives_Native.Some uu____392
type optionstate = option_val FStar_Util.smap[@@deriving show]
let fstar_options: optionstate Prims.list FStar_ST.ref = FStar_Util.mk_ref []
let peek: Prims.unit -> optionstate =
  fun uu____414  ->
    let uu____415 = FStar_ST.op_Bang fstar_options in FStar_List.hd uu____415
let pop: Prims.unit -> Prims.unit =
  fun uu____472  ->
    let uu____473 = FStar_ST.op_Bang fstar_options in
    match uu____473 with
    | [] -> failwith "TOO MANY POPS!"
    | uu____528::[] -> failwith "TOO MANY POPS!"
    | uu____529::tl1 -> FStar_ST.op_Colon_Equals fstar_options tl1
let push: Prims.unit -> Prims.unit =
  fun uu____587  ->
    let uu____588 =
      let uu____591 =
        let uu____594 = peek () in FStar_Util.smap_copy uu____594 in
      let uu____597 = FStar_ST.op_Bang fstar_options in uu____591 ::
        uu____597 in
    FStar_ST.op_Colon_Equals fstar_options uu____588
let set: optionstate -> Prims.unit =
  fun o  ->
    let uu____711 = FStar_ST.op_Bang fstar_options in
    match uu____711 with
    | [] -> failwith "set on empty option stack"
    | uu____766::os -> FStar_ST.op_Colon_Equals fstar_options (o :: os)
let set_option: Prims.string -> option_val -> Prims.unit =
  fun k  ->
    fun v1  -> let uu____828 = peek () in FStar_Util.smap_add uu____828 k v1
let set_option':
  (Prims.string,option_val) FStar_Pervasives_Native.tuple2 -> Prims.unit =
  fun uu____837  -> match uu____837 with | (k,v1) -> set_option k v1
let with_saved_options: 'a . (Prims.unit -> 'a) -> 'a =
  fun f  -> push (); (let retv = f () in pop (); retv)
let light_off_files: Prims.string Prims.list FStar_ST.ref =
  FStar_Util.mk_ref []
let add_light_off_file: Prims.string -> Prims.unit =
  fun filename  ->
    let uu____879 =
      let uu____882 = FStar_ST.op_Bang light_off_files in filename ::
        uu____882 in
    FStar_ST.op_Colon_Equals light_off_files uu____879
let defaults:
  (Prims.string,option_val) FStar_Pervasives_Native.tuple2 Prims.list =
  [("__temp_no_proj", (List []));
  ("admit_smt_queries", (Bool false));
  ("admit_except", Unset);
  ("cache_checked_modules", (Bool false));
  ("codegen", Unset);
  ("codegen-lib", (List []));
  ("debug", (List []));
  ("debug_level", (List []));
  ("dep", Unset);
  ("detail_errors", (Bool false));
  ("detail_hint_replay", (Bool false));
  ("doc", (Bool false));
  ("dump_module", (List []));
  ("eager_inference", (Bool false));
  ("expose_interfaces", (Bool false));
  ("extract_all", (Bool false));
  ("extract_module", (List []));
  ("extract_namespace", (List []));
  ("fs_typ_app", (Bool false));
  ("fstar_home", Unset);
  ("full_context_dependency", (Bool true));
  ("gen_native_tactics", Unset);
  ("hide_uvar_nums", (Bool false));
  ("hint_info", (Bool false));
  ("hint_file", Unset);
  ("in", (Bool false));
  ("ide", (Bool false));
  ("include", (List []));
  ("indent", (Bool false));
  ("initial_fuel", (Int (Prims.parse_int "2")));
  ("initial_ifuel", (Int (Prims.parse_int "1")));
  ("lax", (Bool false));
  ("load", (List []));
  ("log_queries", (Bool false));
  ("log_types", (Bool false));
  ("max_fuel", (Int (Prims.parse_int "8")));
  ("max_ifuel", (Int (Prims.parse_int "2")));
  ("min_fuel", (Int (Prims.parse_int "1")));
  ("MLish", (Bool false));
  ("n_cores", (Int (Prims.parse_int "1")));
  ("no_default_includes", (Bool false));
  ("no_extract", (List []));
  ("no_location_info", (Bool false));
  ("no_tactics", (Bool false));
  ("odir", Unset);
  ("prims", Unset);
  ("pretype", (Bool true));
  ("prims_ref", Unset);
  ("print_bound_var_types", (Bool false));
  ("print_effect_args", (Bool false));
  ("print_full_names", (Bool false));
  ("print_implicits", (Bool false));
  ("print_universes", (Bool false));
  ("print_z3_statistics", (Bool false));
  ("prn", (Bool false));
  ("query_stats", (Bool false));
  ("record_hints", (Bool false));
  ("reuse_hint_for", Unset);
  ("silent", (Bool false));
  ("smt", Unset);
  ("smtencoding.elim_box", (Bool false));
  ("smtencoding.nl_arith_repr", (String "boxwrap"));
  ("smtencoding.l_arith_repr", (String "boxwrap"));
  ("tactic_raw_binders", (Bool false));
  ("tactic_trace", (Bool false));
  ("tactic_trace_d", (Int (Prims.parse_int "0")));
  ("timing", (Bool false));
  ("trace_error", (Bool false));
  ("ugly", (Bool false));
  ("unthrottle_inductives", (Bool false));
  ("unsafe_tactic_exec", (Bool false));
  ("use_native_tactics", Unset);
  ("use_eq_at_higher_order", (Bool false));
  ("use_hints", (Bool false));
  ("use_hint_hashes", (Bool false));
  ("using_facts_from", Unset);
  ("verify_module", (List []));
  ("warn_default_effects", (Bool false));
  ("z3refresh", (Bool false));
  ("z3rlimit", (Int (Prims.parse_int "5")));
  ("z3rlimit_factor", (Int (Prims.parse_int "1")));
  ("z3seed", (Int (Prims.parse_int "0")));
  ("z3cliopt", (List []));
  ("use_two_phase_tc", (Bool false));
  ("__no_positivity", (Bool false));
  ("__ml_no_eta_expand_coertions", (Bool false));
  ("warn_error", (String ""))]
let init: Prims.unit -> Prims.unit =
  fun uu____1349  ->
    let o = peek () in
    FStar_Util.smap_clear o;
    FStar_All.pipe_right defaults (FStar_List.iter set_option')
let clear: Prims.unit -> Prims.unit =
  fun uu____1364  ->
    let o = FStar_Util.smap_create (Prims.parse_int "50") in
    FStar_ST.op_Colon_Equals fstar_options [o];
    FStar_ST.op_Colon_Equals light_off_files [];
    init ()
let _run: Prims.unit = clear ()
let get_option: Prims.string -> option_val =
  fun s  ->
    let uu____1481 =
      let uu____1484 = peek () in FStar_Util.smap_try_find uu____1484 s in
    match uu____1481 with
    | FStar_Pervasives_Native.None  ->
        failwith
          (Prims.strcat "Impossible: option " (Prims.strcat s " not found"))
    | FStar_Pervasives_Native.Some s1 -> s1
let lookup_opt:
  'Auu____1491 . Prims.string -> (option_val -> 'Auu____1491) -> 'Auu____1491
  = fun s  -> fun c  -> c (get_option s)
let get_admit_smt_queries: Prims.unit -> Prims.bool =
  fun uu____1507  -> lookup_opt "admit_smt_queries" as_bool
let get_admit_except:
  Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1512  -> lookup_opt "admit_except" (as_option as_string)
let get_cache_checked_modules: Prims.unit -> Prims.bool =
  fun uu____1517  -> lookup_opt "cache_checked_modules" as_bool
let get_codegen: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1522  -> lookup_opt "codegen" (as_option as_string)
let get_codegen_lib: Prims.unit -> Prims.string Prims.list =
  fun uu____1529  -> lookup_opt "codegen-lib" (as_list as_string)
let get_debug: Prims.unit -> Prims.string Prims.list =
  fun uu____1536  -> lookup_opt "debug" (as_list as_string)
let get_debug_level: Prims.unit -> Prims.string Prims.list =
  fun uu____1543  -> lookup_opt "debug_level" (as_list as_string)
let get_dep: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1550  -> lookup_opt "dep" (as_option as_string)
let get_detail_errors: Prims.unit -> Prims.bool =
  fun uu____1555  -> lookup_opt "detail_errors" as_bool
let get_detail_hint_replay: Prims.unit -> Prims.bool =
  fun uu____1558  -> lookup_opt "detail_hint_replay" as_bool
let get_doc: Prims.unit -> Prims.bool =
  fun uu____1561  -> lookup_opt "doc" as_bool
let get_dump_module: Prims.unit -> Prims.string Prims.list =
  fun uu____1566  -> lookup_opt "dump_module" (as_list as_string)
let get_eager_inference: Prims.unit -> Prims.bool =
  fun uu____1571  -> lookup_opt "eager_inference" as_bool
let get_expose_interfaces: Prims.unit -> Prims.bool =
  fun uu____1574  -> lookup_opt "expose_interfaces" as_bool
let get_extract_module: Prims.unit -> Prims.string Prims.list =
  fun uu____1579  -> lookup_opt "extract_module" (as_list as_string)
let get_extract_namespace: Prims.unit -> Prims.string Prims.list =
  fun uu____1586  -> lookup_opt "extract_namespace" (as_list as_string)
let get_fs_typ_app: Prims.unit -> Prims.bool =
  fun uu____1591  -> lookup_opt "fs_typ_app" as_bool
let get_fstar_home: Prims.unit -> Prims.string FStar_Pervasives_Native.option
  = fun uu____1596  -> lookup_opt "fstar_home" (as_option as_string)
let get_gen_native_tactics:
  Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1603  -> lookup_opt "gen_native_tactics" (as_option as_string)
let get_hide_uvar_nums: Prims.unit -> Prims.bool =
  fun uu____1608  -> lookup_opt "hide_uvar_nums" as_bool
let get_hint_info: Prims.unit -> Prims.bool =
  fun uu____1611  -> lookup_opt "hint_info" as_bool
let get_hint_file: Prims.unit -> Prims.string FStar_Pervasives_Native.option
  = fun uu____1616  -> lookup_opt "hint_file" (as_option as_string)
let get_in: Prims.unit -> Prims.bool =
  fun uu____1621  -> lookup_opt "in" as_bool
let get_ide: Prims.unit -> Prims.bool =
  fun uu____1624  -> lookup_opt "ide" as_bool
let get_include: Prims.unit -> Prims.string Prims.list =
  fun uu____1629  -> lookup_opt "include" (as_list as_string)
let get_indent: Prims.unit -> Prims.bool =
  fun uu____1634  -> lookup_opt "indent" as_bool
let get_initial_fuel: Prims.unit -> Prims.int =
  fun uu____1637  -> lookup_opt "initial_fuel" as_int
let get_initial_ifuel: Prims.unit -> Prims.int =
  fun uu____1640  -> lookup_opt "initial_ifuel" as_int
let get_lax: Prims.unit -> Prims.bool =
  fun uu____1643  -> lookup_opt "lax" as_bool
let get_load: Prims.unit -> Prims.string Prims.list =
  fun uu____1648  -> lookup_opt "load" (as_list as_string)
let get_log_queries: Prims.unit -> Prims.bool =
  fun uu____1653  -> lookup_opt "log_queries" as_bool
let get_log_types: Prims.unit -> Prims.bool =
  fun uu____1656  -> lookup_opt "log_types" as_bool
let get_max_fuel: Prims.unit -> Prims.int =
  fun uu____1659  -> lookup_opt "max_fuel" as_int
let get_max_ifuel: Prims.unit -> Prims.int =
  fun uu____1662  -> lookup_opt "max_ifuel" as_int
let get_min_fuel: Prims.unit -> Prims.int =
  fun uu____1665  -> lookup_opt "min_fuel" as_int
let get_MLish: Prims.unit -> Prims.bool =
  fun uu____1668  -> lookup_opt "MLish" as_bool
let get_n_cores: Prims.unit -> Prims.int =
  fun uu____1671  -> lookup_opt "n_cores" as_int
let get_no_default_includes: Prims.unit -> Prims.bool =
  fun uu____1674  -> lookup_opt "no_default_includes" as_bool
let get_no_extract: Prims.unit -> Prims.string Prims.list =
  fun uu____1679  -> lookup_opt "no_extract" (as_list as_string)
let get_no_location_info: Prims.unit -> Prims.bool =
  fun uu____1684  -> lookup_opt "no_location_info" as_bool
let get_odir: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1689  -> lookup_opt "odir" (as_option as_string)
let get_ugly: Prims.unit -> Prims.bool =
  fun uu____1694  -> lookup_opt "ugly" as_bool
let get_prims: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1699  -> lookup_opt "prims" (as_option as_string)
let get_print_bound_var_types: Prims.unit -> Prims.bool =
  fun uu____1704  -> lookup_opt "print_bound_var_types" as_bool
let get_print_effect_args: Prims.unit -> Prims.bool =
  fun uu____1707  -> lookup_opt "print_effect_args" as_bool
let get_print_full_names: Prims.unit -> Prims.bool =
  fun uu____1710  -> lookup_opt "print_full_names" as_bool
let get_print_implicits: Prims.unit -> Prims.bool =
  fun uu____1713  -> lookup_opt "print_implicits" as_bool
let get_print_universes: Prims.unit -> Prims.bool =
  fun uu____1716  -> lookup_opt "print_universes" as_bool
let get_print_z3_statistics: Prims.unit -> Prims.bool =
  fun uu____1719  -> lookup_opt "print_z3_statistics" as_bool
let get_prn: Prims.unit -> Prims.bool =
  fun uu____1722  -> lookup_opt "prn" as_bool
let get_query_stats: Prims.unit -> Prims.bool =
  fun uu____1725  -> lookup_opt "query_stats" as_bool
let get_record_hints: Prims.unit -> Prims.bool =
  fun uu____1728  -> lookup_opt "record_hints" as_bool
let get_reuse_hint_for:
  Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1733  -> lookup_opt "reuse_hint_for" (as_option as_string)
let get_silent: Prims.unit -> Prims.bool =
  fun uu____1738  -> lookup_opt "silent" as_bool
let get_smt: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1743  -> lookup_opt "smt" (as_option as_string)
let get_smtencoding_elim_box: Prims.unit -> Prims.bool =
  fun uu____1748  -> lookup_opt "smtencoding.elim_box" as_bool
let get_smtencoding_nl_arith_repr: Prims.unit -> Prims.string =
  fun uu____1751  -> lookup_opt "smtencoding.nl_arith_repr" as_string
let get_smtencoding_l_arith_repr: Prims.unit -> Prims.string =
  fun uu____1754  -> lookup_opt "smtencoding.l_arith_repr" as_string
let get_tactic_raw_binders: Prims.unit -> Prims.bool =
  fun uu____1757  -> lookup_opt "tactic_raw_binders" as_bool
let get_tactic_trace: Prims.unit -> Prims.bool =
  fun uu____1760  -> lookup_opt "tactic_trace" as_bool
let get_tactic_trace_d: Prims.unit -> Prims.int =
  fun uu____1763  -> lookup_opt "tactic_trace_d" as_int
let get_timing: Prims.unit -> Prims.bool =
  fun uu____1766  -> lookup_opt "timing" as_bool
let get_trace_error: Prims.unit -> Prims.bool =
  fun uu____1769  -> lookup_opt "trace_error" as_bool
let get_unthrottle_inductives: Prims.unit -> Prims.bool =
  fun uu____1772  -> lookup_opt "unthrottle_inductives" as_bool
let get_unsafe_tactic_exec: Prims.unit -> Prims.bool =
  fun uu____1775  -> lookup_opt "unsafe_tactic_exec" as_bool
let get_use_eq_at_higher_order: Prims.unit -> Prims.bool =
  fun uu____1778  -> lookup_opt "use_eq_at_higher_order" as_bool
let get_use_hints: Prims.unit -> Prims.bool =
  fun uu____1781  -> lookup_opt "use_hints" as_bool
let get_use_hint_hashes: Prims.unit -> Prims.bool =
  fun uu____1784  -> lookup_opt "use_hint_hashes" as_bool
let get_use_native_tactics:
  Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____1789  -> lookup_opt "use_native_tactics" (as_option as_string)
let get_use_tactics: Prims.unit -> Prims.bool =
  fun uu____1794  ->
    let uu____1795 = lookup_opt "no_tactics" as_bool in
    Prims.op_Negation uu____1795
let get_using_facts_from:
  Prims.unit -> Prims.string Prims.list FStar_Pervasives_Native.option =
  fun uu____1802  ->
    lookup_opt "using_facts_from" (as_option (as_list as_string))
let get_verify_module: Prims.unit -> Prims.string Prims.list =
  fun uu____1813  -> lookup_opt "verify_module" (as_list as_string)
let get___temp_no_proj: Prims.unit -> Prims.string Prims.list =
  fun uu____1820  -> lookup_opt "__temp_no_proj" (as_list as_string)
let get_version: Prims.unit -> Prims.bool =
  fun uu____1825  -> lookup_opt "version" as_bool
let get_warn_default_effects: Prims.unit -> Prims.bool =
  fun uu____1828  -> lookup_opt "warn_default_effects" as_bool
let get_z3cliopt: Prims.unit -> Prims.string Prims.list =
  fun uu____1833  -> lookup_opt "z3cliopt" (as_list as_string)
let get_z3refresh: Prims.unit -> Prims.bool =
  fun uu____1838  -> lookup_opt "z3refresh" as_bool
let get_z3rlimit: Prims.unit -> Prims.int =
  fun uu____1841  -> lookup_opt "z3rlimit" as_int
let get_z3rlimit_factor: Prims.unit -> Prims.int =
  fun uu____1844  -> lookup_opt "z3rlimit_factor" as_int
let get_z3seed: Prims.unit -> Prims.int =
  fun uu____1847  -> lookup_opt "z3seed" as_int
let get_use_two_phase_tc: Prims.unit -> Prims.bool =
  fun uu____1850  -> lookup_opt "use_two_phase_tc" as_bool
let get_no_positivity: Prims.unit -> Prims.bool =
  fun uu____1853  -> lookup_opt "__no_positivity" as_bool
let get_ml_no_eta_expand_coertions: Prims.unit -> Prims.bool =
  fun uu____1856  -> lookup_opt "__ml_no_eta_expand_coertions" as_bool
let get_warn_error: Prims.unit -> Prims.string =
  fun uu____1859  -> lookup_opt "warn_error" as_string
let dlevel: Prims.string -> debug_level_t =
  fun uu___34_1862  ->
    match uu___34_1862 with
    | "Low" -> Low
    | "Medium" -> Medium
    | "High" -> High
    | "Extreme" -> Extreme
    | s -> Other s
let one_debug_level_geq: debug_level_t -> debug_level_t -> Prims.bool =
  fun l1  ->
    fun l2  ->
      match l1 with
      | Other uu____1870 -> l1 = l2
      | Low  -> l1 = l2
      | Medium  -> (l2 = Low) || (l2 = Medium)
      | High  -> ((l2 = Low) || (l2 = Medium)) || (l2 = High)
      | Extreme  ->
          (((l2 = Low) || (l2 = Medium)) || (l2 = High)) || (l2 = Extreme)
let debug_level_geq: debug_level_t -> Prims.bool =
  fun l2  ->
    let uu____1874 = get_debug_level () in
    FStar_All.pipe_right uu____1874
      (FStar_Util.for_some (fun l1  -> one_debug_level_geq (dlevel l1) l2))
let universe_include_path_base_dirs: Prims.string Prims.list =
  ["/ulib"; "/lib/fstar"]
let _version: Prims.string FStar_ST.ref = FStar_Util.mk_ref ""
let _platform: Prims.string FStar_ST.ref = FStar_Util.mk_ref ""
let _compiler: Prims.string FStar_ST.ref = FStar_Util.mk_ref ""
let _date: Prims.string FStar_ST.ref = FStar_Util.mk_ref ""
let _commit: Prims.string FStar_ST.ref = FStar_Util.mk_ref ""
let display_version: Prims.unit -> Prims.unit =
  fun uu____2005  ->
    let uu____2006 =
      let uu____2007 = FStar_ST.op_Bang _version in
      let uu____2056 = FStar_ST.op_Bang _platform in
      let uu____2105 = FStar_ST.op_Bang _compiler in
      let uu____2154 = FStar_ST.op_Bang _date in
      let uu____2203 = FStar_ST.op_Bang _commit in
      FStar_Util.format5
        "F* %s\nplatform=%s\ncompiler=%s\ndate=%s\ncommit=%s\n" uu____2007
        uu____2056 uu____2105 uu____2154 uu____2203 in
    FStar_Util.print_string uu____2006
let display_usage_aux:
  'Auu____2255 'Auu____2256 .
    ('Auu____2256,Prims.string,'Auu____2255 FStar_Getopt.opt_variant,
      Prims.string) FStar_Pervasives_Native.tuple4 Prims.list -> Prims.unit
  =
  fun specs  ->
    FStar_Util.print_string "fstar.exe [options] file[s]\n";
    FStar_List.iter
      (fun uu____2303  ->
         match uu____2303 with
         | (uu____2314,flag,p,doc) ->
             (match p with
              | FStar_Getopt.ZeroArgs ig ->
                  if doc = ""
                  then
                    let uu____2325 =
                      let uu____2326 = FStar_Util.colorize_bold flag in
                      FStar_Util.format1 "  --%s\n" uu____2326 in
                    FStar_Util.print_string uu____2325
                  else
                    (let uu____2328 =
                       let uu____2329 = FStar_Util.colorize_bold flag in
                       FStar_Util.format2 "  --%s  %s\n" uu____2329 doc in
                     FStar_Util.print_string uu____2328)
              | FStar_Getopt.OneArg (uu____2330,argname) ->
                  if doc = ""
                  then
                    let uu____2336 =
                      let uu____2337 = FStar_Util.colorize_bold flag in
                      let uu____2338 = FStar_Util.colorize_bold argname in
                      FStar_Util.format2 "  --%s %s\n" uu____2337 uu____2338 in
                    FStar_Util.print_string uu____2336
                  else
                    (let uu____2340 =
                       let uu____2341 = FStar_Util.colorize_bold flag in
                       let uu____2342 = FStar_Util.colorize_bold argname in
                       FStar_Util.format3 "  --%s %s  %s\n" uu____2341
                         uu____2342 doc in
                     FStar_Util.print_string uu____2340))) specs
let mk_spec:
  (FStar_BaseTypes.char,Prims.string,option_val FStar_Getopt.opt_variant,
    Prims.string) FStar_Pervasives_Native.tuple4 -> FStar_Getopt.opt
  =
  fun o  ->
    let uu____2366 = o in
    match uu____2366 with
    | (ns,name,arg,desc) ->
        let arg1 =
          match arg with
          | FStar_Getopt.ZeroArgs f ->
              let g uu____2396 =
                let uu____2397 = f () in set_option name uu____2397 in
              FStar_Getopt.ZeroArgs g
          | FStar_Getopt.OneArg (f,d) ->
              let g x = let uu____2408 = f x in set_option name uu____2408 in
              FStar_Getopt.OneArg (g, d) in
        (ns, name, arg1, desc)
let accumulated_option: Prims.string -> option_val -> option_val =
  fun name  ->
    fun value  ->
      let prev_values =
        let uu____2422 = lookup_opt name (as_option as_list') in
        FStar_Util.dflt [] uu____2422 in
      mk_list (value :: prev_values)
let reverse_accumulated_option: Prims.string -> option_val -> option_val =
  fun name  ->
    fun value  ->
      let uu____2441 =
        let uu____2444 = lookup_opt name as_list' in
        FStar_List.append uu____2444 [value] in
      mk_list uu____2441
let accumulate_string:
  'Auu____2453 .
    Prims.string ->
      ('Auu____2453 -> Prims.string) -> 'Auu____2453 -> Prims.unit
  =
  fun name  ->
    fun post_processor  ->
      fun value  ->
        let uu____2471 =
          let uu____2472 =
            let uu____2473 = post_processor value in mk_string uu____2473 in
          accumulated_option name uu____2472 in
        set_option name uu____2471
let add_extract_module: Prims.string -> Prims.unit =
  fun s  -> accumulate_string "extract_module" FStar_String.lowercase s
let add_extract_namespace: Prims.string -> Prims.unit =
  fun s  -> accumulate_string "extract_namespace" FStar_String.lowercase s
let add_verify_module: Prims.string -> Prims.unit =
  fun s  -> accumulate_string "verify_module" FStar_String.lowercase s
type opt_type =
  | Const of option_val
  | IntStr of Prims.string
  | BoolStr
  | PathStr of Prims.string
  | SimpleStr of Prims.string
  | EnumStr of Prims.string Prims.list
  | OpenEnumStr of (Prims.string Prims.list,Prims.string)
  FStar_Pervasives_Native.tuple2
  | PostProcessed of (option_val -> option_val,opt_type)
  FStar_Pervasives_Native.tuple2
  | Accumulated of opt_type
  | ReverseAccumulated of opt_type
  | WithSideEffect of (Prims.unit -> Prims.unit,opt_type)
  FStar_Pervasives_Native.tuple2[@@deriving show]
let uu___is_Const: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | Const _0 -> true | uu____2551 -> false
let __proj__Const__item___0: opt_type -> option_val =
  fun projectee  -> match projectee with | Const _0 -> _0
let uu___is_IntStr: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | IntStr _0 -> true | uu____2563 -> false
let __proj__IntStr__item___0: opt_type -> Prims.string =
  fun projectee  -> match projectee with | IntStr _0 -> _0
let uu___is_BoolStr: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | BoolStr  -> true | uu____2574 -> false
let uu___is_PathStr: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | PathStr _0 -> true | uu____2579 -> false
let __proj__PathStr__item___0: opt_type -> Prims.string =
  fun projectee  -> match projectee with | PathStr _0 -> _0
let uu___is_SimpleStr: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | SimpleStr _0 -> true | uu____2591 -> false
let __proj__SimpleStr__item___0: opt_type -> Prims.string =
  fun projectee  -> match projectee with | SimpleStr _0 -> _0
let uu___is_EnumStr: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | EnumStr _0 -> true | uu____2605 -> false
let __proj__EnumStr__item___0: opt_type -> Prims.string Prims.list =
  fun projectee  -> match projectee with | EnumStr _0 -> _0
let uu___is_OpenEnumStr: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | OpenEnumStr _0 -> true | uu____2629 -> false
let __proj__OpenEnumStr__item___0:
  opt_type ->
    (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2
  = fun projectee  -> match projectee with | OpenEnumStr _0 -> _0
let uu___is_PostProcessed: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | PostProcessed _0 -> true | uu____2665 -> false
let __proj__PostProcessed__item___0:
  opt_type ->
    (option_val -> option_val,opt_type) FStar_Pervasives_Native.tuple2
  = fun projectee  -> match projectee with | PostProcessed _0 -> _0
let uu___is_Accumulated: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | Accumulated _0 -> true | uu____2695 -> false
let __proj__Accumulated__item___0: opt_type -> opt_type =
  fun projectee  -> match projectee with | Accumulated _0 -> _0
let uu___is_ReverseAccumulated: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with
    | ReverseAccumulated _0 -> true
    | uu____2707 -> false
let __proj__ReverseAccumulated__item___0: opt_type -> opt_type =
  fun projectee  -> match projectee with | ReverseAccumulated _0 -> _0
let uu___is_WithSideEffect: opt_type -> Prims.bool =
  fun projectee  ->
    match projectee with | WithSideEffect _0 -> true | uu____2725 -> false
let __proj__WithSideEffect__item___0:
  opt_type ->
    (Prims.unit -> Prims.unit,opt_type) FStar_Pervasives_Native.tuple2
  = fun projectee  -> match projectee with | WithSideEffect _0 -> _0
exception InvalidArgument of Prims.string
let uu___is_InvalidArgument: Prims.exn -> Prims.bool =
  fun projectee  ->
    match projectee with
    | InvalidArgument uu____2757 -> true
    | uu____2758 -> false
let __proj__InvalidArgument__item__uu___: Prims.exn -> Prims.string =
  fun projectee  ->
    match projectee with | InvalidArgument uu____2765 -> uu____2765
let rec parse_opt_val: Prims.string -> opt_type -> Prims.string -> option_val
  =
  fun opt_name  ->
    fun typ  ->
      fun str_val  ->
        try
          match typ with
          | Const c -> c
          | IntStr uu____2779 ->
              let uu____2780 = FStar_Util.safe_int_of_string str_val in
              (match uu____2780 with
               | FStar_Pervasives_Native.Some v1 -> mk_int v1
               | FStar_Pervasives_Native.None  ->
                   FStar_Exn.raise (InvalidArgument opt_name))
          | BoolStr  ->
              let uu____2784 =
                if str_val = "true"
                then true
                else
                  if str_val = "false"
                  then false
                  else FStar_Exn.raise (InvalidArgument opt_name) in
              mk_bool uu____2784
          | PathStr uu____2787 -> mk_path str_val
          | SimpleStr uu____2788 -> mk_string str_val
          | EnumStr strs ->
              if FStar_List.mem str_val strs
              then mk_string str_val
              else FStar_Exn.raise (InvalidArgument opt_name)
          | OpenEnumStr uu____2793 -> mk_string str_val
          | PostProcessed (pp,elem_spec) ->
              let uu____2806 = parse_opt_val opt_name elem_spec str_val in
              pp uu____2806
          | Accumulated elem_spec ->
              let v1 = parse_opt_val opt_name elem_spec str_val in
              accumulated_option opt_name v1
          | ReverseAccumulated elem_spec ->
              let v1 = parse_opt_val opt_name elem_spec str_val in
              reverse_accumulated_option opt_name v1
          | WithSideEffect (side_effect,elem_spec) ->
              (side_effect (); parse_opt_val opt_name elem_spec str_val)
        with
        | InvalidArgument opt_name1 ->
            let uu____2823 =
              FStar_Util.format1 "Invalid argument to --%s" opt_name1 in
            failwith uu____2823
let rec desc_of_opt_type:
  opt_type -> Prims.string FStar_Pervasives_Native.option =
  fun typ  ->
    let desc_of_enum cases =
      FStar_Pervasives_Native.Some
        (Prims.strcat "[" (Prims.strcat (FStar_String.concat "|" cases) "]")) in
    match typ with
    | Const c -> FStar_Pervasives_Native.None
    | IntStr desc -> FStar_Pervasives_Native.Some desc
    | BoolStr  -> desc_of_enum ["true"; "false"]
    | PathStr desc -> FStar_Pervasives_Native.Some desc
    | SimpleStr desc -> FStar_Pervasives_Native.Some desc
    | EnumStr strs -> desc_of_enum strs
    | OpenEnumStr (strs,desc) -> desc_of_enum (FStar_List.append strs [desc])
    | PostProcessed (uu____2856,elem_spec) -> desc_of_opt_type elem_spec
    | Accumulated elem_spec -> desc_of_opt_type elem_spec
    | ReverseAccumulated elem_spec -> desc_of_opt_type elem_spec
    | WithSideEffect (uu____2864,elem_spec) -> desc_of_opt_type elem_spec
let rec arg_spec_of_opt_type:
  Prims.string -> opt_type -> option_val FStar_Getopt.opt_variant =
  fun opt_name  ->
    fun typ  ->
      let parser = parse_opt_val opt_name typ in
      let uu____2883 = desc_of_opt_type typ in
      match uu____2883 with
      | FStar_Pervasives_Native.None  ->
          FStar_Getopt.ZeroArgs ((fun uu____2889  -> parser ""))
      | FStar_Pervasives_Native.Some desc ->
          FStar_Getopt.OneArg (parser, desc)
let pp_validate_dir: option_val -> option_val =
  fun p  -> let pp = as_string p in FStar_Util.mkdir false pp; p
let pp_lowercase: option_val -> option_val =
  fun s  ->
    let uu____2901 =
      let uu____2902 = as_string s in FStar_String.lowercase uu____2902 in
    mk_string uu____2901
let rec specs_with_types:
  Prims.unit ->
    (FStar_BaseTypes.char,Prims.string,opt_type,Prims.string)
      FStar_Pervasives_Native.tuple4 Prims.list
  =
  fun uu____2919  ->
    let uu____2930 =
      let uu____2941 =
        let uu____2952 =
          let uu____2961 = let uu____2962 = mk_bool true in Const uu____2962 in
          (FStar_Getopt.noshort, "cache_checked_modules", uu____2961,
            "Write a '.checked' file for each module after verification and read from it if present, instead of re-verifying") in
        let uu____2963 =
          let uu____2974 =
            let uu____2985 =
              let uu____2996 =
                let uu____3007 =
                  let uu____3018 =
                    let uu____3029 =
                      let uu____3038 =
                        let uu____3039 = mk_bool true in Const uu____3039 in
                      (FStar_Getopt.noshort, "detail_errors", uu____3038,
                        "Emit a detailed error report by asking the SMT solver many queries; will take longer;\n         implies n_cores=1") in
                    let uu____3040 =
                      let uu____3051 =
                        let uu____3060 =
                          let uu____3061 = mk_bool true in Const uu____3061 in
                        (FStar_Getopt.noshort, "detail_hint_replay",
                          uu____3060,
                          "Emit a detailed report for proof whose unsat core fails to replay;\n         implies n_cores=1") in
                      let uu____3062 =
                        let uu____3073 =
                          let uu____3082 =
                            let uu____3083 = mk_bool true in Const uu____3083 in
                          (FStar_Getopt.noshort, "doc", uu____3082,
                            "Extract Markdown documentation files for the input modules, as well as an index. Output is written to --odir directory.") in
                        let uu____3084 =
                          let uu____3095 =
                            let uu____3106 =
                              let uu____3115 =
                                let uu____3116 = mk_bool true in
                                Const uu____3116 in
                              (FStar_Getopt.noshort, "eager_inference",
                                uu____3115,
                                "Solve all type-inference constraints eagerly; more efficient but at the cost of generality") in
                            let uu____3117 =
                              let uu____3128 =
                                let uu____3139 =
                                  let uu____3150 =
                                    let uu____3159 =
                                      let uu____3160 = mk_bool true in
                                      Const uu____3160 in
                                    (FStar_Getopt.noshort,
                                      "expose_interfaces", uu____3159,
                                      "Explicitly break the abstraction imposed by the interface of any implementation file that appears on the command line (use with care!)") in
                                  let uu____3161 =
                                    let uu____3172 =
                                      let uu____3183 =
                                        let uu____3194 =
                                          let uu____3203 =
                                            let uu____3204 = mk_bool true in
                                            Const uu____3204 in
                                          (FStar_Getopt.noshort,
                                            "hide_uvar_nums", uu____3203,
                                            "Don't print unification variable numbers") in
                                        let uu____3205 =
                                          let uu____3216 =
                                            let uu____3227 =
                                              let uu____3236 =
                                                let uu____3237 = mk_bool true in
                                                Const uu____3237 in
                                              (FStar_Getopt.noshort,
                                                "hint_info", uu____3236,
                                                "Print information regarding hints (deprecated; use --query_stats instead)") in
                                            let uu____3238 =
                                              let uu____3249 =
                                                let uu____3258 =
                                                  let uu____3259 =
                                                    mk_bool true in
                                                  Const uu____3259 in
                                                (FStar_Getopt.noshort, "in",
                                                  uu____3258,
                                                  "Legacy interactive mode; reads input from stdin") in
                                              let uu____3260 =
                                                let uu____3271 =
                                                  let uu____3280 =
                                                    let uu____3281 =
                                                      mk_bool true in
                                                    Const uu____3281 in
                                                  (FStar_Getopt.noshort,
                                                    "ide", uu____3280,
                                                    "JSON-based interactive mode for IDEs") in
                                                let uu____3282 =
                                                  let uu____3293 =
                                                    let uu____3304 =
                                                      let uu____3313 =
                                                        let uu____3314 =
                                                          mk_bool true in
                                                        Const uu____3314 in
                                                      (FStar_Getopt.noshort,
                                                        "indent", uu____3313,
                                                        "Parses and outputs the files on the command line") in
                                                    let uu____3315 =
                                                      let uu____3326 =
                                                        let uu____3337 =
                                                          let uu____3348 =
                                                            let uu____3357 =
                                                              let uu____3358
                                                                =
                                                                mk_bool true in
                                                              Const
                                                                uu____3358 in
                                                            (FStar_Getopt.noshort,
                                                              "lax",
                                                              uu____3357,
                                                              "Run the lax-type checker only (admit all verification conditions)") in
                                                          let uu____3359 =
                                                            let uu____3370 =
                                                              let uu____3381
                                                                =
                                                                let uu____3390
                                                                  =
                                                                  let uu____3391
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                  Const
                                                                    uu____3391 in
                                                                (FStar_Getopt.noshort,
                                                                  "log_types",
                                                                  uu____3390,
                                                                  "Print types computed for data/val/let-bindings") in
                                                              let uu____3392
                                                                =
                                                                let uu____3403
                                                                  =
                                                                  let uu____3412
                                                                    =
                                                                    let uu____3413
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3413 in
                                                                  (FStar_Getopt.noshort,
                                                                    "log_queries",
                                                                    uu____3412,
                                                                    "Log the Z3 queries in several queries-*.smt2 files, as we go") in
                                                                let uu____3414
                                                                  =
                                                                  let uu____3425
                                                                    =
                                                                    let uu____3436
                                                                    =
                                                                    let uu____3447
                                                                    =
                                                                    let uu____3458
                                                                    =
                                                                    let uu____3467
                                                                    =
                                                                    let uu____3468
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3468 in
                                                                    (FStar_Getopt.noshort,
                                                                    "MLish",
                                                                    uu____3467,
                                                                    "Trigger various specializations for compiling the F* compiler itself (not meant for user code)") in
                                                                    let uu____3469
                                                                    =
                                                                    let uu____3480
                                                                    =
                                                                    let uu____3491
                                                                    =
                                                                    let uu____3500
                                                                    =
                                                                    let uu____3501
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3501 in
                                                                    (FStar_Getopt.noshort,
                                                                    "no_default_includes",
                                                                    uu____3500,
                                                                    "Ignore the default module search paths") in
                                                                    let uu____3502
                                                                    =
                                                                    let uu____3513
                                                                    =
                                                                    let uu____3524
                                                                    =
                                                                    let uu____3533
                                                                    =
                                                                    let uu____3534
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3534 in
                                                                    (FStar_Getopt.noshort,
                                                                    "no_location_info",
                                                                    uu____3533,
                                                                    "Suppress location information in the generated OCaml output (only relevant with --codegen OCaml)") in
                                                                    let uu____3535
                                                                    =
                                                                    let uu____3546
                                                                    =
                                                                    let uu____3557
                                                                    =
                                                                    let uu____3568
                                                                    =
                                                                    let uu____3577
                                                                    =
                                                                    let uu____3578
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3578 in
                                                                    (FStar_Getopt.noshort,
                                                                    "print_bound_var_types",
                                                                    uu____3577,
                                                                    "Print the types of bound variables") in
                                                                    let uu____3579
                                                                    =
                                                                    let uu____3590
                                                                    =
                                                                    let uu____3599
                                                                    =
                                                                    let uu____3600
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3600 in
                                                                    (FStar_Getopt.noshort,
                                                                    "print_effect_args",
                                                                    uu____3599,
                                                                    "Print inferred predicate transformers for all computation types") in
                                                                    let uu____3601
                                                                    =
                                                                    let uu____3612
                                                                    =
                                                                    let uu____3621
                                                                    =
                                                                    let uu____3622
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3622 in
                                                                    (FStar_Getopt.noshort,
                                                                    "print_full_names",
                                                                    uu____3621,
                                                                    "Print full names of variables") in
                                                                    let uu____3623
                                                                    =
                                                                    let uu____3634
                                                                    =
                                                                    let uu____3643
                                                                    =
                                                                    let uu____3644
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3644 in
                                                                    (FStar_Getopt.noshort,
                                                                    "print_implicits",
                                                                    uu____3643,
                                                                    "Print implicit arguments") in
                                                                    let uu____3645
                                                                    =
                                                                    let uu____3656
                                                                    =
                                                                    let uu____3665
                                                                    =
                                                                    let uu____3666
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3666 in
                                                                    (FStar_Getopt.noshort,
                                                                    "print_universes",
                                                                    uu____3665,
                                                                    "Print universes") in
                                                                    let uu____3667
                                                                    =
                                                                    let uu____3678
                                                                    =
                                                                    let uu____3687
                                                                    =
                                                                    let uu____3688
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3688 in
                                                                    (FStar_Getopt.noshort,
                                                                    "print_z3_statistics",
                                                                    uu____3687,
                                                                    "Print Z3 statistics for each SMT query (deprecated; use --query_stats instead)") in
                                                                    let uu____3689
                                                                    =
                                                                    let uu____3700
                                                                    =
                                                                    let uu____3709
                                                                    =
                                                                    let uu____3710
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3710 in
                                                                    (FStar_Getopt.noshort,
                                                                    "prn",
                                                                    uu____3709,
                                                                    "Print full names (deprecated; use --print_full_names instead)") in
                                                                    let uu____3711
                                                                    =
                                                                    let uu____3722
                                                                    =
                                                                    let uu____3731
                                                                    =
                                                                    let uu____3732
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3732 in
                                                                    (FStar_Getopt.noshort,
                                                                    "query_stats",
                                                                    uu____3731,
                                                                    "Print SMT query statistics") in
                                                                    let uu____3733
                                                                    =
                                                                    let uu____3744
                                                                    =
                                                                    let uu____3753
                                                                    =
                                                                    let uu____3754
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3754 in
                                                                    (FStar_Getopt.noshort,
                                                                    "record_hints",
                                                                    uu____3753,
                                                                    "Record a database of hints for efficient proof replay") in
                                                                    let uu____3755
                                                                    =
                                                                    let uu____3766
                                                                    =
                                                                    let uu____3777
                                                                    =
                                                                    let uu____3786
                                                                    =
                                                                    let uu____3787
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3787 in
                                                                    (FStar_Getopt.noshort,
                                                                    "silent",
                                                                    uu____3786,
                                                                    " ") in
                                                                    let uu____3788
                                                                    =
                                                                    let uu____3799
                                                                    =
                                                                    let uu____3810
                                                                    =
                                                                    let uu____3821
                                                                    =
                                                                    let uu____3832
                                                                    =
                                                                    let uu____3843
                                                                    =
                                                                    let uu____3852
                                                                    =
                                                                    let uu____3853
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3853 in
                                                                    (FStar_Getopt.noshort,
                                                                    "tactic_raw_binders",
                                                                    uu____3852,
                                                                    "Do not use the lexical scope of tactics to improve binder names") in
                                                                    let uu____3854
                                                                    =
                                                                    let uu____3865
                                                                    =
                                                                    let uu____3874
                                                                    =
                                                                    let uu____3875
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3875 in
                                                                    (FStar_Getopt.noshort,
                                                                    "tactic_trace",
                                                                    uu____3874,
                                                                    "Print a depth-indexed trace of tactic execution (Warning: very verbose)") in
                                                                    let uu____3876
                                                                    =
                                                                    let uu____3887
                                                                    =
                                                                    let uu____3898
                                                                    =
                                                                    let uu____3907
                                                                    =
                                                                    let uu____3908
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3908 in
                                                                    (FStar_Getopt.noshort,
                                                                    "timing",
                                                                    uu____3907,
                                                                    "Print the time it takes to verify each top-level definition") in
                                                                    let uu____3909
                                                                    =
                                                                    let uu____3920
                                                                    =
                                                                    let uu____3929
                                                                    =
                                                                    let uu____3930
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3930 in
                                                                    (FStar_Getopt.noshort,
                                                                    "trace_error",
                                                                    uu____3929,
                                                                    "Don't print an error message; show an exception trace instead") in
                                                                    let uu____3931
                                                                    =
                                                                    let uu____3942
                                                                    =
                                                                    let uu____3951
                                                                    =
                                                                    let uu____3952
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3952 in
                                                                    (FStar_Getopt.noshort,
                                                                    "ugly",
                                                                    uu____3951,
                                                                    "Emit output formatted for debugging") in
                                                                    let uu____3953
                                                                    =
                                                                    let uu____3964
                                                                    =
                                                                    let uu____3973
                                                                    =
                                                                    let uu____3974
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3974 in
                                                                    (FStar_Getopt.noshort,
                                                                    "unthrottle_inductives",
                                                                    uu____3973,
                                                                    "Let the SMT solver unfold inductive types to arbitrary depths (may affect verifier performance)") in
                                                                    let uu____3975
                                                                    =
                                                                    let uu____3986
                                                                    =
                                                                    let uu____3995
                                                                    =
                                                                    let uu____3996
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____3996 in
                                                                    (FStar_Getopt.noshort,
                                                                    "unsafe_tactic_exec",
                                                                    uu____3995,
                                                                    "Allow tactics to run external processes. WARNING: checking an untrusted F* file while using this option can have disastrous effects.") in
                                                                    let uu____3997
                                                                    =
                                                                    let uu____4008
                                                                    =
                                                                    let uu____4017
                                                                    =
                                                                    let uu____4018
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4018 in
                                                                    (FStar_Getopt.noshort,
                                                                    "use_eq_at_higher_order",
                                                                    uu____4017,
                                                                    "Use equality constraints when comparing higher-order types (Temporary)") in
                                                                    let uu____4019
                                                                    =
                                                                    let uu____4030
                                                                    =
                                                                    let uu____4039
                                                                    =
                                                                    let uu____4040
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4040 in
                                                                    (FStar_Getopt.noshort,
                                                                    "use_hints",
                                                                    uu____4039,
                                                                    "Use a previously recorded hints database for proof replay") in
                                                                    let uu____4041
                                                                    =
                                                                    let uu____4052
                                                                    =
                                                                    let uu____4061
                                                                    =
                                                                    let uu____4062
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4062 in
                                                                    (FStar_Getopt.noshort,
                                                                    "use_hint_hashes",
                                                                    uu____4061,
                                                                    "Admit queries if their hash matches the hash recorded in the hints database") in
                                                                    let uu____4063
                                                                    =
                                                                    let uu____4074
                                                                    =
                                                                    let uu____4085
                                                                    =
                                                                    let uu____4094
                                                                    =
                                                                    let uu____4095
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4095 in
                                                                    (FStar_Getopt.noshort,
                                                                    "no_tactics",
                                                                    uu____4094,
                                                                    "Do not run the tactic engine before discharging a VC") in
                                                                    let uu____4096
                                                                    =
                                                                    let uu____4107
                                                                    =
                                                                    let uu____4118
                                                                    =
                                                                    let uu____4129
                                                                    =
                                                                    let uu____4139
                                                                    =
                                                                    let uu____4140
                                                                    =
                                                                    let uu____4147
                                                                    =
                                                                    let uu____4148
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4148 in
                                                                    ((fun
                                                                    uu____4153
                                                                     ->
                                                                    display_version
                                                                    ();
                                                                    FStar_All.exit
                                                                    (Prims.parse_int
                                                                    "0")),
                                                                    uu____4147) in
                                                                    WithSideEffect
                                                                    uu____4140 in
                                                                    (118,
                                                                    "version",
                                                                    uu____4139,
                                                                    "Display version number") in
                                                                    let uu____4157
                                                                    =
                                                                    let uu____4169
                                                                    =
                                                                    let uu____4178
                                                                    =
                                                                    let uu____4179
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4179 in
                                                                    (FStar_Getopt.noshort,
                                                                    "warn_default_effects",
                                                                    uu____4178,
                                                                    "Warn when (a -> b) is desugared to (a -> Tot b)") in
                                                                    let uu____4180
                                                                    =
                                                                    let uu____4191
                                                                    =
                                                                    let uu____4202
                                                                    =
                                                                    let uu____4211
                                                                    =
                                                                    let uu____4212
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4212 in
                                                                    (FStar_Getopt.noshort,
                                                                    "z3refresh",
                                                                    uu____4211,
                                                                    "Restart Z3 after each query; useful for ensuring proof robustness") in
                                                                    let uu____4213
                                                                    =
                                                                    let uu____4224
                                                                    =
                                                                    let uu____4235
                                                                    =
                                                                    let uu____4246
                                                                    =
                                                                    let uu____4257
                                                                    =
                                                                    let uu____4268
                                                                    =
                                                                    let uu____4277
                                                                    =
                                                                    let uu____4278
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4278 in
                                                                    (FStar_Getopt.noshort,
                                                                    "__no_positivity",
                                                                    uu____4277,
                                                                    "Don't check positivity of inductive types") in
                                                                    let uu____4279
                                                                    =
                                                                    let uu____4290
                                                                    =
                                                                    let uu____4299
                                                                    =
                                                                    let uu____4300
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4300 in
                                                                    (FStar_Getopt.noshort,
                                                                    "__ml_no_eta_expand_coertions",
                                                                    uu____4299,
                                                                    "Do not eta-expand coertions in generated OCaml") in
                                                                    let uu____4301
                                                                    =
                                                                    let uu____4312
                                                                    =
                                                                    let uu____4323
                                                                    =
                                                                    let uu____4333
                                                                    =
                                                                    let uu____4334
                                                                    =
                                                                    let uu____4341
                                                                    =
                                                                    let uu____4342
                                                                    =
                                                                    mk_bool
                                                                    true in
                                                                    Const
                                                                    uu____4342 in
                                                                    ((fun
                                                                    uu____4347
                                                                     ->
                                                                    (
                                                                    let uu____4349
                                                                    =
                                                                    specs () in
                                                                    display_usage_aux
                                                                    uu____4349);
                                                                    FStar_All.exit
                                                                    (Prims.parse_int
                                                                    "0")),
                                                                    uu____4341) in
                                                                    WithSideEffect
                                                                    uu____4334 in
                                                                    (104,
                                                                    "help",
                                                                    uu____4333,
                                                                    "Display this information") in
                                                                    [uu____4323] in
                                                                    (FStar_Getopt.noshort,
                                                                    "warn_error",
                                                                    (SimpleStr
                                                                    ""),
                                                                    "The [-warn_error] option follows the OCaml syntax, namely:\n\t\t- [r] is a range of warnings (either a number [n], or a range [n..n])\n\t\t- [-r] silences range [r]\n\t\t- [+r] enables range [r]\n\t\t- [@r] makes range [r] fatal.")
                                                                    ::
                                                                    uu____4312 in
                                                                    uu____4290
                                                                    ::
                                                                    uu____4301 in
                                                                    uu____4268
                                                                    ::
                                                                    uu____4279 in
                                                                    (FStar_Getopt.noshort,
                                                                    "use_two_phase_tc",
                                                                    BoolStr,
                                                                    "Use the two phase typechecker (default 'false')")
                                                                    ::
                                                                    uu____4257 in
                                                                    (FStar_Getopt.noshort,
                                                                    "z3seed",
                                                                    (IntStr
                                                                    "positive_integer"),
                                                                    "Set the Z3 random seed (default 0)")
                                                                    ::
                                                                    uu____4246 in
                                                                    (FStar_Getopt.noshort,
                                                                    "z3rlimit_factor",
                                                                    (IntStr
                                                                    "positive_integer"),
                                                                    "Set the Z3 per-query resource limit multiplier. This is useful when, say, regenerating hints and you want to be more lax. (default 1)")
                                                                    ::
                                                                    uu____4235 in
                                                                    (FStar_Getopt.noshort,
                                                                    "z3rlimit",
                                                                    (IntStr
                                                                    "positive_integer"),
                                                                    "Set the Z3 per-query resource limit (default 5 units, taking roughtly 5s)")
                                                                    ::
                                                                    uu____4224 in
                                                                    uu____4202
                                                                    ::
                                                                    uu____4213 in
                                                                    (FStar_Getopt.noshort,
                                                                    "z3cliopt",
                                                                    (ReverseAccumulated
                                                                    (SimpleStr
                                                                    "option")),
                                                                    "Z3 command line options")
                                                                    ::
                                                                    uu____4191 in
                                                                    uu____4169
                                                                    ::
                                                                    uu____4180 in
                                                                    uu____4129
                                                                    ::
                                                                    uu____4157 in
                                                                    (FStar_Getopt.noshort,
                                                                    "__temp_no_proj",
                                                                    (Accumulated
                                                                    (SimpleStr
                                                                    "module_name")),
                                                                    "Don't generate projectors for this module")
                                                                    ::
                                                                    uu____4118 in
                                                                    (FStar_Getopt.noshort,
                                                                    "using_facts_from",
                                                                    (Accumulated
                                                                    (SimpleStr
                                                                    "One or more space-separated occurrences of '[+|-]( * | namespace | fact id)'")),
                                                                    "\n\t\tPrunes the context to include only the facts from the given namespace or fact id. \n\t\t\tFacts can be include or excluded using the [+|-] qualifier. \n\t\t\tFor example --using_facts_from '* -FStar.Reflection +FStar.List -FStar.List.Tot' will \n\t\t\t\tremove all facts from FStar.List.Tot.*, \n\t\t\t\tretain all remaining facts from FStar.List.*, \n\t\t\t\tremove all facts from FStar.Reflection.*, \n\t\t\t\tand retain all the rest.\n\t\tNote, the '+' is optional: --using_facts_from 'FStar.List' is equivalent to --using_facts_from '+FStar.List'. \n\t\tMultiple uses of this option accumulate, e.g., --using_facts_from A --using_facts_from B is interpreted as --using_facts_from A^B.")
                                                                    ::
                                                                    uu____4107 in
                                                                    uu____4085
                                                                    ::
                                                                    uu____4096 in
                                                                    (FStar_Getopt.noshort,
                                                                    "use_native_tactics",
                                                                    (PathStr
                                                                    "path"),
                                                                    "Use compiled tactics from <path>")
                                                                    ::
                                                                    uu____4074 in
                                                                    uu____4052
                                                                    ::
                                                                    uu____4063 in
                                                                    uu____4030
                                                                    ::
                                                                    uu____4041 in
                                                                    uu____4008
                                                                    ::
                                                                    uu____4019 in
                                                                    uu____3986
                                                                    ::
                                                                    uu____3997 in
                                                                    uu____3964
                                                                    ::
                                                                    uu____3975 in
                                                                    uu____3942
                                                                    ::
                                                                    uu____3953 in
                                                                    uu____3920
                                                                    ::
                                                                    uu____3931 in
                                                                    uu____3898
                                                                    ::
                                                                    uu____3909 in
                                                                    (FStar_Getopt.noshort,
                                                                    "tactic_trace_d",
                                                                    (IntStr
                                                                    "positive_integer"),
                                                                    "Trace tactics up to a certain binding depth")
                                                                    ::
                                                                    uu____3887 in
                                                                    uu____3865
                                                                    ::
                                                                    uu____3876 in
                                                                    uu____3843
                                                                    ::
                                                                    uu____3854 in
                                                                    (FStar_Getopt.noshort,
                                                                    "smtencoding.l_arith_repr",
                                                                    (EnumStr
                                                                    ["native";
                                                                    "boxwrap"]),
                                                                    "Toggle the representation of linear arithmetic functions in the SMT encoding:\n\t\ti.e., if 'boxwrap', use 'Prims.op_Addition, Prims.op_Subtraction, Prims.op_Minus'; \n\t\tif 'native', use '+, -, -'; \n\t\t(default 'boxwrap')")
                                                                    ::
                                                                    uu____3832 in
                                                                    (FStar_Getopt.noshort,
                                                                    "smtencoding.nl_arith_repr",
                                                                    (EnumStr
                                                                    ["native";
                                                                    "wrapped";
                                                                    "boxwrap"]),
                                                                    "Control the representation of non-linear arithmetic functions in the SMT encoding:\n\t\ti.e., if 'boxwrap' use 'Prims.op_Multiply, Prims.op_Division, Prims.op_Modulus'; \n\t\tif 'native' use '*, div, mod';\n\t\tif 'wrapped' use '_mul, _div, _mod : Int*Int -> Int'; \n\t\t(default 'boxwrap')")
                                                                    ::
                                                                    uu____3821 in
                                                                    (FStar_Getopt.noshort,
                                                                    "smtencoding.elim_box",
                                                                    BoolStr,
                                                                    "Toggle a peephole optimization that eliminates redundant uses of boxing/unboxing in the SMT encoding (default 'false')")
                                                                    ::
                                                                    uu____3810 in
                                                                    (FStar_Getopt.noshort,
                                                                    "smt",
                                                                    (PathStr
                                                                    "path"),
                                                                    "Path to the Z3 SMT solver (we could eventually support other solvers)")
                                                                    ::
                                                                    uu____3799 in
                                                                    uu____3777
                                                                    ::
                                                                    uu____3788 in
                                                                    (FStar_Getopt.noshort,
                                                                    "reuse_hint_for",
                                                                    (SimpleStr
                                                                    "toplevel_name"),
                                                                    "Optimistically, attempt using the recorded hint for <toplevel_name> (a top-level name in the current module) when trying to verify some other term 'g'")
                                                                    ::
                                                                    uu____3766 in
                                                                    uu____3744
                                                                    ::
                                                                    uu____3755 in
                                                                    uu____3722
                                                                    ::
                                                                    uu____3733 in
                                                                    uu____3700
                                                                    ::
                                                                    uu____3711 in
                                                                    uu____3678
                                                                    ::
                                                                    uu____3689 in
                                                                    uu____3656
                                                                    ::
                                                                    uu____3667 in
                                                                    uu____3634
                                                                    ::
                                                                    uu____3645 in
                                                                    uu____3612
                                                                    ::
                                                                    uu____3623 in
                                                                    uu____3590
                                                                    ::
                                                                    uu____3601 in
                                                                    uu____3568
                                                                    ::
                                                                    uu____3579 in
                                                                    (FStar_Getopt.noshort,
                                                                    "prims",
                                                                    (PathStr
                                                                    "file"),
                                                                    "") ::
                                                                    uu____3557 in
                                                                    (FStar_Getopt.noshort,
                                                                    "odir",
                                                                    (PostProcessed
                                                                    (pp_validate_dir,
                                                                    (PathStr
                                                                    "dir"))),
                                                                    "Place output in directory <dir>")
                                                                    ::
                                                                    uu____3546 in
                                                                    uu____3524
                                                                    ::
                                                                    uu____3535 in
                                                                    (FStar_Getopt.noshort,
                                                                    "no_extract",
                                                                    (Accumulated
                                                                    (PathStr
                                                                    "module name")),
                                                                    "Do not extract code from this module")
                                                                    ::
                                                                    uu____3513 in
                                                                    uu____3491
                                                                    ::
                                                                    uu____3502 in
                                                                    (FStar_Getopt.noshort,
                                                                    "n_cores",
                                                                    (IntStr
                                                                    "positive_integer"),
                                                                    "Maximum number of cores to use for the solver (implies detail_errors = false) (default 1)")
                                                                    ::
                                                                    uu____3480 in
                                                                    uu____3458
                                                                    ::
                                                                    uu____3469 in
                                                                    (FStar_Getopt.noshort,
                                                                    "min_fuel",
                                                                    (IntStr
                                                                    "non-negative integer"),
                                                                    "Minimum number of unrolling of recursive functions to try (default 1)")
                                                                    ::
                                                                    uu____3447 in
                                                                    (FStar_Getopt.noshort,
                                                                    "max_ifuel",
                                                                    (IntStr
                                                                    "non-negative integer"),
                                                                    "Number of unrolling of inductive datatypes to try at most (default 2)")
                                                                    ::
                                                                    uu____3436 in
                                                                  (FStar_Getopt.noshort,
                                                                    "max_fuel",
                                                                    (
                                                                    IntStr
                                                                    "non-negative integer"),
                                                                    "Number of unrolling of recursive functions to try at most (default 8)")
                                                                    ::
                                                                    uu____3425 in
                                                                uu____3403 ::
                                                                  uu____3414 in
                                                              uu____3381 ::
                                                                uu____3392 in
                                                            (FStar_Getopt.noshort,
                                                              "load",
                                                              (ReverseAccumulated
                                                                 (PathStr
                                                                    "module")),
                                                              "Load compiled module")
                                                              :: uu____3370 in
                                                          uu____3348 ::
                                                            uu____3359 in
                                                        (FStar_Getopt.noshort,
                                                          "initial_ifuel",
                                                          (IntStr
                                                             "non-negative integer"),
                                                          "Number of unrolling of inductive datatypes to try at first (default 1)")
                                                          :: uu____3337 in
                                                      (FStar_Getopt.noshort,
                                                        "initial_fuel",
                                                        (IntStr
                                                           "non-negative integer"),
                                                        "Number of unrolling of recursive functions to try initially (default 2)")
                                                        :: uu____3326 in
                                                    uu____3304 :: uu____3315 in
                                                  (FStar_Getopt.noshort,
                                                    "include",
                                                    (ReverseAccumulated
                                                       (PathStr "path")),
                                                    "A directory in which to search for files included on the command line")
                                                    :: uu____3293 in
                                                uu____3271 :: uu____3282 in
                                              uu____3249 :: uu____3260 in
                                            uu____3227 :: uu____3238 in
                                          (FStar_Getopt.noshort, "hint_file",
                                            (PathStr "path"),
                                            "Read/write hints to <path> (instead of module-specific hints files)")
                                            :: uu____3216 in
                                        uu____3194 :: uu____3205 in
                                      (FStar_Getopt.noshort,
                                        "gen_native_tactics",
                                        (PathStr "[path]"),
                                        "Compile all user tactics used in the module in <path>")
                                        :: uu____3183 in
                                    (FStar_Getopt.noshort, "fstar_home",
                                      (PathStr "dir"),
                                      "Set the FSTAR_HOME variable to <dir>")
                                      :: uu____3172 in
                                  uu____3150 :: uu____3161 in
                                (FStar_Getopt.noshort, "extract_namespace",
                                  (Accumulated
                                     (PostProcessed
                                        (pp_lowercase,
                                          (SimpleStr "namespace name")))),
                                  "Only extract modules in the specified namespace")
                                  :: uu____3139 in
                              (FStar_Getopt.noshort, "extract_module",
                                (Accumulated
                                   (PostProcessed
                                      (pp_lowercase,
                                        (SimpleStr "module_name")))),
                                "Only extract the specified modules (instead of the possibly-partial dependency graph)")
                                :: uu____3128 in
                            uu____3106 :: uu____3117 in
                          (FStar_Getopt.noshort, "dump_module",
                            (Accumulated (SimpleStr "module_name")), "") ::
                            uu____3095 in
                        uu____3073 :: uu____3084 in
                      uu____3051 :: uu____3062 in
                    uu____3029 :: uu____3040 in
                  (FStar_Getopt.noshort, "dep",
                    (EnumStr ["make"; "graph"; "full"]),
                    "Output the transitive closure of the full dependency graph in three formats:\n\t 'graph': a format suitable the 'dot' tool from 'GraphViz'\n\t 'full': a format suitable for 'make', including dependences for producing .ml and .krml files\n\t 'make': (deprecated) a format suitable for 'make', including only dependences among source files")
                    :: uu____3018 in
                (FStar_Getopt.noshort, "debug_level",
                  (Accumulated
                     (OpenEnumStr
                        (["Low"; "Medium"; "High"; "Extreme"], "..."))),
                  "Control the verbosity of debugging info") :: uu____3007 in
              (FStar_Getopt.noshort, "debug",
                (Accumulated (SimpleStr "module_name")),
                "Print lots of debugging information while checking module")
                :: uu____2996 in
            (FStar_Getopt.noshort, "codegen-lib",
              (Accumulated (SimpleStr "namespace")),
              "External runtime library (i.e. M.N.x extracts to M.N.X instead of M_N.x)")
              :: uu____2985 in
          (FStar_Getopt.noshort, "codegen",
            (EnumStr ["OCaml"; "FSharp"; "Kremlin"; "tactics"]),
            "Generate code for execution") :: uu____2974 in
        uu____2952 :: uu____2963 in
      (FStar_Getopt.noshort, "admit_except",
        (SimpleStr "[symbol|(symbol, id)]"),
        "Admit all queries, except those with label (<symbol>, <id>)) (e.g. --admit_except '(FStar.Fin.pigeonhole, 1)' or --admit_except FStar.Fin.pigeonhole)")
        :: uu____2941 in
    (FStar_Getopt.noshort, "admit_smt_queries", BoolStr,
      "Admit SMT queries, unsafe! (default 'false')") :: uu____2930
and specs: Prims.unit -> FStar_Getopt.opt Prims.list =
  fun uu____5047  ->
    let uu____5050 = specs_with_types () in
    FStar_List.map
      (fun uu____5075  ->
         match uu____5075 with
         | (short,long,typ,doc) ->
             let uu____5088 =
               let uu____5099 = arg_spec_of_opt_type long typ in
               (short, long, uu____5099, doc) in
             mk_spec uu____5088) uu____5050
let settable: Prims.string -> Prims.bool =
  fun uu___35_5106  ->
    match uu___35_5106 with
    | "admit_smt_queries" -> true
    | "admit_except" -> true
    | "debug" -> true
    | "debug_level" -> true
    | "detail_errors" -> true
    | "detail_hint_replay" -> true
    | "eager_inference" -> true
    | "hide_uvar_nums" -> true
    | "hint_info" -> true
    | "hint_file" -> true
    | "initial_fuel" -> true
    | "initial_ifuel" -> true
    | "lax" -> true
    | "load" -> true
    | "log_types" -> true
    | "log_queries" -> true
    | "max_fuel" -> true
    | "max_ifuel" -> true
    | "min_fuel" -> true
    | "ugly" -> true
    | "print_bound_var_types" -> true
    | "print_effect_args" -> true
    | "print_full_names" -> true
    | "print_implicits" -> true
    | "print_universes" -> true
    | "print_z3_statistics" -> true
    | "prn" -> true
    | "query_stats" -> true
    | "silent" -> true
    | "smtencoding.elim_box" -> true
    | "smtencoding.nl_arith_repr" -> true
    | "smtencoding.l_arith_repr" -> true
    | "timing" -> true
    | "trace_error" -> true
    | "unthrottle_inductives" -> true
    | "use_eq_at_higher_order" -> true
    | "no_tactics" -> true
    | "tactic_raw_binders" -> true
    | "tactic_trace" -> true
    | "tactic_trace_d" -> true
    | "__temp_no_proj" -> true
    | "reuse_hint_for" -> true
    | "warn_error" -> true
    | "z3rlimit_factor" -> true
    | "z3rlimit" -> true
    | "z3refresh" -> true
    | "use_two_phase_tc" -> true
    | uu____5107 -> false
let resettable: Prims.string -> Prims.bool =
  fun s  ->
    (((settable s) || (s = "z3seed")) || (s = "z3cliopt")) ||
      (s = "using_facts_from")
let all_specs: FStar_Getopt.opt Prims.list = specs ()
let all_specs_with_types:
  (FStar_BaseTypes.char,Prims.string,opt_type,Prims.string)
    FStar_Pervasives_Native.tuple4 Prims.list
  = specs_with_types ()
let settable_specs:
  (FStar_BaseTypes.char,Prims.string,Prims.unit FStar_Getopt.opt_variant,
    Prims.string) FStar_Pervasives_Native.tuple4 Prims.list
  =
  FStar_All.pipe_right all_specs
    (FStar_List.filter
       (fun uu____5164  ->
          match uu____5164 with
          | (uu____5175,x,uu____5177,uu____5178) -> settable x))
let resettable_specs:
  (FStar_BaseTypes.char,Prims.string,Prims.unit FStar_Getopt.opt_variant,
    Prims.string) FStar_Pervasives_Native.tuple4 Prims.list
  =
  FStar_All.pipe_right all_specs
    (FStar_List.filter
       (fun uu____5224  ->
          match uu____5224 with
          | (uu____5235,x,uu____5237,uu____5238) -> resettable x))
let display_usage: Prims.unit -> Prims.unit =
  fun uu____5245  ->
    let uu____5246 = specs () in display_usage_aux uu____5246
let fstar_home: Prims.unit -> Prims.string =
  fun uu____5261  ->
    let uu____5262 = get_fstar_home () in
    match uu____5262 with
    | FStar_Pervasives_Native.None  ->
        let x = FStar_Util.get_exec_dir () in
        let x1 = Prims.strcat x "/.." in
        ((let uu____5268 =
            let uu____5273 = mk_string x1 in ("fstar_home", uu____5273) in
          set_option' uu____5268);
         x1)
    | FStar_Pervasives_Native.Some x -> x
exception File_argument of Prims.string
let uu___is_File_argument: Prims.exn -> Prims.bool =
  fun projectee  ->
    match projectee with
    | File_argument uu____5281 -> true
    | uu____5282 -> false
let __proj__File_argument__item__uu___: Prims.exn -> Prims.string =
  fun projectee  ->
    match projectee with | File_argument uu____5289 -> uu____5289
let set_options: options -> Prims.string -> FStar_Getopt.parse_cmdline_res =
  fun o  ->
    fun s  ->
      let specs1 =
        match o with
        | Set  -> settable_specs
        | Reset  -> resettable_specs
        | Restore  -> all_specs in
      try
        if s = ""
        then FStar_Getopt.Success
        else
          FStar_Getopt.parse_string specs1
            (fun s1  -> FStar_Exn.raise (File_argument s1)) s
      with
      | File_argument s1 ->
          let uu____5333 =
            FStar_Util.format1 "File %s is not a valid option" s1 in
          FStar_Getopt.Error uu____5333
let file_list_: Prims.string Prims.list FStar_ST.ref = FStar_Util.mk_ref []
let parse_cmd_line:
  Prims.unit ->
    (FStar_Getopt.parse_cmdline_res,Prims.string Prims.list)
      FStar_Pervasives_Native.tuple2
  =
  fun uu____5359  ->
    let res =
      FStar_Getopt.parse_cmdline all_specs
        (fun i  ->
           let uu____5364 =
             let uu____5367 = FStar_ST.op_Bang file_list_ in
             FStar_List.append uu____5367 [i] in
           FStar_ST.op_Colon_Equals file_list_ uu____5364) in
    let uu____5474 =
      let uu____5477 = FStar_ST.op_Bang file_list_ in
      FStar_List.map FStar_Common.try_convert_file_name_to_mixed uu____5477 in
    (res, uu____5474)
let file_list: Prims.unit -> Prims.string Prims.list =
  fun uu____5538  -> FStar_ST.op_Bang file_list_
let restore_cmd_line_options: Prims.bool -> FStar_Getopt.parse_cmdline_res =
  fun should_clear  ->
    let old_verify_module = get_verify_module () in
    if should_clear then clear () else init ();
    (let r =
       let uu____5600 = specs () in
       FStar_Getopt.parse_cmdline uu____5600 (fun x  -> ()) in
     (let uu____5606 =
        let uu____5611 =
          let uu____5612 = FStar_List.map mk_string old_verify_module in
          List uu____5612 in
        ("verify_module", uu____5611) in
      set_option' uu____5606);
     r)
let module_name_of_file_name: Prims.string -> Prims.string =
  fun f  ->
    let f1 = FStar_Util.basename f in
    let f2 =
      let uu____5620 =
        let uu____5621 =
          let uu____5622 =
            let uu____5623 = FStar_Util.get_file_extension f1 in
            FStar_String.length uu____5623 in
          (FStar_String.length f1) - uu____5622 in
        uu____5621 - (Prims.parse_int "1") in
      FStar_String.substring f1 (Prims.parse_int "0") uu____5620 in
    FStar_String.lowercase f2
let should_verify: Prims.string -> Prims.bool =
  fun m  ->
    let uu____5627 = get_lax () in
    if uu____5627
    then false
    else
      (let l = get_verify_module () in
       FStar_List.contains (FStar_String.lowercase m) l)
let should_verify_file: Prims.string -> Prims.bool =
  fun fn  ->
    let uu____5635 = module_name_of_file_name fn in should_verify uu____5635
let dont_gen_projectors: Prims.string -> Prims.bool =
  fun m  ->
    let uu____5639 = get___temp_no_proj () in
    FStar_List.contains m uu____5639
let should_print_message: Prims.string -> Prims.bool =
  fun m  ->
    let uu____5645 = should_verify m in
    if uu____5645 then m <> "Prims" else false
let include_path: Prims.unit -> Prims.string Prims.list =
  fun uu____5651  ->
    let uu____5652 = get_no_default_includes () in
    if uu____5652
    then get_include ()
    else
      (let h = fstar_home () in
       let defs = universe_include_path_base_dirs in
       let uu____5660 =
         let uu____5663 =
           FStar_All.pipe_right defs
             (FStar_List.map (fun x  -> Prims.strcat h x)) in
         FStar_All.pipe_right uu____5663
           (FStar_List.filter FStar_Util.file_exists) in
       let uu____5676 =
         let uu____5679 = get_include () in
         FStar_List.append uu____5679 ["."] in
       FStar_List.append uu____5660 uu____5676)
let find_file: Prims.string -> Prims.string FStar_Pervasives_Native.option =
  fun filename  ->
    let uu____5687 = FStar_Util.is_path_absolute filename in
    if uu____5687
    then
      (if FStar_Util.file_exists filename
       then FStar_Pervasives_Native.Some filename
       else FStar_Pervasives_Native.None)
    else
      (let uu____5694 =
         let uu____5697 = include_path () in FStar_List.rev uu____5697 in
       FStar_Util.find_map uu____5694
         (fun p  ->
            let path = FStar_Util.join_paths p filename in
            if FStar_Util.file_exists path
            then FStar_Pervasives_Native.Some path
            else FStar_Pervasives_Native.None))
let prims: Prims.unit -> Prims.string =
  fun uu____5709  ->
    let uu____5710 = get_prims () in
    match uu____5710 with
    | FStar_Pervasives_Native.None  ->
        let filename = "prims.fst" in
        let uu____5714 = find_file filename in
        (match uu____5714 with
         | FStar_Pervasives_Native.Some result -> result
         | FStar_Pervasives_Native.None  ->
             let uu____5718 =
               FStar_Util.format1
                 "unable to find required file \"%s\" in the module search path.\n"
                 filename in
             failwith uu____5718)
    | FStar_Pervasives_Native.Some x -> x
let prims_basename: Prims.unit -> Prims.string =
  fun uu____5722  ->
    let uu____5723 = prims () in FStar_Util.basename uu____5723
let pervasives: Prims.unit -> Prims.string =
  fun uu____5726  ->
    let filename = "FStar.Pervasives.fst" in
    let uu____5728 = find_file filename in
    match uu____5728 with
    | FStar_Pervasives_Native.Some result -> result
    | FStar_Pervasives_Native.None  ->
        let uu____5732 =
          FStar_Util.format1
            "unable to find required file \"%s\" in the module search path.\n"
            filename in
        failwith uu____5732
let pervasives_basename: Prims.unit -> Prims.string =
  fun uu____5735  ->
    let uu____5736 = pervasives () in FStar_Util.basename uu____5736
let pervasives_native_basename: Prims.unit -> Prims.string =
  fun uu____5739  ->
    let filename = "FStar.Pervasives.Native.fst" in
    let uu____5741 = find_file filename in
    match uu____5741 with
    | FStar_Pervasives_Native.Some result -> FStar_Util.basename result
    | FStar_Pervasives_Native.None  ->
        let uu____5745 =
          FStar_Util.format1
            "unable to find required file \"%s\" in the module search path.\n"
            filename in
        failwith uu____5745
let prepend_output_dir: Prims.string -> Prims.string =
  fun fname  ->
    let uu____5749 = get_odir () in
    match uu____5749 with
    | FStar_Pervasives_Native.None  -> fname
    | FStar_Pervasives_Native.Some x ->
        Prims.strcat x (Prims.strcat "/" fname)
let __temp_no_proj: Prims.string -> Prims.bool =
  fun s  ->
    let uu____5756 = get___temp_no_proj () in
    FStar_All.pipe_right uu____5756 (FStar_List.contains s)
let admit_smt_queries: Prims.unit -> Prims.bool =
  fun uu____5763  -> get_admit_smt_queries ()
let admit_except: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____5768  -> get_admit_except ()
let cache_checked_modules: Prims.unit -> Prims.bool =
  fun uu____5771  -> get_cache_checked_modules ()
let codegen: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____5776  -> get_codegen ()
let codegen_libs: Prims.unit -> Prims.string Prims.list Prims.list =
  fun uu____5783  ->
    let uu____5784 = get_codegen_lib () in
    FStar_All.pipe_right uu____5784
      (FStar_List.map (fun x  -> FStar_Util.split x "."))
let debug_any: Prims.unit -> Prims.bool =
  fun uu____5799  -> let uu____5800 = get_debug () in uu____5800 <> []
let debug_at_level: Prims.string -> debug_level_t -> Prims.bool =
  fun modul  ->
    fun level  ->
      (let uu____5813 = get_debug () in
       FStar_All.pipe_right uu____5813 (FStar_List.contains modul)) &&
        (debug_level_geq level)
let dep: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____5822  -> get_dep ()
let detail_errors: Prims.unit -> Prims.bool =
  fun uu____5825  -> get_detail_errors ()
let detail_hint_replay: Prims.unit -> Prims.bool =
  fun uu____5828  -> get_detail_hint_replay ()
let doc: Prims.unit -> Prims.bool = fun uu____5831  -> get_doc ()
let dump_module: Prims.string -> Prims.bool =
  fun s  ->
    let uu____5835 = get_dump_module () in
    FStar_All.pipe_right uu____5835 (FStar_List.contains s)
let eager_inference: Prims.unit -> Prims.bool =
  fun uu____5842  -> get_eager_inference ()
let expose_interfaces: Prims.unit -> Prims.bool =
  fun uu____5845  -> get_expose_interfaces ()
let fs_typ_app: Prims.string -> Prims.bool =
  fun filename  ->
    let uu____5849 = FStar_ST.op_Bang light_off_files in
    FStar_List.contains filename uu____5849
let gen_native_tactics:
  Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____5908  -> get_gen_native_tactics ()
let full_context_dependency: Prims.unit -> Prims.bool =
  fun uu____5911  -> true
let hide_uvar_nums: Prims.unit -> Prims.bool =
  fun uu____5914  -> get_hide_uvar_nums ()
let hint_info: Prims.unit -> Prims.bool =
  fun uu____5917  -> (get_hint_info ()) || (get_query_stats ())
let hint_file: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____5922  -> get_hint_file ()
let ide: Prims.unit -> Prims.bool = fun uu____5925  -> get_ide ()
let indent: Prims.unit -> Prims.bool = fun uu____5928  -> get_indent ()
let initial_fuel: Prims.unit -> Prims.int =
  fun uu____5931  ->
    let uu____5932 = get_initial_fuel () in
    let uu____5933 = get_max_fuel () in Prims.min uu____5932 uu____5933
let initial_ifuel: Prims.unit -> Prims.int =
  fun uu____5936  ->
    let uu____5937 = get_initial_ifuel () in
    let uu____5938 = get_max_ifuel () in Prims.min uu____5937 uu____5938
let interactive: Prims.unit -> Prims.bool =
  fun uu____5941  -> (get_in ()) || (get_ide ())
let lax: Prims.unit -> Prims.bool = fun uu____5944  -> get_lax ()
let load: Prims.unit -> Prims.string Prims.list =
  fun uu____5949  -> get_load ()
let legacy_interactive: Prims.unit -> Prims.bool =
  fun uu____5952  -> get_in ()
let log_queries: Prims.unit -> Prims.bool =
  fun uu____5955  -> get_log_queries ()
let log_types: Prims.unit -> Prims.bool = fun uu____5958  -> get_log_types ()
let max_fuel: Prims.unit -> Prims.int = fun uu____5961  -> get_max_fuel ()
let max_ifuel: Prims.unit -> Prims.int = fun uu____5964  -> get_max_ifuel ()
let min_fuel: Prims.unit -> Prims.int = fun uu____5967  -> get_min_fuel ()
let ml_ish: Prims.unit -> Prims.bool = fun uu____5970  -> get_MLish ()
let set_ml_ish: Prims.unit -> Prims.unit =
  fun uu____5973  -> set_option "MLish" (Bool true)
let n_cores: Prims.unit -> Prims.int = fun uu____5976  -> get_n_cores ()
let no_default_includes: Prims.unit -> Prims.bool =
  fun uu____5979  -> get_no_default_includes ()
let no_extract: Prims.string -> Prims.bool =
  fun s  ->
    let s1 = FStar_String.lowercase s in
    let uu____5984 = get_no_extract () in
    FStar_All.pipe_right uu____5984
      (FStar_Util.for_some (fun f  -> (FStar_String.lowercase f) = s1))
let no_location_info: Prims.unit -> Prims.bool =
  fun uu____5993  -> get_no_location_info ()
let output_dir: Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____5998  -> get_odir ()
let ugly: Prims.unit -> Prims.bool = fun uu____6001  -> get_ugly ()
let print_bound_var_types: Prims.unit -> Prims.bool =
  fun uu____6004  -> get_print_bound_var_types ()
let print_effect_args: Prims.unit -> Prims.bool =
  fun uu____6007  -> get_print_effect_args ()
let print_implicits: Prims.unit -> Prims.bool =
  fun uu____6010  -> get_print_implicits ()
let print_real_names: Prims.unit -> Prims.bool =
  fun uu____6013  -> (get_prn ()) || (get_print_full_names ())
let print_universes: Prims.unit -> Prims.bool =
  fun uu____6016  -> get_print_universes ()
let print_z3_statistics: Prims.unit -> Prims.bool =
  fun uu____6019  -> (get_print_z3_statistics ()) || (get_query_stats ())
let query_stats: Prims.unit -> Prims.bool =
  fun uu____6022  -> get_query_stats ()
let record_hints: Prims.unit -> Prims.bool =
  fun uu____6025  -> get_record_hints ()
let reuse_hint_for: Prims.unit -> Prims.string FStar_Pervasives_Native.option
  = fun uu____6030  -> get_reuse_hint_for ()
let silent: Prims.unit -> Prims.bool = fun uu____6033  -> get_silent ()
let smtencoding_elim_box: Prims.unit -> Prims.bool =
  fun uu____6036  -> get_smtencoding_elim_box ()
let smtencoding_nl_arith_native: Prims.unit -> Prims.bool =
  fun uu____6039  ->
    let uu____6040 = get_smtencoding_nl_arith_repr () in
    uu____6040 = "native"
let smtencoding_nl_arith_wrapped: Prims.unit -> Prims.bool =
  fun uu____6043  ->
    let uu____6044 = get_smtencoding_nl_arith_repr () in
    uu____6044 = "wrapped"
let smtencoding_nl_arith_default: Prims.unit -> Prims.bool =
  fun uu____6047  ->
    let uu____6048 = get_smtencoding_nl_arith_repr () in
    uu____6048 = "boxwrap"
let smtencoding_l_arith_native: Prims.unit -> Prims.bool =
  fun uu____6051  ->
    let uu____6052 = get_smtencoding_l_arith_repr () in uu____6052 = "native"
let smtencoding_l_arith_default: Prims.unit -> Prims.bool =
  fun uu____6055  ->
    let uu____6056 = get_smtencoding_l_arith_repr () in
    uu____6056 = "boxwrap"
let tactic_raw_binders: Prims.unit -> Prims.bool =
  fun uu____6059  -> get_tactic_raw_binders ()
let tactic_trace: Prims.unit -> Prims.bool =
  fun uu____6062  -> get_tactic_trace ()
let tactic_trace_d: Prims.unit -> Prims.int =
  fun uu____6065  -> get_tactic_trace_d ()
let timing: Prims.unit -> Prims.bool = fun uu____6068  -> get_timing ()
let trace_error: Prims.unit -> Prims.bool =
  fun uu____6071  -> get_trace_error ()
let unthrottle_inductives: Prims.unit -> Prims.bool =
  fun uu____6074  -> get_unthrottle_inductives ()
let unsafe_tactic_exec: Prims.unit -> Prims.bool =
  fun uu____6077  -> get_unsafe_tactic_exec ()
let use_eq_at_higher_order: Prims.unit -> Prims.bool =
  fun uu____6080  -> get_use_eq_at_higher_order ()
let use_hints: Prims.unit -> Prims.bool = fun uu____6083  -> get_use_hints ()
let use_hint_hashes: Prims.unit -> Prims.bool =
  fun uu____6086  -> get_use_hint_hashes ()
let use_native_tactics:
  Prims.unit -> Prims.string FStar_Pervasives_Native.option =
  fun uu____6091  -> get_use_native_tactics ()
let use_tactics: Prims.unit -> Prims.bool =
  fun uu____6094  -> get_use_tactics ()
let using_facts_from:
  Prims.unit ->
    (FStar_Ident.path,Prims.bool) FStar_Pervasives_Native.tuple2 Prims.list
  =
  fun uu____6103  ->
    let parse_one_setting s =
      if s = "*"
      then ([], true)
      else
        if FStar_Util.starts_with s "-"
        then
          (let path =
             let uu____6132 =
               FStar_Util.substring_from s (Prims.parse_int "1") in
             FStar_Ident.path_of_text uu____6132 in
           (path, false))
        else
          (let s1 =
             if FStar_Util.starts_with s "+"
             then FStar_Util.substring_from s (Prims.parse_int "1")
             else s in
           ((FStar_Ident.path_of_text s1), true)) in
    let parse_setting s =
      FStar_All.pipe_right (FStar_Util.split s " ")
        (FStar_List.map parse_one_setting) in
    let uu____6168 = get_using_facts_from () in
    match uu____6168 with
    | FStar_Pervasives_Native.None  -> [([], true)]
    | FStar_Pervasives_Native.Some ns ->
        let uu____6200 = FStar_List.collect parse_setting ns in
        FStar_All.pipe_right uu____6200 FStar_List.rev
let warn_default_effects: Prims.unit -> Prims.bool =
  fun uu____6239  -> get_warn_default_effects ()
let z3_exe: Prims.unit -> Prims.string =
  fun uu____6242  ->
    let uu____6243 = get_smt () in
    match uu____6243 with
    | FStar_Pervasives_Native.None  -> FStar_Platform.exe "z3"
    | FStar_Pervasives_Native.Some s -> s
let z3_cliopt: Prims.unit -> Prims.string Prims.list =
  fun uu____6251  -> get_z3cliopt ()
let z3_refresh: Prims.unit -> Prims.bool =
  fun uu____6254  -> get_z3refresh ()
let z3_rlimit: Prims.unit -> Prims.int = fun uu____6257  -> get_z3rlimit ()
let z3_rlimit_factor: Prims.unit -> Prims.int =
  fun uu____6260  -> get_z3rlimit_factor ()
let z3_seed: Prims.unit -> Prims.int = fun uu____6263  -> get_z3seed ()
let use_two_phase_tc: Prims.unit -> Prims.bool =
  fun uu____6266  -> get_use_two_phase_tc ()
let no_positivity: Prims.unit -> Prims.bool =
  fun uu____6269  -> get_no_positivity ()
let ml_no_eta_expand_coertions: Prims.unit -> Prims.bool =
  fun uu____6272  -> get_ml_no_eta_expand_coertions ()
let warn_error: Prims.unit -> Prims.string =
  fun uu____6275  -> get_warn_error ()
let should_extract_namespace: Prims.string -> Prims.bool =
  fun m  ->
    let uu____6279 = get_extract_namespace () in
    match uu____6279 with
    | [] -> false
    | ns ->
        FStar_All.pipe_right ns
          (FStar_Util.for_some
             (fun n1  -> FStar_Util.starts_with m (FStar_String.lowercase n1)))
let should_extract_module: Prims.string -> Prims.bool =
  fun m  ->
    let uu____6292 = get_extract_module () in
    match uu____6292 with
    | [] -> false
    | l ->
        FStar_All.pipe_right l
          (FStar_Util.for_some (fun n1  -> (FStar_String.lowercase n1) = m))
let should_extract: Prims.string -> Prims.bool =
  fun m  ->
    let m1 = FStar_String.lowercase m in
    (let uu____6308 = no_extract m1 in Prims.op_Negation uu____6308) &&
      (let uu____6310 =
         let uu____6319 = get_extract_namespace () in
         let uu____6322 = get_extract_module () in (uu____6319, uu____6322) in
       match uu____6310 with
       | ([],[]) -> true
       | uu____6333 ->
           (should_extract_namespace m1) || (should_extract_module m1))
let codegen_fsharp: Prims.unit -> Prims.bool =
  fun uu____6344  ->
    let uu____6345 = codegen () in
    uu____6345 = (FStar_Pervasives_Native.Some "FSharp")