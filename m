Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD827C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F22073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="matb72T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgCZLa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:30:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgCZLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyBG1C0mVx6RjyEWPhdegeyLfdXLlOtzmlIqjg0z1Ks=; b=matb72T8x0zoXgsWLYtooPu5zp
        wvfnFss0VyqIZtTMcV6EPWHiMn6ehRdVtr0+UhShitgcSZGCGTl9IkgfkaoSbnL165xriL/fSm95r
        T053K8FyHpsM694rqwHEphCg/4gCxRreIGeRQfYvoxbG8ynmlkDcyATzkR5jy0qP6eev374+VUPuT
        aK0AdpNzgmUTmw3wT1JtUWCx/jWlEVpcLoN4lDPya3czf6uL14bM7f9uR9bwAOUw06mYPOa+A8lXM
        OlUO4Y7ShJLbvA6uGz4sjhUrohY+CVnbQ/yKHFs89UutfQeMeTCLChvxty041IQ4z3PUNjCzXFIy9
        rgyeqBqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHQiq-0001Rf-5Q; Thu, 26 Mar 2020 11:30:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ABCD3007F2;
        Thu, 26 Mar 2020 12:30:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09A8329C48EBB; Thu, 26 Mar 2020 12:30:50 +0100 (CET)
Date:   Thu, 26 Mar 2020 12:30:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326113049.GD20696@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325174605.369570202@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 06:45:26PM +0100, Peter Zijlstra wrote:
> There is a special case in the UNWIND_HINT_RESTORE code. When, upon
> looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
> the instruction hasn't been visited yet, it normally issues a WARN,
> except when this HINT_SAVE instruction is the first instruction of
> this branch.
> 
> This special case is of dubious correctness and is certainly unused
> (verified with an allmodconfig build), the two sites that employ
> UNWIND_HINT_SAVE/RESTORE (sync_core() and ftrace_regs_caller()) have
> the SAVE on unconditional instructions at the start of the function.
> It is therefore impossible for the save_insn not to have been visited
> when we do hit the RESTORE.

Clearly I was too tired when I did that allmodconfig build, because it
very much does generate a warning :-/.

Thank you 0day:

  kernel/sched/core.o: warning: objtool: finish_task_switch()+0x1c0: objtool isn't smart enough to handle this CFI save/restore combo

At least this gives clue as to what it was trying to do.

---
Subject: objtool: Remove CFI save/restore special case
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 25 12:58:16 CET 2020

There is a special case in the UNWIND_HINT_RESTORE code. When, upon
looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
the instruction hasn't been visited yet, it normally issues a WARN,
except when this HINT_SAVE instruction is the first instruction of
this branch.

The reason for this special case comes apparent when we remove it;
code like:

	if (cond) {
		UNWIND_HINT_SAVE
		// do stuff
		UNWIND_HINT_RESTORE
	}
	// more stuff

will now trigger the warning. This is because UNWIND_HINT_RESTORE is
just a label, and there is nothing keeping it inside the (extended)
basic block covered by @cond. It will attach itself to the first
instruction of 'more stuff' and we'll hit it outside of the @cond,
confusing things.

I don't much like this special case, it confuses things and will come
apart horribly if/when the annotation needs to support nesting.
Instead extend the affected code to at least form an extended basic
block.

In particular, of the 2 users of this annotation: ftrace_regs_caller()
and sync_core(), only the latter suffers this problem. Extend it's
code sequence with a NOP to make it an extended basic block.

This isn't ideal either; stuffing code with NOPs just to make
annotations work is certainly sub-optimal, but given that sync_core()
is stupid expensive in any case, one extra nop isn't going to be a
problem here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    9 ++++++++-
 tools/objtool/check.c            |   15 ++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -727,6 +727,13 @@ static inline void sync_core(void)
 #else
 	unsigned int tmp;
 
+	/*
+	 * The trailing NOP is required to make this an extended basic block,
+	 * such that we can argue about it locally. Specifically this is
+	 * important for the UNWIND_HINTs, without this the UNWIND_HINT_RESTORE
+	 * can fall outside our extended basic block and objtool gets
+	 * (rightfully) confused.
+	 */
 	asm volatile (
 		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
@@ -739,7 +746,7 @@ static inline void sync_core(void)
 		"pushq $1f\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
-		"1:"
+		"1: nop\n\t"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2000,15 +2000,14 @@ static int validate_sibling_call(struct
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
@@ -2061,16 +2060,6 @@ static int validate_branch(struct objtoo
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
