Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE11BC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E12720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgEEOTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730088AbgEEOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5631C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMe-00024a-Gw; Tue, 05 May 2020 16:16:04 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 18C0BFFC8D;
        Tue,  5 May 2020 16:16:04 +0200 (CEST)
Message-Id: <20200505135314.900297476@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:42 +0200
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
Subject: [patch V4 part 4 16/24] x86/entry: Convert Debug exception to IDTENTRY_DB
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

Convert #DB to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY_DB
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |   10 ----------
 arch/x86/entry/entry_64.S       |    2 --
 arch/x86/include/asm/idtentry.h |    4 ++++
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    8 ++++----
 arch/x86/kernel/traps.c         |   21 +++++++++++++--------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    4 ++--
 8 files changed, 24 insertions(+), 30 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1488,16 +1488,6 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exce
 	jmp	restore_all_switch_stack
 SYM_CODE_END(handle_exception)
 
-SYM_CODE_START(debug)
-	/*
-	 * Entry from sysenter is now handled in common_exception
-	 */
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_debug
-	jmp	common_exception
-SYM_CODE_END(debug)
-
 #ifdef CONFIG_DOUBLEFAULT
 SYM_CODE_START(double_fault)
 1:
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1075,12 +1075,10 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-idtentry_mce_db	X86_TRAP_DB		debug			do_debug
 idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
 #endif
 
 /*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -262,4 +262,8 @@ DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_ma
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
 DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
 
+/* #DB */
+DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
+DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
+
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,7 +11,6 @@
 
 #define dotraplinkage __visible
 
-asmlinkage void debug(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
@@ -19,12 +18,10 @@ asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
 #endif
 
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -56,7 +56,7 @@ struct idt_data {
  * stacks work only after cpu_init().
  */
 static const __initconst struct idt_data early_idts[] = {
-	INTG(X86_TRAP_DB,		debug),
+	INTG(X86_TRAP_DB,		asm_exc_debug),
 	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
 	INTG(X86_TRAP_PF,		page_fault),
@@ -90,7 +90,7 @@ static const __initconst struct idt_data
 #else
 	INTG(X86_TRAP_DF,		double_fault),
 #endif
-	INTG(X86_TRAP_DB,		debug),
+	INTG(X86_TRAP_DB,		asm_exc_debug),
 
 #ifdef CONFIG_X86_MCE
 	INTG(X86_TRAP_MC,		asm_exc_machine_check),
@@ -161,7 +161,7 @@ static const __initconst struct idt_data
  * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
  */
 static const __initconst struct idt_data dbg_idts[] = {
-	INTG(X86_TRAP_DB,	debug),
+	INTG(X86_TRAP_DB,		asm_exc_debug),
 };
 #endif
 
@@ -182,7 +182,7 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,			IST_INDEX_DB),
+	ISTG(X86_TRAP_DB,	asm_exc_debug,		IST_INDEX_DB),
 	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
 	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -753,7 +753,7 @@ static __always_inline void debug_exit(u
  *
  * May run on IST stack.
  */
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
 	struct task_struct *tsk = current;
 	unsigned long dr6, dr7;
@@ -762,7 +762,10 @@ dotraplinkage void do_debug(struct pt_re
 
 	debug_enter(&dr6, &dr7);
 
-	nmi_enter();
+	if (user_mode(regs))
+		idtentry_enter(regs);
+	else
+		nmi_enter();
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
@@ -799,7 +802,7 @@ dotraplinkage void do_debug(struct pt_re
 		goto exit;
 #endif
 
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
@@ -813,8 +816,8 @@ dotraplinkage void do_debug(struct pt_re
 	cond_local_irq_enable(regs);
 
 	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code,
-					X86_TRAP_DB);
+		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
+				 X86_TRAP_DB);
 		cond_local_irq_disable(regs);
 		debug_stack_usage_dec();
 		goto exit;
@@ -833,15 +836,17 @@ dotraplinkage void do_debug(struct pt_re
 	}
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, error_code, si_code);
+		send_sigtrap(regs, 0, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 
 exit:
-	nmi_exit();
+	if (user_mode(regs))
+		idtentry_exit(regs);
+	else
+		nmi_exit();
 	debug_exit(dr7);
 }
-NOKPROBE_SYMBOL(do_debug);
 
 /*
  * Note that we play around with the 'TS' bit in an attempt to get
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -616,7 +616,7 @@ struct trap_array_entry {
 	.ist_okay	= ist_ok }
 
 static struct trap_array_entry trap_array[] = {
-	{ debug,                       xen_xendebug,                    true },
+	TRAP_ENTRY_REDIR(exc_debug, exc_xendebug,	true  ),
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY(exc_machine_check,			true  ),
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -29,8 +29,8 @@ SYM_CODE_END(xen_\name)
 .endm
 
 xen_pv_trap asm_exc_divide_error
-xen_pv_trap debug
-xen_pv_trap xendebug
+xen_pv_trap asm_exc_debug
+xen_pv_trap asm_exc_xendebug
 xen_pv_trap asm_exc_int3
 xen_pv_trap asm_exc_xennmi
 xen_pv_trap asm_exc_overflow

