Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDBC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1721B207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgEEOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730133AbgEEOQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96314C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMo-0002CU-FY; Tue, 05 May 2020 16:16:14 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 01E521001F5;
        Tue,  5 May 2020 16:16:14 +0200 (CEST)
Message-Id: <20200505135315.686797857@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:50 +0200
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
Subject: [patch V4 part 4 24/24] x86/entry: Convert double fault exception to
 IDTENTRY_DF
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

Convert #DF to IDTENTRY_DF
  - Implement the C entry point with DEFINE_IDTENTRY_DF
  - Emit the ASM stub with DECLARE_IDTENTRY_DF on 64bit
  - Remove the ASM idtentry in 64bit
  - Adjust the 32bit shim code
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/entry/entry_32.S        |    4 ++--
 arch/x86/entry/entry_64.S        |   10 +---------
 arch/x86/include/asm/idtentry.h  |    5 +++++
 arch/x86/include/asm/traps.h     |    7 -------
 arch/x86/kernel/doublefault_32.c |   10 ++++------
 arch/x86/kernel/idt.c            |    4 ++--
 arch/x86/kernel/traps.c          |   17 ++++++++++++++---
 arch/x86/xen/enlighten_pv.c      |    4 ++--
 arch/x86/xen/xen-asm_64.S        |    2 +-
 9 files changed, 31 insertions(+), 32 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1489,7 +1489,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exce
 SYM_CODE_END(handle_exception)
 
 #ifdef CONFIG_DOUBLEFAULT
-SYM_CODE_START(double_fault)
+SYM_CODE_START(asm_exc_double_fault)
 1:
 	/*
 	 * This is a task gate handler, not an interrupt gate handler.
@@ -1527,7 +1527,7 @@ SYM_CODE_START(double_fault)
 1:
 	hlt
 	jmp 1b
-SYM_CODE_END(double_fault)
+SYM_CODE_END(asm_exc_double_fault)
 #endif
 
 /*
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -681,15 +681,9 @@ SYM_CODE_START(\asmsym)
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
@@ -918,7 +912,7 @@ SYM_INNER_LABEL(native_irq_return_iret,
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
-	 * Double-faults due to espfix64 are handled in do_double_fault.
+	 * Double-faults due to espfix64 are handled in exc_double_fault.
 	 * Other faults here are fatal.
 	 */
 	iretq
@@ -1074,8 +1068,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
-
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
 #endif
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -380,4 +380,9 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
 DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
 DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
 
+/* #DF */
+#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
+DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
+#endif
+
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,20 +11,13 @@
 
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
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
-#endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -11,7 +11,6 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 
-extern void double_fault(void);
 #define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
 
 #define TSS(x) this_cpu_read(cpu_tss_rw.x86_tss.x)
@@ -22,7 +21,7 @@ static void set_df_gdt_entry(unsigned in
  * Called by double_fault with CR0.TS and EFLAGS.NT cleared.  The CPU thinks
  * we're running the doublefault task.  Cannot return.
  */
-asmlinkage notrace void __noreturn doublefault_shim(void)
+asmlinkage noinstr void __noreturn doublefault_shim(void)
 {
 	unsigned long cr2;
 	struct pt_regs regs;
@@ -41,7 +40,7 @@ asmlinkage notrace void __noreturn doubl
 	 * Fill in pt_regs.  A downside of doing this in C is that the unwinder
 	 * won't see it (no ENCODE_FRAME_POINTER), so a nested stack dump
 	 * won't successfully unwind to the source of the double fault.
-	 * The main dump from do_double_fault() is fine, though, since it
+	 * The main dump from exc_double_fault() is fine, though, since it
 	 * uses these regs directly.
 	 *
 	 * If anyone ever cares, this could be moved to asm.
@@ -71,7 +70,7 @@ asmlinkage notrace void __noreturn doubl
 	regs.cx		= TSS(cx);
 	regs.bx		= TSS(bx);
 
-	do_double_fault(&regs, 0, cr2);
+	exc_double_fault(&regs, 0, cr2);
 
 	/*
 	 * x86_32 does not save the original CR3 anywhere on a task switch.
@@ -85,7 +84,6 @@ asmlinkage notrace void __noreturn doubl
 	 */
 	panic("cannot return from double fault\n");
 }
-NOKPROBE_SYMBOL(doublefault_shim);
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 	.tss = {
@@ -96,7 +94,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doubl
 		.ldt		= 0,
 	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 
-		.ip		= (unsigned long) double_fault,
+		.ip		= (unsigned long) asm_exc_double_fault,
 		.flags		= X86_EFLAGS_FIXED,
 		.es		= __USER_DS,
 		.cs		= __KERNEL_CS,
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -88,7 +88,7 @@ static const __initconst struct idt_data
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
 #else
-	INTG(X86_TRAP_DF,		double_fault),
+	INTG(X86_TRAP_DF,		asm_exc_double_fault),
 #endif
 	INTG(X86_TRAP_DB,		asm_exc_debug),
 
@@ -184,7 +184,7 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
 static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_DB,	asm_exc_debug,		IST_INDEX_DB),
 	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
-	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
+	ISTG(X86_TRAP_DF,	asm_exc_double_fault,	IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
 	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
 #endif
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -310,12 +310,19 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_
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
 
@@ -372,6 +379,7 @@ dotraplinkage void do_double_fault(struc
 #endif
 
 	nmi_enter();
+	instr_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -415,13 +423,16 @@ dotraplinkage void do_double_fault(struc
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
+	instr_end();
 }
 #endif
 
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
@@ -652,7 +652,7 @@ static bool __ref get_trap_addr(void **a
 	 * Replace trap handler addresses by Xen specific ones.
 	 * Check for known traps using IST and whitelist them.
 	 * The debugger ones are the only ones we care about.
-	 * Xen will handle faults like double_fault, * so we should never see
+	 * Xen will handle faults like double_fault, so we should never see
 	 * them.  Warn if there's an unexpected IST-using fault handler.
 	 */
 	for (nr = 0; nr < ARRAY_SIZE(trap_array); nr++) {
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

