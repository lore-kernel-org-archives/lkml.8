Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1984C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92B92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qz67HFhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgD1TTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728498AbgD1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D3C035495
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NrsVwe4TzastsXwURfp0/elwEEkYtzFdxS+HUS5Whw0=; b=qz67HFhvgX2F37f9m8k7CcIdFN
        a1Q/cgf0ReGEaCQCrOQlpuqzFHPsSVehEvjnQ/09JKXovBi3voBz+xiwzfpCb9v6ZvwHwrWSSoEGq
        taFZtxfrkURMSULXhbIkrg7MwVryP63vl6poAOy9qH2L+V9QrAF5SrZuppEQz0+iPETqF/iWwyLsJ
        DJLIi/3lP2JhaN0W+9KbLNaRuoRwgRjUs60qycMI9b3LSx05nBJ0SAXIoP7Hih6rWWPNkQ6U+IndQ
        fRx5MfzGhYAgK2S709RGx+QH6ZU0AcW+vtGnLkr4dOSJPlKiGvVSB0bCbiEKdoJYRUl6CTqubfswp
        PVIGmxCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlR-0006WB-Uj; Tue, 28 Apr 2020 19:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7C1E30775A;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9368E25D01317; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.854203028@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 08/14] objtool: Remove INSN_STACK
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the unconditional use of handle_insn_ops(), INSN_STACK has lost
its purpose. Remove it.

Suggested-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch.h            |    1 -
 tools/objtool/arch/x86/decode.c |   23 -----------------------
 tools/objtool/check.c           |    3 ---
 3 files changed, 27 deletions(-)

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
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -141,7 +141,6 @@ int arch_decode_instruction(const struct
 		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
 
 			/* add/sub reg, %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -154,7 +153,6 @@ int arch_decode_instruction(const struct
 	case 0x50 ... 0x57:
 
 		/* push reg */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_REG;
 			op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
@@ -166,7 +164,6 @@ int arch_decode_instruction(const struct
 	case 0x58 ... 0x5f:
 
 		/* pop reg */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_REG;
@@ -178,7 +175,6 @@ int arch_decode_instruction(const struct
 	case 0x68:
 	case 0x6a:
 		/* push immediate */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_CONST;
 			op->dest.type = OP_DEST_PUSH;
@@ -196,7 +192,6 @@ int arch_decode_instruction(const struct
 
 		if (modrm == 0xe4) {
 			/* and imm, %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_AND;
 				op->src.reg = CFI_SP;
@@ -215,7 +210,6 @@ int arch_decode_instruction(const struct
 			break;
 
 		/* add/sub imm, %rsp */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_ADD;
 			op->src.reg = CFI_SP;
@@ -229,7 +223,6 @@ int arch_decode_instruction(const struct
 		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
 
 			/* mov %rsp, reg */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = CFI_SP;
@@ -242,7 +235,6 @@ int arch_decode_instruction(const struct
 		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
 
 			/* mov reg, %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -258,7 +250,6 @@ int arch_decode_instruction(const struct
 		    (modrm_mod == 1 || modrm_mod == 2) && modrm_rm == 5) {
 
 			/* mov reg, disp(%rbp) */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -270,7 +261,6 @@ int arch_decode_instruction(const struct
 		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
 				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
@@ -286,7 +276,6 @@ int arch_decode_instruction(const struct
 		if (rex_w && !rex_b && modrm_mod == 1 && modrm_rm == 5) {
 
 			/* mov disp(%rbp), reg */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG_INDIRECT;
 				op->src.reg = CFI_BP;
@@ -299,7 +288,6 @@ int arch_decode_instruction(const struct
 			   modrm_mod != 3 && modrm_rm == 4) {
 
 			/* mov disp(%rsp), reg */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG_INDIRECT;
 				op->src.reg = CFI_SP;
@@ -314,7 +302,6 @@ int arch_decode_instruction(const struct
 	case 0x8d:
 		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
 
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				if (!insn.displacement.value) {
 					/* lea (%rsp), reg */
@@ -332,7 +319,6 @@ int arch_decode_instruction(const struct
 		} else if (rex == 0x48 && modrm == 0x65) {
 
 			/* lea disp(%rbp), %rsp */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = CFI_BP;
@@ -350,7 +336,6 @@ int arch_decode_instruction(const struct
 			 * Restoring rsp back to its original value after a
 			 * stack realignment.
 			 */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = CFI_R10;
@@ -368,7 +353,6 @@ int arch_decode_instruction(const struct
 			 * Restoring rsp back to its original value after a
 			 * stack realignment.
 			 */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
 				op->src.reg = CFI_R13;
@@ -382,7 +366,6 @@ int arch_decode_instruction(const struct
 
 	case 0x8f:
 		/* pop to mem */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_MEM;
@@ -395,7 +378,6 @@ int arch_decode_instruction(const struct
 
 	case 0x9c:
 		/* pushf */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_CONST;
 			op->dest.type = OP_DEST_PUSHF;
@@ -404,7 +386,6 @@ int arch_decode_instruction(const struct
 
 	case 0x9d:
 		/* popf */
-		*type = INSN_STACK;
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POPF;
 			op->dest.type = OP_DEST_MEM;
@@ -443,7 +424,6 @@ int arch_decode_instruction(const struct
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_CONST;
 				op->dest.type = OP_DEST_PUSH;
@@ -452,7 +432,6 @@ int arch_decode_instruction(const struct
 		} else if (op2 == 0xa1 || op2 == 0xa9) {
 
 			/* pop fs/gs */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_POP;
 				op->dest.type = OP_DEST_MEM;
@@ -469,7 +448,6 @@ int arch_decode_instruction(const struct
 		 * mov bp, sp
 		 * pop bp
 		 */
-		*type = INSN_STACK;
 		ADD_OP(op)
 			op->dest.type = OP_DEST_LEAVE;
 
@@ -537,7 +515,6 @@ int arch_decode_instruction(const struct
 		else if (modrm_reg == 6) {
 
 			/* push from mem */
-			*type = INSN_STACK;
 			ADD_OP(op) {
 				op->src.type = OP_SRC_CONST;
 				op->dest.type = OP_DEST_PUSH;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2327,9 +2327,6 @@ static int validate_branch(struct objtoo
 			}
 			return 0;
 
-		case INSN_STACK:
-			break;
-
 		case INSN_STAC:
 			if (state.uaccess) {
 				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);


