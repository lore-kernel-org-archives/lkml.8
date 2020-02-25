Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C2C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB51E24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgBYX0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgBYX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:34 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaf-0004tN-FH; Wed, 26 Feb 2020 00:26:14 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 454EF100375;
        Wed, 26 Feb 2020 00:25:45 +0100 (CET)
Message-Id: <20200225224144.622102533@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:26 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 05/16] x86/entry: Convert Debug exception to IDTENTRY_DB
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
 arch/x86/kernel/traps.c         |   13 ++++++-------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    4 ++--
 8 files changed, 17 insertions(+), 29 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1455,16 +1455,6 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exce
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)
 
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
@@ -1066,12 +1066,10 @@ idtentry	X86_TRAP_PF		page_fault		do_pag
 idtentry	X86_TRAP_PF		async_page_fault	do_async_page_fault		has_error_code=1
 #endif
 
-idtentry_mce_db	X86_TRAP_DB		debug			do_debug
 idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
 #endif
 
 	/*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -242,4 +242,8 @@ DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_ma
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
@@ -739,7 +739,7 @@ static bool is_sysenter_singlestep(struc
  *
  * May run on IST stack.
  */
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
 	struct task_struct *tsk = current;
 	int user_icebp = 0;
@@ -800,8 +800,8 @@ dotraplinkage void do_debug(struct pt_re
 		goto exit;
 #endif
 
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
-							SIGTRAP) == NOTIFY_STOP)
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
+		       SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
 	/*
@@ -814,8 +814,8 @@ dotraplinkage void do_debug(struct pt_re
 	cond_local_irq_enable(regs);
 
 	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code,
-					X86_TRAP_DB);
+		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
+				 X86_TRAP_DB);
 		cond_local_irq_disable(regs);
 		debug_stack_usage_dec();
 		goto exit;
@@ -834,14 +834,13 @@ dotraplinkage void do_debug(struct pt_re
 	}
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, error_code, si_code);
+		send_sigtrap(regs, 0, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 
 exit:
 	ist_exit(regs);
 }
-NOKPROBE_SYMBOL(do_debug);
 
 /*
  * Note that we play around with the 'TS' bit in an attempt to get
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -613,7 +613,7 @@ struct trap_array_entry {
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

