Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B729AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934E821897
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgE0IMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgE0IL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76EC061A0F;
        Wed, 27 May 2020 01:11:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAL-0002bj-Hc; Wed, 27 May 2020 10:11:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2DCF81C070D;
        Wed, 27 May 2020 10:11:55 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:55 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Switch page fault exception to IDTENTRY_RAW
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202118.238455120@linutronix.de>
References: <20200521202118.238455120@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711504.17951.7580260073968916139.tip-bot2@tip-bot2>
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

Commit-ID:     a707ae1a9bbb3f8649004d4629f4299ffdcecc2a
Gitweb:        https://git.kernel.org/tip/a707ae1a9bbb3f8649004d4629f4299ffdcecc2a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Switch page fault exception to IDTENTRY_RAW

Convert page fault exceptions to IDTENTRY_RAW:

  - Implement the C entry point with DEFINE_IDTENTRY_RAW
  - Add the CR2 read into the exception handler
  - Add the idtentry_enter/exit_cond_rcu() invocations in
    in the regular page fault handler and in the async PF
    part.
  - Emit the ASM stub with DECLARE_IDTENTRY_RAW
  - Remove the ASM idtentry in 64-bit
  - Remove the CR2 read from 64-bit
  - Remove the open coded ASM entry code in 32-bit
  - Fix up the XEN/PV code
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202118.238455120@linutronix.de
---
 arch/x86/entry/entry_32.S       | 30 +--------------
 arch/x86/entry/entry_64.S       | 19 +---------
 arch/x86/include/asm/idtentry.h |  3 +-
 arch/x86/include/asm/traps.h    | 11 +-----
 arch/x86/kernel/idt.c           |  4 +-
 arch/x86/kernel/kvm.c           | 15 ++++---
 arch/x86/mm/fault.c             | 69 ++++++++++++++++++++++----------
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 9 files changed, 63 insertions(+), 92 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 84ee014..1674deb 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1395,36 +1395,6 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 #endif /* CONFIG_HYPERV */
 
-SYM_CODE_START(page_fault)
-	ASM_CLAC
-	pushl	$do_page_fault
-	jmp	common_exception_read_cr2
-SYM_CODE_END(page_fault)
-
-SYM_CODE_START_LOCAL_NOALIGN(common_exception_read_cr2)
-	/* the function address is in %gs's slot on the stack */
-	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
-
-	ENCODE_FRAME_POINTER
-
-	/* fixup %gs */
-	GS_TO_REG %ecx
-	movl	PT_GS(%esp), %edi
-	REG_TO_PTGS %ecx
-	SET_KERNEL_GS %ecx
-
-	GET_CR2_INTO(%ecx)			# might clobber %eax
-
-	/* fixup orig %eax */
-	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
-
-	TRACE_IRQS_OFF
-	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC edi
-	jmp	ret_from_exception
-SYM_CODE_END(common_exception_read_cr2)
-
 SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b70c778..5789f76 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -506,15 +506,6 @@ SYM_CODE_END(spurious_entries_start)
 	call	error_entry
 	UNWIND_HINT_REGS
 
-	.if \vector == X86_TRAP_PF
-		/*
-		 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
-		 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
-		 * GET_CR2_INTO can clobber RAX.
-		 */
-		GET_CR2_INTO(%r12);
-	.endif
-
 	.if \sane == 0
 	TRACE_IRQS_OFF
 
@@ -533,10 +524,6 @@ SYM_CODE_END(spurious_entries_start)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
-	.if \vector == X86_TRAP_PF
-		movq	%r12, %rdx		/* Move CR2 into 3rd argument */
-	.endif
-
 	call	\cfunc
 
 	.if \sane == 0
@@ -1060,12 +1047,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 #endif
 
 /*
- * Exception entry points.
- */
-
-idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
-
-/*
  * Reload gs selector with exception handling
  * edi:  new selector
  *
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 49a797d..92054ff 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -366,7 +366,8 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
 /* Raw exception entries which need extra work */
-DECLARE_IDTENTRY_RAW(X86_TRAP_BP,	exc_int3);
+DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
+DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_PF,	exc_page_fault);
 
 #ifdef CONFIG_X86_MCE
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index f5a2e43..d7de360 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -9,17 +9,6 @@
 #include <asm/idtentry.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
 
-#define dotraplinkage __visible
-
-asmlinkage void page_fault(void);
-asmlinkage void async_page_fault(void);
-
-#if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_page_fault(void);
-#endif
-
-dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index ec55479..ddb1115 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -62,7 +62,7 @@ static const __initconst struct idt_data early_idts[] = {
 	INTG(X86_TRAP_DB,		asm_exc_debug),
 	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
-	INTG(X86_TRAP_PF,		page_fault),
+	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
 };
 
@@ -156,7 +156,7 @@ static const __initconst struct idt_data apic_idts[] = {
  * stacks work only after cpu_init().
  */
 static const __initconst struct idt_data early_pf_idts[] = {
-	INTG(X86_TRAP_PF,		page_fault),
+	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 };
 
 /*
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b3d9b0d..d8a0926 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -218,7 +218,7 @@ again:
 }
 EXPORT_SYMBOL_GPL(kvm_async_pf_task_wake);
 
-u32 kvm_read_and_reset_pf_reason(void)
+u32 noinstr kvm_read_and_reset_pf_reason(void)
 {
 	u32 reason = 0;
 
@@ -230,11 +230,11 @@ u32 kvm_read_and_reset_pf_reason(void)
 	return reason;
 }
 EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
-NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
-bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
+noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	u32 reason = kvm_read_and_reset_pf_reason();
+	bool rcu_exit;
 
 	switch (reason) {
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
@@ -244,6 +244,9 @@ bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 	}
 
+	rcu_exit = idtentry_enter_cond_rcu(regs);
+	instrumentation_begin();
+
 	/*
 	 * If the host managed to inject an async #PF into an interrupt
 	 * disabled region, then die hard as this is not going to end well
@@ -258,13 +261,13 @@ bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {
-		rcu_irq_enter();
 		kvm_async_pf_task_wake(token);
-		rcu_irq_exit();
 	}
+
+	instrumentation_end();
+	idtentry_exit_cond_rcu(regs, rcu_exit);
 	return true;
 }
-NOKPROBE_SYMBOL(__kvm_handle_async_pf);
 
 static void __init paravirt_ops_setup(void)
 {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7c3ac7f..9c57fb8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1521,11 +1521,38 @@ trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 		trace_page_fault_kernel(address, regs, error_code);
 }
 
-dotraplinkage void
-do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
-		unsigned long address)
+static __always_inline void
+handle_page_fault(struct pt_regs *regs, unsigned long error_code,
+			      unsigned long address)
+{
+	trace_page_fault_entries(regs, error_code, address);
+
+	if (unlikely(kmmio_fault(regs, address)))
+		return;
+
+	/* Was the fault on kernel-controlled part of the address space? */
+	if (unlikely(fault_in_kernel_space(address))) {
+		do_kern_addr_fault(regs, error_code, address);
+	} else {
+		do_user_addr_fault(regs, error_code, address);
+		/*
+		 * User address page fault handling might have reenabled
+		 * interrupts. Fixing up all potential exit points of
+		 * do_user_addr_fault() and its leaf functions is just not
+		 * doable w/o creating an unholy mess or turning the code
+		 * upside down.
+		 */
+		local_irq_disable();
+	}
+}
+
+DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
+	unsigned long address = read_cr2();
+	bool rcu_exit;
+
 	prefetchw(&current->mm->mmap_sem);
+
 	/*
 	 * KVM has two types of events that are, logically, interrupts, but
 	 * are unfortunately delivered using the #PF vector.  These events are
@@ -1540,28 +1567,28 @@ do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 * getting values from real and async page faults mixed up.
 	 *
 	 * Fingers crossed.
+	 *
+	 * The async #PF handling code takes care of idtentry handling
+	 * itself.
 	 */
 	if (kvm_handle_async_pf(regs, (u32)address))
 		return;
 
-	trace_page_fault_entries(regs, hw_error_code, address);
+	/*
+	 * Entry handling for valid #PF from kernel mode is slightly
+	 * different: RCU is already watching and rcu_irq_enter() must not
+	 * be invoked because a kernel fault on a user space address might
+	 * sleep.
+	 *
+	 * In case the fault hit a RCU idle region the conditional entry
+	 * code reenabled RCU to avoid subsequent wreckage which helps
+	 * debugability.
+	 */
+	rcu_exit = idtentry_enter_cond_rcu(regs);
 
-	if (unlikely(kmmio_fault(regs, address)))
-		return;
+	instrumentation_begin();
+	handle_page_fault(regs, error_code, address);
+	instrumentation_end();
 
-	/* Was the fault on kernel-controlled part of the address space? */
-	if (unlikely(fault_in_kernel_space(address))) {
-		do_kern_addr_fault(regs, hw_error_code, address);
-	} else {
-		do_user_addr_fault(regs, hw_error_code, address);
-		/*
-		 * User address page fault handling might have reenabled
-		 * interrupts. Fixing up all potential exit points of
-		 * do_user_addr_fault() and its leaf functions is just not
-		 * doable w/o creating an unholy mess or turning the code
-		 * upside down.
-		 */
-		local_irq_disable();
-	}
+	idtentry_exit_cond_rcu(regs, rcu_exit);
 }
-NOKPROBE_SYMBOL(do_page_fault);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 851ea41..35321f4 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -627,7 +627,7 @@ static struct trap_array_entry trap_array[] = {
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
 #endif
-	{ page_fault,                  xen_page_fault,                  false },
+	TRAP_ENTRY(exc_page_fault,			false ),
 	TRAP_ENTRY(exc_divide_error,			false ),
 	TRAP_ENTRY(exc_bounds,				false ),
 	TRAP_ENTRY(exc_invalid_op,			false ),
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 19fbbdb..5d252aa 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -43,7 +43,7 @@ xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present
 xen_pv_trap asm_exc_stack_segment
 xen_pv_trap asm_exc_general_protection
-xen_pv_trap page_fault
+xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
