Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE1420849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEST7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgEST6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8EEC08C5C2;
        Tue, 19 May 2020 12:58:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ny-0008V6-Ho; Tue, 19 May 2020 21:58:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8AEDB1C0837;
        Tue, 19 May 2020 21:58:37 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:37 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Distangle idtentry
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134903.949227617@linutronix.de>
References: <20200505134903.949227617@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831742.17951.6945291686466516773.tip-bot2@tip-bot2>
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

Commit-ID:     696ab9143a5fc25eaaedd589bc9939c58d626030
Gitweb:        https://git.kernel.org/tip/696ab9143a5fc25eaaedd589bc9939c58d626030
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:55 +02:00

x86/entry: Distangle idtentry

idtentry is a completely unreadable maze. Split it into distinct idtentry
variants which only contain the minimal code:

  - idtentry for regular exceptions
  - idtentry_mce_debug for #MCE and #DB
  - idtentry_df for #DF

The generated binary code is equivalent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134903.949227617@linutronix.de



---
 arch/x86/entry/entry_64.S | 403 ++++++++++++++++++++-----------------
 1 file changed, 220 insertions(+), 183 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e62061e..01bfe7f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -37,6 +37,7 @@
 #include <asm/pgtable_types.h>
 #include <asm/export.h>
 #include <asm/frame.h>
+#include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 #include <linux/err.h>
 
@@ -493,6 +494,202 @@ SYM_CODE_END(spurious_entries_start)
 	decl	PER_CPU_VAR(irq_count)
 .endm
 
+/**
+ * idtentry_body - Macro to emit code calling the C function
+ * @vector:		Vector number
+ * @cfunc:		C function to be called
+ * @has_error_code:	Hardware pushed error code on stack
+ */
+.macro idtentry_body vector cfunc has_error_code:req
+
+	call	error_entry
+	UNWIND_HINT_REGS
+
+	.if \vector == X86_TRAP_PF
+		/*
+		 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
+		 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
+		 * GET_CR2_INTO can clobber RAX.
+		 */
+		GET_CR2_INTO(%r12);
+	.endif
+
+	TRACE_IRQS_OFF
+
+#ifdef CONFIG_CONTEXT_TRACKING
+	testb	$3, CS(%rsp)
+	jz	.Lfrom_kernel_no_ctxt_tracking_\@
+	CALL_enter_from_user_mode
+.Lfrom_kernel_no_ctxt_tracking_\@:
+#endif
+
+	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
+
+	.if \has_error_code == 1
+		movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
+		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	.else
+		xorl	%esi, %esi		/* Clear the error code */
+	.endif
+
+	.if \vector == X86_TRAP_PF
+		movq	%r12, %rdx		/* Move CR2 into 3rd argument */
+	.endif
+
+	call	\cfunc
+
+	jmp	error_exit
+.endm
+
+/**
+ * idtentry - Macro to generate entry stubs for simple IDT entries
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ * @has_error_code:	Hardware pushed error code on stack
+ *
+ * The macro emits code to set up the kernel context for straight forward
+ * and simple IDT entries. No IST stack, no paranoid entry checks.
+ */
+.macro idtentry vector asmsym cfunc has_error_code:req
+SYM_CODE_START(\asmsym)
+	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
+	ASM_CLAC
+
+	.if \has_error_code == 0
+		pushq	$-1			/* ORIG_RAX: no syscall to restart */
+	.endif
+
+	.if \vector == X86_TRAP_BP
+		/*
+		 * If coming from kernel space, create a 6-word gap to allow the
+		 * int3 handler to emulate a call instruction.
+		 */
+		testb	$3, CS-ORIG_RAX(%rsp)
+		jnz	.Lfrom_usermode_no_gap_\@
+		.rept	6
+		pushq	5*8(%rsp)
+		.endr
+		UNWIND_HINT_IRET_REGS offset=8
+.Lfrom_usermode_no_gap_\@:
+	.endif
+
+	idtentry_body \vector \cfunc \has_error_code
+
+_ASM_NOKPROBE(\asmsym)
+SYM_CODE_END(\asmsym)
+.endm
+
+/*
+ * MCE and DB exceptions
+ */
+#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
+
+/**
+ * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ *
+ * The macro emits code to set up the kernel context for #MC and #DB
+ *
+ * If the entry comes from user space it uses the normal entry path
+ * including the return to user space work and preemption checks on
+ * exit.
+ *
+ * If hits in kernel mode then it needs to go through the paranoid
+ * entry as the exception can hit any random state. No preemption
+ * check on exit to keep the paranoid path simple.
+ *
+ * If the trap is #DB then the interrupt stack entry in the IST is
+ * moved to the second stack, so a potential recursion will have a
+ * fresh IST.
+ */
+.macro idtentry_mce_db vector asmsym cfunc
+SYM_CODE_START(\asmsym)
+	UNWIND_HINT_IRET_REGS
+	ASM_CLAC
+
+	pushq	$-1			/* ORIG_RAX: no syscall to restart */
+
+	/*
+	 * If the entry is from userspace, switch stacks and treat it as
+	 * a normal entry.
+	 */
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jnz	.Lfrom_usermode_switch_stack_\@
+
+	/*
+	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
+	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
+	 */
+	call	paranoid_entry
+
+	UNWIND_HINT_REGS
+
+	.if \vector == X86_TRAP_DB
+		TRACE_IRQS_OFF_DEBUG
+	.else
+		TRACE_IRQS_OFF
+	.endif
+
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	xorl	%esi, %esi		/* Clear the error code */
+
+	.if \vector == X86_TRAP_DB
+		subq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
+	.endif
+
+	call	\cfunc
+
+	.if \vector == X86_TRAP_DB
+		addq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
+	.endif
+
+	jmp	paranoid_exit
+
+	/* Switch to the regular task stack and use the noist entry point */
+.Lfrom_usermode_switch_stack_\@:
+	idtentry_body vector \cfunc, has_error_code=0
+
+_ASM_NOKPROBE(\asmsym)
+SYM_CODE_END(\asmsym)
+.endm
+
+/*
+ * Double fault entry. Straight paranoid. No checks from which context
+ * this comes because for the espfix induced #DF this would do the wrong
+ * thing.
+ */
+.macro idtentry_df vector asmsym cfunc
+SYM_CODE_START(\asmsym)
+	UNWIND_HINT_IRET_REGS offset=8
+	ASM_CLAC
+
+	/*
+	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
+	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
+	 */
+	call	paranoid_entry
+	UNWIND_HINT_REGS
+
+	/* Read CR2 early */
+	GET_CR2_INTO(%r12);
+
+	TRACE_IRQS_OFF
+
+	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
+	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
+	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	movq	%r12, %rdx		/* Move CR2 into 3rd argument */
+	call	\cfunc
+
+	jmp	paranoid_exit
+
+_ASM_NOKPROBE(\asmsym)
+SYM_CODE_END(\asmsym)
+.endm
+
 /*
  * Interrupt entry helper function.
  *
@@ -860,195 +1057,35 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 /*
  * Exception entry points.
  */
-#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
-
-.macro idtentry_part do_sym, has_error_code:req, read_cr2:req, paranoid:req, shift_ist=-1, ist_offset=0
-
-	.if \paranoid
-	call	paranoid_entry
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
-	.else
-	call	error_entry
-	.endif
-	UNWIND_HINT_REGS
-
-	.if \read_cr2
-	/*
-	 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
-	 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
-	 * GET_CR2_INTO can clobber RAX.
-	 */
-	GET_CR2_INTO(%r12);
-	.endif
-
-	.if \shift_ist != -1
-	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
-	.else
-	TRACE_IRQS_OFF
-	.endif
-
-#ifdef CONFIG_CONTEXT_TRACKING
-	.if \paranoid == 0
-	testb	$3, CS(%rsp)
-	jz	.Lfrom_kernel_no_context_tracking_\@
-	CALL_enter_from_user_mode
-.Lfrom_kernel_no_context_tracking_\@:
-	.endif
-#endif
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
-	.endif
-
-	.if \shift_ist != -1
-	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	.if \read_cr2
-	movq	%r12, %rdx			/* Move CR2 into 3rd argument */
-	.endif
-
-	call	\do_sym
-
-	.if \shift_ist != -1
-	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	.if \paranoid
-	/* this procedure expect "no swapgs" flag in ebx */
-	jmp	paranoid_exit
-	.else
-	jmp	error_exit
-	.endif
-
-.endm
-
-/**
- * idtentry - Generate an IDT entry stub
- * @sym:		Name of the generated entry point
- * @do_sym:		C function to be called
- * @has_error_code:	True if this IDT vector has an error code on the stack
- * @paranoid:		non-zero means that this vector may be invoked from
- *			kernel mode with user GSBASE and/or user CR3.
- *			2 is special -- see below.
- * @shift_ist:		Set to an IST index if entries from kernel mode should
- *			decrement the IST stack so that nested entries get a
- *			fresh stack.  (This is for #DB, which has a nasty habit
- *			of recursing.)
- * @create_gap:		create a 6-word stack gap when coming from kernel mode.
- * @read_cr2:		load CR2 into the 3rd argument; done before calling any C code
- *
- * idtentry generates an IDT stub that sets up a usable kernel context,
- * creates struct pt_regs, and calls @do_sym.  The stub has the following
- * special behaviors:
- *
- * On an entry from user mode, the stub switches from the trampoline or
- * IST stack to the normal thread stack.  On an exit to user mode, the
- * normal exit-to-usermode path is invoked.
- *
- * On an exit to kernel mode, if @paranoid == 0, we check for preemption,
- * whereas we omit the preemption check if @paranoid != 0.  This is purely
- * because the implementation is simpler this way.  The kernel only needs
- * to check for asynchronous kernel preemption when IRQ handlers return.
- *
- * If @paranoid == 0, then the stub will handle IRET faults by pretending
- * that the fault came from user mode.  It will handle gs_change faults by
- * pretending that the fault happened with kernel GSBASE.  Since this handling
- * is omitted for @paranoid != 0, the #GP, #SS, and #NP stubs must have
- * @paranoid == 0.  This special handling will do the wrong thing for
- * espfix-induced #DF on IRET, so #DF must not use @paranoid == 0.
- *
- * @paranoid == 2 is special: the stub will never switch stacks.  This is for
- * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
- */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
-SYM_CODE_START(\sym)
-	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
-
-	/* Sanity check */
-	.if \shift_ist != -1 && \paranoid != 1
-	.error "using shift_ist requires paranoid=1"
-	.endif
-
-	.if \create_gap && \paranoid
-	.error "using create_gap requires paranoid=0"
-	.endif
-
-	ASM_CLAC
-
-	.if \has_error_code == 0
-	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	.endif
-
-	.if \paranoid == 1
-	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
-	jnz	.Lfrom_usermode_switch_stack_\@
-	.endif
-
-	.if \create_gap == 1
-	/*
-	 * If coming from kernel space, create a 6-word gap to allow the
-	 * int3 handler to emulate a call instruction.
-	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
-	jnz	.Lfrom_usermode_no_gap_\@
-	.rept	6
-	pushq	5*8(%rsp)
-	.endr
-	UNWIND_HINT_IRET_REGS offset=8
-.Lfrom_usermode_no_gap_\@:
-	.endif
-
-	idtentry_part \do_sym, \has_error_code, \read_cr2, \paranoid, \shift_ist, \ist_offset
-
-	.if \paranoid == 1
-	/*
-	 * Entry from userspace.  Switch stacks and treat it
-	 * as a normal entry.  This means that paranoid handlers
-	 * run in real process context if user_mode(regs).
-	 */
-.Lfrom_usermode_switch_stack_\@:
-	idtentry_part \do_sym, \has_error_code, \read_cr2, paranoid=0
-	.endif
-
-_ASM_NOKPROBE(\sym)
-SYM_CODE_END(\sym)
-.endm
-
 
-idtentry divide_error			do_divide_error			has_error_code=0
-idtentry overflow			do_overflow			has_error_code=0
-idtentry int3				do_int3				has_error_code=0	create_gap=1
-idtentry bounds				do_bounds			has_error_code=0
-idtentry invalid_op			do_invalid_op			has_error_code=0
-idtentry device_not_available		do_device_not_available		has_error_code=0
-idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
-idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
-idtentry segment_not_present		do_segment_not_present		has_error_code=1
-idtentry stack_segment			do_stack_segment		has_error_code=1
-idtentry general_protection		do_general_protection		has_error_code=1
-idtentry spurious_interrupt_bug		do_spurious_interrupt_bug	has_error_code=0
-idtentry coprocessor_error		do_coprocessor_error		has_error_code=0
-idtentry alignment_check		do_alignment_check		has_error_code=1
-idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
-
-idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
+idtentry	X86_TRAP_DE		divide_error		do_divide_error			has_error_code=0
+idtentry	X86_TRAP_OF		overflow		do_overflow			has_error_code=0
+idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
+idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
+idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
+idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
+idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
+idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
+idtentry	X86_TRAP_NP		segment_not_present	do_segment_not_present		has_error_code=1
+idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
+idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
+idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
+idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
+idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
+idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
+
+idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
 #ifdef CONFIG_X86_MCE
-idtentry machine_check		do_mce			has_error_code=0 paranoid=1
+idtentry_mce_db	X86_TRAP_MCE	 	machine_check		do_mce
 #endif
-idtentry debug			do_debug		has_error_code=0 paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
-idtentry double_fault		do_double_fault		has_error_code=1 paranoid=2 read_cr2=1
+idtentry_mce_db	X86_TRAP_DB		debug			do_debug
+idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
 #ifdef CONFIG_XEN_PV
-idtentry hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-idtentry xennmi			do_nmi				has_error_code=0
-idtentry xendebug		do_debug			has_error_code=0
+idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
+idtentry	X86_TRAP_NMI		xennmi			do_nmi				has_error_code=0
+idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
 #endif
 
 /*
