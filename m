Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4989AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F2921D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dXn6N6t4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506718AbgDPLwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506607AbgDPLwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=G/IT5o5In5AGOz06+jfEzC8PQ8Kd4Ep3f9IxN39kWXA=; b=dXn6N6t4t0WizqWWlqvudqLZv2
        clLbnutnCzbrp2o1+y64LygEe4ow6WwnV1yKQXy6LFXKM6lz/HOomIrtxPkToR0Dd9QIslVjer8bS
        0vjDLxZvTtkmg1jIPRdGu/4YDa6r7O3BoeQso/A2sJhIrmLw8Ud1Zp5HKawfwpQ/14fVfFYQseNcp
        VCYVLmzWlWgnmIBF3UEqlz0V4tMfWggvsOlznQ6mvkcHGo7PuxsU0Nwb4RFPz3nwf9x4+P1iJSHOR
        yBeGMRNoCnqD/Mp8IoW4zJ7dqeFYnR7hYB76pTKu9uHasKcLh9IOaCsJFiuabBfgbDHyEfH/UayIg
        S9tqv/fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34D-0004rz-Ti; Thu, 16 Apr 2020 11:52:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E8B03071D5;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2A02F2B0DE4C3; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.749606694@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 04/17] x86,ftrace: Fix ftrace_regs_caller() unwind
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace_regs_caller() trampoline does something 'funny' when there
is a direct-caller present. In that case it stuffs the 'direct-caller'
address on the return stack and then exits the function. This then
results in 'returning' to the direct-caller with the exact registers
we came in with -- an indirect tail-call without using a register.

This however (rightfully) confuses objtool because the function shares
a few instruction in order to have a single exit path, but the stack
layout is different for them, depending through which path we came
there.

This is currently cludged by forcing the stack state to the non-direct
case, but this generates actively wrong (ORC) unwind information for
the direct case, leading to potential broken unwinds.

Fix this issue by fully separating the exit paths. This results in
having to poke a second RET into the trampoline copy, see
ftrace_regs_caller_ret.

This brings us to a second objtool problem, in order for it to
perceive the 'jmp ftrace_epilogue' as a function exit, it needs to be
recognised as a tail call. In order to make that happen,
ftrace_epilogue needs to be the start of an STT_FUNC, so re-arrange
code to make this so.

Finally, a third issue is that objtool requires functions to exit with
the same stack layout they started with, which is obviously violated
in the direct case, employ the new HINT_RET_OFFSET to tell objtool
this is an expected exception.

Together, this results in generating correct ORC unwind information
for the ftrace_regs_caller() function and it's trampoline copies.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace.c    |   12 ++++++++++--
 arch/x86/kernel/ftrace_64.S |   32 +++++++++++++++-----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -282,7 +282,8 @@ static inline void tramp_free(void *tram
 
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
-extern void ftrace_epilogue(void);
+extern void ftrace_regs_caller_ret(void);
+extern void ftrace_caller_end(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);
 
@@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops
 		call_offset = (unsigned long)ftrace_regs_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
-		end_offset = (unsigned long)ftrace_epilogue;
+		end_offset = (unsigned long)ftrace_caller_end;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
 		call_offset = (unsigned long)ftrace_call;
 	}
@@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops
 	if (WARN_ON(ret < 0))
 		goto fail;
 
+	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
+		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);
+		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
+		if (WARN_ON(ret < 0))
+			goto fail;
+	}
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -157,8 +157,12 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBA
 	 * think twice before adding any new code or changing the
 	 * layout here.
 	 */
-SYM_INNER_LABEL(ftrace_epilogue, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 
+	jmp ftrace_epilogue
+SYM_FUNC_END(ftrace_caller);
+
+SYM_FUNC_START(ftrace_epilogue)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jmp ftrace_stub
@@ -170,14 +174,12 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	retq
-SYM_FUNC_END(ftrace_caller)
+SYM_FUNC_END(ftrace_epilogue)
 
 SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
-	UNWIND_HINT_SAVE
-
 	/* added 8 bytes to save flags */
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
@@ -233,7 +235,10 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	movq ORIG_RAX(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
 
-	/* If ORIG_RAX is anything but zero, make this a call to that */
+	/*
+	 * If ORIG_RAX is anything but zero, make this a call to that.
+	 * See arch_ftrace_set_direct_caller().
+	 */
 	movq ORIG_RAX(%rsp), %rax
 	cmpq	$0, %rax
 	je	1f
@@ -244,20 +249,14 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
 	restore_mcount_regs 8
+	/* Restore flags */
+	popfq
 
-	jmp	2f
+SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
+	UNWIND_HINT_RET_OFFSET
+	jmp	ftrace_epilogue
 
 1:	restore_mcount_regs
-
-
-2:
-	/*
-	 * The stack layout is nondetermistic here, depending on which path was
-	 * taken.  This confuses objtool and ORC, rightfully so.  For now,
-	 * pretend the stack always looks like the non-direct case.
-	 */
-	UNWIND_HINT_RESTORE
-
 	/* Restore flags */
 	popfq
 
@@ -268,7 +267,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
-
 	jmp ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)


