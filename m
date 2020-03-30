Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9075C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C156206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cy/mbkcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgC3RCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:02:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgC3RCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YovRKzds0mUp8LCWT+0s7QzNnI6nnH51z9GqxvgzPSM=; b=cy/mbkcM9mEYCFiUKBa3xQ+hHQ
        2GxSsswkCmvPOBPHF4S3rPexn7Muv3eoVtOtv9E/aRqJFm/HrzKLOZC7HgkllUMhi8YX16fZVcDRQ
        ktoDI/rIOm7/zdpnZ/PUk9D/deGJRYtHERJmjAuCPE8FGQn0MtKKCO+NqovbPIFbM2rVJ0eEJyf1+
        k6u63sWIfdTlkZ6moFmtDCWOoGGNcl+8/gdp//5fgf9gffiQ0dgdUvJE2YgIfG+EBZq02eyAWkJu4
        MARzY7eerlVLkn+ruvx871s0bJGLcE0a3kyfV2zEmD/FaZM14N7HIv5pCdVVp7ArPjK9n75KSprXH
        uUvQtzhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIxnW-0006SI-Ve; Mon, 30 Mar 2020 17:02:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60E69300F28;
        Mon, 30 Mar 2020 19:02:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D7E829D6CDEE; Mon, 30 Mar 2020 19:02:00 +0200 (CEST)
Date:   Mon, 30 Mar 2020 19:02:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200330170200.GU20713@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327010001.i3kebxb4um422ycb@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:00:01PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 26, 2020 at 08:57:18PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 26, 2020 at 04:49:38PM +0100, Peter Zijlstra wrote:
> > > > The 'insn == first' check isn't ideal, but at least it works (I think?).
> > > 
> > > It works, yes, for exactly this one case.
> >
> > How's this? Ignore the ignore_cfi bits, that's a 'failed' experiment.
> 
> It still seems complex to me.
> 
> What do you think about this? 

Perhaps, but I still don't really like it. After much thinking I have
yet another proposal, see below.

> If we store save_insn in the state when
> we see insn->save, the restore logic becomes a lot easier.

Yes, that does help.

> Then if we
> get a restore without a save, we can just ignore the restore hint in
> that path.  Later, when we see the restore insn again from the save
> path, we can then compare the insn state with the saved state to make
> sure they match.

That basically removes the error.

> This assumes no crazy save/restore scenarios.

This.

> It also means that the
> restore path has to be reachable from the save path, for which I had to
> make a change to make IRETQ *not* a dead end if there's a restore hint
> immediately after it.

Right, I did that too. But that then makes me wonder why you needed that
change to validate_unwind_hints(), because if the restore hint makes it
continue, you'll not have unreachable code after it.



---
Subject: objtool: Implement RET_TAIL hint

This replaces the SAVE/RESTORE hints with a RET_TAIL hint that applies to:

 - regular RETURN and sibling calls (which are also function exists)
   it allows the stack-frame to be off by one word, ie. it allows a
   return-tail-call.

 - EXCEPTION_RETURN (a new INSN_type that splits IRET out of
   CONTEXT_SWITCH) and here it denotes a return to self by having it
   consume arch_exception_frame_size bytes off the stack and continuing.

Apply this hint to ftrace_64.S and sync_core(), the two existing users
of the SAVE/RESTORE hints.

For ftrace_64.S we split the return path and make sure the
ftrace_epilogue call is seen as a sibling/tail-call turning it into it's
own function.

By splitting the return path every instruction has a unique stack setup
and ORC can generate correct unwinds (XXX check if/how the ftrace
trampolines map into the ORC). Then employ the RET_TAIL hint to the
tail-call exit that has the direct-call (orig_eax) return-tail-call on.

For sync_core() annotate the IRET with RET_TAIL to mark it as a
control-flow NOP that consumes the exception frame.

XXX this adds a tail-call to ftrace_caller()
XXX compile tested only

Possibly-signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/orc_types.h       |  3 +-
 arch/x86/include/asm/processor.h       |  3 +-
 arch/x86/include/asm/unwind_hints.h    | 12 ++----
 arch/x86/kernel/ftrace.c               | 12 +++++-
 arch/x86/kernel/ftrace_64.S            | 27 +++++--------
 tools/arch/x86/include/asm/orc_types.h |  3 +-
 tools/objtool/Makefile                 |  2 +-
 tools/objtool/arch.h                   |  3 ++
 tools/objtool/arch/x86/decode.c        |  5 ++-
 tools/objtool/check.c                  | 74 ++++++++++------------------------
 tools/objtool/check.h                  |  3 +-
 11 files changed, 59 insertions(+), 88 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 6e060907c163..49536fdd29ce 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -58,8 +58,7 @@
 #define ORC_TYPE_CALL			0
 #define ORC_TYPE_REGS			1
 #define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_TAIL	3
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 94789db550df..cb09ee18cbab 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -728,7 +728,6 @@ static inline void sync_core(void)
 	unsigned int tmp;
 
 	asm volatile (
-		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
@@ -737,8 +736,8 @@ static inline void sync_core(void)
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
+		UNWIND_HINT_RET_TAIL
 		"iretq\n\t"
-		UNWIND_HINT_RESTORE
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index f5e2eb12cb71..64ec9c9a6674 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -86,12 +86,8 @@
 	UNWIND_HINT sp_offset=\sp_offset
 .endm
 
-.macro UNWIND_HINT_SAVE
-	UNWIND_HINT type=UNWIND_HINT_TYPE_SAVE
-.endm
-
-.macro UNWIND_HINT_RESTORE
-	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
+.macro UNWIND_HINT_RET_TAIL
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_TAIL
 .endm
 
 #else /* !__ASSEMBLY__ */
@@ -108,9 +104,7 @@
 	".balign 4 \n\t"					\
 	".popsection\n\t"
 
-#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
-
-#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
+#define UNWIND_HINT_RET_TAIL UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RET_TAIL, 0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 37a0aeaf89e7..3fda2ee7bf71 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -282,7 +282,8 @@ static inline void tramp_free(void *tramp) { }
 
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
-extern void ftrace_epilogue(void);
+extern void ftrace_regs_caller_ret(void);
+extern void ftrace_caller_end(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);
 
@@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		call_offset = (unsigned long)ftrace_regs_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
-		end_offset = (unsigned long)ftrace_epilogue;
+		end_offset = (unsigned long)ftrace_caller_end;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
 		call_offset = (unsigned long)ftrace_call;
 	}
@@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
+	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
+		ip = ftrace_regs_caller_ret;
+		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
+		if (WARN_ON(ret < 0))
+			goto fail;
+	}
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 369e61faacfe..28834d715817 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -157,8 +157,12 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	 * think twice before adding any new code or changing the
 	 * layout here.
 	 */
-SYM_INNER_LABEL(ftrace_epilogue, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 
+	jmp ftrace_epilogue
+SYM_FUNC_END(ftrace_caller);
+
+SYM_FUNC_START(ftrace_epilogue)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jmp ftrace_stub
@@ -170,14 +174,12 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	retq
-SYM_FUNC_END(ftrace_caller)
+SYM_FUNC_END(ftrace_epilogue)
 
 SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
-	UNWIND_HINT_SAVE
-
 	/* added 8 bytes to save flags */
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
@@ -244,20 +246,14 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
 	restore_mcount_regs 8
+	/* Restore flags */
+	popfq
 
-	jmp	2f
+SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
+	UNWIND_HINT_RET_TAIL
+	jmp	ftrace_epilogue
 
 1:	restore_mcount_regs
-
-
-2:
-	/*
-	 * The stack layout is nondetermistic here, depending on which path was
-	 * taken.  This confuses objtool and ORC, rightfully so.  For now,
-	 * pretend the stack always looks like the non-direct case.
-	 */
-	UNWIND_HINT_RESTORE
-
 	/* Restore flags */
 	popfq
 
@@ -268,7 +264,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
-
 	jmp ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 6e060907c163..49536fdd29ce 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -58,8 +58,7 @@
 #define ORC_TYPE_CALL			0
 #define ORC_TYPE_REGS			1
 #define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_TAIL	3
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ee08aeff30a1..ebbf92a8836f 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -ggdb3 $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765c4f44..6d04a683f8cc 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -19,6 +19,7 @@ enum insn_type {
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
+	INSN_EXCEPTION_RETURN,
 	INSN_CONTEXT_SWITCH,
 	INSN_STACK,
 	INSN_BUG,
@@ -73,6 +74,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate, struct stack_op *op);
 
+static const int arch_exception_frame_size = 5*8;
+
 bool arch_callee_saved_reg(unsigned char reg);
 
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..1f9dd97e4a50 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -431,10 +431,13 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
-	case 0xcf: /* iret */
 		*type = INSN_CONTEXT_SWITCH;
 		break;
 
+	case 0xcf: /* iret */
+		*type = INSN_EXCEPTION_RETURN;
+		break;
+
 	case 0xe8:
 		*type = INSN_CALL;
 		break;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e637a4a38d2a..6eb9ae48c94f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1259,13 +1259,8 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		cfa = &insn->state.cfa;
 
-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
-			insn->save = true;
-			continue;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
-			insn->restore = true;
-			insn->hint = true;
+		if (hint->type == UNWIND_HINT_TYPE_RET_TAIL) {
+			insn->ret_tail = true;
 			continue;
 		}
 
@@ -1429,16 +1424,22 @@ static bool is_fentry_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct insn_state *state)
+static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
 	int i;
 
 	if (state->cfa.base != initial_func_cfi.cfa.base ||
-	    state->cfa.offset != initial_func_cfi.cfa.offset ||
-	    state->stack_size != initial_func_cfi.cfa.offset ||
 	    state->drap)
 		return true;
 
+	if (state->cfa.offset != initial_func_cfi.cfa.offset ||
+	    !(insn->ret_tail && state->cfa.offset == initial_func_cfi.cfa.offset + 8))
+
+
+	if (state->stack_size != initial_func_cfi.cfa.offset &&
+	    !(insn->ret_tail && state->stack_size == initial_func_cfi.cfa.offset + 8))
+		return true;
+
 	for (i = 0; i < CFI_NUM_REGS; i++)
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
@@ -1984,7 +1985,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 
 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
-	if (has_modified_stack_frame(state)) {
+	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -2041,47 +2042,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 		}
 
-		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn = i;
-						break;
-					}
-				}
-
-				if (!save_insn) {
-					WARN_FUNC("no corresponding CFI save for CFI restore",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				insn->state = save_insn->state;
-			}
-
+		if (insn->hint)
 			state = insn->state;
-
-		} else
+		else
 			insn->state = state;
 
 		insn->visited |= visited;
@@ -2123,7 +2086,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 1;
 			}
 
-			if (func && has_modified_stack_frame(&state)) {
+			if (func && has_modified_stack_frame(insn, &state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
 				return 1;
@@ -2190,6 +2153,13 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			break;
 
+		case INSN_EXCEPTION_RETURN:
+			if (insn->ret_tail) {
+				state.stack_size -= arch_exception_frame_size;
+				break;
+			}
+
+			/* fallthrough */
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
 				WARN_FUNC("unsupported instruction in callable function",
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca6fce0..138533ac23e2 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,7 +33,8 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool alt_group, dead_end, ignore, ignore_alts;
+	bool hint, ret_tail;
 	bool retpoline_safe;
 	u8 visited;
 	struct symbol *call_dest;
