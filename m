Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46920C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FF20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgEEOU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729901AbgEEOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF96C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLx-0001bC-4d; Tue, 05 May 2020 16:15:21 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 93047FFC8D;
        Tue,  5 May 2020 16:15:20 +0200 (CEST)
Message-Id: <20200505134905.637269946@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 3 24/29] x86/entry: Convert General protection
 exception to IDTENTRY
References: <20200505134354.774943181@linutronix.de>
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

Convert #GP to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Fixup simd on 32bit to exc_general_protection
---
 arch/x86/entry/entry_32.S       |    8 +-------
 arch/x86/entry/entry_64.S       |    3 +--
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    8 +++-----
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 9 insertions(+), 20 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1302,7 +1302,7 @@ SYM_CODE_START(simd_coprocessor_error)
 	pushl	$0
 #ifdef CONFIG_X86_INVD_BUG
 	/* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
-	ALTERNATIVE "pushl	$do_general_protection",	\
+	ALTERNATIVE "pushl	$exc_general_protection",	\
 		    "pushl	$do_simd_coprocessor_error",	\
 		    X86_FEATURE_XMM
 #else
@@ -1692,12 +1692,6 @@ SYM_CODE_START(int3)
 	jmp	common_exception
 SYM_CODE_END(int3)
 
-SYM_CODE_START(general_protection)
-	ASM_CLAC
-	pushl	$do_general_protection
-	jmp	common_exception
-SYM_CODE_END(general_protection)
-
 .pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,7 +1074,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
 idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
 idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
 idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
@@ -1210,7 +1209,7 @@ SYM_CODE_START(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	pushq	$0				/* RIP */
 	UNWIND_HINT_IRET_REGS offset=8
-	jmp	general_protection
+	jmp	asm_exc_general_protection
 1:	/* Segment mismatch => Category 1 (Bad segment). Retry the IRET. */
 	movq	(%rsp), %rcx
 	movq	8(%rsp), %r11
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -134,5 +134,6 @@ DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_co
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -17,7 +17,6 @@ asmlinkage void int3(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
-asmlinkage void general_protection(void);
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
 asmlinkage void spurious_interrupt_bug(void);
@@ -33,7 +32,6 @@ asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
-asmlinkage void xen_general_protection(void);
 asmlinkage void xen_page_fault(void);
 asmlinkage void xen_spurious_interrupt_bug(void);
 asmlinkage void xen_coprocessor_error(void);
@@ -50,7 +48,6 @@ dotraplinkage void do_int3(struct pt_reg
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
-dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -79,7 +79,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_TS,		asm_exc_invalid_tss),
 	INTG(X86_TRAP_NP,		asm_exc_segment_not_present),
 	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
-	INTG(X86_TRAP_GP,		general_protection),
+	INTG(X86_TRAP_GP,		asm_exc_general_protection),
 	INTG(X86_TRAP_SPURIOUS,		spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		coprocessor_error),
 	INTG(X86_TRAP_AC,		alignment_check),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -145,7 +145,7 @@ do_trap_no_signal(struct task_struct *ts
 	 * process no chance to handle the signal and notice the
 	 * kernel fault information, so that won't result in polluting
 	 * the information about previously queued, but not yet
-	 * delivered, faults.  See also do_general_protection below.
+	 * delivered, faults.  See also exc_general_protection below.
 	 */
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = trapnr;
@@ -366,7 +366,7 @@ dotraplinkage void do_double_fault(struc
 		 * which is what the stub expects, given that the faulting
 		 * RIP will be the IRET instruction.
 		 */
-		regs->ip = (unsigned long)general_protection;
+		regs->ip = (unsigned long)asm_exc_general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
 		return;
@@ -486,7 +486,7 @@ static enum kernel_gp_hint get_kernel_gp
 
 #define GPFSTR "general protection fault"
 
-dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
@@ -494,7 +494,6 @@ dotraplinkage void do_general_protection
 	unsigned long gp_addr;
 	int ret;
 
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
@@ -562,7 +561,6 @@ dotraplinkage void do_general_protection
 exit:
 	cond_local_irq_disable(regs);
 }
-NOKPROBE_SYMBOL(do_general_protection);
 
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -631,7 +631,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_invalid_tss,			false ),
 	TRAP_ENTRY(exc_segment_not_present,		false ),
 	TRAP_ENTRY(exc_stack_segment,			false ),
-	{ general_protection,          xen_general_protection,          false },
+	TRAP_ENTRY(exc_general_protection,		false ),
 	{ spurious_interrupt_bug,      xen_spurious_interrupt_bug,      false },
 	{ coprocessor_error,           xen_coprocessor_error,           false },
 	{ alignment_check,             xen_alignment_check,             false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -42,7 +42,7 @@ xen_pv_trap asm_exc_coproc_segment_overr
 xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present
 xen_pv_trap asm_exc_stack_segment
-xen_pv_trap general_protection
+xen_pv_trap asm_exc_general_protection
 xen_pv_trap page_fault
 xen_pv_trap spurious_interrupt_bug
 xen_pv_trap coprocessor_error

