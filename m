Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262D3C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6A820714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOZHQjvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgCYImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59727 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727527AbgCYIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWdnVIjIIs6bsYC8vxrVMFfC7V2vIeBCBdn+/rAvvOI=;
        b=BOZHQjvtwDQCXKTtmBrUlYhAT04DXAsGpvHpkOYp85Om3W5YLdv7CPe9Fndn4nnJyno4Se
        B8Ow7b8ERreflYUoxem1fgy6pez3cKMYyv+MiVZ4dLRu6+U+RMaBd32RX+Le7FvJasQORc
        Jy/cVlud42/oBU+2KYM0UwjwByKlXww=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-T7JKPRwfP82ja-_3lA2u9Q-1; Wed, 25 Mar 2020 04:42:25 -0400
X-MC-Unique: T7JKPRwfP82ja-_3lA2u9Q-1
Received: by mail-wm1-f69.google.com with SMTP id w12so408709wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWdnVIjIIs6bsYC8vxrVMFfC7V2vIeBCBdn+/rAvvOI=;
        b=SKv04Q2UkkBHex8erG8cSd69EHKKJ0yhv8Q80YJGT8d16VgRJ6hjV0s6HyplPUyG7Z
         Xn+HCFZP57EEqHYXBxLU3G7+RDiBMNCFXtDvjKHs285nzo9M4JoaQGaMnmSK7bRlbQqe
         DAtKiPx4NdN+NunZzzPDlazwxVNls+PqG45D5ETpytyA4TkI/EZd99X5XidXgySQ3a9h
         8rH1lW8Rgnhdhp7GLMpcQYNkQ834or/BrWpZ2Iqxc/6SIkpoo9IZuaNigpPXu2KF//+u
         p6E8/7mzkq4tO8/1egt0rDrAiZzhnhBrkZYUCS0EQHkL3xx9Dc/qGCyp0gLFGo4Ke6Sv
         xaUw==
X-Gm-Message-State: ANhLgQ2+ZOhzfUDaXcyJWwzdo9s0kGYNnsjMeX+1av0Utw2/GOje6u9/
        UE9tyW2EYqOSrm5y5uEbPYhVXwasTmHQf66UYylMYqxHR8ykVE7TKb9OpEdimt7NvEwQ8G1Fr0Y
        DB0deOybOgn8eNzjnFnQ3omIv
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr2287873wmc.15.1585125743851;
        Wed, 25 Mar 2020 01:42:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtR2IjSfQaYo7hsd0L3utdaxmq7SXQr1DHTHqgsWrjrMAKIcOcIh/A4EsEhNUpolnhea8zX0Q==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr2287848wmc.15.1585125743522;
        Wed, 25 Mar 2020 01:42:23 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:22 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 10/10] objtool: Support multiple stack_op per instruction
Date:   Wed, 25 Mar 2020 08:42:03 +0000
Message-Id: <20200325084203.17005-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
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
 tools/objtool/check.c           | 79 +++++++++++++++++++++------------
 tools/objtool/check.h           |  2 +-
 4 files changed, 67 insertions(+), 31 deletions(-)

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
index 7b80a4a6e53d..592fbebf234a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -259,6 +259,7 @@ static int decode_instructions(struct objtool_file *file)
 			}
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
+			INIT_LIST_HEAD(&insn->stack_ops);
 			clear_insn_state(&insn->state);
 
 			insn->sec = sec;
@@ -268,7 +269,7 @@ static int decode_instructions(struct objtool_file *file)
 						      sec->len - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
-						      &insn->stack_op);
+						      &insn->stack_ops);
 			if (ret)
 				goto err;
 
@@ -770,6 +771,7 @@ static int handle_group_alt(struct objtool_file *file,
 		}
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
+		INIT_LIST_HEAD(&fake_jump->stack_ops);
 		clear_insn_state(&fake_jump->state);
 
 		fake_jump->sec = special_alt->new_sec;
@@ -1472,10 +1474,11 @@ static bool has_valid_stack_frame(struct insn_state *state)
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
@@ -1565,9 +1568,9 @@ static void restore_reg(struct insn_state *state, unsigned char reg)
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
 
@@ -1581,7 +1584,7 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	}
 
 	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state);
+		return update_insn_state_regs(insn, state, op);
 
 	switch (op->dest.type) {
 
@@ -1918,6 +1921,42 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
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
@@ -2210,29 +2249,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
@@ -2477,12 +2495,17 @@ static void cleanup(struct objtool_file *file)
 {
 	struct instruction *insn, *tmpinsn;
 	struct alternative *alt, *tmpalt;
+	struct stack_op *op, *tmpop;
 
 	list_for_each_entry_safe(insn, tmpinsn, &file->insn_list, list) {
 		list_for_each_entry_safe(alt, tmpalt, &insn->alts, list) {
 			list_del(&alt->list);
 			free(alt);
 		}
+		list_for_each_entry_safe(op, tmpop, &insn->stack_ops, list) {
+			list_del(&op->list);
+			free(op);
+		}
 		list_del(&insn->list);
 		hash_del(&insn->hash);
 		free(insn);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 0cfdad839b76..8e9a37b1c609 100644
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

