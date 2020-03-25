Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8D8C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0033E208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofJHMSJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgCYOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:43:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37724 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgCYOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r6ouWfmU+rxyY3goDKuSXczwjXQTuk22USvBPOXeAyE=; b=ofJHMSJM1GIeq78Q6jwnKWFUjK
        rCXZUzcCLXq3wgWQyfL9xcIZ53kN6PWDnirtqsdZIWrDcMYAwgYSKfQ4h5kgq9P/ZyYBSiZoCpf42
        73JWhDW7PdZcE7zs/s1hfv/CE0xCtcVSFWs7O8Zs+FI8bg0cSHIR1fyDfpFLUbZBxbNmv+3XUf04w
        ClE4f9wBtqmaw1vnbcG7BWxlh5XSLG5e2PwUafDCC1dQwvLki0OCwd2MPXCuMiH+yYXhXbZ7BmbuP
        4MgEXboA6k8Ue9S8uTp5A0XqoooizRi+3N/fFhW134EqneR2M+U4UnmLHQ/Axd4hWSdJmu/yGvYiT
        NmGJihyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH7G2-0008A8-LQ; Wed, 25 Mar 2020 14:43:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 812AA3007F2;
        Wed, 25 Mar 2020 15:43:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 733BB29A8F430; Wed, 25 Mar 2020 15:43:49 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:43:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3.1 18d/26] objtool: Fix !CFI insn_state propagation
Message-ID: <20200325144349.GY20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324160924.987489248@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Fix !CFI insn_state propagation
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 25 14:04:45 CET 2020

Objtool keeps per instruction CFI state in struct insn_state and will
save/restore this where required. However, insn_state has grown some
!CFI state, and this must not be saved/restored (that would
loose/destroy state).

Fix this by moving the CFI specific parts of insn_state into struct
cfi_state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/cfi.h     |   12 ++
 tools/objtool/check.c   |  270 ++++++++++++++++++++++++------------------------
 tools/objtool/check.h   |   13 --
 tools/objtool/orc_gen.c |    8 -
 4 files changed, 160 insertions(+), 143 deletions(-)

--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -36,8 +36,20 @@ struct cfi_reg {
 };
 
 struct cfi_init_state {
+	struct cfi_reg regs[CFI_NUM_REGS];
 	struct cfi_reg cfa;
+};
+
+struct cfi_state {
 	struct cfi_reg regs[CFI_NUM_REGS];
+	struct cfi_reg vals[CFI_NUM_REGS];
+	struct cfi_reg cfa;
+	int stack_size;
+	int drap_reg, drap_offset;
+	unsigned char type;
+	bool bp_scratch;
+	bool drap;
+	bool end;
 };
 
 #endif /* _OBJTOOL_CFI_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -215,18 +215,23 @@ static bool dead_end_function(struct obj
 	return __dead_end_function(file, func, 0);
 }
 
-static void clear_insn_state(struct insn_state *state)
+static void init_cfi_state(struct cfi_state *cfi)
 {
 	int i;
 
-	memset(state, 0, sizeof(*state));
-	state->cfa.base = CFI_UNDEFINED;
 	for (i = 0; i < CFI_NUM_REGS; i++) {
-		state->regs[i].base = CFI_UNDEFINED;
-		state->vals[i].base = CFI_UNDEFINED;
+		cfi->regs[i].base = CFI_UNDEFINED;
+		cfi->vals[i].base = CFI_UNDEFINED;
 	}
-	state->drap_reg = CFI_UNDEFINED;
-	state->drap_offset = -1;
+	cfi->cfa.base = CFI_UNDEFINED;
+	cfi->drap_reg = CFI_UNDEFINED;
+	cfi->drap_offset = -1;
+}
+
+static void clear_insn_state(struct insn_state *state)
+{
+	memset(state, 0, sizeof(*state));
+	init_cfi_state(&state->cfi);
 }
 
 /*
@@ -260,7 +265,7 @@ static int decode_instructions(struct ob
 			}
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
-			clear_insn_state(&insn->state);
+			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -769,7 +774,7 @@ static int handle_group_alt(struct objto
 		}
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
-		clear_insn_state(&fake_jump->state);
+		init_cfi_state(&fake_jump->cfi);
 
 		fake_jump->sec = special_alt->new_sec;
 		fake_jump->offset = FAKE_JUMP_OFFSET;
@@ -1262,7 +1267,7 @@ static int read_unwind_hints(struct objt
 			return -1;
 		}
 
-		cfa = &insn->state.cfa;
+		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
 			insn->save = true;
@@ -1308,8 +1313,8 @@ static int read_unwind_hints(struct objt
 		}
 
 		cfa->offset = hint->sp_offset;
-		insn->state.type = hint->type;
-		insn->state.end = hint->end;
+		insn->cfi.type = hint->type;
+		insn->cfi.end = hint->end;
 	}
 
 	return 0;
@@ -1436,17 +1441,18 @@ static bool is_fentry_call(struct instru
 
 static bool has_modified_stack_frame(struct insn_state *state)
 {
+	struct cfi_state *cfi = &state->cfi;
 	int i;
 
-	if (state->cfa.base != initial_func_cfi.cfa.base ||
-	    state->cfa.offset != initial_func_cfi.cfa.offset ||
-	    state->stack_size != initial_func_cfi.cfa.offset ||
-	    state->drap)
+	if (cfi->cfa.base != initial_func_cfi.cfa.base ||
+	    cfi->cfa.offset != initial_func_cfi.cfa.offset ||
+	    cfi->stack_size != initial_func_cfi.cfa.offset ||
+	    cfi->drap)
 		return true;
 
 	for (i = 0; i < CFI_NUM_REGS; i++)
-		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
-		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
+		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
+		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
 
 	return false;
@@ -1454,19 +1460,21 @@ static bool has_modified_stack_frame(str
 
 static bool has_valid_stack_frame(struct insn_state *state)
 {
-	if (state->cfa.base == CFI_BP && state->regs[CFI_BP].base == CFI_CFA &&
-	    state->regs[CFI_BP].offset == -16)
+	struct cfi_state *cfi = &state->cfi;
+
+	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
+	    cfi->regs[CFI_BP].offset == -16)
 		return true;
 
-	if (state->drap && state->regs[CFI_BP].base == CFI_BP)
+	if (cfi->drap && cfi->regs[CFI_BP].base == CFI_BP)
 		return true;
 
 	return false;
 }
 
-static int update_insn_state_regs(struct instruction *insn, struct insn_state *state)
+static int update_cfi_state_regs(struct instruction *insn, struct cfi_state *cfi)
 {
-	struct cfi_reg *cfa = &state->cfa;
+	struct cfi_reg *cfa = &cfi->cfa;
 	struct stack_op *op = &insn->stack_op;
 
 	if (cfa->base != CFI_SP)
@@ -1488,20 +1496,19 @@ static int update_insn_state_regs(struct
 	return 0;
 }
 
-static void save_reg(struct insn_state *state, unsigned char reg, int base,
-		     int offset)
+static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
 {
 	if (arch_callee_saved_reg(reg) &&
-	    state->regs[reg].base == CFI_UNDEFINED) {
-		state->regs[reg].base = base;
-		state->regs[reg].offset = offset;
+	    cfi->regs[reg].base == CFI_UNDEFINED) {
+		cfi->regs[reg].base = base;
+		cfi->regs[reg].offset = offset;
 	}
 }
 
-static void restore_reg(struct insn_state *state, unsigned char reg)
+static void restore_reg(struct cfi_state *cfi, unsigned char reg)
 {
-	state->regs[reg].base = CFI_UNDEFINED;
-	state->regs[reg].offset = 0;
+	cfi->regs[reg].base = CFI_UNDEFINED;
+	cfi->regs[reg].offset = 0;
 }
 
 /*
@@ -1557,11 +1564,11 @@ static void restore_reg(struct insn_stat
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_insn_state(struct instruction *insn, struct insn_state *state)
+static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi)
 {
 	struct stack_op *op = &insn->stack_op;
-	struct cfi_reg *cfa = &state->cfa;
-	struct cfi_reg *regs = state->regs;
+	struct cfi_reg *cfa = &cfi->cfa;
+	struct cfi_reg *regs = cfi->regs;
 
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
@@ -1572,8 +1579,8 @@ static int update_insn_state(struct inst
 		return 0;
 	}
 
-	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state);
+	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
+		return update_cfi_state_regs(insn, cfi);
 
 	switch (op->dest.type) {
 
@@ -1588,16 +1595,16 @@ static int update_insn_state(struct inst
 
 				/* mov %rsp, %rbp */
 				cfa->base = op->dest.reg;
-				state->bp_scratch = false;
+				cfi->bp_scratch = false;
 			}
 
 			else if (op->src.reg == CFI_SP &&
-				 op->dest.reg == CFI_BP && state->drap) {
+				 op->dest.reg == CFI_BP && cfi->drap) {
 
 				/* drap: mov %rsp, %rbp */
 				regs[CFI_BP].base = CFI_BP;
-				regs[CFI_BP].offset = -state->stack_size;
-				state->bp_scratch = false;
+				regs[CFI_BP].offset = -cfi->stack_size;
+				cfi->bp_scratch = false;
 			}
 
 			else if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
@@ -1612,8 +1619,8 @@ static int update_insn_state(struct inst
 				 *   ...
 				 *   mov    %rax, %rsp
 				 */
-				state->vals[op->dest.reg].base = CFI_CFA;
-				state->vals[op->dest.reg].offset = -state->stack_size;
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = -cfi->stack_size;
 			}
 
 			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
@@ -1624,14 +1631,14 @@ static int update_insn_state(struct inst
 				 *
 				 * Restore the original stack pointer (Clang).
 				 */
-				state->stack_size = -state->regs[CFI_BP].offset;
+				cfi->stack_size = -cfi->regs[CFI_BP].offset;
 			}
 
 			else if (op->dest.reg == cfa->base) {
 
 				/* mov %reg, %rsp */
 				if (cfa->base == CFI_SP &&
-				    state->vals[op->src.reg].base == CFI_CFA) {
+				    cfi->vals[op->src.reg].base == CFI_CFA) {
 
 					/*
 					 * This is needed for the rare case
@@ -1641,8 +1648,8 @@ static int update_insn_state(struct inst
 					 *   ...
 					 *   mov    %rcx, %rsp
 					 */
-					cfa->offset = -state->vals[op->src.reg].offset;
-					state->stack_size = cfa->offset;
+					cfa->offset = -cfi->vals[op->src.reg].offset;
+					cfi->stack_size = cfa->offset;
 
 				} else {
 					cfa->base = CFI_UNDEFINED;
@@ -1656,7 +1663,7 @@ static int update_insn_state(struct inst
 			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
 
 				/* add imm, %rsp */
-				state->stack_size -= op->src.offset;
+				cfi->stack_size -= op->src.offset;
 				if (cfa->base == CFI_SP)
 					cfa->offset -= op->src.offset;
 				break;
@@ -1665,14 +1672,14 @@ static int update_insn_state(struct inst
 			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
 
 				/* lea disp(%rbp), %rsp */
-				state->stack_size = -(op->src.offset + regs[CFI_BP].offset);
+				cfi->stack_size = -(op->src.offset + regs[CFI_BP].offset);
 				break;
 			}
 
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
-				state->drap_reg = op->dest.reg;
+				cfi->drap_reg = op->dest.reg;
 
 				/*
 				 * lea disp(%rsp), %reg
@@ -1684,25 +1691,25 @@ static int update_insn_state(struct inst
 				 *   ...
 				 *   mov    %rcx, %rsp
 				 */
-				state->vals[op->dest.reg].base = CFI_CFA;
-				state->vals[op->dest.reg].offset = \
-					-state->stack_size + op->src.offset;
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = \
+					-cfi->stack_size + op->src.offset;
 
 				break;
 			}
 
-			if (state->drap && op->dest.reg == CFI_SP &&
-			    op->src.reg == state->drap_reg) {
+			if (cfi->drap && op->dest.reg == CFI_SP &&
+			    op->src.reg == cfi->drap_reg) {
 
 				 /* drap: lea disp(%drap), %rsp */
 				cfa->base = CFI_SP;
-				cfa->offset = state->stack_size = -op->src.offset;
-				state->drap_reg = CFI_UNDEFINED;
-				state->drap = false;
+				cfa->offset = cfi->stack_size = -op->src.offset;
+				cfi->drap_reg = CFI_UNDEFINED;
+				cfi->drap = false;
 				break;
 			}
 
-			if (op->dest.reg == state->cfa.base) {
+			if (op->dest.reg == cfi->cfa.base) {
 				WARN_FUNC("unsupported stack register modification",
 					  insn->sec, insn->offset);
 				return -1;
@@ -1712,18 +1719,18 @@ static int update_insn_state(struct inst
 
 		case OP_SRC_AND:
 			if (op->dest.reg != CFI_SP ||
-			    (state->drap_reg != CFI_UNDEFINED && cfa->base != CFI_SP) ||
-			    (state->drap_reg == CFI_UNDEFINED && cfa->base != CFI_BP)) {
+			    (cfi->drap_reg != CFI_UNDEFINED && cfa->base != CFI_SP) ||
+			    (cfi->drap_reg == CFI_UNDEFINED && cfa->base != CFI_BP)) {
 				WARN_FUNC("unsupported stack pointer realignment",
 					  insn->sec, insn->offset);
 				return -1;
 			}
 
-			if (state->drap_reg != CFI_UNDEFINED) {
+			if (cfi->drap_reg != CFI_UNDEFINED) {
 				/* drap: and imm, %rsp */
-				cfa->base = state->drap_reg;
-				cfa->offset = state->stack_size = 0;
-				state->drap = true;
+				cfa->base = cfi->drap_reg;
+				cfa->offset = cfi->stack_size = 0;
+				cfi->drap = true;
 			}
 
 			/*
@@ -1735,57 +1742,57 @@ static int update_insn_state(struct inst
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
-			if (!state->drap && op->dest.type == OP_DEST_REG &&
+			if (!cfi->drap && op->dest.type == OP_DEST_REG &&
 			    op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
 				cfa->base = CFI_SP;
 			}
 
-			if (state->drap && cfa->base == CFI_BP_INDIRECT &&
+			if (cfi->drap && cfa->base == CFI_BP_INDIRECT &&
 			    op->dest.type == OP_DEST_REG &&
-			    op->dest.reg == state->drap_reg &&
-			    state->drap_offset == -state->stack_size) {
+			    op->dest.reg == cfi->drap_reg &&
+			    cfi->drap_offset == -cfi->stack_size) {
 
 				/* drap: pop %drap */
-				cfa->base = state->drap_reg;
+				cfa->base = cfi->drap_reg;
 				cfa->offset = 0;
-				state->drap_offset = -1;
+				cfi->drap_offset = -1;
 
-			} else if (regs[op->dest.reg].offset == -state->stack_size) {
+			} else if (regs[op->dest.reg].offset == -cfi->stack_size) {
 
 				/* pop %reg */
-				restore_reg(state, op->dest.reg);
+				restore_reg(cfi, op->dest.reg);
 			}
 
-			state->stack_size -= 8;
+			cfi->stack_size -= 8;
 			if (cfa->base == CFI_SP)
 				cfa->offset -= 8;
 
 			break;
 
 		case OP_SRC_REG_INDIRECT:
-			if (state->drap && op->src.reg == CFI_BP &&
-			    op->src.offset == state->drap_offset) {
+			if (cfi->drap && op->src.reg == CFI_BP &&
+			    op->src.offset == cfi->drap_offset) {
 
 				/* drap: mov disp(%rbp), %drap */
-				cfa->base = state->drap_reg;
+				cfa->base = cfi->drap_reg;
 				cfa->offset = 0;
-				state->drap_offset = -1;
+				cfi->drap_offset = -1;
 			}
 
-			if (state->drap && op->src.reg == CFI_BP &&
+			if (cfi->drap && op->src.reg == CFI_BP &&
 			    op->src.offset == regs[op->dest.reg].offset) {
 
 				/* drap: mov disp(%rbp), %reg */
-				restore_reg(state, op->dest.reg);
+				restore_reg(cfi, op->dest.reg);
 
 			} else if (op->src.reg == cfa->base &&
 			    op->src.offset == regs[op->dest.reg].offset + cfa->offset) {
 
 				/* mov disp(%rbp), %reg */
 				/* mov disp(%rsp), %reg */
-				restore_reg(state, op->dest.reg);
+				restore_reg(cfi, op->dest.reg);
 			}
 
 			break;
@@ -1800,78 +1807,78 @@ static int update_insn_state(struct inst
 
 	case OP_DEST_PUSH:
 	case OP_DEST_PUSHF:
-		state->stack_size += 8;
+		cfi->stack_size += 8;
 		if (cfa->base == CFI_SP)
 			cfa->offset += 8;
 
 		if (op->src.type != OP_SRC_REG)
 			break;
 
-		if (state->drap) {
-			if (op->src.reg == cfa->base && op->src.reg == state->drap_reg) {
+		if (cfi->drap) {
+			if (op->src.reg == cfa->base && op->src.reg == cfi->drap_reg) {
 
 				/* drap: push %drap */
 				cfa->base = CFI_BP_INDIRECT;
-				cfa->offset = -state->stack_size;
+				cfa->offset = -cfi->stack_size;
 
 				/* save drap so we know when to restore it */
-				state->drap_offset = -state->stack_size;
+				cfi->drap_offset = -cfi->stack_size;
 
-			} else if (op->src.reg == CFI_BP && cfa->base == state->drap_reg) {
+			} else if (op->src.reg == CFI_BP && cfa->base == cfi->drap_reg) {
 
 				/* drap: push %rbp */
-				state->stack_size = 0;
+				cfi->stack_size = 0;
 
 			} else if (regs[op->src.reg].base == CFI_UNDEFINED) {
 
 				/* drap: push %reg */
-				save_reg(state, op->src.reg, CFI_BP, -state->stack_size);
+				save_reg(cfi, op->src.reg, CFI_BP, -cfi->stack_size);
 			}
 
 		} else {
 
 			/* push %reg */
-			save_reg(state, op->src.reg, CFI_CFA, -state->stack_size);
+			save_reg(cfi, op->src.reg, CFI_CFA, -cfi->stack_size);
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
 		if (!no_fp && insn->func && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
-			state->bp_scratch = true;
+			cfi->bp_scratch = true;
 		break;
 
 	case OP_DEST_REG_INDIRECT:
 
-		if (state->drap) {
-			if (op->src.reg == cfa->base && op->src.reg == state->drap_reg) {
+		if (cfi->drap) {
+			if (op->src.reg == cfa->base && op->src.reg == cfi->drap_reg) {
 
 				/* drap: mov %drap, disp(%rbp) */
 				cfa->base = CFI_BP_INDIRECT;
 				cfa->offset = op->dest.offset;
 
 				/* save drap offset so we know when to restore it */
-				state->drap_offset = op->dest.offset;
+				cfi->drap_offset = op->dest.offset;
 			}
 
 			else if (regs[op->src.reg].base == CFI_UNDEFINED) {
 
 				/* drap: mov reg, disp(%rbp) */
-				save_reg(state, op->src.reg, CFI_BP, op->dest.offset);
+				save_reg(cfi, op->src.reg, CFI_BP, op->dest.offset);
 			}
 
 		} else if (op->dest.reg == cfa->base) {
 
 			/* mov reg, disp(%rbp) */
 			/* mov reg, disp(%rsp) */
-			save_reg(state, op->src.reg, CFI_CFA,
-				 op->dest.offset - state->cfa.offset);
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->cfa.offset);
 		}
 
 		break;
 
 	case OP_DEST_LEAVE:
-		if ((!state->drap && cfa->base != CFI_BP) ||
-		    (state->drap && cfa->base != state->drap_reg)) {
+		if ((!cfi->drap && cfa->base != CFI_BP) ||
+		    (cfi->drap && cfa->base != cfi->drap_reg)) {
 			WARN_FUNC("leave instruction with modified stack frame",
 				  insn->sec, insn->offset);
 			return -1;
@@ -1879,10 +1886,10 @@ static int update_insn_state(struct inst
 
 		/* leave (mov %rbp, %rsp; pop %rbp) */
 
-		state->stack_size = -state->regs[CFI_BP].offset - 8;
-		restore_reg(state, CFI_BP);
+		cfi->stack_size = -cfi->regs[CFI_BP].offset - 8;
+		restore_reg(cfi, CFI_BP);
 
-		if (!state->drap) {
+		if (!cfi->drap) {
 			cfa->base = CFI_SP;
 			cfa->offset -= 8;
 		}
@@ -1897,7 +1904,7 @@ static int update_insn_state(struct inst
 		}
 
 		/* pop mem */
-		state->stack_size -= 8;
+		cfi->stack_size -= 8;
 		if (cfa->base == CFI_SP)
 			cfa->offset -= 8;
 
@@ -1912,41 +1919,44 @@ static int update_insn_state(struct inst
 	return 0;
 }
 
-static bool insn_state_match(struct instruction *insn, struct insn_state *state)
+static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 {
-	struct insn_state *state1 = &insn->state, *state2 = state;
+	struct cfi_state *cfi1 = &insn->cfi;
 	int i;
 
-	if (memcmp(&state1->cfa, &state2->cfa, sizeof(state1->cfa))) {
+	if (memcmp(&cfi1->cfa, &cfi2->cfa, sizeof(cfi1->cfa))) {
+
 		WARN_FUNC("stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
 			  insn->sec, insn->offset,
-			  state1->cfa.base, state1->cfa.offset,
-			  state2->cfa.base, state2->cfa.offset);
+			  cfi1->cfa.base, cfi1->cfa.offset,
+			  cfi2->cfa.base, cfi2->cfa.offset);
 
-	} else if (memcmp(&state1->regs, &state2->regs, sizeof(state1->regs))) {
+	} else if (memcmp(&cfi1->regs, &cfi2->regs, sizeof(cfi1->regs))) {
 		for (i = 0; i < CFI_NUM_REGS; i++) {
-			if (!memcmp(&state1->regs[i], &state2->regs[i],
+			if (!memcmp(&cfi1->regs[i], &cfi2->regs[i],
 				    sizeof(struct cfi_reg)))
 				continue;
 
 			WARN_FUNC("stack state mismatch: reg1[%d]=%d%+d reg2[%d]=%d%+d",
 				  insn->sec, insn->offset,
-				  i, state1->regs[i].base, state1->regs[i].offset,
-				  i, state2->regs[i].base, state2->regs[i].offset);
+				  i, cfi1->regs[i].base, cfi1->regs[i].offset,
+				  i, cfi2->regs[i].base, cfi2->regs[i].offset);
 			break;
 		}
 
-	} else if (state1->type != state2->type) {
+	} else if (cfi1->type != cfi2->type) {
+
 		WARN_FUNC("stack state mismatch: type1=%d type2=%d",
-			  insn->sec, insn->offset, state1->type, state2->type);
+			  insn->sec, insn->offset, cfi1->type, cfi2->type);
+
+	} else if (cfi1->drap != cfi2->drap ||
+		   (cfi1->drap && cfi1->drap_reg != cfi2->drap_reg) ||
+		   (cfi1->drap && cfi1->drap_offset != cfi2->drap_offset)) {
 
-	} else if (state1->drap != state2->drap ||
-		 (state1->drap && state1->drap_reg != state2->drap_reg) ||
-		 (state1->drap && state1->drap_offset != state2->drap_offset)) {
 		WARN_FUNC("stack state mismatch: drap1=%d(%d,%d) drap2=%d(%d,%d)",
 			  insn->sec, insn->offset,
-			  state1->drap, state1->drap_reg, state1->drap_offset,
-			  state2->drap, state2->drap_reg, state2->drap_offset);
+			  cfi1->drap, cfi1->drap_reg, cfi1->drap_offset,
+			  cfi2->drap, cfi2->drap_reg, cfi2->drap_offset);
 
 	} else
 		return true;
@@ -2024,7 +2034,7 @@ static int validate_return(struct symbol
 		return 1;
 	}
 
-	if (state->bp_scratch) {
+	if (state->cfi.bp_scratch) {
 		WARN("%s uses BP as a scratch register",
 		     func->name);
 		return 1;
@@ -2035,7 +2045,7 @@ static int validate_return(struct symbol
 
 static int apply_insn_hint(struct objtool_file *file, struct section *sec,
 			   struct symbol *func, struct instruction *insn,
-			   struct insn_state *state)
+			   struct cfi_state *cfi)
 {
 	if (insn->restore) {
 		struct instruction *save_insn, *i;
@@ -2061,10 +2071,10 @@ static int apply_insn_hint(struct objtoo
 			return 1;
 		}
 
-		insn->state = save_insn->state;
+		insn->cfi = save_insn->cfi;
 	}
 
-	state = insn->state;
+	*cfi = insn->cfi;
 }
 
 /*
@@ -2107,7 +2117,7 @@ static int validate_branch(struct objtoo
 
 		visited = 1 << state.uaccess;
 		if (insn->visited) {
-			if (!insn->hint && !insn_state_match(insn, &state))
+			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
 				return 1;
 
 			if (insn->visited & visited)
@@ -2115,11 +2125,11 @@ static int validate_branch(struct objtoo
 		}
 
 		if (insn->hint) {
-			ret = apply_insn_hint(file, sec, func, insn, &state);
+			ret = apply_insn_hint(file, sec, func, insn, &state.cfi);
 			if (ret)
 				return ret;
 		} else
-			insn->state = state;
+			insn->cfi = state.cfi;
 
 		insn->visited |= visited;
 
@@ -2209,7 +2219,7 @@ static int validate_branch(struct objtoo
 			return 0;
 
 		case INSN_STACK:
-			if (update_insn_state(insn, &state))
+			if (update_cfi_state(insn, &state.cfi))
 				return 1;
 
 			if (insn->stack_op.dest.type == OP_DEST_PUSHF) {
@@ -2279,7 +2289,7 @@ static int validate_branch(struct objtoo
 			return 0;
 
 		if (!next_insn) {
-			if (state.cfa.base == CFI_UNDEFINED)
+			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
@@ -2419,10 +2429,10 @@ static int validate_section(struct objto
 
 	clear_insn_state(&state);
 
-	state.cfa = initial_func_cfi.cfa;
-	memcpy(&state.regs, &initial_func_cfi.regs,
+	state.cfi.cfa = initial_func_cfi.cfa;
+	memcpy(&state.cfi.regs, &initial_func_cfi.regs,
 	       CFI_NUM_REGS * sizeof(struct cfi_reg));
-	state.stack_size = initial_func_cfi.cfa.offset;
+	state.cfi.stack_size = initial_func_cfi.cfa.offset;
 
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -14,15 +14,10 @@
 #include <linux/hashtable.h>
 
 struct insn_state {
-	struct cfi_reg cfa;
-	struct cfi_reg regs[CFI_NUM_REGS];
-	int stack_size;
-	unsigned char type;
-	bool bp_scratch;
-	bool drap, end, uaccess, df;
+	struct cfi_state cfi;
 	unsigned int uaccess_stack;
-	int drap_reg, drap_offset;
-	struct cfi_reg vals[CFI_NUM_REGS];
+	bool uaccess;
+	bool df;
 };
 
 struct instruction {
@@ -43,7 +38,7 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
-	struct insn_state state;
+	struct cfi_state cfi;
 	struct orc_entry orc;
 };
 
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -16,10 +16,10 @@ int create_orc(struct objtool_file *file
 
 	for_each_insn(file, insn) {
 		struct orc_entry *orc = &insn->orc;
-		struct cfi_reg *cfa = &insn->state.cfa;
-		struct cfi_reg *bp = &insn->state.regs[CFI_BP];
+		struct cfi_reg *cfa = &insn->cfi.cfa;
+		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
 
-		orc->end = insn->state.end;
+		orc->end = insn->cfi.end;
 
 		if (cfa->base == CFI_UNDEFINED) {
 			orc->sp_reg = ORC_REG_UNDEFINED;
@@ -75,7 +75,7 @@ int create_orc(struct objtool_file *file
 
 		orc->sp_offset = cfa->offset;
 		orc->bp_offset = bp->offset;
-		orc->type = insn->state.type;
+		orc->type = insn->cfi.type;
 	}
 
 	return 0;
