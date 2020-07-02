Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E219E221EA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGBV7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F0921532;
        Thu,  2 Jul 2020 21:58:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7Dz-004Bdt-R9; Thu, 02 Jul 2020 17:58:31 -0400
Message-ID: <20200702215831.710770737@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 02/18] x86/ftrace: Make non direct case the default in ftrace_regs_caller
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a direct function is hooked along with one of the ftrace registered
functions, then the ftrace_regs_caller is attached to the function that
shares the direct hook as well as the ftrace hook. The ftrace_regs_caller
will call ftrace_ops_list_func() that iterates through all the registered
ftrace callbacks, and if there's a direct callback attached to that
function, the direct ftrace_ops callback is called to notify that
ftrace_regs_caller to return to the direct caller instead of going back to
the function that called it.

But this is a very uncommon case. Currently, the code has it as the default
case. Modify ftrace_regs_caller to make the default case (the non jump) to
just return normally, and have the jump to the handling of the direct
caller.

Link: http://lkml.kernel.org/r/20200422162750.350373278@goodmis.org

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace_64.S | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 083a3da7bb73..3ba32cc58f01 100644
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
 
@@ -266,9 +253,21 @@ SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
 	 * The trampoline will add the code to jump
 	 * to the return.
 	 */
-SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL)
 	jmp ftrace_epilogue
 
+	/* Swap the flags with orig_rax */
+1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
+	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+
+	restore_mcount_regs 8
+	/* Restore flags */
+	popfq
+SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+	UNWIND_HINT_RET_OFFSET
+	jmp	ftrace_epilogue
+
 SYM_FUNC_END(ftrace_regs_caller)
 
 
-- 
2.26.2


