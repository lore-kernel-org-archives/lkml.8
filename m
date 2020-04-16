Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA90C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5BC21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="18gIha6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634424AbgDPLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633981AbgDPLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594FC0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=j0vVLpAsgisOvtLlJu5Oc9txbLzNwPvNwKAnEr4oqLg=; b=18gIha6Pp+8MbzmQi6FRpSvFA5
        bvx0HPAZFL+zfBdJEqqYkjN+cB0LkA7zOz5Y/lnk/le2cTkmB0QonmTpPF7JZ+NplXGJT+HkN1Jmc
        0r+bNcNwwFt4ltYPTovxMkPaR2yR3fWSpYUMaD1OLHtRjRRX7YfT8fhXkeL6usNNf3hvn66M5nrwr
        5VUXbwGtSh6YoUbTpE76eXaaLS2//JUcq47GIYWbD4uCzZTOioOPddLqbqsNaawchSfRpdOk6uXqt
        +QfqLr1s/a1Jg1xHYuT/wMwqWCcUkPMWgVk9oc5d5aoatpQ3ynf01w2QiJc4dhFfm1GLcvrOWMdns
        8sBDSUeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0006jL-2Z; Thu, 16 Apr 2020 11:52:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CB6F307016;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 272692B0DE4C4; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.690601403@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 03/17] objtool: Introduce HINT_RET_OFFSET
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally objtool ensures a function keeps the stack layout invariant.
But there is a useful exception, it is possible to stuff the return
stack in order to 'inject' a 'call':

	push $fun
	ret

In this case the invariant mentioned above is violated.

Add an objtool HINT to annotate this and allow a function exit with a
modified stack frame.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/orc_types.h       |    1 +
 arch/x86/include/asm/unwind_hints.h    |   10 ++++++++++
 tools/arch/x86/include/asm/orc_types.h |    1 +
 tools/objtool/check.c                  |   24 ++++++++++++++++--------
 tools/objtool/check.h                  |    4 +++-
 5 files changed, 31 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,7 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_OFFSET	5
 
 #ifndef __ASSEMBLY__
 /*
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -94,6 +94,16 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
 .endm
 
+
+/*
+ * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
+ * and sibling calls. On these, sp_offset denotes the expected offset from
+ * initial_func_cfi.
+ */
+.macro UNWIND_HINT_RET_OFFSET sp_offset=8
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
+.endm
+
 #else /* !__ASSEMBLY__ */
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,7 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_OFFSET	5
 
 #ifndef __ASSEMBLY__
 /*
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1253,6 +1253,9 @@ static int read_unwind_hints(struct objt
 		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
 			insn->restore = true;
 			insn->hint = true;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+			insn->ret_offset = hint->sp_offset;
 			continue;
 		}
 
@@ -1416,20 +1419,25 @@ static bool is_fentry_call(struct instru
 	return false;
 }
 
-static bool has_modified_stack_frame(struct insn_state *state)
+static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
+	u8 ret_offset = insn->ret_offset;
 	int i;
 
-	if (state->cfa.base != initial_func_cfi.cfa.base ||
-	    state->cfa.offset != initial_func_cfi.cfa.offset ||
-	    state->stack_size != initial_func_cfi.cfa.offset ||
-	    state->drap)
+	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
+		return true;
+
+	if (state->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
-	for (i = 0; i < CFI_NUM_REGS; i++)
+	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
+		return true;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
+	}
 
 	return false;
 }
@@ -1971,7 +1979,7 @@ static int validate_call(struct instruct
 
 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
-	if (has_modified_stack_frame(state)) {
+	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -2000,7 +2008,7 @@ static int validate_return(struct symbol
 		return 1;
 	}
 
-	if (func && has_modified_stack_frame(state)) {
+	if (func && has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("return with modified stack frame",
 			  insn->sec, insn->offset);
 		return 1;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,9 +33,11 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool alt_group, dead_end, ignore, ignore_alts;
+	bool hint, save, restore;
 	bool retpoline_safe;
 	u8 visited;
+	u8 ret_offset;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;


