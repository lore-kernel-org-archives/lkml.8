Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CE9C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431E424684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgBYX1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56010 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbgBYX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:54 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jb4-00058E-FU; Wed, 26 Feb 2020 00:26:38 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6DDDD1040C9;
        Wed, 26 Feb 2020 00:25:54 +0100 (CET)
Message-Id: <20200225231610.418058554@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:34 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 15/15] x86/entry: Use return_from_exception()
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ASM return from exception checks for user mode and kernel mode
return with the new C function and invoke this from the idtentry_exit()
helper for all regular exceptions and IST exceptions which hit user mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c         |   13 +++----------
 arch/x86/entry/entry_32.S       |   25 ++++---------------------
 arch/x86/entry/entry_64.S       |   25 ++-----------------------
 arch/x86/include/asm/idtentry.h |    7 +++++--
 4 files changed, 14 insertions(+), 56 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -196,7 +196,7 @@ static void exit_to_usermode_loop(struct
 }
 
 /* Called with IRQs disabled. */
-static inline void __prepare_exit_to_usermode(struct pt_regs *regs)
+static inline void prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags;
@@ -241,13 +241,6 @@ static inline void __prepare_exit_to_use
 	mds_user_clear_cpu_buffers();
 }
 
-__visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
-{
-	__prepare_exit_to_usermode(regs);
-	trace_hardirqs_on();
-}
-NOKPROBE_SYMBOL(prepare_exit_to_usermode);
-
 #define SYSCALL_EXIT_WORK_FLAGS				\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
 	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
@@ -299,7 +292,7 @@ static void syscall_slow_exit_work(struc
 		syscall_slow_exit_work(regs, cached_flags);
 
 	local_irq_disable();
-	__prepare_exit_to_usermode(regs);
+	prepare_exit_to_usermode(regs);
 	/* Return to user space enables interrupts */
 	trace_hardirqs_on();
 }
@@ -429,7 +422,7 @@ static __always_inline long do_fast_sysc
 		/* User code screwed up. */
 		local_irq_disable();
 		regs->ax = -EFAULT;
-		__prepare_exit_to_usermode(regs);
+		prepare_exit_to_usermode(regs);
 		return 0;	/* Keep it simple: use IRET. */
 	}
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -862,15 +862,10 @@ SYM_CODE_START(ret_from_fork)
 SYM_CODE_END(ret_from_fork)
 
 /*
- * Return to user mode is not as complex as all this looks,
- * but we want the default path for a system call return to
- * go as quickly as possible which is why some of this is
- * less clear than it otherwise should be.
+ * C code already did all preparatory work (prepare_exit_to_usermode or
+ * kernel preemption) so this just has to select the proper return path.
  */
-
-	# userspace resumption stub bypassing syscall exit tracing
 SYM_CODE_START_LOCAL(ret_from_exception)
-ret_from_intr:
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb	PT_CS(%esp), %al
@@ -884,9 +879,6 @@ SYM_CODE_START_LOCAL(ret_from_exception)
 #endif
 	cmpl	$USER_RPL, %eax
 	jb	restore_all_kernel		# not returning to v8086 or userspace
-
-	movl	%esp, %eax
-	call	prepare_exit_to_usermode
 	jmp	restore_all_switch_stack
 SYM_CODE_END(ret_from_exception)
 
@@ -1125,15 +1117,6 @@ SYM_FUNC_START(entry_INT80_32)
 	INTERRUPT_RETURN
 
 restore_all_kernel:
-#ifdef CONFIG_PREEMPTION
-	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	.Lno_preempt
-	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
-	jz	.Lno_preempt
-	call	preempt_schedule_irq
-.Lno_preempt:
-#endif
-	TRACE_IRQS_IRET
 	PARANOID_EXIT_TO_KERNEL_MODE
 	BUG_IF_WRONG_CR3
 	RESTORE_REGS 4
@@ -1247,7 +1230,7 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
 	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
 	call	\cfunc
-	jmp	ret_from_intr
+	jmp	ret_from_exception
 SYM_CODE_END(asm_\cfunc)
 .endm
 
@@ -1294,7 +1277,7 @@ SYM_FUNC_START(exc_xen_hypervisor_callba
 #ifndef CONFIG_PREEMPTION
 	call	xen_maybe_preempt_hcall
 #endif
-	jmp	ret_from_intr
+	jmp	ret_from_exception
 SYM_FUNC_END(exc_xen_hypervisor_callback)
 
 /*
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -701,10 +701,6 @@ SYM_CODE_END(\asmsym)
 #include <asm/idtentry.h>
 
 SYM_CODE_START_LOCAL(common_interrupt_return)
-	/* Interrupt came from user space */
-.Lretint_user:
-	mov	%rsp,%rdi
-	call	prepare_exit_to_usermode
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
@@ -746,24 +742,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 	SWAPGS
 	INTERRUPT_RETURN
 
-
 /* Returning to kernel space */
-retint_kernel:
-#ifdef CONFIG_PREEMPTION
-	/* Interrupts are off */
-	/* Check if we need preemption */
-	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
-	jnc	1f
-	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	1f
-	call	preempt_schedule_irq
-1:
-#endif
-	/*
-	 * The iretq could re-enable interrupts:
-	 */
-	TRACE_IRQS_IRETQ
-
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates kernel mode. */
@@ -1167,8 +1146,8 @@ SYM_CODE_START_LOCAL(error_exit)
 	UNWIND_HINT_REGS
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
-	jz	retint_kernel
-	jmp	.Lretint_user
+	jz	restore_regs_and_return_to_kernel
+	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(error_exit)
 
 /*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -41,11 +41,14 @@ static __always_inline void idtentry_ent
 /**
  * idtentry_exit - Prepare returning to low level ASM code
  *
- * Disables interrupts before returning
+ * Invokes return_from_exception() which disables interrupts
+ * and handles return to user mode work and kernel preemption.
+ * This function returns with interrupts disabled and the
+ * hardirq tracing state updated.
  */
 static __always_inline void idtentry_exit(struct pt_regs *regs)
 {
-	local_irq_disable();
+	return_from_exception(regs);
 }
 
 /**

