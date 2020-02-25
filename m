Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7ECC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3969224680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgBYX1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56034 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgBYX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:00 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jb1-00056Y-ND; Wed, 26 Feb 2020 00:26:36 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B844F1040C6;
        Wed, 26 Feb 2020 00:25:53 +0100 (CET)
Message-Id: <20200225231610.123348205@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:31 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 12/15] x86/entry: Remove the apic/BUILD interrupt leftovers
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

Remove all the code which was there to emit the system vector stubs. All
users are gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |   15 -----
 arch/x86/entry/entry_64.S |  118 ----------------------------------------------
 2 files changed, 133 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1271,21 +1271,6 @@ SYM_CODE_END(asm_\cfunc)
  */
 #include <asm/idtentry.h>
 
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
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -700,103 +700,7 @@ SYM_CODE_END(\asmsym)
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
-	UNWIND_HINT_FUNC
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
-	pushq	2*8(%rdi)		/* regs->orig_ax */
-	pushq	8(%rdi)			/* return address */
-	UNWIND_HINT_FUNC
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
 	/* Interrupt came from user space */
 .Lretint_user:
 	mov	%rsp,%rdi
@@ -973,28 +877,6 @@ SYM_CODE_END(common_interrupt_return)
 _ASM_NOKPROBE(common_interrupt_return)
 
 /*
- * APIC interrupts.
- */
-.macro apicinterrupt3 num sym do_sym
-SYM_CODE_START(\sym)
-	UNWIND_HINT_IRET_REGS
-	pushq	$~(\num)
-.Lcommon_\sym:
-	call	interrupt_entry
-	UNWIND_HINT_REGS indirect=1
-	call	\do_sym	/* rdi points to pt_regs */
-	jmp	ret_from_intr
-SYM_CODE_END(\sym)
-_ASM_NOKPROBE(\sym)
-.endm
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
  */

