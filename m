Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA76C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345F52084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgEEOQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730024AbgEEOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D11C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:10 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMS-0001tB-9J; Tue, 05 May 2020 16:15:52 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ACCD01001F5;
        Tue,  5 May 2020 16:15:51 +0200 (CEST)
Message-Id: <20200505135313.938474960@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:32 +0200
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
Subject: [patch V4 part 4 06/24] x86/entry: Convert INT3 exception to IDTENTRY_RAW
References: <20200505134926.578885807@linutronix.de>
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

Convert #BP to IDTENTRY_RAW:
  - Implement the C entry point with DEFINE_IDTENTRY_RAW
  - Invoke idtentry_enter/exit() from the function body
  - Emit the ASM stub with DECLARE_IDTENTRY_RAW
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

This could be a plain IDTENTRY, but as Peter pointed out INT3 is broken
vs. the static key in the context tracking code as this static key might be
in the state of being patched and has an int3 which would recurse forever.
IDTENTRY_RAW is therefore chosen to allow addressing this issue without
lots of code churn.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/entry/entry_32.S       |    7 -------
 arch/x86/entry/entry_64.S       |    2 --
 arch/x86/include/asm/idtentry.h |    3 +++
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |   28 +++++++++++++++++-----------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 23 insertions(+), 26 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1651,13 +1651,6 @@ SYM_CODE_START(nmi)
 #endif
 SYM_CODE_END(nmi)
 
-SYM_CODE_START(int3)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_int3
-	jmp	common_exception
-SYM_CODE_END(int3)
-
 .pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,8 +1073,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
 #ifdef CONFIG_X86_MCE
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -181,4 +181,7 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+/* Raw exception entries which need extra work */
+DECLARE_IDTENTRY_RAW(X86_TRAP_BP,	exc_int3);
+
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -13,7 +13,6 @@
 
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
-asmlinkage void int3(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
@@ -26,7 +25,6 @@ asmlinkage void machine_check(void);
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
-asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
 #ifdef CONFIG_X86_MCE
@@ -36,7 +34,6 @@ asmlinkage void xen_machine_check(void);
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
-dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -57,7 +57,7 @@ struct idt_data {
  */
 static const __initconst struct idt_data early_idts[] = {
 	INTG(X86_TRAP_DB,		debug),
-	SYSG(X86_TRAP_BP,		int3),
+	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
 	INTG(X86_TRAP_PF,		page_fault),
 #endif
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -564,7 +564,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	cond_local_irq_disable(regs);
 }
 
-dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_RAW(exc_int3)
 {
 	/*
 	 * poke_int3_handler() is completely self contained code; it does (and
@@ -575,16 +575,20 @@ dotraplinkage void notrace do_int3(struc
 		return;
 
 	/*
-	 * Unlike any other non-IST entry, we can be called from pretty much
-	 * any location in the kernel through kprobes -- text_poke() will most
-	 * likely be handled by poke_int3_handler() above. This means this
-	 * handler is effectively NMI-like.
+	 * idtentry_enter() uses static_branch_{,un}likely() and therefore
+	 * can trigger INT3, hence poke_int3_handler() must be done
+	 * before. If the entry came from kernel mode, then use nmi_enter()
+	 * because the INT3 could have been hit in any context including
+	 * NMI.
 	 */
-	if (!user_mode(regs))
+	if (user_mode(regs))
+		idtentry_enter(regs);
+	else
 		nmi_enter();
 
+	instr_begin();
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
-	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
+	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
 				SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 #endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
@@ -594,19 +598,21 @@ dotraplinkage void notrace do_int3(struc
 		goto exit;
 #endif
 
-	if (notify_die(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
+	if (notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
 	cond_local_irq_enable(regs);
-	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, 0, NULL);
+	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
 	cond_local_irq_disable(regs);
 
 exit:
-	if (!user_mode(regs))
+	instr_end();
+	if (user_mode(regs))
+		idtentry_exit(regs);
+	else
 		nmi_exit();
 }
-NOKPROBE_SYMBOL(do_int3);
 
 #ifdef CONFIG_X86_64
 /*
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -617,7 +617,7 @@ static struct trap_array_entry trap_arra
 	{ machine_check,               xen_machine_check,               true },
 #endif
 	{ nmi,                         xen_xennmi,                      true },
-	{ int3,                        xen_int3,                        false },
+	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -31,7 +31,7 @@ SYM_CODE_END(xen_\name)
 xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
-xen_pv_trap int3
+xen_pv_trap asm_exc_int3
 xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds

