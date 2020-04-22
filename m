Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F228320857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgDVWZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgDVWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A189EC03C1AC;
        Wed, 22 Apr 2020 15:24:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnI-0001Md-Cg; Thu, 23 Apr 2020 00:24:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5856D1C047B;
        Thu, 23 Apr 2020 00:24:34 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:33 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix !CFI insn_state propagation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.045821071@infradead.org>
References: <20200416115119.045821071@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427379.28353.14722376643450815266.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4b6c0589e3938b6b09a16c29ab42d63d667f23b1
Gitweb:        https://git.kernel.org/tip/4b6c0589e3938b6b09a16c29ab42d63d667f23b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 25 Mar 2020 14:04:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:07 +02:00

objtool: Fix !CFI insn_state propagation

Objtool keeps per instruction CFI state in struct insn_state and will
save/restore this where required. However, insn_state has grown some
!CFI state, and this must not be saved/restored (that would
loose/destroy state).

Fix this by moving the CFI specific parts of insn_state into struct
cfi_state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.045821071@infradead.org
---
 tools/objtool/cfi.h     |  12 ++-
 tools/objtool/check.c   | 264 ++++++++++++++++++++-------------------
 tools/objtool/check.h   |  13 +--
 tools/objtool/orc_gen.c |   8 +-
 4 files changed, 157 insertions(+), 140 deletions(-)

diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index 6faf976..c7c59c6 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -19,8 +19,20 @@ struct cfi_reg {
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8bc525f..7e67b3c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -215,18 +215,23 @@ static bool dead_end_function(struct objtool_file *file, struct symbol *func)
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
@@ -261,7 +266,7 @@ static int decode_instructions(struct objtool_file *file)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			clear_insn_state(&insn->state);
+			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -772,7 +777,7 @@ static int handle_group_alt(struct objtool_file *file,
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
 		INIT_LIST_HEAD(&fake_jump->stack_ops);
-		clear_insn_state(&fake_jump->state);
+		init_cfi_state(&fake_jump->cfi);
 
 		fake_jump->sec = special_alt->new_sec;
 		fake_jump->offset = FAKE_JUMP_OFFSET;
@@ -1268,7 +1273,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa = &insn->state.cfa;
+		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
 			insn->ret_offset = hint->sp_offset;
@@ -1309,8 +1314,8 @@ static int read_unwind_hints(struct objtool_file *file)
 		}
 
 		cfa->offset = hint->sp_offset;
-		insn->state.type = hint->type;
-		insn->state.end = hint->end;
+		insn->cfi.type = hint->type;
+		insn->cfi.end = hint->end;
 	}
 
 	return 0;
@@ -1438,20 +1443,21 @@ static bool is_fentry_call(struct instruction *insn)
 static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
 	u8 ret_offset = insn->ret_offset;
+	struct cfi_state *cfi = &state->cfi;
 	int i;
 
-	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
+	if (cfi->cfa.base != initial_func_cfi.cfa.base || cfi->drap)
 		return true;
 
-	if (state->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
+	if (cfi->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
-	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
+	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
 	for (i = 0; i < CFI_NUM_REGS; i++) {
-		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
-		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
+		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
+		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
 	}
 
@@ -1460,21 +1466,23 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 
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
 
-static int update_insn_state_regs(struct instruction *insn,
-				  struct insn_state *state,
+static int update_cfi_state_regs(struct instruction *insn,
+				  struct cfi_state *cfi,
 				  struct stack_op *op)
 {
-	struct cfi_reg *cfa = &state->cfa;
+	struct cfi_reg *cfa = &cfi->cfa;
 
 	if (cfa->base != CFI_SP)
 		return 0;
@@ -1495,20 +1503,19 @@ static int update_insn_state_regs(struct instruction *insn,
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
-	state->regs[reg].base = initial_func_cfi.regs[reg].base;
-	state->regs[reg].offset = initial_func_cfi.regs[reg].offset;
+	cfi->regs[reg].base = initial_func_cfi.regs[reg].base;
+	cfi->regs[reg].offset = initial_func_cfi.regs[reg].offset;
 }
 
 /*
@@ -1564,11 +1571,11 @@ static void restore_reg(struct insn_state *state, unsigned char reg)
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_insn_state(struct instruction *insn, struct insn_state *state,
+static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			     struct stack_op *op)
 {
-	struct cfi_reg *cfa = &state->cfa;
-	struct cfi_reg *regs = state->regs;
+	struct cfi_reg *cfa = &cfi->cfa;
+	struct cfi_reg *regs = cfi->regs;
 
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
@@ -1579,8 +1586,8 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 		return 0;
 	}
 
-	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state, op);
+	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
+		return update_cfi_state_regs(insn, cfi, op);
 
 	switch (op->dest.type) {
 
@@ -1595,16 +1602,16 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 
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
@@ -1619,8 +1626,8 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 				 *   ...
 				 *   mov    %rax, %rsp
 				 */
-				state->vals[op->dest.reg].base = CFI_CFA;
-				state->vals[op->dest.reg].offset = -state->stack_size;
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = -cfi->stack_size;
 			}
 
 			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
@@ -1631,14 +1638,14 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
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
@@ -1648,8 +1655,8 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 					 *   ...
 					 *   mov    %rcx, %rsp
 					 */
-					cfa->offset = -state->vals[op->src.reg].offset;
-					state->stack_size = cfa->offset;
+					cfa->offset = -cfi->vals[op->src.reg].offset;
+					cfi->stack_size = cfa->offset;
 
 				} else {
 					cfa->base = CFI_UNDEFINED;
@@ -1663,7 +1670,7 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
 
 				/* add imm, %rsp */
-				state->stack_size -= op->src.offset;
+				cfi->stack_size -= op->src.offset;
 				if (cfa->base == CFI_SP)
 					cfa->offset -= op->src.offset;
 				break;
@@ -1672,14 +1679,14 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
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
@@ -1691,25 +1698,25 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
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
@@ -1719,18 +1726,18 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 
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
@@ -1742,55 +1749,55 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
-			if (!state->drap && op->dest.reg == cfa->base) {
+			if (!cfi->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
 				cfa->base = CFI_SP;
 			}
 
-			if (state->drap && cfa->base == CFI_BP_INDIRECT &&
-			    op->dest.reg == state->drap_reg &&
-			    state->drap_offset == -state->stack_size) {
+			if (cfi->drap && cfa->base == CFI_BP_INDIRECT &&
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
@@ -1805,78 +1812,78 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 
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
@@ -1884,10 +1891,10 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 
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
@@ -1902,7 +1909,7 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state,
 		}
 
 		/* pop mem */
-		state->stack_size -= 8;
+		cfi->stack_size -= 8;
 		if (cfa->base == CFI_SP)
 			cfa->offset -= 8;
 
@@ -1924,7 +1931,7 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 	list_for_each_entry(op, &insn->stack_ops, list) {
 		int res;
 
-		res = update_insn_state(insn, state, op);
+		res = update_cfi_state(insn, &state->cfi, op);
 		if (res)
 			return res;
 
@@ -1953,41 +1960,44 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
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
@@ -2065,7 +2075,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
-	if (state->bp_scratch) {
+	if (state->cfi.bp_scratch) {
 		WARN_FUNC("BP used as a scratch register",
 			  insn->sec, insn->offset);
 		return 1;
@@ -2114,7 +2124,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		visited = 1 << state.uaccess;
 		if (insn->visited) {
-			if (!insn->hint && !insn_state_match(insn, &state))
+			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
 				return 1;
 
 			if (insn->visited & visited)
@@ -2122,9 +2132,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		}
 
 		if (insn->hint)
-			state = insn->state;
+			state.cfi = insn->cfi;
 		else
-			insn->state = state;
+			insn->cfi = state.cfi;
 
 		insn->visited |= visited;
 
@@ -2277,7 +2287,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		if (!next_insn) {
-			if (state.cfa.base == CFI_UNDEFINED)
+			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
@@ -2446,10 +2456,10 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 			continue;
 
 		clear_insn_state(&state);
-		state.cfa = initial_func_cfi.cfa;
-		memcpy(&state.regs, &initial_func_cfi.regs,
+		state.cfi.cfa = initial_func_cfi.cfa;
+		memcpy(&state.cfi.regs, &initial_func_cfi.regs,
 		       CFI_NUM_REGS * sizeof(struct cfi_reg));
-		state.stack_size = initial_func_cfi.cfa.offset;
+		state.cfi.stack_size = initial_func_cfi.cfa.offset;
 
 		state.uaccess = func->uaccess_safe;
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 7c30760..99413d4 100644
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
@@ -45,7 +40,7 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
-	struct insn_state state;
+	struct cfi_state cfi;
 	struct orc_entry orc;
 };
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 4c0dabd..2cf640f 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -16,10 +16,10 @@ int create_orc(struct objtool_file *file)
 
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
@@ -75,7 +75,7 @@ int create_orc(struct objtool_file *file)
 
 		orc->sp_offset = cfa->offset;
 		orc->bp_offset = bp->offset;
-		orc->type = insn->state.type;
+		orc->type = insn->cfi.type;
 	}
 
 	return 0;
