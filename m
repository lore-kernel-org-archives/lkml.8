Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E830C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6351B20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL1rMNkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgD1TTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728963AbgD1TTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4111BC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=57u+e2eFeEcAxZVEVzqwcWwsYUdxidMG9GSuCzHKIXg=; b=WL1rMNkUCpZZiYTaDmBFER3AbE
        sNIDghGy7bW52DEQ2lmBhPTviN7qZxFs1oHtCdpEP67q81wDCwA2IGrOpuCDWWRhXdJEYwWfn15TN
        +YAQns5MaU8U7omlVKPkaDQSC0XetVRwgxVpHMuZxJ3DYa8GOypRrxh8L2iMQLPnUIqodPIsO3Aee
        DCOge7dKKJLxOHyeQt+UKOOubQvbyLl3yN4kOhh5wInLwIrMfuZHN606XHaT4lKk04pnIrZOt3R+/
        8p6jbm5DgPVKaKqRZBqOIbo0lxNAK8zAeOC8Rx+zDu7MWLLrA+2fjuWe51ekaohpH0u/MEW8iWF1a
        GwO8OivQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlR-0007kx-Ig; Tue, 28 Apr 2020 19:19:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B11B93076E9;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8CC9725D01315; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.736151601@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 06/14] objtool: Rework allocating stack_ops on decode
References: <20200428191101.886208539@infradead.org>
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
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c |  251 +++++++++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 104 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -77,6 +77,11 @@ unsigned long arch_jump_destination(stru
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
@@ -88,7 +93,7 @@ int arch_decode_instruction(const struct
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
-	struct stack_op *op;
+	struct stack_op *op = NULL;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -129,10 +134,6 @@ int arch_decode_instruction(const struct
 	if (insn.sib.nbytes)
 		sib = insn.sib.bytes[0];
 
-	op = calloc(1, sizeof(*op));
-	if (!op)
-		return -1;
-
 	switch (op1) {
 
 	case 0x1:
@@ -141,10 +142,12 @@ int arch_decode_instruction(const struct
 
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
 
@@ -152,9 +155,11 @@ int arch_decode_instruction(const struct
 
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
 
@@ -162,9 +167,11 @@ int arch_decode_instruction(const struct
 
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
 
@@ -172,8 +179,10 @@ int arch_decode_instruction(const struct
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
@@ -188,11 +197,13 @@ int arch_decode_instruction(const struct
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
 
@@ -205,11 +216,13 @@ int arch_decode_instruction(const struct
 
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
@@ -217,10 +230,12 @@ int arch_decode_instruction(const struct
 
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
 
@@ -228,10 +243,12 @@ int arch_decode_instruction(const struct
 
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
 
@@ -242,21 +259,25 @@ int arch_decode_instruction(const struct
 
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
@@ -266,22 +287,26 @@ int arch_decode_instruction(const struct
 
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
@@ -290,27 +315,31 @@ int arch_decode_instruction(const struct
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
@@ -322,11 +351,13 @@ int arch_decode_instruction(const struct
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
@@ -338,11 +369,13 @@ int arch_decode_instruction(const struct
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
@@ -350,8 +383,10 @@ int arch_decode_instruction(const struct
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
@@ -361,15 +396,19 @@ int arch_decode_instruction(const struct
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
@@ -405,15 +444,19 @@ int arch_decode_instruction(const struct
 
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
@@ -427,7 +470,8 @@ int arch_decode_instruction(const struct
 		 * pop bp
 		 */
 		*type = INSN_STACK;
-		op->dest.type = OP_DEST_LEAVE;
+		ADD_OP(op)
+			op->dest.type = OP_DEST_LEAVE;
 
 		break;
 
@@ -449,12 +493,14 @@ int arch_decode_instruction(const struct
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
@@ -492,8 +538,10 @@ int arch_decode_instruction(const struct
 
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
@@ -504,11 +552,6 @@ int arch_decode_instruction(const struct
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
-		list_add_tail(&op->list, ops_list);
-	else
-		free(op);
-
 	return 0;
 }
 


