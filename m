Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1156C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799E521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZC2izyE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634003AbgDPLwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506677AbgDPLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1FC0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=J+ItDG3Bwa1Lu5WWwGn/oZb48sqtrONiCiC7apqqtPU=; b=ZC2izyE6R56afJo+1wjt1NrIG/
        M7HSDmuy5FFUwm+JWkXAWM3YDNq35Gy2EOMLltJeWVGIEsiGkidtrPsBGcIdX68osU5CcYlx3uSmx
        rWaOkbYCcAUJYN1q21zUCmCgbwVUkPd4zD6vI810spu2/Clhw/nkP03JyPOD63upFrNNONUFDM/dq
        l1aFRGaz878g2QmyRDc4+0jcDrNAlSnjaLh3j3m3hHiGVzjabaCk5JFwazTWUIS+ZTLHxDtXy/PCa
        fSQrHovgisID70unNfEHgO8oajrK3K3DJL1p1jvXPCB6uKFj6TzxHXpAz6lIXhs/wgfMWD767hgjC
        bTIfLzVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0004sE-PZ; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D15E3074A7;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3E5542B0DE4C9; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.045821071@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 09/17] objtool: Fix !CFI insn_state propagation
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool keeps per instruction CFI state in struct insn_state and will
save/restore this where required. However, insn_state has grown some
!CFI state, and this must not be saved/restored (that would
loose/destroy state).

Fix this by moving the CFI specific parts of insn_state into struct
cfi_state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/cfi.h     |   12 ++
 tools/objtool/check.c   |  264 ++++++++++++++++++++++++------------------------
 tools/objtool/check.h   |   13 --
 tools/objtool/orc_gen.c |    8 -
 4 files changed, 157 insertions(+), 140 deletions(-)

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
@@ -261,7 +266,7 @@ static int decode_instructions(struct ob
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			clear_insn_state(&insn->state);
+			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -754,7 +759,7 @@ static int handle_group_alt(struct objto
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
 		INIT_LIST_HEAD(&fake_jump->stack_ops);
-		clear_insn_state(&fake_jump->state);
+		init_cfi_state(&fake_jump->cfi);
 
 		fake_jump->sec = special_alt->new_sec;
 		fake_jump->offset = FAKE_JUMP_OFFSET;
@@ -1244,7 +1249,7 @@ static int read_unwind_hints(struct objt
 			return -1;
 		}
 
-		cfa = &insn->state.cfa;
+		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
 			insn->ret_offset = hint->sp_offset;
@@ -1285,8 +1290,8 @@ static int read_unwind_hints(struct objt
 		}
 
 		cfa->offset = hint->sp_offset;
-		insn->state.type = hint->type;
-		insn->state.end = hint->end;
+		insn->cfi.type = hint->type;
+		insn->cfi.end = hint->end;
 	}
 
 	return 0;
@@ -1414,20 +1419,21 @@ static bool is_fentry_call(struct instru
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
 
@@ -1436,21 +1442,23 @@ static bool has_modified_stack_frame(str
 
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
@@ -1471,20 +1479,19 @@ static int update_insn_state_regs(struct
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
@@ -1540,11 +1547,11 @@ static void restore_reg(struct insn_stat
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
@@ -1555,8 +1562,8 @@ static int update_insn_state(struct inst
 		return 0;
 	}
 
-	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state, op);
+	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
+		return update_cfi_state_regs(insn, cfi, op);
 
 	switch (op->dest.type) {
 
@@ -1571,16 +1578,16 @@ static int update_insn_state(struct inst
 
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
@@ -1595,8 +1602,8 @@ static int update_insn_state(struct inst
 				 *   ...
 				 *   mov    %rax, %rsp
 				 */
-				state->vals[op->dest.reg].base = CFI_CFA;
-				state->vals[op->dest.reg].offset = -state->stack_size;
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = -cfi->stack_size;
 			}
 
 			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
@@ -1607,14 +1614,14 @@ static int update_insn_state(struct inst
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
@@ -1624,8 +1631,8 @@ static int update_insn_state(struct inst
 					 *   ...
 					 *   mov    %rcx, %rsp
 					 */
-					cfa->offset = -state->vals[op->src.reg].offset;
-					state->stack_size = cfa->offset;
+					cfa->offset = -cfi->vals[op->src.reg].offset;
+					cfi->stack_size = cfa->offset;
 
 				} else {
 					cfa->base = CFI_UNDEFINED;
@@ -1639,7 +1646,7 @@ static int update_insn_state(struct inst
 			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
 
 				/* add imm, %rsp */
-				state->stack_size -= op->src.offset;
+				cfi->stack_size -= op->src.offset;
 				if (cfa->base == CFI_SP)
 					cfa->offset -= op->src.offset;
 				break;
@@ -1648,14 +1655,14 @@ static int update_insn_state(struct inst
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
@@ -1667,25 +1674,25 @@ static int update_insn_state(struct inst
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
@@ -1695,18 +1702,18 @@ static int update_insn_state(struct inst
 
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
@@ -1718,57 +1725,57 @@ static int update_insn_state(struct inst
 
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
@@ -1783,78 +1790,78 @@ static int update_insn_state(struct inst
 
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
@@ -1862,10 +1869,10 @@ static int update_insn_state(struct inst
 
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
@@ -1880,7 +1887,7 @@ static int update_insn_state(struct inst
 		}
 
 		/* pop mem */
-		state->stack_size -= 8;
+		cfi->stack_size -= 8;
 		if (cfa->base == CFI_SP)
 			cfa->offset -= 8;
 
@@ -1902,7 +1909,7 @@ static int handle_insn_ops(struct instru
 	list_for_each_entry(op, &insn->stack_ops, list) {
 		int res;
 
-		res = update_insn_state(insn, state, op);
+		res = update_cfi_state(insn, &state->cfi, op);
 		if (res)
 			return res;
 
@@ -1931,41 +1938,44 @@ static int handle_insn_ops(struct instru
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
@@ -2043,7 +2053,7 @@ static int validate_return(struct symbol
 		return 1;
 	}
 
-	if (state->bp_scratch) {
+	if (state->cfi.bp_scratch) {
 		WARN_FUNC("BP used as a scratch register",
 			  insn->sec, insn->offset);
 		return 1;
@@ -2092,7 +2102,7 @@ static int validate_branch(struct objtoo
 
 		visited = 1 << state.uaccess;
 		if (insn->visited) {
-			if (!insn->hint && !insn_state_match(insn, &state))
+			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
 				return 1;
 
 			if (insn->visited & visited)
@@ -2100,9 +2110,9 @@ static int validate_branch(struct objtoo
 		}
 
 		if (insn->hint)
-			state = insn->state;
+			state.cfi = insn->cfi;
 		else
-			insn->state = state;
+			insn->cfi = state.cfi;
 
 		insn->visited |= visited;
 
@@ -2255,7 +2265,7 @@ static int validate_branch(struct objtoo
 			return 0;
 
 		if (!next_insn) {
-			if (state.cfa.base == CFI_UNDEFINED)
+			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
@@ -2408,10 +2418,10 @@ static int validate_section(struct objto
 
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
@@ -45,7 +40,7 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
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


