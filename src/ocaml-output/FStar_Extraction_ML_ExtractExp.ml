
open Prims
# 27 "FStar.Extraction.ML.ExtractExp.fst"
let type_leq : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty  ->  Prims.bool = (fun g t1 t2 -> (FStar_Extraction_ML_Util.type_leq (FStar_Extraction_ML_Util.delta_unfold g) t1 t2))

# 29 "FStar.Extraction.ML.ExtractExp.fst"
let type_leq_c : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlexpr Prims.option  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty  ->  (Prims.bool * FStar_Extraction_ML_Syntax.mlexpr Prims.option) = (fun g t1 t2 -> (FStar_Extraction_ML_Util.type_leq_c (FStar_Extraction_ML_Util.delta_unfold g) t1 t2))

# 30 "FStar.Extraction.ML.ExtractExp.fst"
let erasableType : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlty  ->  Prims.bool = (fun g t -> (FStar_Extraction_ML_Util.erasableType (FStar_Extraction_ML_Util.delta_unfold g) t))

# 31 "FStar.Extraction.ML.ExtractExp.fst"
let eraseTypeDeep : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty = (fun g t -> (FStar_Extraction_ML_Util.eraseTypeDeep (FStar_Extraction_ML_Util.delta_unfold g) t))

# 32 "FStar.Extraction.ML.ExtractExp.fst"
let fail = (fun r msg -> (
# 35 "FStar.Extraction.ML.ExtractExp.fst"
let _71_19 = (let _156_27 = (FStar_Absyn_Print.format_error r msg)
in (FStar_All.pipe_left FStar_Util.print_string _156_27))
in (FStar_All.failwith msg)))

# 36 "FStar.Extraction.ML.ExtractExp.fst"
let err_uninst = (fun env e _71_25 -> (match (_71_25) with
| (vars, t) -> begin
(let _156_35 = (let _156_34 = (FStar_Absyn_Print.exp_to_string e)
in (let _156_33 = (let _156_31 = (FStar_All.pipe_right vars (FStar_List.map Prims.fst))
in (FStar_All.pipe_right _156_31 (FStar_String.concat ", ")))
in (let _156_32 = (FStar_Extraction_ML_Code.string_of_mlty env.FStar_Extraction_ML_Env.currentModule t)
in (FStar_Util.format3 "Variable %s has a polymorphic type (forall %s. %s); expected it to be fully instantiated" _156_34 _156_33 _156_32))))
in (fail e.FStar_Absyn_Syntax.pos _156_35))
end))

# 42 "FStar.Extraction.ML.ExtractExp.fst"
let err_ill_typed_application = (fun e args t -> (let _156_41 = (let _156_40 = (FStar_Absyn_Print.exp_to_string e)
in (let _156_39 = (FStar_Absyn_Print.args_to_string args)
in (FStar_Util.format2 "Ill-typed application: application is %s \n remaining args are %s\n" _156_40 _156_39)))
in (fail e.FStar_Absyn_Syntax.pos _156_41)))

# 48 "FStar.Extraction.ML.ExtractExp.fst"
let err_value_restriction = (fun e -> (fail e.FStar_Absyn_Syntax.pos "Refusing to generalize because of the value restriction"))

# 52 "FStar.Extraction.ML.ExtractExp.fst"
let err_unexpected_eff = (fun e f0 f1 -> (let _156_47 = (let _156_46 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.format3 "for expression %s, Expected effect %s; got effect %s" _156_46 (FStar_Extraction_ML_Util.eff_to_string f0) (FStar_Extraction_ML_Util.eff_to_string f1)))
in (fail e.FStar_Absyn_Syntax.pos _156_47)))

# 55 "FStar.Extraction.ML.ExtractExp.fst"
let is_constructor : (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  Prims.bool = (fun e -> (match ((let _156_50 = (FStar_Absyn_Util.compress_exp e)
in _156_50.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_fvar (_, Some (FStar_Absyn_Syntax.Data_ctor))) | (FStar_Absyn_Syntax.Exp_fvar (_, Some (FStar_Absyn_Syntax.Record_ctor (_)))) -> begin
true
end
| _71_49 -> begin
false
end))

# 60 "FStar.Extraction.ML.ExtractExp.fst"
let rec is_value_or_type_app : FStar_Absyn_Syntax.exp  ->  Prims.bool = (fun e -> (match ((let _156_53 = (FStar_Absyn_Util.compress_exp e)
in _156_53.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_constant (_)) | (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) | (FStar_Absyn_Syntax.Exp_abs (_)) -> begin
true
end
| FStar_Absyn_Syntax.Exp_app (head, args) -> begin
if (is_constructor head) then begin
(FStar_All.pipe_right args (FStar_List.for_all (fun _71_70 -> (match (_71_70) with
| (te, _71_69) -> begin
(match (te) with
| FStar_Util.Inl (_71_72) -> begin
true
end
| FStar_Util.Inr (e) -> begin
(is_value_or_type_app e)
end)
end))))
end else begin
(match ((let _156_55 = (FStar_Absyn_Util.compress_exp head)
in _156_55.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) -> begin
(FStar_All.pipe_right args (FStar_List.for_all (fun _71_1 -> (match (_71_1) with
| (FStar_Util.Inl (te), _71_86) -> begin
true
end
| _71_89 -> begin
false
end))))
end
| _71_91 -> begin
false
end)
end
end
| (FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _))) | (FStar_Absyn_Syntax.Exp_ascribed (e, _, _)) -> begin
(is_value_or_type_app e)
end
| _71_105 -> begin
false
end))

# 80 "FStar.Extraction.ML.ExtractExp.fst"
let rec is_ml_value : FStar_Extraction_ML_Syntax.mlexpr  ->  Prims.bool = (fun e -> (match (e.FStar_Extraction_ML_Syntax.expr) with
| (FStar_Extraction_ML_Syntax.MLE_Const (_)) | (FStar_Extraction_ML_Syntax.MLE_Var (_)) | (FStar_Extraction_ML_Syntax.MLE_Name (_)) | (FStar_Extraction_ML_Syntax.MLE_Fun (_)) -> begin
true
end
| (FStar_Extraction_ML_Syntax.MLE_CTor (_, exps)) | (FStar_Extraction_ML_Syntax.MLE_Tuple (exps)) -> begin
(FStar_Util.for_all is_ml_value exps)
end
| FStar_Extraction_ML_Syntax.MLE_Record (_71_126, fields) -> begin
(FStar_Util.for_all (fun _71_133 -> (match (_71_133) with
| (_71_131, e) -> begin
(is_ml_value e)
end)) fields)
end
| _71_135 -> begin
false
end))

# 90 "FStar.Extraction.ML.ExtractExp.fst"
let translate_typ : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.typ  ->  FStar_Extraction_ML_Syntax.mlty = (fun g t -> (let _156_64 = (FStar_Extraction_ML_ExtractTyp.extractTyp g t)
in (eraseTypeDeep g _156_64)))

# 94 "FStar.Extraction.ML.ExtractExp.fst"
let translate_typ_of_arg : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.arg  ->  FStar_Extraction_ML_Syntax.mlty = (fun g a -> (let _156_69 = (FStar_Extraction_ML_ExtractTyp.getTypeFromArg g a)
in (eraseTypeDeep g _156_69)))

# 95 "FStar.Extraction.ML.ExtractExp.fst"
let instantiate : FStar_Extraction_ML_Syntax.mltyscheme  ->  FStar_Extraction_ML_Syntax.mlty Prims.list  ->  FStar_Extraction_ML_Syntax.mlty = (fun s args -> (FStar_Extraction_ML_Util.subst s args))

# 99 "FStar.Extraction.ML.ExtractExp.fst"
let erasable : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  Prims.bool = (fun g f t -> ((f = FStar_Extraction_ML_Syntax.E_GHOST) || ((f = FStar_Extraction_ML_Syntax.E_PURE) && (erasableType g t))))

# 103 "FStar.Extraction.ML.ExtractExp.fst"
let erase : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  (FStar_Extraction_ML_Syntax.mlexpr * FStar_Extraction_ML_Syntax.e_tag * FStar_Extraction_ML_Syntax.mlty) = (fun g e f t -> if (erasable g f t) then begin
(
# 107 "FStar.Extraction.ML.ExtractExp.fst"
let _71_150 = (FStar_Extraction_ML_Env.debug g (fun _71_149 -> (match (()) with
| () -> begin
(let _156_90 = (FStar_Extraction_ML_Code.string_of_mlexpr g.FStar_Extraction_ML_Env.currentModule e)
in (let _156_89 = (FStar_Extraction_ML_Code.string_of_mlty g.FStar_Extraction_ML_Env.currentModule t)
in (FStar_Util.print2 "Erasing %s at type %s\n" _156_90 _156_89)))
end)))
in (
# 108 "FStar.Extraction.ML.ExtractExp.fst"
let e_val = if (type_leq g t FStar_Extraction_ML_Syntax.ml_unit_ty) then begin
FStar_Extraction_ML_Syntax.ml_unit
end else begin
(FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t) (FStar_Extraction_ML_Syntax.MLE_Coerce ((FStar_Extraction_ML_Syntax.ml_unit, FStar_Extraction_ML_Syntax.ml_unit_ty, t))))
end
in (e_val, f, t)))
end else begin
(e, f, t)
end)

# 110 "FStar.Extraction.ML.ExtractExp.fst"
let maybe_coerce : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g e tInferred tExpected -> (match ((type_leq_c g (Some (e)) tInferred tExpected)) with
| (true, Some (e')) -> begin
e'
end
| _71_162 -> begin
(FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty tExpected) (FStar_Extraction_ML_Syntax.MLE_Coerce ((e, tInferred, tExpected))))
end))

# 119 "FStar.Extraction.ML.ExtractExp.fst"
let extract_pat : FStar_Extraction_ML_Env.env  ->  (FStar_Absyn_Syntax.pat', ((FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Util.either Prims.option) FStar_Absyn_Syntax.withinfo_t  ->  (FStar_Extraction_ML_Env.env * (FStar_Extraction_ML_Syntax.mlpattern * FStar_Extraction_ML_Syntax.mlexpr Prims.option) Prims.list) = (fun g p -> (
# 123 "FStar.Extraction.ML.ExtractExp.fst"
let rec extract_one_pat = (fun disj imp g p -> (match (p.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (_71_171) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_int (c)) when (not ((FStar_ST.read FStar_Options.use_native_int))) -> begin
(
# 129 "FStar.Extraction.ML.ExtractExp.fst"
let x = (let _156_111 = (FStar_Absyn_Util.new_bvd None)
in (FStar_Extraction_ML_Syntax.as_mlident _156_111))
in (
# 130 "FStar.Extraction.ML.ExtractExp.fst"
let when_clause = (let _156_120 = (let _156_119 = (let _156_118 = (let _156_117 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_int_ty) (FStar_Extraction_ML_Syntax.MLE_Var (x)))
in (let _156_116 = (let _156_115 = (let _156_114 = (let _156_113 = (FStar_Extraction_ML_Util.mlconst_of_const' p.FStar_Absyn_Syntax.p (FStar_Const.Const_int (c)))
in (FStar_All.pipe_left (fun _156_112 -> FStar_Extraction_ML_Syntax.MLE_Const (_156_112)) _156_113))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_int_ty) _156_114))
in (_156_115)::[])
in (_156_117)::_156_116))
in (FStar_Extraction_ML_Util.prims_op_equality, _156_118))
in FStar_Extraction_ML_Syntax.MLE_App (_156_119))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) _156_120))
in (g, Some ((FStar_Extraction_ML_Syntax.MLP_Var (x), (when_clause)::[])))))
end
| FStar_Absyn_Syntax.Pat_constant (s) -> begin
(let _156_124 = (let _156_123 = (let _156_122 = (let _156_121 = (FStar_Extraction_ML_Util.mlconst_of_const' p.FStar_Absyn_Syntax.p s)
in FStar_Extraction_ML_Syntax.MLP_Const (_156_121))
in (_156_122, []))
in Some (_156_123))
in (g, _156_124))
end
| FStar_Absyn_Syntax.Pat_cons (f, q, pats) -> begin
(
# 138 "FStar.Extraction.ML.ExtractExp.fst"
let _71_200 = (match ((FStar_Extraction_ML_Env.lookup_fv g f)) with
| ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (n); FStar_Extraction_ML_Syntax.mlty = _71_188; FStar_Extraction_ML_Syntax.loc = _71_186}, ttys, _71_194) -> begin
(n, ttys)
end
| _71_197 -> begin
(FStar_All.failwith "Expected a constructor")
end)
in (match (_71_200) with
| (d, tys) -> begin
(
# 141 "FStar.Extraction.ML.ExtractExp.fst"
let nTyVars = (FStar_List.length (Prims.fst tys))
in (
# 142 "FStar.Extraction.ML.ExtractExp.fst"
let _71_204 = (FStar_Util.first_N nTyVars pats)
in (match (_71_204) with
| (tysVarPats, restPats) -> begin
(
# 143 "FStar.Extraction.ML.ExtractExp.fst"
let _71_211 = (FStar_Util.fold_map (fun g _71_208 -> (match (_71_208) with
| (p, imp) -> begin
(extract_one_pat disj true g p)
end)) g tysVarPats)
in (match (_71_211) with
| (g, tyMLPats) -> begin
(
# 144 "FStar.Extraction.ML.ExtractExp.fst"
let _71_225 = (FStar_Util.fold_map (fun g _71_215 -> (match (_71_215) with
| (p, imp) -> begin
(
# 145 "FStar.Extraction.ML.ExtractExp.fst"
let _71_218 = (extract_one_pat disj false g p)
in (match (_71_218) with
| (env, popt) -> begin
(
# 146 "FStar.Extraction.ML.ExtractExp.fst"
let popt = (match (popt) with
| None -> begin
Some ((FStar_Extraction_ML_Syntax.MLP_Wild, []))
end
| _71_221 -> begin
popt
end)
in (env, popt))
end))
end)) g restPats)
in (match (_71_225) with
| (g, restMLPats) -> begin
(
# 150 "FStar.Extraction.ML.ExtractExp.fst"
let _71_233 = (let _156_130 = (FStar_All.pipe_right (FStar_List.append tyMLPats restMLPats) (FStar_List.collect (fun _71_2 -> (match (_71_2) with
| Some (x) -> begin
(x)::[]
end
| _71_230 -> begin
[]
end))))
in (FStar_All.pipe_right _156_130 FStar_List.split))
in (match (_71_233) with
| (mlPats, when_clauses) -> begin
(let _156_134 = (let _156_133 = (let _156_132 = (FStar_All.pipe_left (FStar_Extraction_ML_Util.resugar_pat q) (FStar_Extraction_ML_Syntax.MLP_CTor ((d, mlPats))))
in (let _156_131 = (FStar_All.pipe_right when_clauses FStar_List.flatten)
in (_156_132, _156_131)))
in Some (_156_133))
in (g, _156_134))
end))
end))
end))
end)))
end))
end
| FStar_Absyn_Syntax.Pat_var (x) -> begin
(
# 154 "FStar.Extraction.ML.ExtractExp.fst"
let mlty = (translate_typ g x.FStar_Absyn_Syntax.sort)
in (
# 155 "FStar.Extraction.ML.ExtractExp.fst"
let g = (FStar_Extraction_ML_Env.extend_bv g x ([], mlty) false false imp)
in (g, if imp then begin
None
end else begin
Some ((FStar_Extraction_ML_Syntax.MLP_Var ((FStar_Extraction_ML_Syntax.as_mlident x.FStar_Absyn_Syntax.v)), []))
end)))
end
| FStar_Absyn_Syntax.Pat_wild (x) when disj -> begin
(g, Some ((FStar_Extraction_ML_Syntax.MLP_Wild, [])))
end
| FStar_Absyn_Syntax.Pat_wild (x) -> begin
(
# 162 "FStar.Extraction.ML.ExtractExp.fst"
let mlty = (translate_typ g x.FStar_Absyn_Syntax.sort)
in (
# 163 "FStar.Extraction.ML.ExtractExp.fst"
let g = (FStar_Extraction_ML_Env.extend_bv g x ([], mlty) false false imp)
in (g, if imp then begin
None
end else begin
Some ((FStar_Extraction_ML_Syntax.MLP_Var ((FStar_Extraction_ML_Syntax.as_mlident x.FStar_Absyn_Syntax.v)), []))
end)))
end
| FStar_Absyn_Syntax.Pat_tvar (a) -> begin
(
# 167 "FStar.Extraction.ML.ExtractExp.fst"
let mlty = FStar_Extraction_ML_Syntax.MLTY_Top
in (
# 168 "FStar.Extraction.ML.ExtractExp.fst"
let g = (FStar_Extraction_ML_Env.extend_ty g a (Some (mlty)))
in (g, if imp then begin
None
end else begin
Some ((FStar_Extraction_ML_Syntax.MLP_Wild, []))
end)))
end
| (FStar_Absyn_Syntax.Pat_dot_term (_)) | (FStar_Absyn_Syntax.Pat_dot_typ (_)) | (FStar_Absyn_Syntax.Pat_twild (_)) -> begin
(g, None)
end))
in (
# 176 "FStar.Extraction.ML.ExtractExp.fst"
let extract_one_pat = (fun disj g p -> (match ((extract_one_pat disj false g p)) with
| (g, Some (x, v)) -> begin
(g, (x, v))
end
| _71_268 -> begin
(FStar_All.failwith "Impossible")
end))
in (
# 181 "FStar.Extraction.ML.ExtractExp.fst"
let mk_when_clause = (fun whens -> (match (whens) with
| [] -> begin
None
end
| hd::tl -> begin
(let _156_143 = (FStar_List.fold_left FStar_Extraction_ML_Util.conjoin hd tl)
in Some (_156_143))
end))
in (match (p.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj ([]) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Absyn_Syntax.Pat_disj (p::pats) -> begin
(
# 190 "FStar.Extraction.ML.ExtractExp.fst"
let _71_283 = (extract_one_pat true g p)
in (match (_71_283) with
| (g, p) -> begin
(
# 191 "FStar.Extraction.ML.ExtractExp.fst"
let ps = (let _156_146 = (FStar_All.pipe_right pats (FStar_List.map (fun x -> (let _156_145 = (extract_one_pat true g x)
in (Prims.snd _156_145)))))
in (p)::_156_146)
in (
# 192 "FStar.Extraction.ML.ExtractExp.fst"
let _71_299 = (FStar_All.pipe_right ps (FStar_List.partition (fun _71_3 -> (match (_71_3) with
| (_71_288, _71_292::_71_290) -> begin
true
end
| _71_296 -> begin
false
end))))
in (match (_71_299) with
| (ps_when, rest) -> begin
(
# 193 "FStar.Extraction.ML.ExtractExp.fst"
let ps = (FStar_All.pipe_right ps_when (FStar_List.map (fun _71_302 -> (match (_71_302) with
| (x, whens) -> begin
(let _156_149 = (mk_when_clause whens)
in (x, _156_149))
end))))
in (
# 195 "FStar.Extraction.ML.ExtractExp.fst"
let res = (match (rest) with
| [] -> begin
(g, ps)
end
| rest -> begin
(let _156_153 = (let _156_152 = (let _156_151 = (let _156_150 = (FStar_List.map Prims.fst rest)
in FStar_Extraction_ML_Syntax.MLP_Branch (_156_150))
in (_156_151, None))
in (_156_152)::ps)
in (g, _156_153))
end)
in res))
end)))
end))
end
| _71_308 -> begin
(
# 201 "FStar.Extraction.ML.ExtractExp.fst"
let _71_313 = (extract_one_pat false g p)
in (match (_71_313) with
| (g, (p, whens)) -> begin
(
# 202 "FStar.Extraction.ML.ExtractExp.fst"
let when_clause = (mk_when_clause whens)
in (g, ((p, when_clause))::[]))
end))
end)))))

# 203 "FStar.Extraction.ML.ExtractExp.fst"
let normalize_abs : (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  FStar_Absyn_Syntax.exp = (fun e0 -> (
# 206 "FStar.Extraction.ML.ExtractExp.fst"
let rec aux = (fun bs e -> (
# 207 "FStar.Extraction.ML.ExtractExp.fst"
let e = (FStar_Absyn_Util.compress_exp e)
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_abs (bs', body) -> begin
(aux (FStar_List.append bs bs') body)
end
| _71_325 -> begin
(
# 211 "FStar.Extraction.ML.ExtractExp.fst"
let e' = (FStar_Absyn_Util.unascribe e)
in if (FStar_Absyn_Util.is_fun e') then begin
(aux bs e')
end else begin
(FStar_Absyn_Syntax.mk_Exp_abs (bs, e) None e0.FStar_Absyn_Syntax.pos)
end)
end)))
in (aux [] e0)))

# 215 "FStar.Extraction.ML.ExtractExp.fst"
let ffi_mltuple_mlp : Prims.int  ->  (Prims.string Prims.list * Prims.string) = (fun n -> (
# 218 "FStar.Extraction.ML.ExtractExp.fst"
let name = if ((2 < n) && (n < 6)) then begin
(let _156_162 = (FStar_Util.string_of_int n)
in (Prims.strcat "mktuple" _156_162))
end else begin
if (n = 2) then begin
"mkpair"
end else begin
(FStar_All.failwith "NYI in runtime/allocator/camlstack.mli")
end
end
in (("Camlstack")::[], name)))

# 219 "FStar.Extraction.ML.ExtractExp.fst"
let fix_lalloc : FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun arg -> (match (arg.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_Tuple (args) -> begin
(FStar_All.failwith "unexpected. Prims.TupleN is not specially handled yet. So, F* tuples, which are sugar forPrims.TupleN,  were expected to be extracted as MLE_CTor")
end
| FStar_Extraction_ML_Syntax.MLE_Record (mlns, fields) -> begin
(
# 226 "FStar.Extraction.ML.ExtractExp.fst"
let args = (FStar_List.map Prims.snd fields)
in (
# 227 "FStar.Extraction.ML.ExtractExp.fst"
let tup = (let _156_169 = (let _156_168 = (let _156_167 = (let _156_166 = (let _156_165 = (ffi_mltuple_mlp (FStar_List.length args))
in FStar_Extraction_ML_Syntax.MLE_Name (_156_165))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top) _156_166))
in (_156_167, args))
in FStar_Extraction_ML_Syntax.MLE_App (_156_168))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top) _156_169))
in (
# 228 "FStar.Extraction.ML.ExtractExp.fst"
let dummyTy = FStar_Extraction_ML_Syntax.ml_unit_ty
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty dummyTy) (FStar_Extraction_ML_Syntax.MLE_Coerce ((tup, dummyTy, dummyTy)))))))
end
| FStar_Extraction_ML_Syntax.MLE_CTor (mlp, args) -> begin
(FStar_All.failwith "NYI: lalloc ctor")
end
| _71_344 -> begin
(FStar_All.failwith "for efficiency, the argument to lalloc should be a head normal form of the type. Extraction will then avoid creating this value on the heap.")
end))

# 231 "FStar.Extraction.ML.ExtractExp.fst"
let maybe_lalloc_eta_data : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.fv_qual Prims.option  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g qual residualType mlAppExpr -> (
# 243 "FStar.Extraction.ML.ExtractExp.fst"
let rec eta_args = (fun more_args t -> (match (t) with
| FStar_Extraction_ML_Syntax.MLTY_Fun (t0, _71_354, t1) -> begin
(
# 245 "FStar.Extraction.ML.ExtractExp.fst"
let x = (let _156_182 = (FStar_Absyn_Util.gensym ())
in (_156_182, (- (1))))
in (let _156_185 = (let _156_184 = (let _156_183 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t0) (FStar_Extraction_ML_Syntax.MLE_Var (x)))
in ((x, t0), _156_183))
in (_156_184)::more_args)
in (eta_args _156_185 t1)))
end
| FStar_Extraction_ML_Syntax.MLTY_Named (_71_360, _71_362) -> begin
((FStar_List.rev more_args), t)
end
| _71_366 -> begin
(FStar_All.failwith "Impossible")
end))
in (
# 250 "FStar.Extraction.ML.ExtractExp.fst"
let as_record = (fun qual e -> (match ((e.FStar_Extraction_ML_Syntax.expr, qual)) with
| (FStar_Extraction_ML_Syntax.MLE_CTor (_71_371, args), Some (FStar_Absyn_Syntax.Record_ctor (_71_376, fields))) -> begin
(
# 253 "FStar.Extraction.ML.ExtractExp.fst"
let path = (FStar_Extraction_ML_Util.record_field_path fields)
in (
# 254 "FStar.Extraction.ML.ExtractExp.fst"
let fields = (FStar_Extraction_ML_Util.record_fields fields args)
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty e.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Record ((path, fields))))))
end
| _71_385 -> begin
e
end))
in (
# 258 "FStar.Extraction.ML.ExtractExp.fst"
let resugar_and_maybe_eta = (fun qual e -> (
# 259 "FStar.Extraction.ML.ExtractExp.fst"
let _71_391 = (eta_args [] residualType)
in (match (_71_391) with
| (eargs, tres) -> begin
(match (eargs) with
| [] -> begin
(let _156_194 = (as_record qual e)
in (FStar_Extraction_ML_Util.resugar_exp _156_194))
end
| _71_394 -> begin
(
# 263 "FStar.Extraction.ML.ExtractExp.fst"
let _71_397 = (FStar_List.unzip eargs)
in (match (_71_397) with
| (binders, eargs) -> begin
(match (e.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_CTor (head, args) -> begin
(
# 266 "FStar.Extraction.ML.ExtractExp.fst"
let body = (let _156_196 = (let _156_195 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty tres) (FStar_Extraction_ML_Syntax.MLE_CTor ((head, (FStar_List.append args eargs)))))
in (FStar_All.pipe_left (as_record qual) _156_195))
in (FStar_All.pipe_left FStar_Extraction_ML_Util.resugar_exp _156_196))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty e.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Fun ((binders, body)))))
end
| _71_404 -> begin
(FStar_All.failwith "Impossible")
end)
end))
end)
end)))
in (match ((mlAppExpr.FStar_Extraction_ML_Syntax.expr, qual)) with
| (FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _71_408; FStar_Extraction_ML_Syntax.loc = _71_406}, mlarg::[]), _71_417) when (mlp = FStar_Extraction_ML_Syntax.mlp_lalloc) -> begin
(
# 272 "FStar.Extraction.ML.ExtractExp.fst"
let _71_420 = (FStar_Extraction_ML_Env.debug g (fun _71_419 -> (match (()) with
| () -> begin
(FStar_Util.print_string "need to do lalloc surgery here\n")
end)))
in (fix_lalloc mlarg))
end
| (_71_423, None) -> begin
mlAppExpr
end
| (FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _71_429; FStar_Extraction_ML_Syntax.loc = _71_427}, mle::args), Some (FStar_Absyn_Syntax.Record_projector (f))) -> begin
(
# 278 "FStar.Extraction.ML.ExtractExp.fst"
let fn = (FStar_Extraction_ML_Util.mlpath_of_lid f)
in (
# 279 "FStar.Extraction.ML.ExtractExp.fst"
let proj = FStar_Extraction_ML_Syntax.MLE_Proj ((mle, fn))
in (
# 280 "FStar.Extraction.ML.ExtractExp.fst"
let e = (match (args) with
| [] -> begin
proj
end
| _71_446 -> begin
(let _156_199 = (let _156_198 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top) proj)
in (_156_198, args))
in FStar_Extraction_ML_Syntax.MLE_App (_156_199))
end)
in (FStar_Extraction_ML_Syntax.with_ty mlAppExpr.FStar_Extraction_ML_Syntax.mlty e))))
end
| ((FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, mlargs), Some (FStar_Absyn_Syntax.Data_ctor))) | ((FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, mlargs), Some (FStar_Absyn_Syntax.Record_ctor (_)))) -> begin
(let _156_200 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty mlAppExpr.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_CTor ((mlp, mlargs))))
in (FStar_All.pipe_left (resugar_and_maybe_eta qual) _156_200))
end
| ((FStar_Extraction_ML_Syntax.MLE_Name (mlp), Some (FStar_Absyn_Syntax.Data_ctor))) | ((FStar_Extraction_ML_Syntax.MLE_Name (mlp), Some (FStar_Absyn_Syntax.Record_ctor (_)))) -> begin
(let _156_201 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty mlAppExpr.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_CTor ((mlp, []))))
in (FStar_All.pipe_left (resugar_and_maybe_eta qual) _156_201))
end
| _71_486 -> begin
mlAppExpr
end)))))

# 294 "FStar.Extraction.ML.ExtractExp.fst"
let check_pats_for_ite : (FStar_Absyn_Syntax.pat * FStar_Absyn_Syntax.exp Prims.option * FStar_Absyn_Syntax.exp) Prims.list  ->  (Prims.bool * FStar_Absyn_Syntax.exp Prims.option * FStar_Absyn_Syntax.exp Prims.option) = (fun l -> (
# 297 "FStar.Extraction.ML.ExtractExp.fst"
let def = (false, None, None)
in if ((FStar_List.length l) <> 2) then begin
def
end else begin
(
# 300 "FStar.Extraction.ML.ExtractExp.fst"
let _71_492 = (FStar_List.hd l)
in (match (_71_492) with
| (p1, w1, e1) -> begin
(
# 301 "FStar.Extraction.ML.ExtractExp.fst"
let _71_496 = (let _156_204 = (FStar_List.tl l)
in (FStar_List.hd _156_204))
in (match (_71_496) with
| (p2, w2, e2) -> begin
(match ((w1, w2, p1.FStar_Absyn_Syntax.v, p2.FStar_Absyn_Syntax.v)) with
| (None, None, FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (true)), FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (false))) -> begin
(true, Some (e1), Some (e2))
end
| (None, None, FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (false)), FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (true))) -> begin
(true, Some (e2), Some (e1))
end
| _71_516 -> begin
def
end)
end))
end))
end))

# 305 "FStar.Extraction.ML.ExtractExp.fst"
let rec check_exp : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g e f t -> (
# 310 "FStar.Extraction.ML.ExtractExp.fst"
let _71_526 = (let _156_221 = (check_exp' g e f t)
in (erase g _156_221 f t))
in (match (_71_526) with
| (e, _71_523, _71_525) -> begin
e
end)))
and check_exp' : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g e f t -> (
# 314 "FStar.Extraction.ML.ExtractExp.fst"
let _71_534 = (synth_exp g e)
in (match (_71_534) with
| (e0, f0, t0) -> begin
if (FStar_Extraction_ML_Util.eff_leq f0 f) then begin
(maybe_coerce g e0 t0 t)
end else begin
(err_unexpected_eff e f f0)
end
end)))
and synth_exp : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  (FStar_Extraction_ML_Syntax.mlexpr * FStar_Extraction_ML_Syntax.e_tag * FStar_Extraction_ML_Syntax.mlty) = (fun g e -> (
# 320 "FStar.Extraction.ML.ExtractExp.fst"
let _71_540 = (synth_exp' g e)
in (match (_71_540) with
| (e, f, t) -> begin
(erase g e f t)
end)))
and synth_exp' : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  (FStar_Extraction_ML_Syntax.mlexpr * FStar_Extraction_ML_Syntax.e_tag * FStar_Extraction_ML_Syntax.mlty) = (fun g e -> (
# 327 "FStar.Extraction.ML.ExtractExp.fst"
let _71_544 = (FStar_Extraction_ML_Env.debug g (fun u -> (let _156_233 = (let _156_232 = (FStar_Absyn_Print.tag_of_exp e)
in (let _156_231 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.format2 "now synthesizing expression (%s) :  %s \n" _156_232 _156_231)))
in (FStar_Util.print_string _156_233))))
in (match ((let _156_234 = (FStar_Absyn_Util.compress_exp e)
in _156_234.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_constant (c) -> begin
(
# 331 "FStar.Extraction.ML.ExtractExp.fst"
let t = (FStar_Tc_Recheck.typing_const e.FStar_Absyn_Syntax.pos c)
in (
# 332 "FStar.Extraction.ML.ExtractExp.fst"
let ml_ty = (translate_typ g t)
in (let _156_238 = (let _156_237 = (let _156_236 = (FStar_Extraction_ML_Util.mlconst_of_const' e.FStar_Absyn_Syntax.pos c)
in (FStar_All.pipe_left (fun _156_235 -> FStar_Extraction_ML_Syntax.MLE_Const (_156_235)) _156_236))
in (FStar_Extraction_ML_Syntax.with_ty ml_ty _156_237))
in (_156_238, FStar_Extraction_ML_Syntax.E_PURE, ml_ty))))
end
| FStar_Absyn_Syntax.Exp_ascribed (e0, t, f) -> begin
(
# 336 "FStar.Extraction.ML.ExtractExp.fst"
let t = (translate_typ g t)
in (
# 337 "FStar.Extraction.ML.ExtractExp.fst"
let f = (match (f) with
| None -> begin
(FStar_All.failwith "Ascription node with an empty effect label")
end
| Some (l) -> begin
(FStar_Extraction_ML_ExtractTyp.translate_eff g l)
end)
in (
# 340 "FStar.Extraction.ML.ExtractExp.fst"
let e = (check_exp g e0 f t)
in (e, f, t))))
end
| (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) -> begin
(
# 345 "FStar.Extraction.ML.ExtractExp.fst"
let _71_573 = (FStar_Extraction_ML_Env.lookup_var g e)
in (match (_71_573) with
| ((x, mltys, _71_570), qual) -> begin
(match (mltys) with
| ([], t) -> begin
(let _156_239 = (maybe_lalloc_eta_data g qual t x)
in (_156_239, FStar_Extraction_ML_Syntax.E_PURE, t))
end
| _71_578 -> begin
(err_uninst g e mltys)
end)
end))
end
| FStar_Absyn_Syntax.Exp_app (head, args) -> begin
(
# 353 "FStar.Extraction.ML.ExtractExp.fst"
let rec synth_app = (fun is_data _71_587 _71_590 restArgs -> (match ((_71_587, _71_590)) with
| ((mlhead, mlargs_f), (f, t)) -> begin
(match ((restArgs, t)) with
| ([], _71_594) -> begin
(
# 361 "FStar.Extraction.ML.ExtractExp.fst"
let _71_605 = if ((FStar_Absyn_Util.is_primop head) || (FStar_Extraction_ML_Util.codegen_fsharp ())) then begin
(let _156_248 = (FStar_All.pipe_right (FStar_List.rev mlargs_f) (FStar_List.map Prims.fst))
in ([], _156_248))
end else begin
(FStar_List.fold_left (fun _71_598 _71_601 -> (match ((_71_598, _71_601)) with
| ((lbs, out_args), (arg, f)) -> begin
if ((f = FStar_Extraction_ML_Syntax.E_PURE) || (f = FStar_Extraction_ML_Syntax.E_GHOST)) then begin
(lbs, (arg)::out_args)
end else begin
(
# 367 "FStar.Extraction.ML.ExtractExp.fst"
let x = (let _156_251 = (FStar_Absyn_Util.gensym ())
in (_156_251, (- (1))))
in (let _156_253 = (let _156_252 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty arg.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Var (x)))
in (_156_252)::out_args)
in (((x, arg))::lbs, _156_253)))
end
end)) ([], []) mlargs_f)
end
in (match (_71_605) with
| (lbs, mlargs) -> begin
(
# 370 "FStar.Extraction.ML.ExtractExp.fst"
let app = (let _156_254 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t) (FStar_Extraction_ML_Syntax.MLE_App ((mlhead, mlargs))))
in (FStar_All.pipe_left (maybe_lalloc_eta_data g is_data t) _156_254))
in (
# 371 "FStar.Extraction.ML.ExtractExp.fst"
let l_app = (FStar_List.fold_right (fun _71_609 out -> (match (_71_609) with
| (x, arg) -> begin
(FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty out.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Let (((false, ({FStar_Extraction_ML_Syntax.mllb_name = x; FStar_Extraction_ML_Syntax.mllb_tysc = Some (([], arg.FStar_Extraction_ML_Syntax.mlty)); FStar_Extraction_ML_Syntax.mllb_add_unit = false; FStar_Extraction_ML_Syntax.mllb_def = arg; FStar_Extraction_ML_Syntax.print_typ = true})::[]), out))))
end)) lbs app)
in (l_app, f, t)))
end))
end
| ((FStar_Util.Inl (_71_614), _71_617)::rest, FStar_Extraction_ML_Syntax.MLTY_Fun (tunit, f', t)) -> begin
if (type_leq g tunit FStar_Extraction_ML_Syntax.ml_unit_ty) then begin
(let _156_258 = (let _156_257 = (FStar_Extraction_ML_Util.join f f')
in (_156_257, t))
in (synth_app is_data (mlhead, ((FStar_Extraction_ML_Syntax.ml_unit, FStar_Extraction_ML_Syntax.E_PURE))::mlargs_f) _156_258 rest))
end else begin
(FStar_All.failwith "Impossible: ill-typed application")
end
end
| ((FStar_Util.Inr (e0), _71_630)::rest, FStar_Extraction_ML_Syntax.MLTY_Fun (tExpected, f', t)) -> begin
(
# 385 "FStar.Extraction.ML.ExtractExp.fst"
let _71_642 = (synth_exp g e0)
in (match (_71_642) with
| (e0, f0, tInferred) -> begin
(
# 386 "FStar.Extraction.ML.ExtractExp.fst"
let e0 = (maybe_coerce g e0 tInferred tExpected)
in (let _156_260 = (let _156_259 = (FStar_Extraction_ML_Util.join_l ((f)::(f')::(f0)::[]))
in (_156_259, t))
in (synth_app is_data (mlhead, ((e0, f0))::mlargs_f) _156_260 rest)))
end))
end
| _71_645 -> begin
(match ((FStar_Extraction_ML_Util.delta_unfold g t)) with
| Some (t) -> begin
(synth_app is_data (mlhead, mlargs_f) (f, t) restArgs)
end
| None -> begin
(err_ill_typed_application e restArgs t)
end)
end)
end))
in (
# 395 "FStar.Extraction.ML.ExtractExp.fst"
let synth_app_maybe_projector = (fun is_data mlhead _71_654 args -> (match (_71_654) with
| (f, t) -> begin
(match (is_data) with
| Some (FStar_Absyn_Syntax.Record_projector (_71_657)) -> begin
(
# 398 "FStar.Extraction.ML.ExtractExp.fst"
let rec remove_implicits = (fun args f t -> (match ((args, t)) with
| ((FStar_Util.Inr (_71_666), Some (FStar_Absyn_Syntax.Implicit (_71_669)))::args, FStar_Extraction_ML_Syntax.MLTY_Fun (_71_675, f', t)) -> begin
(let _156_275 = (FStar_Extraction_ML_Util.join f f')
in (remove_implicits args _156_275 t))
end
| _71_682 -> begin
(args, f, t)
end))
in (
# 403 "FStar.Extraction.ML.ExtractExp.fst"
let _71_686 = (remove_implicits args f t)
in (match (_71_686) with
| (args, f, t) -> begin
(synth_app is_data (mlhead, []) (f, t) args)
end)))
end
| _71_688 -> begin
(synth_app is_data (mlhead, []) (f, t) args)
end)
end))
in (
# 408 "FStar.Extraction.ML.ExtractExp.fst"
let head = (FStar_Absyn_Util.compress_exp head)
in (match (head.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) -> begin
(
# 413 "FStar.Extraction.ML.ExtractExp.fst"
let _71_703 = (FStar_Extraction_ML_Env.lookup_var g head)
in (match (_71_703) with
| ((head_ml, (vars, t), inst_ok), qual) -> begin
(
# 414 "FStar.Extraction.ML.ExtractExp.fst"
let has_typ_apps = (match (args) with
| (FStar_Util.Inl (_71_707), _71_710)::_71_705 -> begin
true
end
| _71_714 -> begin
false
end)
in (
# 418 "FStar.Extraction.ML.ExtractExp.fst"
let _71_756 = (match (vars) with
| _71_719::_71_717 when ((not (has_typ_apps)) && inst_ok) -> begin
(head_ml, t, args)
end
| _71_722 -> begin
(
# 425 "FStar.Extraction.ML.ExtractExp.fst"
let n = (FStar_List.length vars)
in if (n <= (FStar_List.length args)) then begin
(
# 427 "FStar.Extraction.ML.ExtractExp.fst"
let _71_726 = (FStar_Util.first_N n args)
in (match (_71_726) with
| (prefix, rest) -> begin
(
# 429 "FStar.Extraction.ML.ExtractExp.fst"
let prefixAsMLTypes = (FStar_List.map (translate_typ_of_arg g) prefix)
in (
# 431 "FStar.Extraction.ML.ExtractExp.fst"
let t = (instantiate (vars, t) prefixAsMLTypes)
in (
# 432 "FStar.Extraction.ML.ExtractExp.fst"
let head = (match (head_ml.FStar_Extraction_ML_Syntax.expr) with
| (FStar_Extraction_ML_Syntax.MLE_Name (_)) | (FStar_Extraction_ML_Syntax.MLE_Var (_)) -> begin
(
# 434 "FStar.Extraction.ML.ExtractExp.fst"
let _71_735 = head_ml
in {FStar_Extraction_ML_Syntax.expr = _71_735.FStar_Extraction_ML_Syntax.expr; FStar_Extraction_ML_Syntax.mlty = t; FStar_Extraction_ML_Syntax.loc = _71_735.FStar_Extraction_ML_Syntax.loc})
end
| FStar_Extraction_ML_Syntax.MLE_App (head, {FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Unit); FStar_Extraction_ML_Syntax.mlty = _71_741; FStar_Extraction_ML_Syntax.loc = _71_739}::[]) -> begin
(FStar_All.pipe_right (FStar_Extraction_ML_Syntax.MLE_App (((
# 435 "FStar.Extraction.ML.ExtractExp.fst"
let _71_748 = head
in {FStar_Extraction_ML_Syntax.expr = _71_748.FStar_Extraction_ML_Syntax.expr; FStar_Extraction_ML_Syntax.mlty = FStar_Extraction_ML_Syntax.MLTY_Fun ((FStar_Extraction_ML_Syntax.ml_unit_ty, FStar_Extraction_ML_Syntax.E_PURE, t)); FStar_Extraction_ML_Syntax.loc = _71_748.FStar_Extraction_ML_Syntax.loc}), (FStar_Extraction_ML_Syntax.ml_unit)::[]))) (FStar_Extraction_ML_Syntax.with_ty t))
end
| _71_751 -> begin
(FStar_All.failwith "Impossible")
end)
in (head, t, rest))))
end))
end else begin
(err_uninst g head (vars, t))
end)
end)
in (match (_71_756) with
| (head_ml, head_t, args) -> begin
(match (args) with
| [] -> begin
(let _156_276 = (maybe_lalloc_eta_data g qual head_t head_ml)
in (_156_276, FStar_Extraction_ML_Syntax.E_PURE, head_t))
end
| _71_759 -> begin
(synth_app_maybe_projector qual head_ml (FStar_Extraction_ML_Syntax.E_PURE, head_t) args)
end)
end)))
end))
end
| _71_761 -> begin
(
# 446 "FStar.Extraction.ML.ExtractExp.fst"
let _71_765 = (synth_exp g head)
in (match (_71_765) with
| (head, f, t) -> begin
(synth_app_maybe_projector None head (f, t) args)
end))
end))))
end
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
(
# 451 "FStar.Extraction.ML.ExtractExp.fst"
let _71_788 = (FStar_List.fold_left (fun _71_772 _71_776 -> (match ((_71_772, _71_776)) with
| ((ml_bs, env), (b, _71_775)) -> begin
(match (b) with
| FStar_Util.Inl (a) -> begin
(
# 453 "FStar.Extraction.ML.ExtractExp.fst"
let env = (FStar_Extraction_ML_Env.extend_ty env a (Some (FStar_Extraction_ML_Syntax.MLTY_Top)))
in (
# 454 "FStar.Extraction.ML.ExtractExp.fst"
let ml_b = (let _156_279 = (FStar_Extraction_ML_Env.btvar_as_mlTermVar a)
in (_156_279, FStar_Extraction_ML_Syntax.ml_unit_ty))
in ((ml_b)::ml_bs, env)))
end
| FStar_Util.Inr (x) -> begin
(
# 458 "FStar.Extraction.ML.ExtractExp.fst"
let t = (translate_typ env x.FStar_Absyn_Syntax.sort)
in (
# 459 "FStar.Extraction.ML.ExtractExp.fst"
let env = (FStar_Extraction_ML_Env.extend_bv env x ([], t) false false false)
in (
# 460 "FStar.Extraction.ML.ExtractExp.fst"
let ml_b = ((FStar_Extraction_ML_Syntax.as_mlident x.FStar_Absyn_Syntax.v), t)
in ((ml_b)::ml_bs, env))))
end)
end)) ([], g) bs)
in (match (_71_788) with
| (ml_bs, env) -> begin
(
# 462 "FStar.Extraction.ML.ExtractExp.fst"
let ml_bs = (FStar_List.rev ml_bs)
in (
# 463 "FStar.Extraction.ML.ExtractExp.fst"
let _71_793 = (synth_exp env body)
in (match (_71_793) with
| (ml_body, f, t) -> begin
(
# 465 "FStar.Extraction.ML.ExtractExp.fst"
let _71_803 = (FStar_List.fold_right (fun _71_797 _71_800 -> (match ((_71_797, _71_800)) with
| ((_71_795, targ), (f, t)) -> begin
(FStar_Extraction_ML_Syntax.E_PURE, FStar_Extraction_ML_Syntax.MLTY_Fun ((targ, f, t)))
end)) ml_bs (f, t))
in (match (_71_803) with
| (f, tfun) -> begin
(let _156_282 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty tfun) (FStar_Extraction_ML_Syntax.MLE_Fun ((ml_bs, ml_body))))
in (_156_282, f, tfun))
end))
end)))
end))
end
| FStar_Absyn_Syntax.Exp_let ((is_rec, lbs), e') -> begin
(
# 473 "FStar.Extraction.ML.ExtractExp.fst"
let maybe_generalize = (fun _71_815 -> (match (_71_815) with
| {FStar_Absyn_Syntax.lbname = lbname; FStar_Absyn_Syntax.lbtyp = t; FStar_Absyn_Syntax.lbeff = lbeff; FStar_Absyn_Syntax.lbdef = e} -> begin
(
# 474 "FStar.Extraction.ML.ExtractExp.fst"
let f_e = (FStar_Extraction_ML_ExtractTyp.translate_eff g lbeff)
in (
# 475 "FStar.Extraction.ML.ExtractExp.fst"
let t = (FStar_Absyn_Util.compress_typ t)
in (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (bs, c) when (FStar_Extraction_ML_Util.is_type_abstraction bs) -> begin
(
# 482 "FStar.Extraction.ML.ExtractExp.fst"
let _71_839 = (match ((FStar_Util.prefix_until (fun _71_4 -> (match (_71_4) with
| (FStar_Util.Inr (_71_824), _71_827) -> begin
true
end
| _71_830 -> begin
false
end)) bs)) with
| None -> begin
(bs, (FStar_Absyn_Util.comp_result c))
end
| Some (bs, b, rest) -> begin
(let _156_286 = (FStar_Absyn_Syntax.mk_Typ_fun ((b)::rest, c) None c.FStar_Absyn_Syntax.pos)
in (bs, _156_286))
end)
in (match (_71_839) with
| (tbinders, tbody) -> begin
(
# 487 "FStar.Extraction.ML.ExtractExp.fst"
let n = (FStar_List.length tbinders)
in (
# 488 "FStar.Extraction.ML.ExtractExp.fst"
let e = (normalize_abs e)
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
if (n <= (FStar_List.length bs)) then begin
(
# 492 "FStar.Extraction.ML.ExtractExp.fst"
let _71_848 = (FStar_Util.first_N n bs)
in (match (_71_848) with
| (targs, rest_args) -> begin
(
# 496 "FStar.Extraction.ML.ExtractExp.fst"
let expected_t = (match ((FStar_Absyn_Util.mk_subst_binder targs tbinders)) with
| None -> begin
(FStar_All.failwith "Not enough type binders in the body of the let expression")
end
| Some (s) -> begin
(FStar_Absyn_Util.subst_typ s tbody)
end)
in (
# 500 "FStar.Extraction.ML.ExtractExp.fst"
let targs = (FStar_All.pipe_right targs (FStar_List.map (fun _71_5 -> (match (_71_5) with
| (FStar_Util.Inl (a), _71_857) -> begin
a
end
| _71_860 -> begin
(FStar_All.failwith "Impossible")
end))))
in (
# 501 "FStar.Extraction.ML.ExtractExp.fst"
let env = (FStar_List.fold_left (fun env a -> (FStar_Extraction_ML_Env.extend_ty env a None)) g targs)
in (
# 502 "FStar.Extraction.ML.ExtractExp.fst"
let expected_t = (translate_typ env expected_t)
in (
# 503 "FStar.Extraction.ML.ExtractExp.fst"
let polytype = (let _156_290 = (FStar_All.pipe_right targs (FStar_List.map FStar_Extraction_ML_Env.btvar_as_mltyvar))
in (_156_290, expected_t))
in (
# 504 "FStar.Extraction.ML.ExtractExp.fst"
let add_unit = (match (rest_args) with
| [] -> begin
(not ((is_value_or_type_app body)))
end
| _71_869 -> begin
false
end)
in (
# 507 "FStar.Extraction.ML.ExtractExp.fst"
let rest_args = if add_unit then begin
(FStar_Extraction_ML_Util.unit_binder)::rest_args
end else begin
rest_args
end
in (
# 508 "FStar.Extraction.ML.ExtractExp.fst"
let body = (match (rest_args) with
| [] -> begin
body
end
| _71_874 -> begin
(FStar_Absyn_Syntax.mk_Exp_abs (rest_args, body) None e.FStar_Absyn_Syntax.pos)
end)
in (lbname, f_e, (t, (targs, polytype)), add_unit, body)))))))))
end))
end else begin
(FStar_All.failwith "Not enough type binders")
end
end
| _71_877 -> begin
(err_value_restriction e)
end)))
end))
end
| _71_879 -> begin
(
# 537 "FStar.Extraction.ML.ExtractExp.fst"
let expected_t = (translate_typ g t)
in (lbname, f_e, (t, ([], ([], expected_t))), false, e))
end)))
end))
in (
# 540 "FStar.Extraction.ML.ExtractExp.fst"
let check_lb = (fun env _71_894 -> (match (_71_894) with
| (nm, (lbname, f, (t, (targs, polytype)), add_unit, e)) -> begin
(
# 541 "FStar.Extraction.ML.ExtractExp.fst"
let env = (FStar_List.fold_left (fun env a -> (FStar_Extraction_ML_Env.extend_ty env a None)) env targs)
in (
# 542 "FStar.Extraction.ML.ExtractExp.fst"
let expected_t = if add_unit then begin
FStar_Extraction_ML_Syntax.MLTY_Fun ((FStar_Extraction_ML_Syntax.ml_unit_ty, FStar_Extraction_ML_Syntax.E_PURE, (Prims.snd polytype)))
end else begin
(Prims.snd polytype)
end
in (
# 543 "FStar.Extraction.ML.ExtractExp.fst"
let e = (check_exp env e f expected_t)
in (f, {FStar_Extraction_ML_Syntax.mllb_name = nm; FStar_Extraction_ML_Syntax.mllb_tysc = Some (polytype); FStar_Extraction_ML_Syntax.mllb_add_unit = add_unit; FStar_Extraction_ML_Syntax.mllb_def = e; FStar_Extraction_ML_Syntax.print_typ = true}))))
end))
in (
# 547 "FStar.Extraction.ML.ExtractExp.fst"
let lbs = (FStar_All.pipe_right lbs (FStar_List.map maybe_generalize))
in (
# 549 "FStar.Extraction.ML.ExtractExp.fst"
let _71_923 = (FStar_List.fold_right (fun lb _71_904 -> (match (_71_904) with
| (env, lbs) -> begin
(
# 550 "FStar.Extraction.ML.ExtractExp.fst"
let _71_917 = lb
in (match (_71_917) with
| (lbname, _71_907, (t, (_71_910, polytype)), add_unit, _71_916) -> begin
(
# 551 "FStar.Extraction.ML.ExtractExp.fst"
let _71_920 = (FStar_Extraction_ML_Env.extend_lb env lbname t polytype add_unit true)
in (match (_71_920) with
| (env, nm) -> begin
(env, ((nm, lb))::lbs)
end))
end))
end)) lbs (g, []))
in (match (_71_923) with
| (env_body, lbs) -> begin
(
# 554 "FStar.Extraction.ML.ExtractExp.fst"
let env_def = if is_rec then begin
env_body
end else begin
g
end
in (
# 556 "FStar.Extraction.ML.ExtractExp.fst"
let lbs = (FStar_All.pipe_right lbs (FStar_List.map (check_lb env_def)))
in (
# 558 "FStar.Extraction.ML.ExtractExp.fst"
let _71_929 = (synth_exp env_body e')
in (match (_71_929) with
| (e', f', t') -> begin
(
# 560 "FStar.Extraction.ML.ExtractExp.fst"
let f = (let _156_300 = (let _156_299 = (FStar_List.map Prims.fst lbs)
in (f')::_156_299)
in (FStar_Extraction_ML_Util.join_l _156_300))
in (let _156_306 = (let _156_305 = (let _156_303 = (let _156_302 = (let _156_301 = (FStar_List.map Prims.snd lbs)
in (is_rec, _156_301))
in (_156_302, e'))
in FStar_Extraction_ML_Syntax.MLE_Let (_156_303))
in (let _156_304 = (FStar_Extraction_ML_Util.mlloc_of_range e.FStar_Absyn_Syntax.pos)
in (FStar_Extraction_ML_Syntax.with_ty_loc t' _156_305 _156_304)))
in (_156_306, f, t')))
end))))
end)))))
end
| FStar_Absyn_Syntax.Exp_match (scrutinee, pats) -> begin
(
# 565 "FStar.Extraction.ML.ExtractExp.fst"
let _71_938 = (synth_exp g scrutinee)
in (match (_71_938) with
| (e, f_e, t_e) -> begin
(
# 566 "FStar.Extraction.ML.ExtractExp.fst"
let _71_942 = (check_pats_for_ite pats)
in (match (_71_942) with
| (b, then_e, else_e) -> begin
(
# 567 "FStar.Extraction.ML.ExtractExp.fst"
let no_lift = (fun x t -> x)
in if b then begin
(match ((then_e, else_e)) with
| (Some (then_e), Some (else_e)) -> begin
(
# 571 "FStar.Extraction.ML.ExtractExp.fst"
let _71_954 = (synth_exp g then_e)
in (match (_71_954) with
| (then_mle, f_then, t_then) -> begin
(
# 572 "FStar.Extraction.ML.ExtractExp.fst"
let _71_958 = (synth_exp g else_e)
in (match (_71_958) with
| (else_mle, f_else, t_else) -> begin
(
# 573 "FStar.Extraction.ML.ExtractExp.fst"
let _71_961 = if (type_leq g t_then t_else) then begin
(t_else, no_lift)
end else begin
if (type_leq g t_else t_then) then begin
(t_then, no_lift)
end else begin
(FStar_Extraction_ML_Syntax.MLTY_Top, FStar_Extraction_ML_Syntax.apply_obj_repr)
end
end
in (match (_71_961) with
| (t_branch, maybe_lift) -> begin
(let _156_337 = (let _156_335 = (let _156_334 = (let _156_333 = (maybe_lift then_mle t_then)
in (let _156_332 = (let _156_331 = (maybe_lift else_mle t_else)
in Some (_156_331))
in (e, _156_333, _156_332)))
in FStar_Extraction_ML_Syntax.MLE_If (_156_334))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t_branch) _156_335))
in (let _156_336 = (FStar_Extraction_ML_Util.join f_then f_else)
in (_156_337, _156_336, t_branch)))
end))
end))
end))
end
| _71_963 -> begin
(FStar_All.failwith "ITE pats matched but then and else expressions not found?")
end)
end else begin
(
# 584 "FStar.Extraction.ML.ExtractExp.fst"
let mlbranches = (FStar_All.pipe_right pats (FStar_List.collect (fun _71_967 -> (match (_71_967) with
| (pat, when_opt, branch) -> begin
(
# 585 "FStar.Extraction.ML.ExtractExp.fst"
let _71_970 = (extract_pat g pat)
in (match (_71_970) with
| (env, p) -> begin
(
# 586 "FStar.Extraction.ML.ExtractExp.fst"
let _71_981 = (match (when_opt) with
| None -> begin
(None, FStar_Extraction_ML_Syntax.E_PURE)
end
| Some (w) -> begin
(
# 589 "FStar.Extraction.ML.ExtractExp.fst"
let _71_977 = (synth_exp env w)
in (match (_71_977) with
| (w, f_w, t_w) -> begin
(
# 590 "FStar.Extraction.ML.ExtractExp.fst"
let w = (maybe_coerce env w t_w FStar_Extraction_ML_Syntax.ml_bool_ty)
in (Some (w), f_w))
end))
end)
in (match (_71_981) with
| (when_opt, f_when) -> begin
(
# 592 "FStar.Extraction.ML.ExtractExp.fst"
let _71_985 = (synth_exp env branch)
in (match (_71_985) with
| (mlbranch, f_branch, t_branch) -> begin
(FStar_All.pipe_right p (FStar_List.map (fun _71_988 -> (match (_71_988) with
| (p, wopt) -> begin
(
# 595 "FStar.Extraction.ML.ExtractExp.fst"
let when_clause = (FStar_Extraction_ML_Util.conjoin_opt wopt when_opt)
in (p, (when_clause, f_when), (mlbranch, f_branch, t_branch)))
end))))
end))
end))
end))
end))))
in (match (mlbranches) with
| [] -> begin
(
# 600 "FStar.Extraction.ML.ExtractExp.fst"
let _71_997 = (FStar_Extraction_ML_Env.lookup_fv g (FStar_Absyn_Util.fv FStar_Absyn_Const.failwith_lid))
in (match (_71_997) with
| (fw, _71_994, _71_996) -> begin
(let _156_344 = (let _156_343 = (let _156_342 = (let _156_341 = (let _156_340 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_string_ty) (FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_String ("unreachable"))))
in (_156_340)::[])
in (fw, _156_341))
in FStar_Extraction_ML_Syntax.MLE_App (_156_342))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_unit_ty) _156_343))
in (_156_344, FStar_Extraction_ML_Syntax.E_PURE, FStar_Extraction_ML_Syntax.ml_unit_ty))
end))
end
| (_71_1000, _71_1002, (_71_1004, f_first, t_first))::rest -> begin
(
# 607 "FStar.Extraction.ML.ExtractExp.fst"
let _71_1030 = (FStar_List.fold_left (fun _71_1012 _71_1022 -> (match ((_71_1012, _71_1022)) with
| ((topt, f), (_71_1014, _71_1016, (_71_1018, f_branch, t_branch))) -> begin
(
# 611 "FStar.Extraction.ML.ExtractExp.fst"
let f = (FStar_Extraction_ML_Util.join f f_branch)
in (
# 612 "FStar.Extraction.ML.ExtractExp.fst"
let topt = (match (topt) with
| None -> begin
None
end
| Some (t) -> begin
if (type_leq g t t_branch) then begin
Some (t_branch)
end else begin
if (type_leq g t_branch t) then begin
Some (t)
end else begin
None
end
end
end)
in (topt, f)))
end)) (Some (t_first), f_first) rest)
in (match (_71_1030) with
| (topt, f_match) -> begin
(
# 625 "FStar.Extraction.ML.ExtractExp.fst"
let mlbranches = (FStar_All.pipe_right mlbranches (FStar_List.map (fun _71_1041 -> (match (_71_1041) with
| (p, (wopt, _71_1034), (b, _71_1038, t)) -> begin
(
# 626 "FStar.Extraction.ML.ExtractExp.fst"
let b = (match (topt) with
| None -> begin
(FStar_Extraction_ML_Syntax.apply_obj_repr b t)
end
| Some (_71_1044) -> begin
b
end)
in (p, wopt, b))
end))))
in (
# 632 "FStar.Extraction.ML.ExtractExp.fst"
let t_match = (match (topt) with
| None -> begin
FStar_Extraction_ML_Syntax.MLTY_Top
end
| Some (t) -> begin
t
end)
in (let _156_348 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t_match) (FStar_Extraction_ML_Syntax.MLE_Match ((e, mlbranches))))
in (_156_348, f_match, t_match))))
end))
end))
end)
end))
end))
end
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _71_1054)) -> begin
(synth_exp g e)
end
| (FStar_Absyn_Syntax.Exp_uvar (_)) | (FStar_Absyn_Syntax.Exp_delayed (_)) -> begin
(fail e.FStar_Absyn_Syntax.pos "Unexpected expression")
end)))

# 643 "FStar.Extraction.ML.ExtractExp.fst"
let fresh : Prims.string  ->  (Prims.string * Prims.int) = (
# 646 "FStar.Extraction.ML.ExtractExp.fst"
let c = (FStar_Util.mk_ref 0)
in (fun x -> (
# 647 "FStar.Extraction.ML.ExtractExp.fst"
let _71_1066 = (FStar_Util.incr c)
in (let _156_351 = (FStar_ST.read c)
in (x, _156_351)))))

# 647 "FStar.Extraction.ML.ExtractExp.fst"
let ind_discriminator_body : FStar_Extraction_ML_Env.env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  FStar_Extraction_ML_Syntax.mlmodule1 = (fun env discName constrName -> (
# 651 "FStar.Extraction.ML.ExtractExp.fst"
let fstar_disc_type = (FStar_Tc_Env.lookup_lid env.FStar_Extraction_ML_Env.tcenv discName)
in (
# 652 "FStar.Extraction.ML.ExtractExp.fst"
let wildcards = (match (fstar_disc_type.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (binders, _71_1074) -> begin
(let _156_361 = (FStar_All.pipe_right binders (FStar_List.filter (fun _71_6 -> (match (_71_6) with
| (_71_1079, Some (FStar_Absyn_Syntax.Implicit (_71_1081))) -> begin
true
end
| _71_1086 -> begin
false
end))))
in (FStar_All.pipe_right _156_361 (FStar_List.map (fun _71_1087 -> (let _156_360 = (fresh "_")
in (_156_360, FStar_Extraction_ML_Syntax.MLTY_Top))))))
end
| _71_1090 -> begin
(FStar_All.failwith "Discriminator must be a function")
end)
in (
# 663 "FStar.Extraction.ML.ExtractExp.fst"
let mlid = (fresh "_discr_")
in (
# 664 "FStar.Extraction.ML.ExtractExp.fst"
let targ = FStar_Extraction_ML_Syntax.MLTY_Top
in (
# 667 "FStar.Extraction.ML.ExtractExp.fst"
let disc_ty = FStar_Extraction_ML_Syntax.MLTY_Top
in (
# 668 "FStar.Extraction.ML.ExtractExp.fst"
let discrBody = (let _156_376 = (let _156_375 = (let _156_374 = (let _156_373 = (let _156_372 = (let _156_371 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty targ) (FStar_Extraction_ML_Syntax.MLE_Name (([], (FStar_Extraction_ML_Syntax.idsym mlid)))))
in (let _156_370 = (let _156_369 = (let _156_365 = (let _156_363 = (let _156_362 = (FStar_Extraction_ML_Syntax.mlpath_of_lident constrName)
in (_156_362, (FStar_Extraction_ML_Syntax.MLP_Wild)::[]))
in FStar_Extraction_ML_Syntax.MLP_CTor (_156_363))
in (let _156_364 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) (FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Bool (true))))
in (_156_365, None, _156_364)))
in (let _156_368 = (let _156_367 = (let _156_366 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) (FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Bool (false))))
in (FStar_Extraction_ML_Syntax.MLP_Wild, None, _156_366))
in (_156_367)::[])
in (_156_369)::_156_368))
in (_156_371, _156_370)))
in FStar_Extraction_ML_Syntax.MLE_Match (_156_372))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) _156_373))
in ((FStar_List.append wildcards (((mlid, targ))::[])), _156_374))
in FStar_Extraction_ML_Syntax.MLE_Fun (_156_375))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty disc_ty) _156_376))
in FStar_Extraction_ML_Syntax.MLM_Let ((false, ({FStar_Extraction_ML_Syntax.mllb_name = (FStar_Extraction_ML_Env.convIdent discName.FStar_Ident.ident); FStar_Extraction_ML_Syntax.mllb_tysc = None; FStar_Extraction_ML_Syntax.mllb_add_unit = false; FStar_Extraction_ML_Syntax.mllb_def = discrBody; FStar_Extraction_ML_Syntax.print_typ = true})::[])))))))))




