Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB81C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7C520849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgESUCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgEST60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E314C08C5C1;
        Tue, 19 May 2020 12:58:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NZ-0008AT-Ay; Tue, 19 May 2020 21:58:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 02EAF1C0480;
        Tue, 19 May 2020 21:58:21 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Debug exception to IDTENTRY_DB
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.900297476@linutronix.de>
References: <20200505135314.900297476@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830089.17951.4794971518476962359.tip-bot2@tip-bot2>
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

Commit-ID:     c087b87b1469166dbb0d757c7d79fecf14a90a0a
Gitweb:        https://git.kernel.org/tip/c087b87b1469166dbb0d757c7d79fecf14a90a0a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:11 +02:00

x86/entry: Convert Debug exception to IDTENTRY_DB

Convert #DB to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY_DB
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.900297476@linutronix.de


---
 arch/x86/entry/entry_32.S       | 10 ----------
 arch/x86/entry/entry_64.S       |  2 --
 arch/x86/include/asm/idtentry.h |  4 ++++
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  8 ++++----
 arch/x86/kernel/traps.c         | 21 +++++++++++++--------
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/xen-asm_64.S       |  4 ++--
 8 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d4961ca..30c6ed3 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1488,16 +1488,6 @@ ret_to_user:
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
 SYM_CODE_START(double_fault)
 1:
 	/*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3d7f2cc..f47629a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,12 +1074,10 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-idtentry_mce_db	X86_TRAP_DB		debug			do_debug
 idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
 #endif
 
 /*
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1f067e6..fcd4230 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -262,4 +262,8 @@ DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
 DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
 
+/* #DB */
+DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
+DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
+
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 57b83ae..9bd602d 100644
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
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d3fecd8..ddf3f3d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -59,7 +59,7 @@ static bool idt_setup_done __initdata;
  * stacks work only after cpu_init().
  */
 static const __initconst struct idt_data early_idts[] = {
-	INTG(X86_TRAP_DB,		debug),
+	INTG(X86_TRAP_DB,		asm_exc_debug),
 	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
 	INTG(X86_TRAP_PF,		page_fault),
@@ -93,7 +93,7 @@ static const __initconst struct idt_data def_idts[] = {
 #else
 	INTG(X86_TRAP_DF,		double_fault),
 #endif
-	INTG(X86_TRAP_DB,		debug),
+	INTG(X86_TRAP_DB,		asm_exc_debug),
 
 #ifdef CONFIG_X86_MCE
 	INTG(X86_TRAP_MC,		asm_exc_machine_check),
@@ -164,7 +164,7 @@ static const __initconst struct idt_data early_pf_idts[] = {
  * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
  */
 static const __initconst struct idt_data dbg_idts[] = {
-	INTG(X86_TRAP_DB,	debug),
+	INTG(X86_TRAP_DB,		asm_exc_debug),
 };
 #endif
 
@@ -185,7 +185,7 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,			IST_INDEX_DB),
+	ISTG(X86_TRAP_DB,	asm_exc_debug,		IST_INDEX_DB),
 	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
 	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index de5120e..569408a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -775,7 +775,7 @@ static __always_inline void debug_exit(unsigned long dr7)
  *
  * May run on IST stack.
  */
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
 	struct task_struct *tsk = current;
 	unsigned long dr6, dr7;
@@ -784,7 +784,10 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 
 	debug_enter(&dr6, &dr7);
 
-	nmi_enter();
+	if (user_mode(regs))
+		idtentry_enter(regs);
+	else
+		nmi_enter();
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
@@ -821,7 +824,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 		goto exit;
 #endif
 
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
@@ -835,8 +838,8 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	cond_local_irq_enable(regs);
 
 	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code,
-					X86_TRAP_DB);
+		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
+				 X86_TRAP_DB);
 		cond_local_irq_disable(regs);
 		debug_stack_usage_dec();
 		goto exit;
@@ -855,15 +858,17 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
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
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c65aa4c..535dde1 100644
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
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 04fa01b..9999ea3 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -29,8 +29,8 @@ _ASM_NOKPROBE(xen_\name)
 .endm
 
 xen_pv_trap asm_exc_divide_error
-xen_pv_trap debug
-xen_pv_trap xendebug
+xen_pv_trap asm_exc_debug
+xen_pv_trap asm_exc_xendebug
 xen_pv_trap asm_exc_int3
 xen_pv_trap asm_exc_xennmi
 xen_pv_trap asm_exc_overflow
