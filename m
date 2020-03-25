Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E71C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0663B215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsT1H23T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCYOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:41:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37292 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z2El5lP1Z4FdN97HIoVekE575/AVIuxZqJUH0mgI10s=; b=JsT1H23TjVkq1RpIUnRa/AU8FB
        5IVNLlKC2fIh1VHPjc3Z5egxhLWyyAhnis0Df0Xb98jeRJhs/ia4IliZAo+evVTiyPWY0YbAmGQbL
        poDk+sNO5CC8F6jf/HSkQfl9uQHS1qlrSa2eZvYxvv8ixWnAMWbTrbgw5D2L2434hUXip2BwP7ho7
        LROS28mxK0wYxmxF6q1ng8z3JJ3XHry7zwQbu25LuaCfDGmFRaCCdrI5L8gek2DWKTrs62kZ5UFXT
        B4ymejXHUz+RZKzuR54yKc3RWfNkNV9cnYyENmjWyLn32L6JEQ3PONz9AfDChCMQrvar0G+YQijWr
        m4/CrLug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH7Ds-00084u-DQ; Wed, 25 Mar 2020 14:41:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F9633010C1;
        Wed, 25 Mar 2020 15:41:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70E2A29A8F430; Wed, 25 Mar 2020 15:41:33 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:41:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3.1 18a/26] objtool: Remove CFI save/restore special case
Message-ID: <20200325144133.GV20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324160924.987489248@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Remove CFI save/restore special case
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 25 12:58:16 CET 2020

There is a special case in the UNWIND_HINT_RESTORE code. When, upon
looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
the instruction hasn't been visited yet, it normally issues a WARN,
except when this HINT_SAVE instruction is the first instruction of
this branch.

This special case is of dubious correctness and is certainly unused
(verified with an allmodconfig build), the two sites that employ
UNWIND_HINT_SAVE/RESTORE (sync_core() and ftrace_regs_caller()) have
the SAVE on unconditional instructions at the start of the function.
It is therefore impossible for the save_insn not to have been visited
when we do hit the RESTORE.

Remove this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2040,15 +2040,14 @@ static int validate_return(struct symbol
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *first, struct insn_state state)
+			   struct instruction *insn, struct insn_state state)
 {
+	struct instruction *next_insn;
 	struct alternative *alt;
-	struct instruction *insn, *next_insn;
 	struct section *sec;
 	u8 visited;
 	int ret;
 
-	insn = first;
 	sec = insn->sec;
 
 	if (insn->alt_group && list_empty(&insn->alts)) {
@@ -2101,16 +2100,6 @@ static int validate_branch(struct objtoo
 				}
 
 				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
 					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
 						  sec, insn->offset);
 					return 1;
