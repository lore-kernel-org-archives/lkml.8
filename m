Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBCCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5313020849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgESUC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgEST6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B65C08C5C0;
        Tue, 19 May 2020 12:58:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nf-0008Bv-Kx; Tue, 19 May 2020 21:58:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B20E1C0480;
        Tue, 19 May 2020 21:58:22 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert NMI to IDTENTRY_NMI
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.609932306@linutronix.de>
References: <20200505135314.609932306@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830222.17951.17096802294286009516.tip-bot2@tip-bot2>
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

Commit-ID:     b209b183b6db506737d2bf6c76a866fe954e513a
Gitweb:        https://git.kernel.org/tip/b209b183b6db506737d2bf6c76a866fe954e513a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:09 +02:00

x86/entry: Convert NMI to IDTENTRY_NMI

Convert #NMI to IDTENTRY_NMI:
  - Implement the C entry point with DEFINE_IDTENTRY_NMI
  - Fixup the XEN/PV code
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.609932306@linutronix.de


---
 arch/x86/entry/entry_32.S       |  8 ++++----
 arch/x86/entry/entry_64.S       | 15 +++++++--------
 arch/x86/include/asm/idtentry.h |  4 ++++
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  4 ++--
 arch/x86/kernel/nmi.c           |  4 +---
 arch/x86/xen/enlighten_pv.c     |  7 ++++++-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 8 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4dd3d70..d4961ca 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1545,7 +1545,7 @@ SYM_CODE_END(double_fault)
  * switched stacks.  We handle both conditions by simply checking whether we
  * interrupted kernel code running on the SYSENTER stack.
  */
-SYM_CODE_START(nmi)
+SYM_CODE_START(asm_exc_nmi)
 	ASM_CLAC
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1574,7 +1574,7 @@ SYM_CODE_START(nmi)
 	jb	.Lnmi_from_sysenter_stack
 
 	/* Not on SYSENTER stack. */
-	call	do_nmi
+	call	exc_nmi
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1584,7 +1584,7 @@ SYM_CODE_START(nmi)
 	 */
 	movl	%esp, %ebx
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
-	call	do_nmi
+	call	exc_nmi
 	movl	%ebx, %esp
 
 .Lnmi_return:
@@ -1638,7 +1638,7 @@ SYM_CODE_START(nmi)
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
 	jmp	.Lirq_return
 #endif
-SYM_CODE_END(nmi)
+SYM_CODE_END(asm_exc_nmi)
 
 .pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5007b97..3d7f2cc 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1079,7 +1079,6 @@ idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
 
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-idtentry	X86_TRAP_NMI		xennmi			do_nmi				has_error_code=0
 idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
 #endif
 
@@ -1414,7 +1413,7 @@ SYM_CODE_END(error_return)
  *	%r14: Used to save/restore the CR3 of the interrupted context
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
-SYM_CODE_START(nmi)
+SYM_CODE_START(asm_exc_nmi)
 	UNWIND_HINT_IRET_REGS
 
 	/*
@@ -1499,7 +1498,7 @@ SYM_CODE_START(nmi)
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	do_nmi
+	call	exc_nmi
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1556,7 +1555,7 @@ SYM_CODE_START(nmi)
 	 * end_repeat_nmi, then we are a nested NMI.  We must not
 	 * modify the "iret" frame because it's being written by
 	 * the outer NMI.  That's okay; the outer NMI handler is
-	 * about to about to call do_nmi anyway, so we can just
+	 * about to about to call exc_nmi() anyway, so we can just
 	 * resume the outer NMI.
 	 */
 
@@ -1675,7 +1674,7 @@ repeat_nmi:
 	 * RSP is pointing to "outermost RIP".  gsbase is unknown, but, if
 	 * we're repeating an NMI, gsbase has the same value that it had on
 	 * the first iteration.  paranoid_entry will load the kernel
-	 * gsbase if needed before we call do_nmi.  "NMI executing"
+	 * gsbase if needed before we call exc_nmi().  "NMI executing"
 	 * is zero.
 	 */
 	movq	$1, 10*8(%rsp)		/* Set "NMI executing". */
@@ -1709,10 +1708,10 @@ end_repeat_nmi:
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
-	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
+	/* paranoidentry exc_nmi(), 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	do_nmi
+	call	exc_nmi
 
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
@@ -1749,7 +1748,7 @@ nmi_restore:
 	 * about espfix64 on the way back to kernel mode.
 	 */
 	iretq
-SYM_CODE_END(nmi)
+SYM_CODE_END(asm_exc_nmi)
 
 #ifndef CONFIG_IA32_EMULATION
 /*
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 2315eec..1f067e6 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -258,4 +258,8 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_BP,	exc_int3);
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
 #endif
 
+/* NMI */
+DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
+DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
+
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 6096db9..57b83ae 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -12,7 +12,6 @@
 #define dotraplinkage __visible
 
 asmlinkage void debug(void);
-asmlinkage void nmi(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
@@ -20,14 +19,12 @@ asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
 #endif
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
-dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 6b93840..d3fecd8 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -74,7 +74,7 @@ static const __initconst struct idt_data early_idts[] = {
  */
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
-	INTG(X86_TRAP_NMI,		nmi),
+	INTG(X86_TRAP_NMI,		asm_exc_nmi),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
@@ -186,7 +186,7 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
  */
 static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_DB,	debug,			IST_INDEX_DB),
-	ISTG(X86_TRAP_NMI,	nmi,			IST_INDEX_NMI),
+	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
 	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
 	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 6407ea2..d55e448 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -507,8 +507,7 @@ static bool notrace is_debug_stack(unsigned long addr)
 NOKPROBE_SYMBOL(is_debug_stack);
 #endif
 
-dotraplinkage notrace void
-do_nmi(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_NMI(exc_nmi)
 {
 	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
 		return;
@@ -558,7 +557,6 @@ nmi_restart:
 	if (user_mode(regs))
 		mds_user_clear_cpu_buffers();
 }
-NOKPROBE_SYMBOL(do_nmi);
 
 void stop_nmi(void)
 {
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index f116afe..c65aa4c 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -610,13 +610,18 @@ struct trap_array_entry {
 	.xen		= xen_asm_##func,		\
 	.ist_okay	= ist_ok }
 
+#define TRAP_ENTRY_REDIR(func, xenfunc, ist_ok) {	\
+	.orig		= asm_##func,			\
+	.xen		= xen_asm_##xenfunc,		\
+	.ist_okay	= ist_ok }
+
 static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
-	{ nmi,                         xen_xennmi,                      true },
+	TRAP_ENTRY_REDIR(exc_nmi, exc_xennmi,		true  ),
 	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 617ef3f..04fa01b 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -32,7 +32,7 @@ xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
 xen_pv_trap asm_exc_int3
-xen_pv_trap xennmi
+xen_pv_trap asm_exc_xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
