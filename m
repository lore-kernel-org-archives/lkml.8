Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F30C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC18220874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgEUUcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgEUUc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BABC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:28 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrrF-0000xX-6G; Thu, 21 May 2020 22:32:01 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A8885100C2D;
        Thu, 21 May 2020 22:32:00 +0200 (CEST)
Message-Id: <20200521202120.414043330@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:51 +0200
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
Subject: [patch V9 38/39] x86/entry: Move paranoid irq tracing out of ASM code
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

The last step to remove the irq tracing cruft from ASM. Ignore #DF as the
maschine is going to die anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: Fixup #DB, #MCE, #INT3 as well
---
 arch/x86/entry/entry_64.S      |   13 -------------
 arch/x86/kernel/cpu/mce/core.c |    3 +++
 arch/x86/kernel/nmi.c          |    3 +++
 arch/x86/kernel/traps.c        |   11 +++++++++++
 4 files changed, 17 insertions(+), 13 deletions(-)

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
@@ -1292,7 +1280,6 @@ SYM_CODE_START(asm_exc_nmi)
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
-	/* paranoidentry exc_nmi(), 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	exc_nmi
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1922,7 +1922,10 @@ static __always_inline void exc_machine_
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
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -334,6 +334,7 @@ static noinstr void default_do_nmi(struc
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
+	trace_hardirqs_off_prepare();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -420,6 +421,8 @@ static noinstr void default_do_nmi(struc
 		unknown_nmi_error(reason, regs);
 
 out:
+	if (regs->flags & X86_EFLAGS_IF)
+		trace_hardirqs_on_prepare();
 	instrumentation_end();
 }
 
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
@@ -850,6 +853,10 @@ static __always_inline void exc_debug_ke
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
@@ -871,6 +878,10 @@ static __always_inline void exc_debug_ke
 	if (dr6)
 		handle_debug(regs, dr6, false);
 
+	instrumentation_begin();
+	if (regs->flags & X86_EFLAGS_IF)
+		trace_hardirqs_on_prepare();
+	instrumentation_end();
 	nmi_exit();
 }
 

