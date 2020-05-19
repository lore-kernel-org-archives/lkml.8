Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E660720872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEST6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgEST6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776AEC08C5C0;
        Tue, 19 May 2020 12:58:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ne-0008Cq-UJ; Tue, 19 May 2020 21:58:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8999A1C047E;
        Tue, 19 May 2020 21:58:23 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Machine Check to IDTENTRY_IST
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.334980426@linutronix.de>
References: <20200505135314.334980426@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830345.17951.13189429952628826581.tip-bot2@tip-bot2>
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

Commit-ID:     aaa4947defff8e6e647e5c1dbc0b4b0dfd4c4359
Gitweb:        https://git.kernel.org/tip/aaa4947defff8e6e647e5c1dbc0b4b0dfd4c4359
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:08 +02:00

x86/entry: Convert Machine Check to IDTENTRY_IST

Convert #MC to IDTENTRY_MCE:
  - Implement the C entry points with DEFINE_IDTENTRY_MCE
  - Emit the ASM stub with DECLARE_IDTENTRY_MCE
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes
  - Remove the error code from *machine_check_vector() as
    it is always 0 and not used by any of the functions
    it can point to. Fixup all the functions as well.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.334980426@linutronix.de


---
 arch/x86/entry/entry_32.S          |  9 ---------
 arch/x86/entry/entry_64.S          |  3 ---
 arch/x86/include/asm/idtentry.h    |  4 ++++
 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/include/asm/traps.h       |  7 -------
 arch/x86/kernel/cpu/mce/core.c     | 23 ++++++++++++++---------
 arch/x86/kernel/cpu/mce/inject.c   |  4 ++--
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 arch/x86/kernel/cpu/mce/p5.c       |  2 +-
 arch/x86/kernel/cpu/mce/winchip.c  |  2 +-
 arch/x86/kernel/idt.c              | 10 +++++-----
 arch/x86/kvm/vmx/vmx.c             |  2 +-
 arch/x86/xen/enlighten_pv.c        |  2 +-
 arch/x86/xen/xen-asm_64.S          |  2 +-
 14 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b9b0ddb..4dd3d70 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1297,15 +1297,6 @@ SYM_CODE_START(native_iret)
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 69ddd05..5007b97 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,9 +1074,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-#ifdef CONFIG_X86_MCE
-idtentry_mce_db	X86_TRAP_MCE	 	machine_check		do_mce
-#endif
 idtentry_mce_db	X86_TRAP_DB		debug			do_debug
 idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3edd6d0..36fe964 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -238,4 +238,8 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 /* Raw exception entries which need extra work */
 DECLARE_IDTENTRY_RAW(X86_TRAP_BP,	exc_int3);
 
+#ifdef CONFIG_X86_MCE
+DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
+#endif
+
 #endif
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index f9cea08..a001301 100644
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
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 698285a..6096db9 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,25 +18,18 @@ asmlinkage void double_fault(void);
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
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f5993ed..842dd03 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1232,7 +1232,7 @@ static void kill_me_maybe(struct callback_head *cb)
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-void noinstr do_machine_check(struct pt_regs *regs, long error_code)
+void noinstr do_machine_check(struct pt_regs *regs)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1366,7 +1366,7 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 			current->mce_kill_me.func = kill_me_now;
 		task_work_add(current, &current->mce_kill_me, true);
 	} else {
-		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
+		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
 	}
 }
@@ -1895,27 +1895,32 @@ bool filter_mce(struct mce *m)
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
 
-dotraplinkage noinstr void do_mce(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
 	if (machine_check_vector == do_machine_check &&
 	    mce_check_crashing_cpu())
 		return;
 
-	nmi_enter();
+	if (user_mode(regs))
+		idtentry_enter(regs);
+	else
+		nmi_enter();
 
-	machine_check_vector(regs, error_code);
+	machine_check_vector(regs);
 
-	nmi_exit();
+	if (user_mode(regs))
+		idtentry_exit(regs);
+	else
+		nmi_exit();
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3413b41..0593b19 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -146,9 +146,9 @@ static void raise_exception(struct mce *m, struct pt_regs *pregs)
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
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 3b00817..b74ca4a 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -9,7 +9,7 @@
 #include <asm/mce.h>
 
 /* Pointer to the installed machine check handler for this CPU setup. */
-extern void (*machine_check_vector)(struct pt_regs *, long error_code);
+extern void (*machine_check_vector)(struct pt_regs *);
 
 enum severity_level {
 	MCE_NO_SEVERITY,
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index dc29f0f..eaebc4c 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -21,7 +21,7 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static void pentium_machine_check(struct pt_regs *regs, long error_code)
+static void pentium_machine_check(struct pt_regs *regs)
 {
 	u32 loaddr, hi, lotype;
 
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 3f8f84b..90e3d60 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -17,7 +17,7 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static void winchip_machine_check(struct pt_regs *regs, long error_code)
+static void winchip_machine_check(struct pt_regs *regs)
 {
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 9ca8af6..6b93840 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -96,7 +96,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DB,		debug),
 
 #ifdef CONFIG_X86_MCE
-	INTG(X86_TRAP_MC,		machine_check),
+	INTG(X86_TRAP_MC,		asm_exc_machine_check),
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
@@ -185,11 +185,11 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
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
-	ISTG(X86_TRAP_MC,	machine_check,	IST_INDEX_MCE),
+	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
 #endif
 };
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c2c6335..513378c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4578,7 +4578,7 @@ static void kvm_machine_check(void)
 		.flags = X86_EFLAGS_IF,
 	};
 
-	do_machine_check(&regs, 0);
+	do_machine_check(&regs);
 #endif
 }
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 725d550..f116afe 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -614,7 +614,7 @@ static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
-	{ machine_check,               xen_machine_check,               true },
+	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
 	{ nmi,                         xen_xennmi,                      true },
 	TRAP_ENTRY(exc_int3,				false ),
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 44f5556..617ef3f 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -48,7 +48,7 @@ xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
 #ifdef CONFIG_X86_MCE
-xen_pv_trap machine_check
+xen_pv_trap asm_exc_machine_check
 #endif /* CONFIG_X86_MCE */
 xen_pv_trap asm_exc_simd_coprocessor_error
 #ifdef CONFIG_IA32_EMULATION
