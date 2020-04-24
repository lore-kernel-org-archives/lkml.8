Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D5C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182DF20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgDXJhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgDXJhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:37:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EED6BAECE;
        Fri, 24 Apr 2020 09:37:01 +0000 (UTC)
Date:   Fri, 24 Apr 2020 11:37:01 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 4/8] objtool: Add support for intra-function calls
In-Reply-To: <20200423152243.GV20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2004241102500.6175@pobox.suse.cz>
References: <20200423125013.452964352@infradead.org> <20200423125042.794350465@infradead.org> <alpine.LSU.2.21.2004231619070.6520@pobox.suse.cz> <20200423152243.GV20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Peter Zijlstra wrote:

> On Thu, Apr 23, 2020 at 04:34:21PM +0200, Miroslav Benes wrote:
> > >  /*
> > >   * Find the destination instructions for all calls.
> > >   */
> > > @@ -715,10 +725,7 @@ static int add_call_destinations(struct
> > >  				continue;
> > >  
> > >  			if (!insn->call_dest) {
> > > -				WARN_FUNC("unsupported intra-function call",
> > > -					  insn->sec, insn->offset);
> > > -				if (retpoline)
> > > -					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
> > > +				WARN_FUNC("intra-function call", insn->sec, insn->offset);
> > 
> > "unsupported intra-function call"?
> 
> Well, I think the thinking was that intra-function calls are actually
> supported, 'unannotated' perhaps ?

Ok, that would work too. Just keep it consistent with a new description in 
tools/objtool/Documentation/stack-validation.txt added by the patch.
 
> > >  				return -1;
> > >  			}
> > >  
> > > @@ -741,6 +748,12 @@ static int add_call_destinations(struct
> > >  			}
> > >  		} else
> > >  			insn->call_dest = rela->sym;
> > > +
> > > +		/*
> > > +		 * Whatever stack impact regular CALLs have, should be
> > > +		 * undone by the RETURN of the called function.
> > 
> >  * Annotated intra-function CALLs are treated as JMPs with a stack_op.
> >  * See read_intra_function_calls().
> > 
> > would make it a bit clearer.
> 
> That doesn't work for me; we want to explain why it is OK to delete
> stack_ops for regular CALLs. The reason this is OK, is because they're
> matched by RETURN.

Yes. I meant to add the paragraph, not to replace it. Sorry about the 
confusion. The point is to explain what "regular" also means in this 
context.

> > > +                */
> > > +               remove_insn_ops(insn);
> > >         }
> > >  
> > >         return 0;
> > > @@ -1416,6 +1429,57 @@ static int read_instr_hints(struct objto
> > >         return 0;
> > >  }
> > > 
> > > +static int read_intra_function_calls(struct objtool_file *file)
> > > +{
> > > +       struct instruction *insn;
> > > +       struct section *sec;
> > > +       struct rela *rela;
> > > +
> > > +       sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
> > > +       if (!sec)
> > > +               return 0;
> > > +
> > > +       list_for_each_entry(rela, &sec->rela_list, list) {
> > > +               unsigned long dest_off;
> > > +
> > > +               if (rela->sym->type != STT_SECTION) {
> > > +                       WARN("unexpected relocation symbol type in %s",
> > > +                            sec->name);
> > > +                       return -1;
> > > +               }
> > > +
> > > +               insn = find_insn(file, rela->sym->sec, rela->addend);
> > > +               if (!insn) {
> > > +                       WARN("bad .discard.intra_function_call entry");
> > > +                       return -1;
> > > +               }
> > > +
> > > +               if (insn->type != INSN_CALL) {
> > > +                       WARN_FUNC("intra_function_call not a direct call",
> > > +                                 insn->sec, insn->offset);
> > > +                       return -1;
> > > +               }
> > > +
> > > +               /*
> > > +                * Treat intra-function CALLs as JMPs, but with a stack_op.
> > > +                * Also see how setup_call_dest() strips stack_ops from normal
> > > +                * CALLs.
> > 
> > /*
> >  * Treat annotated intra-function CALLs as JMPs, but with a stack_op.
> >  * Also see how add_call_destinations() strips stack_ops from normal
> >  * CALLs.
> >  */
> > 
> > ? (note added "annotated" and s/setup_call_dest/add_call_destinations/)
> 
> Unannotated intra-function calls are not allowed, so I don't see a
> reason to make that distinction, but sure.

Then it would be better to say something like

/*
 * Treat intra-function CALLs as JMPs, but with a stack_op.
 * See add_call_destinations() for reference which also strips 
 * stack_ops from normal CALLs.
 */

But in the end it is up to you for sure.

> > > +                */
> > > +               insn->type = INSN_JUMP_UNCONDITIONAL;
> > 
> > [...]
> > 
> > > @@ -2245,6 +2313,9 @@ static int validate_branch(struct objtoo
> > >  				return 0;
> > >  		}
> > >  
> > > +		if (handle_insn_ops(insn, &state))
> > > +			return 1;
> > > +
> > >  		switch (insn->type) {
> > >  
> > >  		case INSN_RETURN:
> > > @@ -2304,9 +2375,6 @@ static int validate_branch(struct objtoo
> > >  			break;
> > >  
> > >  		case INSN_EXCEPTION_RETURN:
> > > -			if (handle_insn_ops(insn, &state))
> > > -				return 1;
> > > -
> > >  			/*
> > >  			 * This handles x86's sync_core() case, where we use an
> > >  			 * IRET to self. All 'normal' IRET instructions are in
> > > @@ -2326,8 +2394,6 @@ static int validate_branch(struct objtoo
> > >  			return 0;
> > >  
> > >  		case INSN_STACK:
> > > -			if (handle_insn_ops(insn, &state))
> > > -				return 1;
> > >  			break;
> > 
> > So we could get rid of INSN_STACK now as Julien proposed, couldn't we? If 
> > I am not missing something. handle_insn_ops() is called unconditionally 
> > here for all insn types and you remove stack_ops when unneeded.
> 
> Yes, INSN_STACK can now go away in favour of NOPs with stack_ops.
> Separate patch though.
> 
> > We could also go ahead with Julien's proposal to remove 
> > INSN_EXCEPTION_RETURN hack and move it to tools/objtool/arch/x86/decode.c. 
> 
> I don't immediately see how; we don't have a symbol there.

You can call find_symbol_by_offset() to get it, no? All the information 
sohuld be available.

If by symbol you mean the symbol containing the iret.

Quoting Julien:
"And the other suggestion is my other email was that you don't even need to add
INSN_EXCEPTION_RETURN. You can keep IRET as INSN_CONTEXT_SWITCH by default and
x86 decoder lookups the symbol conaining an iret. If it's a function symbol, it
can just set the type to INSN_OTHER so that it caries on to the next
instruction after having handled the stack_op."

So something like (it is incomplete, does not compile and it may be 
completely wrong, so sorry for wasting time in that case):

---

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 6340ea0dd527..be6520155cfd 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -100,6 +100,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
 	struct stack_op *op = NULL;
+	struct symbol *sym;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -496,22 +497,24 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		*type = INSN_RETURN;
 		break;
 
-	case 0xcf: /* iret */
-		*type = INSN_EXCEPTION_RETURN;
-
-		ADD_OP(op) {
-			/* add $40, %rsp */
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_SP;
-			op->src.offset = 5*8;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
-		}
-		break;
-
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
+	case 0xcf: /* iret */
 		*type = INSN_CONTEXT_SWITCH;
+
+		sym = find_symbol_by_offset(sec, offset);
+		if (sym && sym->type == STT_FUNC) {
+			*type = INSN_OTHER;
+
+			ADD_OP(op) {
+				/* add $40, %rsp */
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_SP;
+				op->src.offset = 5*8;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
+		}
 		break;
 
 	case 0xe8:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 802dba19a161..a5eedf5e9813 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2358,17 +2358,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			break;
 
-		case INSN_EXCEPTION_RETURN:
-			/*
-			 * This handles x86's sync_core() case, where we use an
-			 * IRET to self. All 'normal' IRET instructions are in
-			 * STT_NOTYPE entry symbols.
-			 */
-			if (func)
-				break;
-
-			return 0;
-
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
 				WARN_FUNC("unsupported instruction in callable function",
