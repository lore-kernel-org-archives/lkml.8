Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD754C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE22520826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgEUUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgEUUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05205C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:17 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrr9-0000ra-Tz; Thu, 21 May 2020 22:31:56 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7121A100606;
        Thu, 21 May 2020 22:31:54 +0200 (CEST)
Message-Id: <20200521202119.927433002@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:46 +0200
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
Subject: [patch V9 33/39] x86/entry: Remove the apic/BUILD interrupt leftovers
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

Remove all the code which was there to emit the system vector stubs. All
users are gone.

Move the now unused GET_CR2_INTO macro muck to head_64.S where the last
user is. Fixup the eye hurting comment there while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/calling.h          |   20 -----
 arch/x86/entry/entry_32.S         |   18 ----
 arch/x86/entry/entry_64.S         |  143 --------------------------------------
 arch/x86/include/asm/entry_arch.h |   12 ---
 arch/x86/kernel/head_64.S         |    7 +
 5 files changed, 4 insertions(+), 196 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -351,23 +351,3 @@ For 32-bit we have the following convent
 	call stackleak_erase
 #endif
 .endm
-
-/*
- * This does 'call enter_from_user_mode' unless we can avoid it based on
- * kernel config or using the static jump infrastructure.
- */
-.macro CALL_enter_from_user_mode
-#ifdef CONFIG_CONTEXT_TRACKING
-#ifdef CONFIG_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_key, def=0
-#endif
-	call enter_from_user_mode
-.Lafter_call_\@:
-#endif
-.endm
-
-#ifdef CONFIG_PARAVIRT_XXL
-#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
-#else
-#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
-#endif
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1233,24 +1233,6 @@ SYM_FUNC_END(entry_INT80_32)
 #endif
 .endm
 
-#define BUILD_INTERRUPT3(name, nr, fn)			\
-SYM_FUNC_START(name)					\
-	ASM_CLAC;					\
-	pushl	$~(nr);					\
-	SAVE_ALL switch_stacks=1;			\
-	ENCODE_FRAME_POINTER;				\
-	TRACE_IRQS_OFF					\
-	movl	%esp, %eax;				\
-	call	fn;					\
-	jmp	ret_from_intr;				\
-SYM_FUNC_END(name)
-
-#define BUILD_INTERRUPT(name, nr)		\
-	BUILD_INTERRUPT3(name, nr, smp_##name);	\
-
-/* The include is where all of the SMP etc. interrupts come from */
-#include <asm/entry_arch.h>
-
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -658,108 +658,7 @@ SYM_CODE_END(\asmsym)
  */
 #include <asm/idtentry.h>
 
-/*
- * Interrupt entry helper function.
- *
- * Entry runs with interrupts off. Stack layout at entry:
- * +----------------------------------------------------+
- * | regs->ss						|
- * | regs->rsp						|
- * | regs->eflags					|
- * | regs->cs						|
- * | regs->ip						|
- * +----------------------------------------------------+
- * | regs->orig_ax = ~(interrupt number)		|
- * +----------------------------------------------------+
- * | return address					|
- * +----------------------------------------------------+
- */
-SYM_CODE_START(interrupt_entry)
-	UNWIND_HINT_IRET_REGS offset=16
-	ASM_CLAC
-	cld
-
-	testb	$3, CS-ORIG_RAX+8(%rsp)
-	jz	1f
-	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	/*
-	 * Switch to the thread stack. The IRET frame and orig_ax are
-	 * on the stack, as well as the return address. RDI..R12 are
-	 * not (yet) on the stack and space has not (yet) been
-	 * allocated for them.
-	 */
-	pushq	%rdi
-
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	 /*
-	  * We have RDI, return address, and orig_ax on the stack on
-	  * top of the IRET frame. That means offset=24
-	  */
-	UNWIND_HINT_IRET_REGS base=%rdi offset=24
-
-	pushq	7*8(%rdi)		/* regs->ss */
-	pushq	6*8(%rdi)		/* regs->rsp */
-	pushq	5*8(%rdi)		/* regs->eflags */
-	pushq	4*8(%rdi)		/* regs->cs */
-	pushq	3*8(%rdi)		/* regs->ip */
-	UNWIND_HINT_IRET_REGS
-	pushq	2*8(%rdi)		/* regs->orig_ax */
-	pushq	8(%rdi)			/* return address */
-
-	movq	(%rdi), %rdi
-	jmp	2f
-1:
-	FENCE_SWAPGS_KERNEL_ENTRY
-2:
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
-
-	testb	$3, CS+8(%rsp)
-	jz	1f
-
-	/*
-	 * IRQ from user mode.
-	 *
-	 * We need to tell lockdep that IRQs are off.  We can't do this until
-	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).  Since TRACE_IRQS_OFF is idempotent,
-	 * the simplest way to handle it is to just call it twice if
-	 * we enter from user mode.  There's no reason to optimize this since
-	 * TRACE_IRQS_OFF is a no-op if lockdep is off.
-	 */
-	TRACE_IRQS_OFF
-
-	CALL_enter_from_user_mode
-
-1:
-	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
-	/* We entered an interrupt context - irqs are off: */
-	TRACE_IRQS_OFF
-
-	ret
-SYM_CODE_END(interrupt_entry)
-_ASM_NOKPROBE(interrupt_entry)
-
 SYM_CODE_START_LOCAL(common_interrupt_return)
-ret_from_intr:
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
-
-	LEAVE_IRQ_STACK
-
-	testb	$3, CS(%rsp)
-	jz	retint_kernel
-
-	/* Interrupt came from user space */
-.Lretint_user:
-	mov	%rsp,%rdi
-	call	prepare_exit_to_usermode
-
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates user mode. */
@@ -802,23 +701,6 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 	INTERRUPT_RETURN
 
 
-/* Returning to kernel space */
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
@@ -932,31 +814,6 @@ SYM_CODE_END(common_interrupt_return)
 _ASM_NOKPROBE(common_interrupt_return)
 
 /*
- * APIC interrupts.
- */
-.macro apicinterrupt3 num sym do_sym
-SYM_CODE_START(\sym)
-	UNWIND_HINT_IRET_REGS
-	pushq	$~(\num)
-	call	interrupt_entry
-	UNWIND_HINT_REGS indirect=1
-	call	\do_sym	/* rdi points to pt_regs */
-	jmp	ret_from_intr
-SYM_CODE_END(\sym)
-_ASM_NOKPROBE(\sym)
-.endm
-
-/* Make sure APIC interrupt handlers end up in the irqentry section: */
-#define PUSH_SECTION_IRQENTRY	.pushsection .irqentry.text, "ax"
-#define POP_SECTION_IRQENTRY	.popsection
-
-.macro apicinterrupt num sym do_sym
-PUSH_SECTION_IRQENTRY
-apicinterrupt3 \num \sym \do_sym
-POP_SECTION_IRQENTRY
-.endm
-
-/*
  * Reload gs selector with exception handling
  * edi:  new selector
  *
--- a/arch/x86/include/asm/entry_arch.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This file is designed to contain the BUILD_INTERRUPT specifications for
- * all of the extra named interrupt vectors used by the architecture.
- * Usually this is the Inter Process Interrupts (IPIs)
- */
-
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs)
- */
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -29,15 +29,16 @@
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
+#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
 #else
 #define INTERRUPT_RETURN iretq
+#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
 #endif
 
-/* we are not able to switch in one step to the final KERNEL ADDRESS SPACE
+/*
+ * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
  * because we need identity-mapped pages.
- *
  */
-
 #define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 

