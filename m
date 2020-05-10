Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074ACC54E8B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D628924956
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEJSaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgEJSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 14:30:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E6C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 11:30:28 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXqiX-0003pL-UT; Sun, 10 May 2020 20:30:26 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 520791004CE;
        Sun, 10 May 2020 20:30:25 +0200 (CEST)
Date:   Sun, 10 May 2020 11:55:59 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.7-rc5
References: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
Message-ID: <158911175944.19109.11559501658854451831.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-05-10

up to:  fb9cbbc895eb: x86/unwind/orc: Move ORC sorting variables under !CONFIG_MODULES


A set of fixes for x86:

 - Ensure that direct mapping alias is always flushed when changing page
   attributes. The optimization for small ranges failed to do so when
   the virtual address was in the vmalloc or module space.

 - Unbreak the trace event registration for syscalls without arguments
   caused by the refactoring of the SYSCALL_DEFINE0() macro.

 - Move the printk in the TSC deadline timer code to a place where it is
   guaranteed to only be called once during boot and cannot be rearmed by
   clearing warn_once after boot. If it's invoked post boot then lockdep
   rightfully complains about a potential deadlock as the calling context
   is different.

 - A series of fixes for objtool and the ORC unwinder addressing variety
   of small issues:

     Stack offset tracking for indirect CFAs in objtool ignored subsequent
     pushs and pops

     Repair the unwind hints in the register clearing entry ASM code

     Make the unwinding in the low level exit to usermode code stop after
     switching to the trampoline stack. The unwind hint is not longer valid
     and the ORC unwinder emits a warning as it can't find the registers
     anymore.

     Fix the unwind hints in switch_to_asm() and rewind_stack_do_exit()
     which caused objtool to generate bogus ORC data.

     Prevent unwinder warnings when dumping the stack of a non-current
     task as there is no way to be sure about the validity because the
     dumped stack can be a moving target.

     Make the ORC unwinder behave the same way as the frame pointer
     unwinder when dumping an inactive tasks stack and do not skip the
     first frame.

     Prevent ORC unwinding before ORC data has been initialized

     Immediately terminate unwinding when a unknown ORC entry type is
     found.

     Prevent premature stop of the unwinder caused by IRET frames.

     Fix another infinite loop in objtool caused by a negative offset which
     was not catched.

     Address a few build warnings in the ORC unwinder and add missing
     static/ro_after_init annotations

Thanks,

	tglx

------------------>
Jann Horn (1):
      x86/entry/64: Fix unwind hints in rewind_stack_do_exit()

Josh Poimboeuf (11):
      objtool: Fix stack offset tracking for indirect CFAs
      x86/entry/64: Fix unwind hints in register clearing code
      x86/entry/64: Fix unwind hints in kernel exit path
      x86/entry/64: Fix unwind hints in __switch_to_asm()
      x86/unwind/orc: Convert global variables to static
      x86/unwind: Prevent false warnings for non-current tasks
      x86/unwind/orc: Prevent unwinding before ORC initialization
      x86/unwind/orc: Fix error path for bad ORC entry type
      x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
      objtool: Fix infinite loop in for_offset_range()
      x86/unwind/orc: Move ORC sorting variables under !CONFIG_MODULES

Konstantin Khlebnikov (1):
      ftrace/x86: Fix trace event registration for syscalls without arguments

Miroslav Benes (1):
      x86/unwind/orc: Don't skip the first frame for inactive tasks

Rick Edgecombe (1):
      x86/mm/cpa: Flush direct map alias during cpa

Thomas Gleixner (1):
      x86/apic: Move TSC deadline timer debug printk


 arch/x86/entry/calling.h       |  40 ++++++++-------
 arch/x86/entry/entry_64.S      |  14 ++---
 arch/x86/include/asm/ftrace.h  |   5 +-
 arch/x86/include/asm/unwind.h  |   2 +-
 arch/x86/kernel/apic/apic.c    |  27 +++++-----
 arch/x86/kernel/dumpstack_64.c |   3 +-
 arch/x86/kernel/unwind_frame.c |   3 ++
 arch/x86/kernel/unwind_orc.c   | 113 +++++++++++++++++++++++++++--------------
 arch/x86/mm/pat/set_memory.c   |  12 +++--
 tools/objtool/check.c          |   2 +-
 tools/objtool/elf.h            |   7 +--
 11 files changed, 138 insertions(+), 90 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 0789e13ece90..1c7f13bb6728 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -98,13 +98,6 @@ For 32-bit we have the following conventions - kernel is built with
 #define SIZEOF_PTREGS	21*8
 
 .macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	/*
-	 * Push registers and sanitize registers of values that a
-	 * speculation attack might otherwise want to exploit. The
-	 * lower registers are likely clobbered well before they
-	 * could be put to use in a speculative execution gadget.
-	 * Interleave XOR with PUSH for better uop scheduling:
-	 */
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -114,34 +107,43 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
-	xorl	%edx, %edx	/* nospec   dx */
 	pushq   %rcx		/* pt_regs->cx */
-	xorl	%ecx, %ecx	/* nospec   cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
-	xorl	%r8d, %r8d	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
-	xorl	%r9d, %r9d	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
-	xorl	%r10d, %r10d	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
-	xorl	%r11d, %r11d	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
-	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
-	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
-	xorl	%r12d, %r12d	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
-	xorl	%r13d, %r13d	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
-	xorl	%r14d, %r14d	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
-	xorl	%r15d, %r15d	/* nospec   r15*/
 	UNWIND_HINT_REGS
+
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
+
+	/*
+	 * Sanitize registers of values that a speculation attack might
+	 * otherwise want to exploit. The lower registers are likely clobbered
+	 * well before they could be put to use in a speculative execution
+	 * gadget.
+	 */
+	xorl	%edx,  %edx	/* nospec dx  */
+	xorl	%ecx,  %ecx	/* nospec cx  */
+	xorl	%r8d,  %r8d	/* nospec r8  */
+	xorl	%r9d,  %r9d	/* nospec r9  */
+	xorl	%r10d, %r10d	/* nospec r10 */
+	xorl	%r11d, %r11d	/* nospec r11 */
+	xorl	%ebx,  %ebx	/* nospec rbx */
+	xorl	%ebp,  %ebp	/* nospec rbp */
+	xorl	%r12d, %r12d	/* nospec r12 */
+	xorl	%r13d, %r13d	/* nospec r13 */
+	xorl	%r14d, %r14d	/* nospec r14 */
+	xorl	%r15d, %r15d	/* nospec r15 */
+
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0e9504fabe52..3063aa9090f9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -249,7 +249,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 */
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
-	UNWIND_HINT_EMPTY
 	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
@@ -258,6 +257,7 @@ syscall_return_via_sysret:
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
 
 	pushq	RSP-RDI(%rdi)	/* RSP */
 	pushq	(%rdi)		/* RDI */
@@ -279,8 +279,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  * %rdi: prev task
  * %rsi: next task
  */
-SYM_CODE_START(__switch_to_asm)
-	UNWIND_HINT_FUNC
+SYM_FUNC_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in inactive_task_frame
@@ -321,7 +320,7 @@ SYM_CODE_START(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-SYM_CODE_END(__switch_to_asm)
+SYM_FUNC_END(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -512,7 +511,7 @@ SYM_CODE_END(spurious_entries_start)
  * +----------------------------------------------------+
  */
 SYM_CODE_START(interrupt_entry)
-	UNWIND_HINT_FUNC
+	UNWIND_HINT_IRET_REGS offset=16
 	ASM_CLAC
 	cld
 
@@ -544,9 +543,9 @@ SYM_CODE_START(interrupt_entry)
 	pushq	5*8(%rdi)		/* regs->eflags */
 	pushq	4*8(%rdi)		/* regs->cs */
 	pushq	3*8(%rdi)		/* regs->ip */
+	UNWIND_HINT_IRET_REGS
 	pushq	2*8(%rdi)		/* regs->orig_ax */
 	pushq	8(%rdi)			/* return address */
-	UNWIND_HINT_FUNC
 
 	movq	(%rdi), %rdi
 	jmp	2f
@@ -637,6 +636,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
 
 	/* Copy the IRET frame to the trampoline stack. */
 	pushq	6*8(%rdi)	/* SS */
@@ -1739,7 +1739,7 @@ SYM_CODE_START(rewind_stack_do_exit)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
-	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
+	UNWIND_HINT_REGS
 
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 85be2f506272..70b96cae5b42 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -61,11 +61,12 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 {
 	/*
 	 * Compare the symbol name with the system call name. Skip the
-	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
+	 * "__x64_sys", "__ia32_sys", "__do_sys" or simple "sys" prefix.
 	 */
 	return !strcmp(sym + 3, name + 3) ||
 		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
-		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
+		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3)) ||
+		(!strncmp(sym, "__do_sys", 8) && !strcmp(sym + 8, name + 3));
 }
 
 #ifndef COMPILE_OFFSETS
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 499578f7e6d7..70fc159ebe69 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -19,7 +19,7 @@ struct unwind_state {
 #if defined(CONFIG_UNWINDER_ORC)
 	bool signal, full_regs;
 	unsigned long sp, bp, ip;
-	struct pt_regs *regs;
+	struct pt_regs *regs, *prev_regs;
 #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
 	bool got_irq;
 	unsigned long *bp, *orig_sp, ip;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 81b9c63dae1b..e53dda210cd7 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -352,8 +352,6 @@ static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
 		 * According to Intel, MFENCE can do the serialization here.
 		 */
 		asm volatile("mfence" : : : "memory");
-
-		printk_once(KERN_DEBUG "TSC deadline timer enabled\n");
 		return;
 	}
 
@@ -546,7 +544,7 @@ static struct clock_event_device lapic_clockevent = {
 };
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
-static u32 hsx_deadline_rev(void)
+static __init u32 hsx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
 	case 0x02: return 0x3a; /* EP */
@@ -556,7 +554,7 @@ static u32 hsx_deadline_rev(void)
 	return ~0U;
 }
 
-static u32 bdx_deadline_rev(void)
+static __init u32 bdx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
 	case 0x02: return 0x00000011;
@@ -568,7 +566,7 @@ static u32 bdx_deadline_rev(void)
 	return ~0U;
 }
 
-static u32 skx_deadline_rev(void)
+static __init u32 skx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
 	case 0x03: return 0x01000136;
@@ -581,7 +579,7 @@ static u32 skx_deadline_rev(void)
 	return ~0U;
 }
 
-static const struct x86_cpu_id deadline_match[] = {
+static const struct x86_cpu_id deadline_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
 	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
 	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
@@ -603,18 +601,19 @@ static const struct x86_cpu_id deadline_match[] = {
 	{},
 };
 
-static void apic_check_deadline_errata(void)
+static __init bool apic_validate_deadline_timer(void)
 {
 	const struct x86_cpu_id *m;
 	u32 rev;
 
-	if (!boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER) ||
-	    boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return;
+	if (!boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		return false;
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return true;
 
 	m = x86_match_cpu(deadline_match);
 	if (!m)
-		return;
+		return true;
 
 	/*
 	 * Function pointers will have the MSB set due to address layout,
@@ -626,11 +625,12 @@ static void apic_check_deadline_errata(void)
 		rev = (u32)m->driver_data;
 
 	if (boot_cpu_data.microcode >= rev)
-		return;
+		return true;
 
 	setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 	pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; "
 	       "please update microcode to version: 0x%x (or later)\n", rev);
+	return false;
 }
 
 /*
@@ -2092,7 +2092,8 @@ void __init init_apic_mappings(void)
 {
 	unsigned int new_apicid;
 
-	apic_check_deadline_errata();
+	if (apic_validate_deadline_timer())
+		pr_debug("TSC deadline timer available\n");
 
 	if (x2apic_mode) {
 		boot_cpu_physical_apicid = read_apic_id();
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 87b97897a881..460ae7f66818 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -183,7 +183,8 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	 */
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
-			printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
+			if (task == current)
+				printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
 			goto unknown;
 		}
 		*visit_mask |= 1UL << info->type;
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index a224b5ab103f..54226110bc7f 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -344,6 +344,9 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (IS_ENABLED(CONFIG_X86_32))
 		goto the_end;
 
+	if (state->task != current)
+		goto the_end;
+
 	if (state->regs) {
 		printk_deferred_once(KERN_WARNING
 			"WARNING: kernel stack regs at %p in %s:%d has bad 'bp' value %p\n",
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9cc182aa97e..5b0bd8581fe6 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -8,19 +8,21 @@
 #include <asm/orc_lookup.h>
 
 #define orc_warn(fmt, ...) \
-	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+
+#define orc_warn_current(args...)					\
+({									\
+	if (state->task == current)					\
+		orc_warn(args);						\
+})
 
 extern int __start_orc_unwind_ip[];
 extern int __stop_orc_unwind_ip[];
 extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
 
-static DEFINE_MUTEX(sort_mutex);
-int *cur_orc_ip_table = __start_orc_unwind_ip;
-struct orc_entry *cur_orc_table = __start_orc_unwind;
-
-unsigned int lookup_num_blocks;
-bool orc_init;
+static bool orc_init __ro_after_init;
+static unsigned int lookup_num_blocks __ro_after_init;
 
 static inline unsigned long orc_ip(const int *ip)
 {
@@ -142,9 +144,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
 
-	if (!orc_init)
-		return NULL;
-
 	if (ip == 0)
 		return &null_orc_entry;
 
@@ -189,6 +188,10 @@ static struct orc_entry *orc_find(unsigned long ip)
 
 #ifdef CONFIG_MODULES
 
+static DEFINE_MUTEX(sort_mutex);
+static int *cur_orc_ip_table = __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table = __start_orc_unwind;
+
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
@@ -381,9 +384,38 @@ static bool deref_stack_iret_regs(struct unwind_state *state, unsigned long addr
 	return true;
 }
 
+/*
+ * If state->regs is non-NULL, and points to a full pt_regs, just get the reg
+ * value from state->regs.
+ *
+ * Otherwise, if state->regs just points to IRET regs, and the previous frame
+ * had full regs, it's safe to get the value from the previous regs.  This can
+ * happen when early/late IRQ entry code gets interrupted by an NMI.
+ */
+static bool get_reg(struct unwind_state *state, unsigned int reg_off,
+		    unsigned long *val)
+{
+	unsigned int reg = reg_off/8;
+
+	if (!state->regs)
+		return false;
+
+	if (state->full_regs) {
+		*val = ((unsigned long *)state->regs)[reg];
+		return true;
+	}
+
+	if (state->prev_regs) {
+		*val = ((unsigned long *)state->prev_regs)[reg];
+		return true;
+	}
+
+	return false;
+}
+
 bool unwind_next_frame(struct unwind_state *state)
 {
-	unsigned long ip_p, sp, orig_ip = state->ip, prev_sp = state->sp;
+	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
 	enum stack_type prev_type = state->stack_info.type;
 	struct orc_entry *orc;
 	bool indirect = false;
@@ -445,43 +477,39 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
 
 	case ORC_REG_R10:
-		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R10 at ip %pB\n",
-				 (void *)state->ip);
+		if (!get_reg(state, offsetof(struct pt_regs, r10), &sp)) {
+			orc_warn_current("missing R10 value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->r10;
 		break;
 
 	case ORC_REG_R13:
-		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R13 at ip %pB\n",
-				 (void *)state->ip);
+		if (!get_reg(state, offsetof(struct pt_regs, r13), &sp)) {
+			orc_warn_current("missing R13 value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->r13;
 		break;
 
 	case ORC_REG_DI:
-		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DI at ip %pB\n",
-				 (void *)state->ip);
+		if (!get_reg(state, offsetof(struct pt_regs, di), &sp)) {
+			orc_warn_current("missing RDI value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->di;
 		break;
 
 	case ORC_REG_DX:
-		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DX at ip %pB\n",
-				 (void *)state->ip);
+		if (!get_reg(state, offsetof(struct pt_regs, dx), &sp)) {
+			orc_warn_current("missing DX value at %pB\n",
+					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->dx;
 		break;
 
 	default:
-		orc_warn("unknown SP base reg %d for ip %pB\n",
+		orc_warn("unknown SP base reg %d at %pB\n",
 			 orc->sp_reg, (void *)state->ip);
 		goto err;
 	}
@@ -504,44 +532,48 @@ bool unwind_next_frame(struct unwind_state *state)
 
 		state->sp = sp;
 		state->regs = NULL;
+		state->prev_regs = NULL;
 		state->signal = false;
 		break;
 
 	case ORC_TYPE_REGS:
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't access registers at %pB\n",
+					 (void *)orig_ip);
 			goto err;
 		}
 
 		state->regs = (struct pt_regs *)sp;
+		state->prev_regs = NULL;
 		state->full_regs = true;
 		state->signal = true;
 		break;
 
 	case ORC_TYPE_REGS_IRET:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference iret registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't access iret registers at %pB\n",
+					 (void *)orig_ip);
 			goto err;
 		}
 
+		if (state->full_regs)
+			state->prev_regs = state->regs;
 		state->regs = (void *)sp - IRET_FRAME_OFFSET;
 		state->full_regs = false;
 		state->signal = true;
 		break;
 
 	default:
-		orc_warn("unknown .orc_unwind entry type %d for ip %pB\n",
+		orc_warn("unknown .orc_unwind entry type %d at %pB\n",
 			 orc->type, (void *)orig_ip);
-		break;
+		goto err;
 	}
 
 	/* Find BP: */
 	switch (orc->bp_reg) {
 	case ORC_REG_UNDEFINED:
-		if (state->regs && state->full_regs)
-			state->bp = state->regs->bp;
+		if (get_reg(state, offsetof(struct pt_regs, bp), &tmp))
+			state->bp = tmp;
 		break;
 
 	case ORC_REG_PREV_SP:
@@ -564,8 +596,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (state->stack_info.type == prev_type &&
 	    on_stack(&state->stack_info, (void *)state->sp, sizeof(long)) &&
 	    state->sp <= prev_sp) {
-		orc_warn("stack going in the wrong direction? ip=%pB\n",
-			 (void *)orig_ip);
+		orc_warn_current("stack going in the wrong direction? at %pB\n",
+				 (void *)orig_ip);
 		goto err;
 	}
 
@@ -585,6 +617,9 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
+	if (!orc_init)
+		goto done;
+
 	memset(state, 0, sizeof(*state));
 	state->task = task;
 
@@ -651,7 +686,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	/* Otherwise, skip ahead to the user-specified starting frame: */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp <= (unsigned long)first_frame))
+			state->sp < (unsigned long)first_frame))
 		unwind_next_frame(state);
 
 	return;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 59eca6a94ce7..b8c55a2e402d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -43,7 +43,8 @@ struct cpa_data {
 	unsigned long	pfn;
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
-			force_static_prot	: 1;
+			force_static_prot	: 1,
+			force_flush_all		: 1;
 	struct page	**pages;
 };
 
@@ -355,10 +356,10 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		return;
 	}
 
-	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
-	else
+	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
+	else
+		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 
 	if (!cache)
 		return;
@@ -1598,6 +1599,8 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		cpa->force_flush_all = 1;
+
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
 		if (ret)
 			return ret;
@@ -1618,6 +1621,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		cpa->force_flush_all = 1;
 		/*
 		 * The high mapping range is imprecise, so ignore the
 		 * return value.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b170fd08a28..e7184641a40c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1449,7 +1449,7 @@ static int update_insn_state_regs(struct instruction *insn, struct insn_state *s
 	struct cfi_reg *cfa = &state->cfa;
 	struct stack_op *op = &insn->stack_op;
 
-	if (cfa->base != CFI_SP)
+	if (cfa->base != CFI_SP && cfa->base != CFI_SP_INDIRECT)
 		return 0;
 
 	/* push */
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ebbb10c61e24..c227a2e55751 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -87,9 +87,10 @@ struct elf {
 #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
 #define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
 
-#define for_offset_range(_offset, _start, _end)		\
-	for (_offset = ((_start) & OFFSET_STRIDE_MASK);	\
-	     _offset <= ((_end) & OFFSET_STRIDE_MASK);	\
+#define for_offset_range(_offset, _start, _end)			\
+	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
+	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
+	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
 	     _offset += OFFSET_STRIDE)
 
 static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)

