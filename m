Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1993120842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Usv8Wt+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgCaW1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:27:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaW1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ByEY9ZMovaRN6Wl2pi08+SRs7WS8GWHkGD4Cg+Rm/GY=; b=Usv8Wt+RcmWsbMTDYPlrn1NUSV
        aOSXzmG1+BW09hBPtNjwTWNKq1EKTIAIwYWQ5wiPRUy1dgZ3AjIqtbpqk6CPM6eYQ+D3GudwFYWld
        1aYYov+FsR8F5kwrltwzJVezpdnE2Q4+cWvSp+ct4X6GBBigMpmctIrJXpFhrusuL/r8Cd3vhsabF
        WWThpL4OjBCpC4BZFhevM8h9EGJMYMycLfK95m99Yi1y8+O02ml6NHYtnWPu5pPvb1Lle2ulCWBXV
        ylZZmypFsEIJVqBBei6XgudRfy4CQ7ji3bAm2VuWuL7QqODXu964JudZQIxc5NepY22I+V71zIfX2
        +aP4RYfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJPLe-0000uH-Pb; Tue, 31 Mar 2020 22:27:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D58DF98354A; Wed,  1 Apr 2020 00:27:03 +0200 (CEST)
Date:   Wed, 1 Apr 2020 00:27:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331222703.GH2452@worktop.programming.kicks-ass.net>
References: <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331212040.7lrzmj7tbbx2jgrj@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:20:40PM -0500, Josh Poimboeuf wrote:
> On Tue, Mar 31, 2020 at 04:17:58PM -0500, Josh Poimboeuf wrote:
> > > I'm not against adding a second/separate hint for this. In fact, I
> > > almost considered teaching objtool how to interpret the whole IRET frame
> > > so that we can do it without hints. It's just that that's too much code
> > > for this one case.
> > > 
> > > HINT_IRET_SELF ?
> > 
> > Despite my earlier complaint about stack size knowledge, we could just
> > forget the hint and make "iretq in C code" equivalent to "reduce stack
> > size by arch_exception_stack_size()" and keep going.  There's
> > file->c_file which tells you it's a C file.
> 
> Or maybe "iretq in an STT_FUNC" is better since this pattern could
> presumably happen in a callable asm function.

Like so then?

---
Subject: objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 31 Mar 2020 13:16:52 +0200

This replaces the SAVE/RESTORE hints with a RET_OFFSET hint that
applies to any instruction that terminates a function, like: RETURN
and sibling calls. It allows the stack-frame to be off by @sp_offset,
ie. it allows stuffing the return stack.

For ftrace_64.S we split the return path and make sure the
ftrace_epilogue call is seen as a sibling/tail-call turning it into it's
own function.

By splitting the return path every instruction has a unique stack setup
and ORC can generate correct unwinds. Then employ the RET_OFFSET hint to
the tail-call exit that has the direct-call (orig_eax) stuffed on the
return stack.

For sync_core() we teach objtool that an IRET inside an STT_FUNC
simply consumes the exception stack and continues.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/orc_types.h       |    9 ++-
 arch/x86/include/asm/processor.h       |    2
 arch/x86/include/asm/unwind_hints.h    |   12 +---
 arch/x86/kernel/ftrace.c               |   12 ++++
 arch/x86/kernel/ftrace_64.S            |   27 ++++-------
 tools/arch/x86/include/asm/orc_types.h |    9 ++-
 tools/objtool/Makefile                 |    2
 tools/objtool/arch.h                   |    3 +
 tools/objtool/arch/x86/decode.c        |    5 +-
 tools/objtool/check.c                  |   80 ++++++++++-----------------------
 tools/objtool/check.h                  |    4 +
 11 files changed, 74 insertions(+), 91 deletions(-)

--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -58,8 +58,13 @@
 #define ORC_TYPE_CALL			0
 #define ORC_TYPE_REGS			1
 #define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
+
+/*
+ * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
+ * and sibling calls. On these, sp_offset denotes the expected offset from
+ * initial_func_cfi.
+ */
+#define UNWIND_HINT_TYPE_RET_OFFSET	3

 #ifndef __ASSEMBLY__
 /*
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -738,7 +738,6 @@ static inline void sync_core(void)
 	unsigned int tmp;

 	asm volatile (
-		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
@@ -748,7 +747,6 @@ static inline void sync_core(void)
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
 		"iretq\n\t"
-		UNWIND_HINT_RESTORE
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
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
+.macro UNWIND_HINT_RET_OFFSET sp_offset=8
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
 .endm

 #else /* !__ASSEMBLY__ */
@@ -108,9 +104,7 @@
 	".balign 4 \n\t"					\
 	".popsection\n\t"

-#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
-
-#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
+#define UNWIND_HINT_RET_OFFSET(offset) UNWIND_HINT(0, (offset), UNWIND_HINT_TYPE_RET_OFFSET, 0)

 #endif /* __ASSEMBLY__ */

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -282,7 +282,8 @@ static inline void tramp_free(void *tram

 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
-extern void ftrace_epilogue(void);
+extern void ftrace_regs_caller_ret(void);
+extern void ftrace_caller_end(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);

@@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops
 		call_offset = (unsigned long)ftrace_regs_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
-		end_offset = (unsigned long)ftrace_epilogue;
+		end_offset = (unsigned long)ftrace_caller_end;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
 		call_offset = (unsigned long)ftrace_call;
 	}
@@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops
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
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -157,8 +157,12 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBA
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
@@ -170,14 +174,12 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L
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
@@ -244,20 +246,14 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	movq %rax, MCOUNT_REG_SIZE(%rsp)

 	restore_mcount_regs 8
+	/* Restore flags */
+	popfq

-	jmp	2f
+SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
+	UNWIND_HINT_RET_OFFSET
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

@@ -268,7 +264,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
-
 	jmp ftrace_epilogue

 SYM_FUNC_END(ftrace_regs_caller)
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -58,8 +58,13 @@
 #define ORC_TYPE_CALL			0
 #define ORC_TYPE_REGS			1
 #define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
+
+/*
+ * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
+ * and sibling calls. On these, sp_offset denotes the expected offset from
+ * initial_func_cfi.
+ */
+#define UNWIND_HINT_TYPE_RET_OFFSET	3

 #ifndef __ASSEMBLY__
 /*
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
@@ -75,4 +76,6 @@ int arch_decode_instruction(struct elf *

 bool arch_callee_saved_reg(unsigned char reg);

+static const int arch_exception_frame_size = 5*8;
+
 #endif /* _ARCH_H */
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -431,10 +431,13 @@ int arch_decode_instruction(struct elf *

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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1246,13 +1246,8 @@ static int read_unwind_hints(struct objt

 		cfa = &insn->state.cfa;

-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
-			insn->save = true;
-			continue;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
-			insn->restore = true;
-			insn->hint = true;
+		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+			insn->ret_offset = hint->sp_offset;
 			continue;
 		}

@@ -1416,20 +1411,26 @@ static bool is_fentry_call(struct instru
 	return false;
 }

-static bool has_modified_stack_frame(struct insn_state *state)
+static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
+	u8 ret_offset = insn->ret_offset;
 	int i;

-	if (state->cfa.base != initial_func_cfi.cfa.base ||
-	    state->cfa.offset != initial_func_cfi.cfa.offset ||
-	    state->stack_size != initial_func_cfi.cfa.offset ||
-	    state->drap)
+	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
+		return true;
+
+	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
+	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))
+		return true;
+
+	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;

-	for (i = 0; i < CFI_NUM_REGS; i++)
+	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
+	}

 	return false;
 }
@@ -1971,7 +1972,7 @@ static int validate_call(struct instruct

 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
-	if (has_modified_stack_frame(state)) {
+	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -2000,7 +2001,7 @@ static int validate_return(struct symbol
 		return 1;
 	}

-	if (func && has_modified_stack_frame(state)) {
+	if (func && has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("return with modified stack frame",
 			  insn->sec, insn->offset);
 		return 1;
@@ -2063,47 +2064,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}

-		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				sym_for_each_insn_continue_reverse(file, func, i) {
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
@@ -2185,6 +2148,13 @@ static int validate_branch(struct objtoo

 			break;

+		case INSN_EXCEPTION_RETURN:
+			if (func) {
+				state.stack_size -= arch_exception_frame_size;
+				break;
+			}
+
+			/* fallthrough */
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
 				WARN_FUNC("unsupported instruction in callable function",
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,9 +33,11 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool alt_group, dead_end, ignore, ignore_alts;
+	bool hint;
 	bool retpoline_safe;
 	u8 visited;
+	u8 ret_offset;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;

