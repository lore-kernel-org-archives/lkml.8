Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170AC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DB724968
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgEASXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730706AbgEASWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753EFC08E859;
        Fri,  1 May 2020 11:22:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIp-0003fh-L6; Fri, 01 May 2020 20:22:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B89461C0330;
        Fri,  1 May 2020 20:22:21 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:21 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rework allocating stack_ops on decode
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191659.736151601@infradead.org>
References: <20200428191659.736151601@infradead.org>
MIME-Version: 1.0
Message-ID: <158835734169.8414.14694139621609463708.tip-bot2@tip-bot2>
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

Commit-ID:     7d989fcadd6e225a61d6490dd15bdbdfc8a53d5c
Gitweb:        https://git.kernel.org/tip/7d989fcadd6e225a61d6490dd15bdbdfc8a53d5c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Apr 2020 13:22:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:32 +02:00

objtool: Rework allocating stack_ops on decode

Wrap each stack_op in a macro that allocates and adds it to the list.
This simplifies trying to figure out what to do with the pre-allocated
stack_op at the end.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191659.736151601@infradead.org
---
 tools/objtool/arch/x86/decode.c | 251 ++++++++++++++++++-------------
 1 file changed, 147 insertions(+), 104 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c45a0b4..97e66c7 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -77,6 +77,11 @@ unsigned long arch_jump_destination(struct instruction *insn)
 	return insn->offset + insn->len + insn->immediate;
 }
 
+#define ADD_OP(op) \
+	if (!(op = calloc(1, sizeof(*op)))) \
+		return -1; \
+	else for (list_add_tail(&op->list, ops_list); op; op = NULL)
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -88,7 +93,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
-	struct stack_op *op;
+	struct stack_op *op = NULL;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -129,10 +134,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	if (insn.sib.nbytes)
 		sib = insn.sib.bytes[0];
 
-	op = calloc(1, sizeof(*op));
-	if (!op)
-		return -1;
-
 	switch (op1) {
 
 	case 0x1:
@@ -141,10 +142,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* add/sub reg, %rsp */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
 		}
 		break;
 
@@ -152,9 +155,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		/* push reg */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_REG;
-		op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
-		op->dest.type = OP_DEST_PUSH;
+		ADD_OP(op) {
+			op->src.type = OP_SRC_REG;
+			op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+			op->dest.type = OP_DEST_PUSH;
+		}
 
 		break;
 
@@ -162,9 +167,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		/* pop reg */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_POP;
-		op->dest.type = OP_DEST_REG;
-		op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+		ADD_OP(op) {
+			op->src.type = OP_SRC_POP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+		}
 
 		break;
 
@@ -172,8 +179,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x6a:
 		/* push immediate */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_CONST;
-		op->dest.type = OP_DEST_PUSH;
+		ADD_OP(op) {
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSH;
+		}
 		break;
 
 	case 0x70 ... 0x7f:
@@ -188,11 +197,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (modrm == 0xe4) {
 			/* and imm, %rsp */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_AND;
-			op->src.reg = CFI_SP;
-			op->src.offset = insn.immediate.value;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_AND;
+				op->src.reg = CFI_SP;
+				op->src.offset = insn.immediate.value;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
 			break;
 		}
 
@@ -205,11 +216,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		/* add/sub imm, %rsp */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_ADD;
-		op->src.reg = CFI_SP;
-		op->src.offset = insn.immediate.value * sign;
-		op->dest.type = OP_DEST_REG;
-		op->dest.reg = CFI_SP;
+		ADD_OP(op) {
+			op->src.type = OP_SRC_ADD;
+			op->src.reg = CFI_SP;
+			op->src.offset = insn.immediate.value * sign;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+		}
 		break;
 
 	case 0x89:
@@ -217,10 +230,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* mov %rsp, reg */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_REG;
-			op->src.reg = CFI_SP;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = CFI_SP;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			}
 			break;
 		}
 
@@ -228,10 +243,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* mov reg, %rsp */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_REG;
-			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
 			break;
 		}
 
@@ -242,21 +259,25 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* mov reg, disp(%rbp) */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_REG;
-			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
-			op->dest.type = OP_DEST_REG_INDIRECT;
-			op->dest.reg = CFI_BP;
-			op->dest.offset = insn.displacement.value;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.type = OP_DEST_REG_INDIRECT;
+				op->dest.reg = CFI_BP;
+				op->dest.offset = insn.displacement.value;
+			}
 
 		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_REG;
-			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
-			op->dest.type = OP_DEST_REG_INDIRECT;
-			op->dest.reg = CFI_SP;
-			op->dest.offset = insn.displacement.value;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.type = OP_DEST_REG_INDIRECT;
+				op->dest.reg = CFI_SP;
+				op->dest.offset = insn.displacement.value;
+			}
 		}
 
 		break;
@@ -266,22 +287,26 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* mov disp(%rbp), reg */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_REG_INDIRECT;
-			op->src.reg = CFI_BP;
-			op->src.offset = insn.displacement.value;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG_INDIRECT;
+				op->src.reg = CFI_BP;
+				op->src.offset = insn.displacement.value;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			}
 
 		} else if (rex_w && !rex_b && sib == 0x24 &&
 			   modrm_mod != 3 && modrm_rm == 4) {
 
 			/* mov disp(%rsp), reg */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_REG_INDIRECT;
-			op->src.reg = CFI_SP;
-			op->src.offset = insn.displacement.value;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG_INDIRECT;
+				op->src.reg = CFI_SP;
+				op->src.offset = insn.displacement.value;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			}
 		}
 
 		break;
@@ -290,27 +315,31 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
 
 			*type = INSN_STACK;
-			if (!insn.displacement.value) {
-				/* lea (%rsp), reg */
-				op->src.type = OP_SRC_REG;
-			} else {
-				/* lea disp(%rsp), reg */
-				op->src.type = OP_SRC_ADD;
-				op->src.offset = insn.displacement.value;
+			ADD_OP(op) {
+				if (!insn.displacement.value) {
+					/* lea (%rsp), reg */
+					op->src.type = OP_SRC_REG;
+				} else {
+					/* lea disp(%rsp), reg */
+					op->src.type = OP_SRC_ADD;
+					op->src.offset = insn.displacement.value;
+				}
+				op->src.reg = CFI_SP;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
 			}
-			op->src.reg = CFI_SP;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
 
 		} else if (rex == 0x48 && modrm == 0x65) {
 
 			/* lea disp(%rbp), %rsp */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_BP;
-			op->src.offset = insn.displacement.value;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_BP;
+				op->src.offset = insn.displacement.value;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
 
 		} else if (rex == 0x49 && modrm == 0x62 &&
 			   insn.displacement.value == -8) {
@@ -322,11 +351,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			 * stack realignment.
 			 */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_R10;
-			op->src.offset = -8;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_R10;
+				op->src.offset = -8;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
 
 		} else if (rex == 0x49 && modrm == 0x65 &&
 			   insn.displacement.value == -16) {
@@ -338,11 +369,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			 * stack realignment.
 			 */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_R13;
-			op->src.offset = -16;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_R13;
+				op->src.offset = -16;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
 		}
 
 		break;
@@ -350,8 +383,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x8f:
 		/* pop to mem */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_POP;
-		op->dest.type = OP_DEST_MEM;
+		ADD_OP(op) {
+			op->src.type = OP_SRC_POP;
+			op->dest.type = OP_DEST_MEM;
+		}
 		break;
 
 	case 0x90:
@@ -361,15 +396,19 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0x9c:
 		/* pushf */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_CONST;
-		op->dest.type = OP_DEST_PUSHF;
+		ADD_OP(op) {
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSHF;
+		}
 		break;
 
 	case 0x9d:
 		/* popf */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_POPF;
-		op->dest.type = OP_DEST_MEM;
+		ADD_OP(op) {
+			op->src.type = OP_SRC_POPF;
+			op->dest.type = OP_DEST_MEM;
+		}
 		break;
 
 	case 0x0f:
@@ -405,15 +444,19 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* push fs/gs */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_CONST;
-			op->dest.type = OP_DEST_PUSH;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_CONST;
+				op->dest.type = OP_DEST_PUSH;
+			}
 
 		} else if (op2 == 0xa1 || op2 == 0xa9) {
 
 			/* pop fs/gs */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_POP;
-			op->dest.type = OP_DEST_MEM;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_POP;
+				op->dest.type = OP_DEST_MEM;
+			}
 		}
 
 		break;
@@ -427,7 +470,8 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		 * pop bp
 		 */
 		*type = INSN_STACK;
-		op->dest.type = OP_DEST_LEAVE;
+		ADD_OP(op)
+			op->dest.type = OP_DEST_LEAVE;
 
 		break;
 
@@ -449,12 +493,14 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case 0xcf: /* iret */
 		*type = INSN_EXCEPTION_RETURN;
 
-		/* add $40, %rsp */
-		op->src.type = OP_SRC_ADD;
-		op->src.reg = CFI_SP;
-		op->src.offset = 5*8;
-		op->dest.type = OP_DEST_REG;
-		op->dest.reg = CFI_SP;
+		ADD_OP(op) {
+			/* add $40, %rsp */
+			op->src.type = OP_SRC_ADD;
+			op->src.reg = CFI_SP;
+			op->src.offset = 5*8;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+		}
 		break;
 
 	case 0xca: /* retf */
@@ -492,8 +538,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 			/* push from mem */
 			*type = INSN_STACK;
-			op->src.type = OP_SRC_CONST;
-			op->dest.type = OP_DEST_PUSH;
+			ADD_OP(op) {
+				op->src.type = OP_SRC_CONST;
+				op->dest.type = OP_DEST_PUSH;
+			}
 		}
 
 		break;
@@ -504,11 +552,6 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
-		list_add_tail(&op->list, ops_list);
-	else
-		free(op);
-
 	return 0;
 }
 
