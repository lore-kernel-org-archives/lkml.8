Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8995CC5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7112E2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgDVQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgDVQ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:27:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EFC21655;
        Wed, 22 Apr 2020 16:27:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRIE2-000O5N-Ov; Wed, 22 Apr 2020 12:27:50 -0400
Message-Id: <20200422162750.638839749@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 12:25:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        jpoimboe@redhat.com, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: [PATCH 3/3] x86/ftrace: Do not jump to direct code in created trampolines
References: <20200422162539.808362933@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When creating a trampoline based on the ftrace_regs_caller code, nop out the
jnz test that would jmup to the code that would return to a direct caller
(stored in the ORIG_RAX field) and not back to the function that called it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c    | 15 +++++++++++++++
 arch/x86/kernel/ftrace_64.S |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 2e11250d5647..1db87ddb268b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -286,6 +286,7 @@ extern void ftrace_regs_caller_ret(void);
 extern void ftrace_caller_end(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);
+extern void ftrace_regs_caller_jmp(void);
 
 /* movq function_trace_op(%rip), %rdx */
 /* 0x48 0x8b 0x15 <offset-to-ftrace_trace_op (4 bytes)> */
@@ -316,6 +317,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long end_offset;
 	unsigned long op_offset;
 	unsigned long call_offset;
+	unsigned long jmp_offset;
 	unsigned long offset;
 	unsigned long npages;
 	unsigned long size;
@@ -333,11 +335,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		end_offset = (unsigned long)ftrace_regs_caller_end;
 		op_offset = (unsigned long)ftrace_regs_caller_op_ptr;
 		call_offset = (unsigned long)ftrace_regs_call;
+		jmp_offset = (unsigned long)ftrace_regs_caller_jmp;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
 		end_offset = (unsigned long)ftrace_caller_end;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
 		call_offset = (unsigned long)ftrace_call;
+		jmp_offset = 0;
 	}
 
 	size = end_offset - start_offset;
@@ -367,6 +371,17 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
+	/* No need to test direct calls on created trampolines */
+	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
+		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */
+		ip = trampoline + (jmp_offset - start_offset);
+		if (WARN_ON(*(char *)ip != 0x75))
+			goto fail;
+		ret = probe_kernel_read(ip, ideal_nops[2], 2);
+		if (ret < 0)
+			goto fail;
+	}
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 0882758d165a..f72ef157feb3 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -241,6 +241,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 */
 	movq ORIG_RAX(%rsp), %rax
 	testq	%rax, %rax
+SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	jnz	1f
 
 	restore_mcount_regs
-- 
2.26.1


