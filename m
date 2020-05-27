Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA90214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgE0ILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgE0ILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85567C061A0F;
        Wed, 27 May 2020 01:11:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrA8-0002T3-Oa; Wed, 27 May 2020 10:11:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 54A861C03A9;
        Wed, 27 May 2020 10:11:44 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:44 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Move paranoid irq tracing out of ASM code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202120.414043330@linutronix.de>
References: <20200521202120.414043330@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710421.17951.5346461925222955953.tip-bot2@tip-bot2>
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

Commit-ID:     290e14a71d0fab4dad25ad2fee2e78e3bd6aef79
Gitweb:        https://git.kernel.org/tip/290e14a71d0fab4dad25ad2fee2e78e3bd6aef79
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry: Move paranoid irq tracing out of ASM code

The last step to remove the irq tracing cruft from ASM. Ignore #DF as the
maschine is going to die anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202120.414043330@linutronix.de
---
 arch/x86/entry/entry_64.S      | 13 -------------
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 arch/x86/kernel/nmi.c          |  3 +++
 arch/x86/kernel/traps.c        | 11 +++++++++++
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fb7f126..2566554 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -16,7 +16,6 @@
  *
  * Some macro usage:
  * - SYM_FUNC_START/END:Define functions in the symbol table.
- * - TRACE_IRQ_*:	Trace hardirq state for lock debugging.
  * - idtentry:		Define exception entry points.
  */
 #include <linux/linkage.h>
@@ -107,11 +106,6 @@ SYM_CODE_END(native_usergs_sysret64)
 
 SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
-	/*
-	 * Interrupts are off on entry.
-	 * We do not frame this tiny irq-off block with TRACE_IRQS_OFF/ON,
-	 * it is too small to ever cause noticeable irq latency.
-	 */
 
 	swapgs
 	/* tss.sp2 is scratch space. */
@@ -462,8 +456,6 @@ SYM_CODE_START(\asmsym)
 
 	UNWIND_HINT_REGS
 
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
 	.if \vector == X86_TRAP_DB
@@ -881,17 +873,13 @@ SYM_CODE_END(paranoid_entry)
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
-	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
 	jmp	restore_regs_and_return_to_kernel
 .Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	jmp restore_regs_and_return_to_kernel
@@ -1292,7 +1280,6 @@ end_repeat_nmi:
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
-	/* paranoidentry exc_nmi(), 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	exc_nmi
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c47f004..068e6ca 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1922,7 +1922,10 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * that out because it's an indirect call. Annotate it.
 	 */
 	instrumentation_begin();
+	trace_hardirqs_off_prepare();
 	machine_check_vector(regs);
+	if (regs->flags & X86_EFLAGS_IF)
+		trace_hardirqs_on_prepare();
 	instrumentation_end();
 	nmi_exit();
 }
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d18ec18..1c58454 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -334,6 +334,7 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
+	trace_hardirqs_off_prepare();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -420,6 +421,8 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 		unknown_nmi_error(reason, regs);
 
 out:
+	if (regs->flags & X86_EFLAGS_IF)
+		trace_hardirqs_on_prepare();
 	instrumentation_end();
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f28be3e..50fb9cd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -634,8 +634,11 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	} else {
 		nmi_enter();
 		instrumentation_begin();
+		trace_hardirqs_off_prepare();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
+		if (regs->flags & X86_EFLAGS_IF)
+			trace_hardirqs_on_prepare();
 		instrumentation_end();
 		nmi_exit();
 	}
@@ -850,6 +853,10 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
 	nmi_enter();
+	instrumentation_begin();
+	trace_hardirqs_off_prepare();
+	instrumentation_end();
+
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
@@ -871,6 +878,10 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if (dr6)
 		handle_debug(regs, dr6, false);
 
+	instrumentation_begin();
+	if (regs->flags & X86_EFLAGS_IF)
+		trace_hardirqs_on_prepare();
+	instrumentation_end();
 	nmi_exit();
 }
 
