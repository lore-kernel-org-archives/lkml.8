Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8120826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgEUUc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgEUUcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6BC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:18 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrrC-0000uv-Mn; Thu, 21 May 2020 22:31:58 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 30581100606;
        Thu, 21 May 2020 22:31:58 +0200 (CEST)
Message-Id: <20200521202120.221223450@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 36/39] x86/entry/32: Remove redundant irq disable code
References: <20200521200513.656533920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All exceptions/interrupts return with interrupts disabled now. No point in
doing this in ASM again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S |   76 ----------------------------------------------
 1 file changed, 76 deletions(-)

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
@@ -1147,22 +1087,6 @@ SYM_FUNC_START(entry_INT80_32)
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

