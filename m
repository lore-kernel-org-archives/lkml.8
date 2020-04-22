Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5136DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356862071C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDVAdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:33:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8612070B;
        Wed, 22 Apr 2020 00:33:47 +0000 (UTC)
Date:   Tue, 21 Apr 2020 20:33:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 04/17] x86,ftrace: Fix ftrace_regs_caller() unwind
Message-ID: <20200421203345.4e165c4b@oasis.local.home>
In-Reply-To: <20200416115118.749606694@infradead.org>
References: <20200416114706.625340212@infradead.org>
        <20200416115118.749606694@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

After looking at the code, I realized that the only possible way to do
the "direct call" part, is if the direct function helper is executed
there. All other ftrace_ops, will not call that path.

I added a trampoline that points to ftrace_regs_caller to the direct
ftrace_ops, to force it never to allocate its own trampoline, and thus
no created trampoline should ever do the jump for a direct caller.

By doing this, I was able to move the code around to be a bit simpler,
and not need the double modifications (the double ret).

Of course, if any created trampoline were to touch the ORIG_RAX, then
it would crash. We could always nop that compare in the created
trampoline if that is a concern.

Anyway, I added the below patch on top of your patches and it appears
to work. Thoughts?

-- Steve

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 867c126ddabe..2e11250d5647 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -367,13 +367,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
-	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
-		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);
-		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
-		if (WARN_ON(ret < 0))
-			goto fail;
-	}
-
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 9738ed23964e..1f2afaa8f71f 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -241,22 +241,9 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 */
 	movq ORIG_RAX(%rsp), %rax
 	testq	%rax, %rax
-	jz	1f
+	jnz	1f
 
-	/* Swap the flags with orig_rax */
-	movq MCOUNT_REG_SIZE(%rsp), %rdi
-	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
-	movq %rax, MCOUNT_REG_SIZE(%rsp)
-
-	restore_mcount_regs 8
-	/* Restore flags */
-	popfq
-
-SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
-	UNWIND_HINT_RET_OFFSET
-	jmp	ftrace_epilogue
-
-1:	restore_mcount_regs
+	restore_mcount_regs
 	/* Restore flags */
 	popfq
 
@@ -267,8 +254,19 @@ SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+	UNWIND_HINT_RET_OFFSET
 	jmp ftrace_epilogue
 
+	/* Swap the flags with orig_rax */
+1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
+	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+
+	restore_mcount_regs 8
+	/* Restore flags */
+	popfq
+	jmp	ftrace_epilogue
+
 SYM_FUNC_END(ftrace_regs_caller)
 
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 041694a1eb74..8f540eef7511 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2399,6 +2399,13 @@ struct ftrace_ops direct_ops = {
 	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
 			  | FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
+	/*
+	 * By declaring the main trampoline as this trampoline
+	 * it will never have one allocated for it. This is fine
+	 * as this should only be used if we are in the
+	 * ftrace_ops_list function.
+	 */
+	.trampoline	= FTRACE_REGS_ADDR,
 };
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
