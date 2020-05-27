Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C30C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140EB20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgE0ILu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgE0ILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD97C061A0F;
        Wed, 27 May 2020 01:11:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrA9-0002Tn-Mk; Wed, 27 May 2020 10:11:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EE6E1C03A9;
        Wed, 27 May 2020 10:11:45 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:45 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Remove redundant irq disable code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202120.221223450@linutronix.de>
References: <20200521202120.221223450@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710513.17951.13586647821555500992.tip-bot2@tip-bot2>
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

Commit-ID:     3728dd935c76646515e91e109067659200eb3a1b
Gitweb:        https://git.kernel.org/tip/3728dd935c76646515e91e109067659200eb3a1b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry/32: Remove redundant irq disable code

All exceptions/interrupts return with interrupts disabled now. No point in
doing this in ASM again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202120.221223450@linutronix.de
---
 arch/x86/entry/entry_32.S | 76 +--------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4a4f34b..96fa462 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -51,34 +51,6 @@
 
 	.section .entry.text, "ax"
 
-/*
- * We use macros for low-level operations which need to be overridden
- * for paravirtualization.  The following will never clobber any registers:
- *   INTERRUPT_RETURN (aka. "iret")
- *   GET_CR0_INTO_EAX (aka. "movl %cr0, %eax")
- *   ENABLE_INTERRUPTS_SYSEXIT (aka "sti; sysexit").
- *
- * For DISABLE_INTERRUPTS/ENABLE_INTERRUPTS (aka "cli"/"sti"), you must
- * specify what registers can be overwritten (CLBR_NONE, CLBR_EAX/EDX/ECX/ANY).
- * Allowing a register to be clobbered can shrink the paravirt replacement
- * enough to patch inline, increasing performance.
- */
-
-#ifdef CONFIG_PREEMPTION
-# define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
-#else
-# define preempt_stop(clobbers)
-#endif
-
-.macro TRACE_IRQS_IRET
-#ifdef CONFIG_TRACE_IRQFLAGS
-	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)     # interrupts off?
-	jz	1f
-	TRACE_IRQS_ON
-1:
-#endif
-.endm
-
 #define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
 
 /*
@@ -881,38 +853,6 @@ SYM_CODE_START(ret_from_fork)
 SYM_CODE_END(ret_from_fork)
 .popsection
 
-/*
- * Return to user mode is not as complex as all this looks,
- * but we want the default path for a system call return to
- * go as quickly as possible which is why some of this is
- * less clear than it otherwise should be.
- */
-
-	# userspace resumption stub bypassing syscall exit tracing
-SYM_CODE_START_LOCAL(ret_from_exception)
-	preempt_stop(CLBR_ANY)
-ret_from_intr:
-#ifdef CONFIG_VM86
-	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
-	movb	PT_CS(%esp), %al
-	andl	$(X86_EFLAGS_VM | SEGMENT_RPL_MASK), %eax
-#else
-	/*
-	 * We can be coming here from child spawned by kernel_thread().
-	 */
-	movl	PT_CS(%esp), %eax
-	andl	$SEGMENT_RPL_MASK, %eax
-#endif
-	cmpl	$USER_RPL, %eax
-	jb	restore_all_kernel		# not returning to v8086 or userspace
-
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
-	movl	%esp, %eax
-	call	prepare_exit_to_usermode
-	jmp	restore_all_switch_stack
-SYM_CODE_END(ret_from_exception)
-
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
 /*
  * All code from here through __end_SYSENTER_singlestep_region is subject
@@ -1147,22 +1087,6 @@ restore_all_switch_stack:
 	 */
 	INTERRUPT_RETURN
 
-restore_all_kernel:
-#ifdef CONFIG_PREEMPTION
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	.Lno_preempt
-	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
-	jz	.Lno_preempt
-	call	preempt_schedule_irq
-.Lno_preempt:
-#endif
-	TRACE_IRQS_IRET
-	PARANOID_EXIT_TO_KERNEL_MODE
-	BUG_IF_WRONG_CR3
-	RESTORE_REGS 4
-	jmp	.Lirq_return
-
 .section .fixup, "ax"
 SYM_CODE_START(asm_iret_error)
 	pushl	$0				# no error code
