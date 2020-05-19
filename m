Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F52BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C5820849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgEST6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgEST6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF1C08C5C0;
        Tue, 19 May 2020 12:58:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NW-00087v-1I; Tue, 19 May 2020 21:58:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C0E81C0178;
        Tue, 19 May 2020 21:58:17 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:17 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert double fault exception to IDTENTRY_DF
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.583415264@linutronix.de>
References: <20200505135315.583415264@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991829735.17951.7712515737738791927.tip-bot2@tip-bot2>
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

Commit-ID:     095b7a3e7745e6fb7cf0a1c09967c4f43e76f8f4
Gitweb:        https://git.kernel.org/tip/095b7a3e7745e6fb7cf0a1c09967c4f43e76f8f4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:15 +02:00

x86/entry: Convert double fault exception to IDTENTRY_DF

Convert #DF to IDTENTRY_DF
  - Implement the C entry point with DEFINE_IDTENTRY_DF
  - Emit the ASM stub with DECLARE_IDTENTRY_DF on 64bit
  - Remove the ASM idtentry in 64bit
  - Adjust the 32bit shim code
  - Fixup the XEN/PV code
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.583415264@linutronix.de

---
 arch/x86/entry/entry_32.S        |  4 ++--
 arch/x86/entry/entry_64.S        | 10 +---------
 arch/x86/include/asm/idtentry.h  |  3 +++
 arch/x86/include/asm/traps.h     |  5 -----
 arch/x86/kernel/doublefault_32.c | 10 ++++------
 arch/x86/kernel/idt.c            |  4 ++--
 arch/x86/kernel/traps.c          | 17 ++++++++++++++---
 arch/x86/xen/enlighten_pv.c      |  4 ++--
 arch/x86/xen/xen-asm_64.S        |  2 +-
 9 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 30c6ed3..28d13f0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1488,7 +1488,7 @@ ret_to_user:
 	jmp	restore_all_switch_stack
 SYM_CODE_END(handle_exception)
 
-SYM_CODE_START(double_fault)
+SYM_CODE_START(asm_exc_double_fault)
 1:
 	/*
 	 * This is a task gate handler, not an interrupt gate handler.
@@ -1526,7 +1526,7 @@ SYM_CODE_START(double_fault)
 1:
 	hlt
 	jmp 1b
-SYM_CODE_END(double_fault)
+SYM_CODE_END(asm_exc_double_fault)
 
 /*
  * NMI is doubly nasty.  It can happen on the first instruction of
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d302839..d983a0d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -680,15 +680,9 @@ SYM_CODE_START(\asmsym)
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
-	/* Read CR2 early */
-	GET_CR2_INTO(%r12);
-
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	movq	%r12, %rdx		/* Move CR2 into 3rd argument */
 	call	\cfunc
 
 	jmp	paranoid_exit
@@ -918,7 +912,7 @@ SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
-	 * Double-faults due to espfix64 are handled in do_double_fault.
+	 * Double-faults due to espfix64 are handled in exc_double_fault.
 	 * Other faults here are fatal.
 	 */
 	iretq
@@ -1073,8 +1067,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
-
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
 #endif
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 9521f32..ce97478 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -368,4 +368,7 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
 DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
 DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
 
+/* #DF */
+DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
+
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 9bd602d..f5a2e43 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,18 +11,13 @@
 
 #define dotraplinkage __visible
 
-#ifdef CONFIG_X86_64
-asmlinkage void double_fault(void);
-#endif
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
 #endif
 
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 3793646..25692bd 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -11,7 +11,6 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 
-extern void double_fault(void);
 #define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
 
 #define TSS(x) this_cpu_read(cpu_tss_rw.x86_tss.x)
@@ -22,7 +21,7 @@ static void set_df_gdt_entry(unsigned int cpu);
  * Called by double_fault with CR0.TS and EFLAGS.NT cleared.  The CPU thinks
  * we're running the doublefault task.  Cannot return.
  */
-asmlinkage notrace void __noreturn doublefault_shim(void)
+asmlinkage noinstr void __noreturn doublefault_shim(void)
 {
 	unsigned long cr2;
 	struct pt_regs regs;
@@ -41,7 +40,7 @@ asmlinkage notrace void __noreturn doublefault_shim(void)
 	 * Fill in pt_regs.  A downside of doing this in C is that the unwinder
 	 * won't see it (no ENCODE_FRAME_POINTER), so a nested stack dump
 	 * won't successfully unwind to the source of the double fault.
-	 * The main dump from do_double_fault() is fine, though, since it
+	 * The main dump from exc_double_fault() is fine, though, since it
 	 * uses these regs directly.
 	 *
 	 * If anyone ever cares, this could be moved to asm.
@@ -71,7 +70,7 @@ asmlinkage notrace void __noreturn doublefault_shim(void)
 	regs.cx		= TSS(cx);
 	regs.bx		= TSS(bx);
 
-	do_double_fault(&regs, 0, cr2);
+	exc_double_fault(&regs, 0, cr2);
 
 	/*
 	 * x86_32 does not save the original CR3 anywhere on a task switch.
@@ -85,7 +84,6 @@ asmlinkage notrace void __noreturn doublefault_shim(void)
 	 */
 	panic("cannot return from double fault\n");
 }
-NOKPROBE_SYMBOL(doublefault_shim);
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 	.tss = {
@@ -96,7 +94,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 		.ldt		= 0,
 	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 
-		.ip		= (unsigned long) double_fault,
+		.ip		= (unsigned long) asm_exc_double_fault,
 		.flags		= X86_EFLAGS_FIXED,
 		.es		= __USER_DS,
 		.cs		= __KERNEL_CS,
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index ddf3f3d..ec55479 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -91,7 +91,7 @@ static const __initconst struct idt_data def_idts[] = {
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
 #else
-	INTG(X86_TRAP_DF,		double_fault),
+	INTG(X86_TRAP_DF,		asm_exc_double_fault),
 #endif
 	INTG(X86_TRAP_DB,		asm_exc_debug),
 
@@ -187,7 +187,7 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
 static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_DB,	asm_exc_debug,		IST_INDEX_DB),
 	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
-	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
+	ISTG(X86_TRAP_DF,	asm_exc_double_fault,	IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
 	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 41bb0cb..35298c1 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -319,12 +319,19 @@ __visible void __noreturn handle_stack_overflow(const char *message,
  * from the TSS.  Returning is, in principle, okay, but changes to regs will
  * be lost.  If, for some reason, we need to return to a context with modified
  * regs, the shim code could be adjusted to synchronize the registers.
+ *
+ * The 32bit #DF shim provides CR2 already as an argument. On 64bit it needs
+ * to be read before doing anything else.
  */
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2)
+DEFINE_IDTENTRY_DF(exc_double_fault)
 {
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
 
+#ifdef CONFIG_X86_64
+	unsigned long address = read_cr2();
+#endif
+
 #ifdef CONFIG_X86_ESPFIX64
 	extern unsigned char native_irq_return_iret[];
 
@@ -381,6 +388,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 #endif
 
 	nmi_enter();
+	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -424,13 +432,16 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	 * stack even if the actual trigger for the double fault was
 	 * something else.
 	 */
-	if ((unsigned long)task_stack_page(tsk) - 1 - cr2 < PAGE_SIZE)
-		handle_stack_overflow("kernel stack overflow (double-fault)", regs, cr2);
+	if ((unsigned long)task_stack_page(tsk) - 1 - address < PAGE_SIZE) {
+		handle_stack_overflow("kernel stack overflow (double-fault)",
+				      regs, address);
+	}
 #endif
 
 	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
 	die("double fault", regs, error_code);
 	panic("Machine halted.");
+	instrumentation_end();
 }
 
 DEFINE_IDTENTRY(exc_bounds)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 535dde1..851ea41 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -617,7 +617,7 @@ struct trap_array_entry {
 
 static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY_REDIR(exc_debug, exc_xendebug,	true  ),
-	{ double_fault,                xen_double_fault,                true },
+	TRAP_ENTRY(exc_double_fault,			true  ),
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
@@ -652,7 +652,7 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
 	 * Replace trap handler addresses by Xen specific ones.
 	 * Check for known traps using IST and whitelist them.
 	 * The debugger ones are the only ones we care about.
-	 * Xen will handle faults like double_fault, * so we should never see
+	 * Xen will handle faults like double_fault, so we should never see
 	 * them.  Warn if there's an unexpected IST-using fault handler.
 	 */
 	for (nr = 0; nr < ARRAY_SIZE(trap_array); nr++) {
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 9999ea3..e46d863 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -37,7 +37,7 @@ xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
 xen_pv_trap asm_exc_device_not_available
-xen_pv_trap double_fault
+xen_pv_trap asm_exc_double_fault
 xen_pv_trap asm_exc_coproc_segment_overrun
 xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present
