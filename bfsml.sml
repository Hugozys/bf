signature BfInter =
sig
    val start: string->unit
end
structure MyBfInter :> BfInter =
struct

fun interpret (instr) =
    let
	val datarr = Array.array(65536,chr 0)
	val dtp = ref 0
	val EOF = size instr
	val nested = ref 0
	val loop_pos = ref ([]: int list)
    in
	let
	    fun parse (cmd) = if cmd = EOF then () else
			      let
				  fun skip(ins) = (if ins = EOF then EOF else if (String.sub (instr, ins)) = #"[" then (nested := (!nested) + 1; skip(ins+1)) else if (String.sub (instr, ins)) = #"]" then (nested := (!nested) - 1; if (!nested) = 0 then ins+1 else skip(ins+1)) else skip(ins+1))					   
				  fun execute (#">") = (dtp := (!dtp) + 1; cmd+1)
				    | execute (#"<") = (dtp := (!dtp) - 1; cmd+1)
				    | execute (#"+") = ((Array.update(datarr, (!dtp), (Char.chr(Char.ord(Array.sub (datarr, (!dtp))) + 1))); cmd+1) handle Chr => (Array.update(datarr, (!dtp), Char.chr 0); cmd+1))
				    | execute (#"-") = ((Array.update(datarr, (!dtp), (Char.chr(Char.ord(Array.sub (datarr, (!dtp))) - 1))); cmd+1) handle Chr => (Array.update(datarr, (!dtp), Char.chr 255); cmd+1))
				    | execute (#".") = (TextIO.output1(TextIO.stdOut,Array.sub(datarr, (!dtp))); TextIO.flushOut(TextIO.stdOut); cmd+1)
				    | execute (#",") = (Array.update(datarr, (!dtp), Option.valOf(TextIO.input1(TextIO.stdIn))); cmd+1)
				    | execute (#"[") = if (Array.sub(datarr, (!dtp)) = Char.chr 0) then (nested := (!nested) + 1; skip(cmd+1)) else (loop_pos := (cmd+1)::(!loop_pos);cmd+1)
				    | execute (#"]") = if (Array.sub(datarr,(!dtp)) = Char.chr 0) then (if List.null (!loop_pos) then EOF else (loop_pos := List.drop(!loop_pos,1); cmd+1)) else if List.null (!loop_pos) then EOF else let in hd(!loop_pos) end  
				    | execute (other) = (cmd+1)			       
			      in
				  parse(execute(String.sub (instr, cmd)))
			      end
	in
	    parse(0)
	end
    end
	
fun start (filename) =
    let
	val instm = TextIO.openIn(filename)
    in
	interpret(TextIO.inputAll(instm));
	TextIO.closeIn(instm)
    end
    
end

fun main() =
    let
	val args = CommandLine.arguments()
    in
	if (List.length args) <> 1 then print("Usage: ./bfsml <filename>\n") else MyBfInter.start(List.hd(args))
    end

val _ = main()
		       
