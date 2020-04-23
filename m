Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE40C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F84E20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ip3RfG6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgDWMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgDWMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:52:30 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFFC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Fj0YmBpf5k6AfqGXMf2bcrKYTlTqNnVfcuIHNQRhlfQ=; b=Ip3RfG6Em/XMunxOO9B8z/dRlD
        +fhqTVPQcR3bkV1vpqb+lwwFT0+Or8OYZxgaqz48f4WQU/6klQ7YL+hMcqfTRdHNaowC4AaSVxZgH
        LPXqyG3LdJa05pHD/NAQuSWK9vyGpWUcmP0WeXNCjAsIVmSucZIL3Xxg4qL13pzHMeZ/h9HE2AL/S
        vjM5Y6ElRI0HfufFV755X9qHZZonHHe81LtFY4zqYiU2NwHr8CpCt+mq0JY0U7MuLwTmV7sXtCgkY
        86dMqL9ZvYdJ4wfjDHjMwA/LCFfEK6dDLLT59UWVTksPzTvp6vHBvR3TpbZNkWQXaDFKZ5LPaiuzN
        4aakDKYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRbKi-0007S6-RM; Thu, 23 Apr 2020 12:52:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 565DA306108;
        Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3DCAD20BE637E; Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Message-Id: <20200423125042.713052240@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 14:47:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH 3/8] objtool: Rework allocating stack_ops on decode
References: <20200423125013.452964352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap each stack_op in a macro that allocates and adds it to the list.
This simplifies trying to figure out what to do with the pre-allocated
stack_op at the end.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |  257 +++++++++++++++++++++++-----------------
 1 file changed, 153 insertions(+), 104 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -77,6 +77,17 @@ unsigned long arch_jump_destination(stru
 	return insn->offset + insn->len + insn->immediate;
 }
 
+#define PUSH_OP(op) \
+({ \
+	list_add_tail(&op->list, ops_list); \
+	NULL; \
+})
+
+#define ADD_OP(op) \
+	if (!(op = calloc(1, sizeof(*op)))) \
+		return -1; \
+	else for (; op; op = PUSH_OP(op))
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -88,7 +99,7 @@ int arch_decode_instruction(struct elf *
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
-	struct stack_op *op;
+	struct stack_op *op = NULL;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -129,10 +140,6 @@ int arch_decode_instruction(struct elf *
 	if (insn.sib.nbytes)
 		sib = insn.sib.bytes[0];
 
-	op = calloc(1, sizeof(*op));
-	if (!op)
-		return -1;
-
 	switch (op1) {
 
 	case 0x1:
@@ -141,10 +148,12 @@ int arch_decode_instruction(struct elf *
 
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
 
@@ -152,9 +161,11 @@ int arch_decode_instruction(struct elf *
 
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
 
@@ -162,9 +173,11 @@ int arch_decode_instruction(struct elf *
 
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
 
@@ -172,8 +185,10 @@ int arch_decode_instruction(struct elf *
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
@@ -188,11 +203,13 @@ int arch_decode_instruction(struct elf *
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
 
@@ -205,11 +222,13 @@ int arch_decode_instruction(struct elf *
 
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
@@ -217,10 +236,12 @@ int arch_decode_instruction(struct elf *
 
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
 
@@ -228,10 +249,12 @@ int arch_decode_instruction(struct elf *
 
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
 
@@ -242,21 +265,25 @@ int arch_decode_instruction(struct elf *
 
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
@@ -266,22 +293,26 @@ int arch_decode_instruction(struct elf *
 
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
@@ -290,27 +321,31 @@ int arch_decode_instruction(struct elf *
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
@@ -322,11 +357,13 @@ int arch_decode_instruction(struct elf *
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
@@ -338,11 +375,13 @@ int arch_decode_instruction(struct elf *
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
@@ -350,8 +389,10 @@ int arch_decode_instruction(struct elf *
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
@@ -361,15 +402,19 @@ int arch_decode_instruction(struct elf *
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
@@ -405,15 +450,19 @@ int arch_decode_instruction(struct elf *
 
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
@@ -427,7 +476,8 @@ int arch_decode_instruction(struct elf *
 		 * pop bp
 		 */
 		*type = INSN_STACK;
-		op->dest.type = OP_DEST_LEAVE;
+		ADD_OP(op)
+			op->dest.type = OP_DEST_LEAVE;
 
 		break;
 
@@ -449,12 +499,14 @@ int arch_decode_instruction(struct elf *
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
@@ -492,8 +544,10 @@ int arch_decode_instruction(struct elf *
 
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
@@ -504,11 +558,6 @@ int arch_decode_instruction(struct elf *
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
-		list_add_tail(&op->list, ops_list);
-	else
-		free(op);
-
 	return 0;
 }
 


