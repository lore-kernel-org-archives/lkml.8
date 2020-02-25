Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE2AC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A235524685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgBYX2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgBYX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:29 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jab-0004rn-PY; Wed, 26 Feb 2020 00:26:11 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 920E2104098;
        Wed, 26 Feb 2020 00:25:44 +0100 (CET)
Message-Id: <20200225224144.313300304@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:23 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 02/16] x86/entry: Convert Machine Check to IDTENTRY_IST
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

Convert #MC to IDTENTRY_MCE:
  - Implement the C entry points with DEFINE_IDTENTRY_MCE
  - Emit the ASM stub with DECLARE_IDTENTRY_MCE
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes
  - Remove the error code from *machine_check_vector() as
    it is always 0 and not used by any of the functions
    it can point to. Fixup all the functions as well.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S          |    9 ---------
 arch/x86/entry/entry_64.S          |    3 ---
 arch/x86/include/asm/idtentry.h    |    5 +++++
 arch/x86/include/asm/mce.h         |    2 +-
 arch/x86/include/asm/traps.h       |    7 -------
 arch/x86/kernel/cpu/mce/core.c     |   14 ++++++--------
 arch/x86/kernel/cpu/mce/inject.c   |    4 ++--
 arch/x86/kernel/cpu/mce/internal.h |    2 +-
 arch/x86/kernel/cpu/mce/p5.c       |    2 +-
 arch/x86/kernel/cpu/mce/winchip.c  |    2 +-
 arch/x86/kernel/idt.c              |   10 +++++-----
 arch/x86/kvm/vmx/vmx.c             |    2 +-
 arch/x86/xen/enlighten_pv.c        |    2 +-
 arch/x86/xen/xen-asm_64.S          |    2 +-
 14 files changed, 25 insertions(+), 41 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1306,15 +1306,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-#ifdef CONFIG_X86_MCE
-SYM_CODE_START(machine_check)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_mce
-	jmp	common_exception
-SYM_CODE_END(machine_check)
-#endif
-
 #ifdef CONFIG_XEN_PV
 SYM_FUNC_START(xen_hypervisor_callback)
 	/*
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1066,9 +1066,6 @@ idtentry	X86_TRAP_PF		page_fault		do_pag
 idtentry	X86_TRAP_PF		async_page_fault	do_async_page_fault		has_error_code=1
 #endif
 
-#ifdef CONFIG_X86_MCE
-idtentry_mce_db	X86_TRAP_MCE	 	machine_check		do_mce
-#endif
 idtentry_mce_db	X86_TRAP_DB		debug			do_debug
 idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -217,4 +217,9 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+#ifdef CONFIG_X86_MCE
+/* Machine check */
+DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
+#endif
+
 #endif
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -238,7 +238,7 @@ extern void mce_disable_bank(int bank);
 /*
  * Exception handler
  */
-void do_machine_check(struct pt_regs *, long);
+void do_machine_check(struct pt_regs *pt_regs);
 
 /*
  * Threshold handler
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,18 +18,12 @@ asmlinkage void double_fault(void);
 #endif
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
-#ifdef CONFIG_X86_MCE
-asmlinkage void machine_check(void);
-#endif /* CONFIG_X86_MCE */
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
-#ifdef CONFIG_X86_MCE
-asmlinkage void xen_machine_check(void);
-#endif /* CONFIG_X86_MCE */
 #endif
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
@@ -38,7 +32,6 @@ dotraplinkage void do_nmi(struct pt_regs
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1220,7 +1220,7 @@ static void __mc_scan_banks(struct mce *
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-void notrace do_machine_check(struct pt_regs *regs, long error_code)
+void notrace do_machine_check(struct pt_regs *regs)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1358,7 +1358,7 @@ void notrace do_machine_check(struct pt_
 		local_irq_disable();
 		ist_end_non_atomic();
 	} else {
-		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
+		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
 	}
 
@@ -1889,21 +1889,19 @@ bool filter_mce(struct mce *m)
 }
 
 /* Handle unconfigured int18 (should never happen) */
-static void unexpected_machine_check(struct pt_regs *regs, long error_code)
+static void unexpected_machine_check(struct pt_regs *regs)
 {
 	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
 	       smp_processor_id());
 }
 
 /* Call the installed machine check handler for this CPU setup. */
-void (*machine_check_vector)(struct pt_regs *, long error_code) =
-						unexpected_machine_check;
+void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
-dotraplinkage notrace void do_mce(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
-	machine_check_vector(regs, error_code);
+	machine_check_vector(regs);
 }
-NOKPROBE_SYMBOL(do_mce);
 
 /*
  * Called for each booted CPU to set up machine checks.
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -146,9 +146,9 @@ static void raise_exception(struct mce *
 		regs.cs = m->cs;
 		pregs = &regs;
 	}
-	/* in mcheck exeception handler, irq will be disabled */
+	/* do_machine_check() expects interrupts disabled -- at least */
 	local_irq_save(flags);
-	do_machine_check(pregs, 0);
+	do_machine_check(pregs);
 	local_irq_restore(flags);
 	m->finished = 0;
 }
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -9,7 +9,7 @@
 #include <asm/mce.h>
 
 /* Pointer to the installed machine check handler for this CPU setup. */
-extern void (*machine_check_vector)(struct pt_regs *, long error_code);
+extern void (*machine_check_vector)(struct pt_regs *);
 
 enum severity_level {
 	MCE_NO_SEVERITY,
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -20,7 +20,7 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static void pentium_machine_check(struct pt_regs *regs, long error_code)
+static void pentium_machine_check(struct pt_regs *regs)
 {
 	u32 loaddr, hi, lotype;
 
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -16,7 +16,7 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static void winchip_machine_check(struct pt_regs *regs, long error_code)
+static void winchip_machine_check(struct pt_regs *regs)
 {
 	ist_enter(regs);
 
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -93,7 +93,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_DB,		debug),
 
 #ifdef CONFIG_X86_MCE
-	INTG(X86_TRAP_MC,		&machine_check),
+	INTG(X86_TRAP_MC,		asm_exc_machine_check),
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
@@ -182,11 +182,11 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,		IST_INDEX_DB),
-	ISTG(X86_TRAP_NMI,	nmi,		IST_INDEX_NMI),
-	ISTG(X86_TRAP_DF,	double_fault,	IST_INDEX_DF),
+	ISTG(X86_TRAP_DB,	debug,			IST_INDEX_DB),
+	ISTG(X86_TRAP_NMI,	nmi,			IST_INDEX_NMI),
+	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	IST_INDEX_MCE),
+	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
 #endif
 };
 
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4554,7 +4554,7 @@ static void kvm_machine_check(void)
 		.flags = X86_EFLAGS_IF,
 	};
 
-	do_machine_check(&regs, 0);
+	do_machine_check(&regs);
 #endif
 }
 
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -611,7 +611,7 @@ static struct trap_array_entry trap_arra
 	{ debug,                       xen_xendebug,                    true },
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
-	{ machine_check,               xen_machine_check,               true },
+	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
 	{ nmi,                         xen_xennmi,                      true },
 	TRAP_ENTRY(exc_int3,				false ),
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -48,7 +48,7 @@ xen_pv_trap asm_exc_spurious_interrupt_b
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
 #ifdef CONFIG_X86_MCE
-xen_pv_trap machine_check
+xen_pv_trap asm_exc_machine_check
 #endif /* CONFIG_X86_MCE */
 xen_pv_trap asm_exc_simd_coprocessor_error
 #ifdef CONFIG_IA32_EMULATION

