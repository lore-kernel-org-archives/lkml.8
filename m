Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8167120849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgESUBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgEST66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3CBC08C5C3;
        Tue, 19 May 2020 12:58:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O5-00008w-Cq; Tue, 19 May 2020 21:58:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 831111C06FE;
        Tue, 19 May 2020 21:58:42 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:42 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Move irq tracing on syscall entry to C-code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.611961721@linutronix.de>
References: <20200505134340.611961721@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832235.17951.16049072543900962222.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f0fd87b82db7b0102ba98991fa36c2318d2e2894
Gitweb:        https://git.kernel.org/tip/f0fd87b82db7b0102ba98991fa36c2318d2e2894
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:08:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:51 +02:00

x86/entry: Move irq tracing on syscall entry to C-code

Now that the C entry points are safe, move the irq flags tracing code into
the entry helper:

    - Invoke lockdep before calling into context tracking

    - Use the safe trace_hardirqs_on_prepare() trace function after context
      tracking established state and RCU is watching.

enter_from_user_mode() is also still invoked from the exception/interrupt
entry code which still contains the ASM irq flags tracing. So this is just
a redundant and harmless invocation of tracing / lockdep until these are
removed as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.611961721@linutronix.de


---
 arch/x86/entry/common.c          | 21 +++++++++++++++++++--
 arch/x86/entry/entry_32.S        | 12 ------------
 arch/x86/entry/entry_64.S        |  2 --
 arch/x86/entry/entry_64_compat.S | 18 ------------------
 4 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9892fb7..7473c12 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -40,19 +40,36 @@
 #include <trace/events/syscalls.h>
 
 #ifdef CONFIG_CONTEXT_TRACKING
-/* Called on entry from user mode with IRQs off. */
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall entry disables interrupts, but user mode is traced as interrupts
+ * enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ */
 __visible noinstr void enter_from_user_mode(void)
 {
 	enum ctx_state state = ct_state();
 
+	lockdep_hardirqs_off(CALLER_ADDR0);
 	user_exit_irqoff();
 
 	instrumentation_begin();
 	CT_WARN_ON(state != CONTEXT_USER);
+	trace_hardirqs_off_prepare();
 	instrumentation_end();
 }
 #else
-static inline void enter_from_user_mode(void) {}
+static __always_inline void enter_from_user_mode(void)
+{
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	instrumentation_begin();
+	trace_hardirqs_off_prepare();
+	instrumentation_end();
+}
 #endif
 
 static noinstr void exit_to_user_mode(void)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index bf0082b..65704e0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -967,12 +967,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -1082,12 +1076,6 @@ SYM_FUNC_START(entry_INT80_32)
 
 	SAVE_ALL pt_regs_ax=$-ENOSYS switch_stacks=1	/* save rest */
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt gate
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b199f43..9e34fe8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -167,8 +167,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
-	TRACE_IRQS_OFF
-
 	/* IRQs are off. */
 	movq	%rax, %rdi
 	movq	%rsp, %rsi
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index f1d3cca..e2e8bd7 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -129,12 +129,6 @@ SYM_FUNC_START(entry_SYSENTER_compat)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -247,12 +241,6 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	pushq   $0			/* pt_regs->r15 = 0 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -403,12 +391,6 @@ SYM_CODE_START(entry_INT80_compat)
 	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt
-	 * gate turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
