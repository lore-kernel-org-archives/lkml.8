Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3910AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5520780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGBV73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFAB215A4;
        Thu,  2 Jul 2020 21:58:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E0-004BeP-0B; Thu, 02 Jul 2020 17:58:32 -0400
Message-ID: <20200702215831.866585851@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 03/18] x86/ftrace: Only have the builtin ftrace_regs_caller call direct
 hooks
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a direct hook is attached to a function that ftrace also has a function
attached to it, then it is required that the ftrace_ops_list_func() is used
to iterate over the registered ftrace callbacks. This will also include the
direct ftrace_ops helper, that tells ftrace_regs_caller where to return to
(the direct callback and not the function that called it).

As this direct helper is only to handle the case of ftrace callbacks
attached to the same function as the direct callback, the ftrace callback
allocated trampolines (used to only call them), should never be used to
return back to a direct callback.

Only copy the portion of the ftrace_regs_caller that will return back to
what called it, and not the portion that returns back to the direct caller.

The direct ftrace_ops must then pick the ftrace_regs_caller builtin function
as its own trampoline to ensure that it will never have one allocated for
it (which would not include the handling of direct callbacks).

Link: http://lkml.kernel.org/r/20200422162750.495903799@goodmis.org

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c    | 7 -------
 arch/x86/kernel/ftrace_64.S | 3 +--
 kernel/trace/ftrace.c       | 8 ++++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 51504566b3a6..d1a0190fef5b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -367,13 +367,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
-	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
-		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);
-		ret = copy_from_kernel_nofault(ip, (void *)retq, RET_SIZE);
-		if (WARN_ON(ret < 0))
-			goto fail;
-	}
-
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 3ba32cc58f01..43cf9a2b52c7 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -253,7 +253,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * The trampoline will add the code to jump
 	 * to the return.
 	 */
-SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	jmp ftrace_epilogue
 
 	/* Swap the flags with orig_rax */
@@ -264,7 +264,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL)
 	restore_mcount_regs 8
 	/* Restore flags */
 	popfq
-SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	UNWIND_HINT_RET_OFFSET
 	jmp	ftrace_epilogue
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6eb..c141d347f71a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2388,6 +2388,14 @@ struct ftrace_ops direct_ops = {
 	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
 			  | FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
+	/*
+	 * By declaring the main trampoline as this trampoline
+	 * it will never have one allocated for it. Allocated
+	 * trampolines should not call direct functions.
+	 * The direct_ops should only be called by the builtin
+	 * ftrace_regs_caller trampoline.
+	 */
+	.trampoline	= FTRACE_REGS_ADDR,
 };
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
-- 
2.26.2


