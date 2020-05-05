Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F9C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B080206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgEEOSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730283AbgEEORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E25C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNW-0002g0-69; Tue, 05 May 2020 16:16:59 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ADA54FFC8D;
        Tue,  5 May 2020 16:16:57 +0200 (CEST)
Message-Id: <20200505135831.067006961@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:54:11 +0200
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
Subject: [patch V4 part 5 30/31] x86/entry: Move paranoid irq tracing out of ASM code
References: <20200505135341.730586321@linutronix.de>
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |   13 -------------
 arch/x86/kernel/nmi.c     |   11 +++++++----
 2 files changed, 7 insertions(+), 17 deletions(-)

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
@@ -463,8 +457,6 @@ SYM_CODE_START(\asmsym)
 
 	UNWIND_HINT_REGS
 
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
 	.if \vector == X86_TRAP_DB
@@ -842,17 +834,13 @@ SYM_CODE_END(paranoid_entry)
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
@@ -1254,7 +1242,6 @@ SYM_CODE_START(asm_exc_nmi)
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
-	/* paranoidentry exc_nmi(), 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	exc_nmi
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -334,6 +334,8 @@ static noinstr void default_do_nmi(struc
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instr_begin();
+	trace_hardirqs_off_prepare();
+
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
 	if (handled) {
@@ -347,8 +349,7 @@ static noinstr void default_do_nmi(struc
 		 */
 		if (handled > 1)
 			__this_cpu_write(swallow_nmi, true);
-		instr_end();
-		return;
+		goto out;
 	}
 
 	/*
@@ -380,8 +381,7 @@ static noinstr void default_do_nmi(struc
 #endif
 		__this_cpu_add(nmi_stats.external, 1);
 		raw_spin_unlock(&nmi_reason_lock);
-		instr_end();
-		return;
+		goto out;
 	}
 	raw_spin_unlock(&nmi_reason_lock);
 
@@ -419,6 +419,9 @@ static noinstr void default_do_nmi(struc
 		__this_cpu_add(nmi_stats.swallow, 1);
 	else
 		unknown_nmi_error(reason, regs);
+out:
+	if (regs->flags & X86_EFLAGS_IF)
+		trace_hardirqs_on_prepare();
 	instr_end();
 }
 

