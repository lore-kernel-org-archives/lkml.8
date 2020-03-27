Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E28C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ADE20578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QC1S8I24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgC0P32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35690 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbgC0P3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mEWeSwhR59yw9Ak8V6RZalo/Kp7qjssrQ2/0RA8kQE=;
        b=QC1S8I241sdGfzeKmnZ6htJBiNLZbdZbAqtFfLW0OqxOsvzGuazwylp0xhk7SvbKFgSmW6
        hJc5C6xq4+LmRrxB+vE6d/eyUiGXmwVzUg89IO31RzX7uNmxY0JyHQxq8NZUaZgjkavNOe
        Ef9hc8XHDrdDp5Ll4tqFTREDIcHNLGY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Ct5hiuliP1qeOEhDg4yNag-1; Fri, 27 Mar 2020 11:29:23 -0400
X-MC-Unique: Ct5hiuliP1qeOEhDg4yNag-1
Received: by mail-wr1-f71.google.com with SMTP id y1so3589454wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/mEWeSwhR59yw9Ak8V6RZalo/Kp7qjssrQ2/0RA8kQE=;
        b=X4CBsqqQYyugVOdiOxo44mY/MReXo8T2ra/Y2ZuaV+qnKSj3iAboIOcuQKKdg6N7fR
         o2Yokh6YvBaUyYJ9hzcDyUBMqnoT7JJpShjGyu9r9dT4WWaxtgOeSWHs9qxvYBUrgr2T
         yVUAv9Cdf62/H/PtaAJwxmF7s0PtSTyBG1RCgVcFvcGtoXzizncy9NweppRc4YGit5WT
         3Fr8z1NvUQYY5Jsmjx5rm6m7r2BZwGyHxpXFlsuBwsAhdeVyu0vJ8VrPLpu82apBKIDI
         OMlWTTHRCRJZ/8k0QmAy7O+bdOtfLCoD6eFWYFFA75qtRcaDFBt0JFCqSXQ36hIevJV7
         Aj1Q==
X-Gm-Message-State: ANhLgQ0QpHY/7i296PK2fKV+iezwDKKzvLIKcvE3p2UFes8QysqKukif
        HS0GxZSOWVQT8Y8Ah+2k8PXvCqB78LVred0cnJyWJXVyNd/ljejES9dilC4saiv55gvoSYtKx2Y
        yu+Pb0a6s9ZNg3NtGj8V6sLCb
X-Received: by 2002:adf:d088:: with SMTP id y8mr3526wrh.36.1585322961216;
        Fri, 27 Mar 2020 08:29:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vso9T96ctq68Z51Be1Hkx9c5NUtkarkImGuuD/l3NTlLR68LjZPrcYtr7unEOZvzpXGXwu3FA==
X-Received: by 2002:adf:d088:: with SMTP id y8mr3497wrh.36.1585322960915;
        Fri, 27 Mar 2020 08:29:20 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:18 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 10/10] objtool: Support multiple stack_op per instruction
Date:   Fri, 27 Mar 2020 15:28:47 +0000
Message-Id: <20200327152847.15294-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction sets can include more or less complex operations which might
not fit the currently defined set of stack_ops.

Combining more than one stack_op provides more flexibility to describe
the behaviour of an instruction. This also reduces the need to define
new stack_ops specific to a single instruction set.

Allow instruction decoders to generate multiple stack_op per
instruction.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h            |  4 +-
 tools/objtool/arch/x86/decode.c | 13 +++++-
 tools/objtool/check.c           | 74 ++++++++++++++++++++-------------
 tools/objtool/check.h           |  2 +-
 4 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index a9a50a25ca66..f9883c431949 100644
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
index 7ce8650cf085..199b4084a13c 100644
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
index dbfd1f5d06f7..30d916dcc2a8 100644
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
 
@@ -757,6 +758,7 @@ static int handle_group_alt(struct objtool_file *file,
 		}
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
+		INIT_LIST_HEAD(&fake_jump->stack_ops);
 		clear_insn_state(&fake_jump->state);
 
 		fake_jump->sec = special_alt->new_sec;
@@ -1459,10 +1461,11 @@ static bool has_valid_stack_frame(struct insn_state *state)
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
@@ -1552,9 +1555,9 @@ static void restore_reg(struct insn_state *state, unsigned char reg)
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
 
@@ -1568,7 +1571,7 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	}
 
 	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state);
+		return update_insn_state_regs(insn, state, op);
 
 	switch (op->dest.type) {
 
@@ -1905,6 +1908,42 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
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
@@ -2205,29 +2244,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
index d1b55961474c..1a089fc0bd23 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -43,7 +43,7 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct symbol *code_sym;
-	struct stack_op stack_op;
+	struct list_head stack_ops;
 	struct insn_state state;
 	struct orc_entry orc;
 };
-- 
2.21.1

