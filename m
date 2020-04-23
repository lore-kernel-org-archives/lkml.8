Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F4C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6153E21582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgDWHuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgDWHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C3C08ED7D;
        Thu, 23 Apr 2020 00:49:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcC-0008QC-D2; Thu, 23 Apr 2020 09:49:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E0DA91C0450;
        Thu, 23 Apr 2020 09:49:42 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:42 -0000
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support multiple stack_op per instruction
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327152847.15294-11-jthierry@redhat.com>
References: <20200327152847.15294-11-jthierry@redhat.com>
MIME-Version: 1.0
Message-ID: <158762818246.28353.13419513995701103731.tip-bot2@tip-bot2>
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

Commit-ID:     65ea47dcf4f936987a5fbf839c97acea00f4f196
Gitweb:        https://git.kernel.org/tip/65ea47dcf4f936987a5fbf839c97acea00f4f196
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 27 Mar 2020 15:28:47 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:50 +02:00

objtool: Support multiple stack_op per instruction

Instruction sets can include more or less complex operations which might
not fit the currently defined set of stack_ops.

Combining more than one stack_op provides more flexibility to describe
the behaviour of an instruction. This also reduces the need to define
new stack_ops specific to a single instruction set.

Allow instruction decoders to generate multiple stack_op per
instruction.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200327152847.15294-11-jthierry@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/arch.h            |  4 +-
 tools/objtool/arch/x86/decode.c | 13 +++++-
 tools/objtool/check.c           | 74 +++++++++++++++++++-------------
 tools/objtool/check.h           |  2 +-
 4 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index a9a50a2..f9883c4 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -64,6 +64,7 @@ struct op_src {
 struct stack_op {
 	struct op_dest dest;
 	struct op_src src;
+	struct list_head list;
 };
 
 struct instruction;
@@ -73,7 +74,8 @@ void arch_initial_func_cfi_state(struct cfi_state *state);
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate, struct stack_op *op);
+			    unsigned long *immediate,
+			    struct list_head *ops_list);
 
 bool arch_callee_saved_reg(unsigned char reg);
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 7ce8650..199b408 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -80,13 +80,15 @@ unsigned long arch_jump_destination(struct instruction *insn)
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate, struct stack_op *op)
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
 {
 	struct insn insn;
 	int x86_64, sign;
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
+	struct stack_op *op;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -127,6 +129,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	if (insn.sib.nbytes)
 		sib = insn.sib.bytes[0];
 
+	op = calloc(1, sizeof(*op));
+	if (!op)
+		return -1;
+
 	switch (op1) {
 
 	case 0x1:
@@ -488,6 +494,11 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
+	if (*type == INSN_STACK)
+		list_add_tail(&op->list, ops_list);
+	else
+		free(op);
+
 	return 0;
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e06a891..9e854fd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -260,6 +260,7 @@ static int decode_instructions(struct objtool_file *file)
 			}
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
+			INIT_LIST_HEAD(&insn->stack_ops);
 			clear_insn_state(&insn->state);
 
 			insn->sec = sec;
@@ -269,7 +270,7 @@ static int decode_instructions(struct objtool_file *file)
 						      sec->len - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
-						      &insn->stack_op);
+						      &insn->stack_ops);
 			if (ret)
 				goto err;
 
@@ -754,6 +755,7 @@ static int handle_group_alt(struct objtool_file *file,
 		}
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
+		INIT_LIST_HEAD(&fake_jump->stack_ops);
 		clear_insn_state(&fake_jump->state);
 
 		fake_jump->sec = special_alt->new_sec;
@@ -1452,10 +1454,11 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }
 
-static int update_insn_state_regs(struct instruction *insn, struct insn_state *state)
+static int update_insn_state_regs(struct instruction *insn,
+				  struct insn_state *state,
+				  struct stack_op *op)
 {
 	struct cfi_reg *cfa = &state->cfa;
-	struct stack_op *op = &insn->stack_op;
 
 	if (cfa->base != CFI_SP)
 		return 0;
@@ -1545,9 +1548,9 @@ static void restore_reg(struct insn_state *state, unsigned char reg)
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_insn_state(struct instruction *insn, struct insn_state *state)
+static int update_insn_state(struct instruction *insn, struct insn_state *state,
+			     struct stack_op *op)
 {
-	struct stack_op *op = &insn->stack_op;
 	struct cfi_reg *cfa = &state->cfa;
 	struct cfi_reg *regs = state->regs;
 
@@ -1561,7 +1564,7 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	}
 
 	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state);
+		return update_insn_state_regs(insn, state, op);
 
 	switch (op->dest.type) {
 
@@ -1898,6 +1901,42 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	return 0;
 }
 
+static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+{
+	struct stack_op *op;
+
+	list_for_each_entry(op, &insn->stack_ops, list) {
+		int res;
+
+		res = update_insn_state(insn, state, op);
+		if (res)
+			return res;
+
+		if (op->dest.type == OP_DEST_PUSHF) {
+			if (!state->uaccess_stack) {
+				state->uaccess_stack = 1;
+			} else if (state->uaccess_stack >> 31) {
+				WARN_FUNC("PUSHF stack exhausted",
+					  insn->sec, insn->offset);
+				return 1;
+			}
+			state->uaccess_stack <<= 1;
+			state->uaccess_stack  |= state->uaccess;
+		}
+
+		if (op->src.type == OP_SRC_POPF) {
+			if (state->uaccess_stack) {
+				state->uaccess = state->uaccess_stack & 1;
+				state->uaccess_stack >>= 1;
+				if (state->uaccess_stack == 1)
+					state->uaccess_stack = 0;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static bool insn_state_match(struct instruction *insn, struct insn_state *state)
 {
 	struct insn_state *state1 = &insn->state, *state2 = state;
@@ -2198,29 +2237,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STACK:
-			if (update_insn_state(insn, &state))
+			if (handle_insn_ops(insn, &state))
 				return 1;
-
-			if (insn->stack_op.dest.type == OP_DEST_PUSHF) {
-				if (!state.uaccess_stack) {
-					state.uaccess_stack = 1;
-				} else if (state.uaccess_stack >> 31) {
-					WARN_FUNC("PUSHF stack exhausted", sec, insn->offset);
-					return 1;
-				}
-				state.uaccess_stack <<= 1;
-				state.uaccess_stack  |= state.uaccess;
-			}
-
-			if (insn->stack_op.src.type == OP_SRC_POPF) {
-				if (state.uaccess_stack) {
-					state.uaccess = state.uaccess_stack & 1;
-					state.uaccess_stack >>= 1;
-					if (state.uaccess_stack == 1)
-						state.uaccess_stack = 0;
-				}
-			}
-
 			break;
 
 		case INSN_STAC:
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index f0ce8ff..2c55f75 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -42,7 +42,7 @@ struct instruction {
 	struct rela *jump_table;
 	struct list_head alts;
 	struct symbol *func;
-	struct stack_op stack_op;
+	struct list_head stack_ops;
 	struct insn_state state;
 	struct orc_entry orc;
 };
