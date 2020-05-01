Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1177DC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7492495E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgEASX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730657AbgEASW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65245C061A0C;
        Fri,  1 May 2020 11:22:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIn-0003ez-A5; Fri, 01 May 2020 20:22:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E8C4F1C0330;
        Fri,  1 May 2020 20:22:20 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:20 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove INSN_STACK
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191659.854203028@infradead.org>
References: <20200428191659.854203028@infradead.org>
MIME-Version: 1.0
Message-ID: <158835734088.8414.16395422459790306018.tip-bot2@tip-bot2>
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

Commit-ID:     b09fb65e863733e192d4825a285b4b4998969ce0
Gitweb:        https://git.kernel.org/tip/b09fb65e863733e192d4825a285b4b4998969ce0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 24 Apr 2020 16:18:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:33 +02:00

objtool: Remove INSN_STACK

With the unconditional use of handle_insn_ops(), INSN_STACK has lost
its purpose. Remove it.

Suggested-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191659.854203028@infradead.org
---
 tools/objtool/arch.h            |  1 -
 tools/objtool/arch/x86/decode.c | 23 -----------------------
 tools/objtool/check.c           |  3 ---
 3 files changed, 27 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 445b8fa..25dd4a9 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -21,7 +21,6 @@ enum insn_type {
 	INSN_RETURN,
 	INSN_EXCEPTION_RETURN,
 	INSN_CONTEXT_SWITCH,
-	INSN_STACK,
 	INSN_BUG,
 	INSN_NOP,
 	INSN_STAC,
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 97e66c7..e26bedb 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -141,7 +141,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
 
 			/* add/sub reg, %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -154,7 +153,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x50 ... 0x57:
 
 		/* push reg */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_REG;
 			op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
@@ -166,7 +164,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x58 ... 0x5f:
 
 		/* pop reg */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_REG;
@@ -178,7 +175,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x68:
 	case 0x6a:
 		/* push immediate */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_CONST;
 			op->dest.type = OP_DEST_PUSH;
@@ -196,7 +192,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		if (modrm == 0xe4) {
 			/* and imm, %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_AND;
 				op->src.reg = CFI_SP;
@@ -215,7 +210,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 
 		/* add/sub imm, %rsp */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_ADD;
 			op->src.reg = CFI_SP;
@@ -229,7 +223,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
 
 			/* mov %rsp, reg */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = CFI_SP;
@@ -242,7 +235,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
 
 			/* mov reg, %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -258,7 +250,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		    (modrm_mod == 1 || modrm_mod == 2) && modrm_rm == 5) {
 
 			/* mov reg, disp(%rbp) */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -270,7 +261,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -286,7 +276,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (rex_w && !rex_b && modrm_mod == 1 && modrm_rm == 5) {
 
 			/* mov disp(%rbp), reg */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG_INDIRECT;
 				op->src.reg = CFI_BP;
@@ -299,7 +288,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			   modrm_mod != 3 && modrm_rm == 4) {
 
 			/* mov disp(%rsp), reg */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG_INDIRECT;
 				op->src.reg = CFI_SP;
@@ -314,7 +302,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x8d:
 		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
 
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				if (!insn.displacement.value) {
 					/* lea (%rsp), reg */
@@ -332,7 +319,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		} else if (rex == 0x48 && modrm == 0x65) {
 
 			/* lea disp(%rbp), %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = CFI_BP;
@@ -350,7 +336,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			 * Restoring rsp back to its original value after a
 			 * stack realignment.
 			 */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = CFI_R10;
@@ -368,7 +353,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			 * Restoring rsp back to its original value after a
 			 * stack realignment.
 			 */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = CFI_R13;
@@ -382,7 +366,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	case 0x8f:
 		/* pop to mem */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_MEM;
@@ -395,7 +378,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	case 0x9c:
 		/* pushf */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_CONST;
 			op->dest.type = OP_DEST_PUSHF;
@@ -404,7 +386,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	case 0x9d:
 		/* popf */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POPF;
 			op->dest.type = OP_DEST_MEM;
@@ -443,7 +424,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_CONST;
 				op->dest.type = OP_DEST_PUSH;
@@ -452,7 +432,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		} else if (op2 == 0xa1 || op2 == 0xa9) {
 
 			/* pop fs/gs */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_POP;
 				op->dest.type = OP_DEST_MEM;
@@ -469,7 +448,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		 * mov bp, sp
 		 * pop bp
 		 */
-		*type = INSN_STACK;
 		ADD_OP(op)
 			op->dest.type = OP_DEST_LEAVE;
 
@@ -537,7 +515,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		else if (modrm_reg == 6) {
 
 			/* push from mem */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_CONST;
 				op->dest.type = OP_DEST_PUSH;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6591c2d..4f3db2f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2339,9 +2339,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			}
 			return 0;
 
-		case INSN_STACK:
-			break;
-
 		case INSN_STAC:
 			if (state.uaccess) {
 				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
