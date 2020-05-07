Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD8C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7F82084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HjrqUplK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgEGQTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEGQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:19 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C9C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wFNFbYP+xWxU/9oN92oclQ6k4f3Cgheb2D+TAjEkeNo=; b=HjrqUplKtps69pNtdLHmXmbjre
        xux4BZhk7uVRH3SF+gjGFM3pJvkOaqSHwJujVLAwaRnt6zW+gX0T2ujisSudwJp8G9ARECxXJAkvJ
        TbgrG8l/h52jBCZK4B0fg22PnogrSfJ9X4QqbiKmBRaCpOHs1vy4PNjPutfCblDpHfi+FlBdL/JVo
        j7ANyj7zStaYxaMpCYuRDlUGRy666FGxtxm5I9hxvnzSJlxnk3ZB+1T0lIHzw8bYGAjPMLpKFHGle
        zS2PtncbBjEW8VKxLC+I2yeffEinoiYN7vnEOM7kam7mfdnxtHzUDiy3KRqr4i3FPjPxI94VCwvo1
        GIPXxTkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjEg-0004GL-JG; Thu, 07 May 2020 16:18:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64E00302753;
        Thu,  7 May 2020 18:18:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 50EAB2038FB68; Thu,  7 May 2020 18:18:55 +0200 (CEST)
Message-Id: <20200507161828.801097834@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 18:10:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     jpoimboe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about stack irq swizzles
References: <20200507161020.783541450@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas would very much like objtool to understand and generate correct
ORC unwind information for the minimal stack swizzle sequence:

	mov %rsp, (%[ts])
	mov %[ts], %rsp
	...
	pop %rsp

This sequence works for the fp and guess unwinders -- all they need is
that top-of-stack link set up by the first instruction.

The previous entry_64.S code worked with "UNWIND_HINT_REGS indirect=1"
hints to inform the unwinder about the stack-swizzle, but because
we've now already entered C, we can no longer point to a REGS. In
fact, due to being in C we don't even have a reliable sp_offset to
anything.

None of the existing UNWIND_HINT() functionality is quite sufficient
to generate the right thing, but SP_INDIRECT is still the closest, so
extend it.

When SP_INDIRECT is combined with .end=1 (which is otherwise unused,
except for sp_reg == UNDEFINED):

 - change it from (sp+sp_offset) to (sp)+sp_offset
 - have objtool preserve sp_offset from the previous state
 - change "pop %rsp" handling to restore the CFI state from before the
   hint.

NOTES:

 - We now have an instruction with stackops and a hint; make hint take
   precedence over stackops.

 - Due to the reverse search in "pop %rsp" we must
   fill_alternative_cfi() before validate_branch().

 - This all isn't really pretty, but it works and gets Thomas the code
   sequence he wants.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/irq_stack.h    |    1 
 arch/x86/include/asm/unwind_hints.h |   41 +++++++++++++++++++++++++
 arch/x86/kernel/unwind_orc.c        |   11 +++++-
 tools/objtool/check.c               |   58 +++++++++++++++++++++++++++---------
 tools/objtool/orc_dump.c            |   22 ++++++++-----
 5 files changed, 110 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -23,6 +23,7 @@ do {									\
 	__this_cpu_add(irq_count, 1);					\
 	asm volatile(							\
 		"movq	%%rsp, (%[ts])				\n"	\
+		UNWIND_HINT_STACK_EMPTY					\
 		"movq	%[ts], %%rsp				\n"	\
 		ASM_INSTR_BEGIN						\
 		_asm "                                          \n"	\
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -95,6 +95,47 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
 .endm
 
+#else
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
+	"987: \n\t"						\
+	".pushsection .discard.unwind_hints\n\t"		\
+	/* struct unwind_hint */				\
+	".long 987b - .\n\t"					\
+	".short " __stringify(sp_offset) "\n\t"			\
+	".byte " __stringify(sp_reg) "\n\t"			\
+	".byte " __stringify(type) "\n\t"			\
+	".byte " __stringify(end) "\n\t"			\
+	".balign 4 \n\t"					\
+	".popsection\n\t"
+
+/*
+ * Stack swizzling vs objtool/ORC:
+ *
+ * The canonical way of swizzling stack is:
+ *
+ * 1:	mov %%rsp, (%[ts])
+ * 2:	mov %[ts], %%rsp
+ *	...
+ * 3:	pop %%rsp
+ *
+ * Where:
+ *
+ * 1 - places a pointer to the previous stack at the top of the new stack;
+ *     also see the unwinders.
+ *
+ * 2 - switches to the new stack, but to avoid hitting the CFA_UNDEFINED case,
+ *     we need to tell objtool the stack pointer can be found at (%%rsp),
+ *     UNWIND_HINT_STACK_EMPTY does so.
+ *
+ * 3 - restores the previous stack by popping the value stored by 1 into %%rsp,
+ *     ....
+ *
+ * See arch/x86/include/asm/irq_stack.h
+ */
+#define UNWIND_HINT_STACK_EMPTY \
+	UNWIND_HINT(ORC_REG_SP_INDIRECT, 0, ORC_TYPE_CALL, 1)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -435,12 +435,16 @@ bool unwind_next_frame(struct unwind_sta
 		break;
 
 	case ORC_REG_SP_INDIRECT:
-		sp = state->sp + orc->sp_offset;
+		sp = state->sp;
+		if (!orc->end)
+			sp += orc->sp_offset;
 		indirect = true;
 		break;
 
 	case ORC_REG_BP_INDIRECT:
-		sp = state->bp + orc->sp_offset;
+		sp = state->bp;
+		if (!orc->end)
+			sp += orc->sp_offset;
 		indirect = true;
 		break;
 
@@ -489,6 +493,9 @@ bool unwind_next_frame(struct unwind_sta
 	if (indirect) {
 		if (!deref_stack_reg(state, sp, &sp))
 			goto err;
+
+		if (orc->end)
+			sp += orc->sp_offset;
 	}
 
 	/* Find IP, SP and possibly regs: */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1720,8 +1720,8 @@ static void restore_reg(struct cfi_state
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
-			     struct stack_op *op)
+static int update_cfi_state(struct objtool_file *file, struct instruction *insn,
+			    struct cfi_state *cfi, struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 	struct cfi_reg *regs = cfi->regs;
@@ -1898,6 +1898,29 @@ static int update_cfi_state(struct instr
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
+
+			if (op->dest.reg == CFI_SP && cfa->base == CFI_SP_INDIRECT && cfi->end) {
+				/* pop %rsp from a stack swizzle */
+
+				struct instruction *prev;
+
+				for (prev = prev_insn_same_sym(file, insn);
+				     prev; prev = prev_insn_same_sym(file, prev)) {
+
+					if (prev->cfi.cfa.base != CFI_SP_INDIRECT) {
+						*cfi = prev->cfi;
+						break;
+					}
+				}
+
+				if (!prev) {
+					WARN_FUNC("failed RESTORE_STACK", insn->sec, insn->offset);
+					return -1;
+				}
+
+				break;
+			}
+
 			if (!cfi->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
@@ -2073,7 +2096,7 @@ static int update_cfi_state(struct instr
 	return 0;
 }
 
-static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+static int handle_insn_ops(struct objtool_file *file, struct instruction *insn, struct insn_state *state)
 {
 	struct stack_op *op;
 
@@ -2085,9 +2108,11 @@ static int handle_insn_ops(struct instru
 			return -1;
 		}
 
-		res = update_cfi_state(insn, &state->cfi, op);
-		if (res)
-			return res;
+		if (!insn->hint) {
+			res = update_cfi_state(file, insn, &state->cfi, op);
+			if (res)
+				return res;
+		}
 
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
@@ -2319,16 +2344,26 @@ static int validate_branch(struct objtoo
 		if (state.noinstr)
 			state.instr += insn->instr;
 
-		if (insn->hint)
-			state.cfi = insn->cfi;
-		else
+		if (insn->hint) {
+			if (insn->cfi.cfa.base == CFI_SP_INDIRECT && insn->cfi.end) {
+				state.cfi.cfa.base = CFI_SP_INDIRECT;
+				state.cfi.end = true;
+				insn->cfi = state.cfi;
+			} else {
+				state.cfi = insn->cfi;
+			}
+		} else {
 			insn->cfi = state.cfi;
+		}
 
 		insn->visited |= visited;
 
 		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
 			bool skip_orig = false;
 
+			if (insn->alt_group)
+				fill_alternative_cfi(file, insn);
+
 			list_for_each_entry(alt, &insn->alts, list) {
 				if (alt->skip_orig)
 					skip_orig = true;
@@ -2341,14 +2376,11 @@ static int validate_branch(struct objtoo
 				}
 			}
 
-			if (insn->alt_group)
-				fill_alternative_cfi(file, insn);
-
 			if (skip_orig)
 				return 0;
 		}
 
-		if (handle_insn_ops(insn, &state))
+		if (handle_insn_ops(file, insn, &state))
 			return 1;
 
 		switch (insn->type) {
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -47,13 +47,19 @@ static const char *orc_type_name(unsigne
 	}
 }
 
-static void print_reg(unsigned int reg, int offset)
+static void print_reg(unsigned int reg, int offset, bool end)
 {
-	if (reg == ORC_REG_BP_INDIRECT)
-		printf("(bp%+d)", offset);
-	else if (reg == ORC_REG_SP_INDIRECT)
-		printf("(sp%+d)", offset);
-	else if (reg == ORC_REG_UNDEFINED)
+	if (reg == ORC_REG_BP_INDIRECT) {
+		if (end)
+			printf("(bp)%+d", offset);
+		else
+			printf("(bp%+d)", offset);
+	} else if (reg == ORC_REG_SP_INDIRECT) {
+		if (end)
+			printf("(sp)%+d", offset);
+		else
+			printf("(sp%+d)", offset);
+	} else if (reg == ORC_REG_UNDEFINED)
 		printf("(und)");
 	else
 		printf("%s%+d", reg_name(reg), offset);
@@ -195,11 +201,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, orc[i].sp_offset, orc[i].end);
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, orc[i].bp_offset, false);
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);


