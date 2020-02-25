Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E42C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E9824680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgBYX2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgBYX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:47 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jap-0004zb-Mn; Wed, 26 Feb 2020 00:26:24 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 952191040B9;
        Wed, 26 Feb 2020 00:25:47 +0100 (CET)
Message-Id: <20200225224145.657687951@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:36 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 15/16] x86/entry: Switch page fault exceptions to idtentry_simple
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert page fault exceptions to IDTENTRY_CR2:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the CR2 read from 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |   38 --------------------------------------
 arch/x86/entry/entry_64.S       |   33 +++++----------------------------
 arch/x86/include/asm/idtentry.h |    6 ++++++
 arch/x86/include/asm/kvm_para.h |    1 -
 arch/x86/include/asm/traps.h    |   14 +++-----------
 arch/x86/kernel/idt.c           |    4 ++--
 arch/x86/kernel/kvm.c           |    8 +++-----
 arch/x86/mm/fault.c             |   20 +++++++++++++-------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 10 files changed, 34 insertions(+), 94 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1407,36 +1407,6 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vec
 
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
-	CALL_NOSPEC %edi
-	jmp	ret_from_exception
-SYM_CODE_END(common_exception_read_cr2)
-
 SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
@@ -1601,14 +1571,6 @@ SYM_CODE_START(asm_exc_nmi)
 #endif
 SYM_CODE_END(asm_exc_nmi)
 
-#ifdef CONFIG_KVM_GUEST
-SYM_CODE_START(async_page_fault)
-	ASM_CLAC
-	pushl	$do_async_page_fault
-	jmp	common_exception_read_cr2
-SYM_CODE_END(async_page_fault)
-#endif
-
 SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -493,24 +493,14 @@ SYM_CODE_END(spurious_entries_start)
 
 /**
  * idtentry_body - Macro to emit code calling the C function
- * @vector:		Vector number
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
  */
-.macro idtentry_body vector cfunc has_error_code:req
+.macro idtentry_body cfunc has_error_code:req
 
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
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
 	.if \has_error_code == 1
@@ -518,10 +508,6 @@ SYM_CODE_END(spurious_entries_start)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
-	.if \vector == X86_TRAP_PF
-		movq	%r12, %rdx		/* Move CR2 into 3rd argument */
-	.endif
-
 	call	\cfunc
 
 	jmp	error_exit
@@ -560,7 +546,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \vector \cfunc \has_error_code
+	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -635,7 +621,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector noist_\cfunc, has_error_code=0
+	idtentry_body noist_\cfunc, has_error_code=0
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -1040,18 +1026,9 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 #endif
 
 /*
- * Exception entry points.
+ * Reload gs selector with exception handling
+ * edi:  new selector
  */
-
-idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
-#ifdef CONFIG_KVM_GUEST
-idtentry	X86_TRAP_PF		async_page_fault	do_async_page_fault		has_error_code=1
-#endif
-
-	/*
-	 * Reload gs selector with exception handling
-	 * edi:  new selector
-	 */
 SYM_FUNC_START(native_load_gs_index)
 	FRAME_BEGIN
 	pushfq
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -399,6 +399,12 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+/* Page fault entry points */
+DECLARE_IDTENTRY_CR2(X86_TRAP_PF,	exc_page_fault);
+#ifdef CONFIG_KVM_GUEST
+DECLARE_IDTENTRY_CR2(X86_TRAP_PF,	exc_async_page_fault);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -92,7 +92,6 @@ void kvm_async_pf_task_wait(u32 token, i
 void kvm_async_pf_task_wake(u32 token);
 u32 kvm_read_and_reset_pf_reason(void);
 extern void kvm_disable_steal_time(void);
-void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
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
@@ -27,6 +16,9 @@ struct bad_iret_stack *fixup_bad_iret(st
 void __init trap_init(void);
 #endif
 
+void native_do_page_fault(struct pt_regs *regs, unsigned long error_code,
+			  unsigned long address);
+
 static inline int get_si_code(unsigned long condition)
 {
 	if (condition & DR_STEP)
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -59,7 +59,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_DB,		asm_exc_debug),
 	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
-	INTG(X86_TRAP_PF,		page_fault),
+	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
 };
 
@@ -153,7 +153,7 @@ static const __initconst struct idt_data
  * stacks work only after cpu_init().
  */
 static const __initconst struct idt_data early_pf_idts[] = {
-	INTG(X86_TRAP_PF,		page_fault),
+	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 };
 
 /*
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -242,12 +242,11 @@ u32 kvm_read_and_reset_pf_reason(void)
 EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
 NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
-dotraplinkage void
-do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
+DEFINE_IDTENTRY_CR2(exc_async_page_fault)
 {
 	switch (kvm_read_and_reset_pf_reason()) {
 	default:
-		do_page_fault(regs, error_code, address);
+		native_do_page_fault(regs, error_code, address);
 		break;
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
 		/* page is swapped out by the host. */
@@ -260,7 +259,6 @@ do_async_page_fault(struct pt_regs *regs
 		break;
 	}
 }
-NOKPROBE_SYMBOL(do_async_page_fault);
 
 static void __init paravirt_ops_setup(void)
 {
@@ -572,7 +570,7 @@ static int kvm_cpu_down_prepare(unsigned
 
 static void __init kvm_apf_trap_init(void)
 {
-	update_intr_gate(X86_TRAP_PF, async_page_fault);
+	update_intr_gate(X86_TRAP_PF, asm_exc_async_page_fault);
 }
 
 static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1500,20 +1500,26 @@ trace_page_fault_entries(struct pt_regs
 		trace_page_fault_kernel(address, regs, error_code);
 }
 
-dotraplinkage void
-do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
-		unsigned long address)
+/* Invoked from do_aync_page_fault() */
+void notrace native_do_page_fault(struct pt_regs *regs,
+				  unsigned long error_code,
+				  unsigned long address)
 {
 	prefetchw(&current->mm->mmap_sem);
-	trace_page_fault_entries(regs, hw_error_code, address);
+	trace_page_fault_entries(regs, error_code, address);
 
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
 
 	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address)))
-		do_kern_addr_fault(regs, hw_error_code, address);
+		do_kern_addr_fault(regs, error_code, address);
 	else
-		do_user_addr_fault(regs, hw_error_code, address);
+		do_user_addr_fault(regs, error_code, address);
+}
+NOKPROBE_SYMBOL(native_do_page_fault);
+
+DEFINE_IDTENTRY_CR2(exc_page_fault)
+{
+	native_do_page_fault(regs, error_code, address);
 }
-NOKPROBE_SYMBOL(do_page_fault);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -624,7 +624,7 @@ static struct trap_array_entry trap_arra
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
 #endif
-	{ page_fault,                  xen_page_fault,                  false },
+	TRAP_ENTRY(exc_page_fault,			false ),
 	TRAP_ENTRY(exc_divide_error,			false ),
 	TRAP_ENTRY(exc_bounds,				false ),
 	TRAP_ENTRY(exc_invalid_op,			false ),
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

