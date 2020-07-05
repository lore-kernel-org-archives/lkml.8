Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0FDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50942073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6gro4lt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="443yTYej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGEPr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgGEPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:47:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B73C08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 08:47:54 -0700 (PDT)
Date:   Sun, 05 Jul 2020 15:46:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593964071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=C9SnkifQqD1VgTsekOtSs0QETm9tNZQ3fOKOecjPJbg=;
        b=s6gro4ltZYN3/dXG+KHfASdZ1iuM0tnaBgRqym61aGdBmcN1nIIYPybCJmvNRqvRqPC9Hg
        6n1Tgqf8TMEWQoJ5BDFfD5rOlYZqjAKAaUEmNWvvL8B5XyMgnpRip5wlxWChg757UUXR2Z
        2toh/9GKQcIHTwLF34rWBqwgJArMCEhDUWFMxjQ6DY4S1yIktb5XIT/PSTk1uUwwoxQdY2
        qI06LFnoGL15FB4M0xyfMVdMb7s89BGhmy5kHuaz+Oht1rF+ALN1Vuxn/ADGg22oJ5U02f
        wjHt+IbmQL962p8X6LChL1oo9PZ/ufrnTbu6fc+S7X4hfmlDVHChQR+HWonKLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593964071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=C9SnkifQqD1VgTsekOtSs0QETm9tNZQ3fOKOecjPJbg=;
        b=443yTYejuCoLffAdhrsU8VGOfRdsJwckbK8voUl1rKeD1012H+YSIDPWZ/sgjbzYXIlS5e
        SzYDwtAxdmrEBiAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.8-rc4
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
Message-ID: <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-05

up to:  cc801833a171: x86/ldt: Disable 16-bit segments on Xen PV


A series of fixes for x86:

 - Reset MXCSR in kernel_fpu_begin() to prevent using a stale user space
   value.

 - Prevent writing MSR_TEST_CTRL on CPUs which are not explicitly
   whitelisted for split lock detection. Some CPUs which do not support
   it crash even when the MSR is written to 0 which is the default value.

 - Fix the XEN PV fallout of the entry code rework

 - Fix the 32bit fallout of the entry code rework

 - Add more selftests to ensure that these entry problems don't come back.

 - Disable 16 bit segments on XEN PV. It's not supported because XEN PV
   does not implement ESPFIX64

Thanks,

	tglx

------------------>
Andy Lutomirski (11):
      x86/entry: Assert that syscalls are on the right stack
      x86/entry: Move SYSENTER's regs->sp and regs->flags fixups into C
      x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
      selftests/x86/syscall_nt: Add more flag combinations
      selftests/x86/syscall_nt: Clear weird flags after each test
      selftests/x86: Consolidate and fix get/set_eflags() helpers
      x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER
      x86/entry, selftests: Further improve user entry sanity checks
      x86/entry/xen: Route #DB correctly on Xen PV
      x86/entry/32: Fix #MC and #DB wiring on x86_32
      x86/ldt: Disable 16-bit segments on Xen PV

Petteri Aimonen (1):
      x86/fpu: Reset MXCSR to default in kernel_fpu_begin()

Sean Christopherson (1):
      x86/split_lock: Don't write MSR_TEST_CTRL on CPUs that aren't whitelisted


 arch/x86/entry/common.c                           | 49 +++++++++++++++++++++--
 arch/x86/entry/entry_32.S                         |  5 +--
 arch/x86/entry/entry_64_compat.S                  | 31 +++++++-------
 arch/x86/include/asm/fpu/internal.h               |  5 +++
 arch/x86/include/asm/idtentry.h                   | 47 +++++++++-------------
 arch/x86/kernel/cpu/intel.c                       | 11 ++++-
 arch/x86/kernel/cpu/mce/core.c                    |  4 +-
 arch/x86/kernel/fpu/core.c                        |  6 +++
 arch/x86/kernel/ldt.c                             | 35 +++++++++++++++-
 arch/x86/kernel/traps.c                           | 14 ++++++-
 arch/x86/xen/enlighten_pv.c                       | 28 +++++++++++--
 arch/x86/xen/xen-asm_64.S                         | 25 ++++++++----
 tools/testing/selftests/x86/Makefile              |  4 +-
 tools/testing/selftests/x86/helpers.h             | 41 +++++++++++++++++++
 tools/testing/selftests/x86/single_step_syscall.c | 17 +-------
 tools/testing/selftests/x86/syscall_arg_fault.c   | 21 +---------
 tools/testing/selftests/x86/syscall_nt.c          | 47 +++++++++++++---------
 tools/testing/selftests/x86/test_vsyscall.c       | 15 +------
 tools/testing/selftests/x86/unwind_vdso.c         | 23 +----------
 19 files changed, 274 insertions(+), 154 deletions(-)
 create mode 100644 tools/testing/selftests/x86/helpers.h

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193..e83b3f14897c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -45,6 +45,32 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+/* Check that the stack and regs on entry from user mode are sane. */
+static void check_user_regs(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		/*
+		 * Make sure that the entry code gave us a sensible EFLAGS
+		 * register.  Native because we want to check the actual CPU
+		 * state, not the interrupt state as imagined by Xen.
+		 */
+		unsigned long flags = native_save_fl();
+		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
+				      X86_EFLAGS_NT));
+
+		/* We think we came from user mode. Make sure pt_regs agrees. */
+		WARN_ON_ONCE(!user_mode(regs));
+
+		/*
+		 * All entries from user mode (except #DF) should be on the
+		 * normal thread stack and should have user pt_regs in the
+		 * correct location.
+		 */
+		WARN_ON_ONCE(!on_thread_stack());
+		WARN_ON_ONCE(regs != task_pt_regs(current));
+	}
+}
+
 #ifdef CONFIG_CONTEXT_TRACKING
 /**
  * enter_from_user_mode - Establish state when coming from user mode
@@ -127,9 +153,6 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	unsigned long ret = 0;
 	u32 work;
 
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-		BUG_ON(regs != task_pt_regs(current));
-
 	work = READ_ONCE(ti->flags);
 
 	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
@@ -346,6 +369,8 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
+	check_user_regs(regs);
+
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -409,6 +434,8 @@ static void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
+	check_user_regs(regs);
+
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -460,6 +487,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
+	check_user_regs(regs);
+
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
@@ -510,6 +539,18 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
 }
+
+/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
+__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
+{
+	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
+	regs->sp = regs->bp;
+
+	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
+	regs->flags |= X86_EFLAGS_IF;
+
+	return do_fast_syscall_32(regs);
+}
 #endif
 
 SYSCALL_DEFINE0(ni_syscall)
@@ -553,6 +594,7 @@ SYSCALL_DEFINE0(ni_syscall)
 bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
+		check_user_regs(regs);
 		enter_from_user_mode();
 		return false;
 	}
@@ -686,6 +728,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
  */
 void noinstr idtentry_enter_user(struct pt_regs *regs)
 {
+	check_user_regs(regs);
 	enter_from_user_mode();
 }
 
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 024d7d276cd4..2d0bd5d5f032 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -933,9 +933,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
-	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
+	pushl	$0			/* pt_regs->sp (placeholder) */
 	pushfl				/* pt_regs->flags (except IF = 0) */
-	orl	$X86_EFLAGS_IF, (%esp)	/* Fix IF */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
 	pushl	%eax			/* pt_regs->orig_ax */
@@ -965,7 +964,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 .Lsysenter_flags_fixed:
 
 	movl	%esp, %eax
-	call	do_fast_syscall_32
+	call	do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
 		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0f974ae01e62..541fdaf64045 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -57,29 +57,30 @@ SYM_CODE_START(entry_SYSENTER_compat)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
-	/*
-	 * User tracing code (ptrace or signal handlers) might assume that
-	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
-	 * syscall.  Just in case the high bits are nonzero, zero-extend
-	 * the syscall number.  (This could almost certainly be deleted
-	 * with no ill effects.)
-	 */
-	movl	%eax, %eax
-
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
-	pushq	%rbp			/* pt_regs->sp (stashed in bp) */
+	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
 
 	/*
 	 * Push flags.  This is nasty.  First, interrupts are currently
-	 * off, but we need pt_regs->flags to have IF set.  Second, even
-	 * if TF was set when SYSENTER started, it's clear by now.  We fix
-	 * that later using TIF_SINGLESTEP.
+	 * off, but we need pt_regs->flags to have IF set.  Second, if TS
+	 * was set in usermode, it's still set, and we're singlestepping
+	 * through this code.  do_SYSENTER_32() will fix up IF.
 	 */
 	pushfq				/* pt_regs->flags (except IF = 0) */
-	orl	$X86_EFLAGS_IF, (%rsp)	/* Fix saved flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
+SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
+
+	/*
+	 * User tracing code (ptrace or signal handlers) might assume that
+	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
+	 * syscall.  Just in case the high bits are nonzero, zero-extend
+	 * the syscall number.  (This could almost certainly be deleted
+	 * with no ill effects.)
+	 */
+	movl	%eax, %eax
+
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
@@ -135,7 +136,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 .Lsysenter_flags_fixed:
 
 	movq	%rsp, %rdi
-	call	do_fast_syscall_32
+	call	do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f45bf9c..845e7481ab77 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -623,6 +623,11 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
  * MXCSR and XCR definitions:
  */
 
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
 extern unsigned int mxcsr_feature_mask;
 
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index cf51c50eb356..eeac6dc2adaa 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -353,10 +353,6 @@ static __always_inline void __##func(struct pt_regs *regs)
 
 #else	/* CONFIG_X86_64 */
 
-/* Maps to a regular IDTENTRY on 32bit for now */
-# define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
-# define DEFINE_IDTENTRY_IST		DEFINE_IDTENTRY
-
 /**
  * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
  * @vector:	Vector number (ignored for C)
@@ -387,28 +383,18 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #endif	/* !CONFIG_X86_64 */
 
 /* C-Code mapping */
+#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+
+#ifdef CONFIG_X86_64
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
 
-#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
-
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
-
-/**
- * DECLARE_IDTENTRY_XEN - Declare functions for XEN redirect IDT entry points
- * @vector:	Vector number (ignored for C)
- * @func:	Function name of the entry point
- *
- * Used for xennmi and xendebug redirections. No DEFINE as this is all ASM
- * indirection magic.
- */
-#define DECLARE_IDTENTRY_XEN(vector, func)				\
-	asmlinkage void xen_asm_exc_xen##func(void);			\
-	asmlinkage void asm_exc_xen##func(void)
+#endif
 
 #else /* !__ASSEMBLY__ */
 
@@ -455,9 +441,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
-# define DECLARE_IDTENTRY_DEBUG(vector, func)				\
-	DECLARE_IDTENTRY(vector, func)
-
 /* No ASM emitted for DF as this goes through a C shim */
 # define DECLARE_IDTENTRY_DF(vector, func)
 
@@ -469,10 +452,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 /* No ASM code emitted for NMI */
 #define DECLARE_IDTENTRY_NMI(vector, func)
 
-/* XEN NMI and DB wrapper */
-#define DECLARE_IDTENTRY_XEN(vector, func)				\
-	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
-
 /*
  * ASM code to emit the common vector entry stubs where each stub is
  * packed into 8 bytes.
@@ -565,16 +544,28 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
 DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_PF,	exc_page_fault);
 
 #ifdef CONFIG_X86_MCE
+#ifdef CONFIG_X86_64
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
+#else
+DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	exc_machine_check);
+#endif
 #endif
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
+#endif
 
 /* #DB */
+#ifdef CONFIG_X86_64
 DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
-DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
+#else
+DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	exc_debug);
+#endif
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
+#endif
 
 /* #DF */
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c25a67a34bd3..0ab48f1cdf84 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -49,6 +49,13 @@ enum split_lock_detect_state {
 static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
 static u64 msr_test_ctrl_cache __ro_after_init;
 
+/*
+ * With a name like MSR_TEST_CTL it should go without saying, but don't touch
+ * MSR_TEST_CTL unless the CPU is one of the whitelisted models.  Writing it
+ * on CPUs that do not support SLD can cause fireworks, even when writing '0'.
+ */
+static bool cpu_model_supports_sld __ro_after_init;
+
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
@@ -1071,7 +1078,8 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
-	split_lock_verify_msr(sld_state != sld_off);
+	if (cpu_model_supports_sld)
+		split_lock_verify_msr(sld_state != sld_off);
 }
 
 static void split_lock_warn(unsigned long ip)
@@ -1177,5 +1185,6 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 		return;
 	}
 
+	cpu_model_supports_sld = true;
 	split_lock_setup();
 }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce9120c4f740..a6a90b5d7c83 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1901,6 +1901,8 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	WARN_ON_ONCE(user_mode(regs));
+
 	/*
 	 * Only required when from kernel mode. See
 	 * mce_check_crashing_cpu() for details.
@@ -1954,7 +1956,7 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 }
 #else
 /* 32bit unified entry point */
-DEFINE_IDTENTRY_MCE(exc_machine_check)
+DEFINE_IDTENTRY_RAW(exc_machine_check)
 {
 	unsigned long dr7;
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 06c818967bb6..15247b96c6ea 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,6 +101,12 @@ void kernel_fpu_begin(void)
 		copy_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
+
+	if (boot_cpu_has(X86_FEATURE_XMM))
+		ldmxcsr(MXCSR_DEFAULT);
+
+	if (boot_cpu_has(X86_FEATURE_FPU))
+		asm volatile ("fninit");
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 8748321c4486..34e918ad34d4 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -29,6 +29,8 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable_areas.h>
 
+#include <xen/xen.h>
+
 /* This is a multiple of PAGE_SIZE. */
 #define LDT_SLOT_STRIDE (LDT_ENTRIES * LDT_ENTRY_SIZE)
 
@@ -543,6 +545,37 @@ static int read_default_ldt(void __user *ptr, unsigned long bytecount)
 	return bytecount;
 }
 
+static bool allow_16bit_segments(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_16BIT))
+		return false;
+
+#ifdef CONFIG_XEN_PV
+	/*
+	 * Xen PV does not implement ESPFIX64, which means that 16-bit
+	 * segments will not work correctly.  Until either Xen PV implements
+	 * ESPFIX64 and can signal this fact to the guest or unless someone
+	 * provides compelling evidence that allowing broken 16-bit segments
+	 * is worthwhile, disallow 16-bit segments under Xen PV.
+	 */
+	if (xen_pv_domain()) {
+		static DEFINE_MUTEX(xen_warning);
+		static bool warned;
+
+		mutex_lock(&xen_warning);
+		if (!warned) {
+			pr_info("Warning: 16-bit segments do not work correctly in a Xen PV guest\n");
+			warned = true;
+		}
+		mutex_unlock(&xen_warning);
+
+		return false;
+	}
+#endif
+
+	return true;
+}
+
 static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 {
 	struct mm_struct *mm = current->mm;
@@ -574,7 +607,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 		/* The user wants to clear the entry. */
 		memset(&ldt, 0, sizeof(ldt));
 	} else {
-		if (!IS_ENABLED(CONFIG_X86_16BIT) && !ldt_info.seg_32bit) {
+		if (!ldt_info.seg_32bit && !allow_16bit_segments()) {
 			error = -EINVAL;
 			goto out;
 		}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f9727b96961f..6ed8cc5fbe8f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -865,6 +865,12 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
 
+	/*
+	 * If something gets miswired and we end up here for a user mode
+	 * #DB, we will malfunction.
+	 */
+	WARN_ON_ONCE(user_mode(regs));
+
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
@@ -883,6 +889,12 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
+	/*
+	 * If something gets miswired and we end up here for a kernel mode
+	 * #DB, we will malfunction.
+	 */
+	WARN_ON_ONCE(!user_mode(regs));
+
 	idtentry_enter_user(regs);
 	instrumentation_begin();
 
@@ -913,7 +925,7 @@ DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 }
 #else
 /* 32 bit does not have separate entry points. */
-DEFINE_IDTENTRY_DEBUG(exc_debug)
+DEFINE_IDTENTRY_RAW(exc_debug)
 {
 	unsigned long dr6, dr7;
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index acc49fa6a097..0d68948c82ad 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -598,6 +598,26 @@ static void xen_write_ldt_entry(struct desc_struct *dt, int entrynum,
 }
 
 #ifdef CONFIG_X86_64
+void noist_exc_debug(struct pt_regs *regs);
+
+DEFINE_IDTENTRY_RAW(xenpv_exc_nmi)
+{
+	/* On Xen PV, NMI doesn't use IST.  The C part is the sane as native. */
+	exc_nmi(regs);
+}
+
+DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
+{
+	/*
+	 * There's no IST on Xen PV, but we still need to dispatch
+	 * to the correct handler.
+	 */
+	if (user_mode(regs))
+		noist_exc_debug(regs);
+	else
+		exc_debug(regs);
+}
+
 struct trap_array_entry {
 	void (*orig)(void);
 	void (*xen)(void);
@@ -609,18 +629,18 @@ struct trap_array_entry {
 	.xen		= xen_asm_##func,		\
 	.ist_okay	= ist_ok }
 
-#define TRAP_ENTRY_REDIR(func, xenfunc, ist_ok) {	\
+#define TRAP_ENTRY_REDIR(func, ist_ok) {		\
 	.orig		= asm_##func,			\
-	.xen		= xen_asm_##xenfunc,		\
+	.xen		= xen_asm_xenpv_##func,		\
 	.ist_okay	= ist_ok }
 
 static struct trap_array_entry trap_array[] = {
-	TRAP_ENTRY_REDIR(exc_debug, exc_xendebug,	true  ),
+	TRAP_ENTRY_REDIR(exc_debug,			true  ),
 	TRAP_ENTRY(exc_double_fault,			true  ),
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
-	TRAP_ENTRY_REDIR(exc_nmi, exc_xennmi,		true  ),
+	TRAP_ENTRY_REDIR(exc_nmi,			true  ),
 	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 5d252aaeade8..aab1d99b2b48 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -29,10 +29,9 @@ _ASM_NOKPROBE(xen_\name)
 .endm
 
 xen_pv_trap asm_exc_divide_error
-xen_pv_trap asm_exc_debug
-xen_pv_trap asm_exc_xendebug
+xen_pv_trap asm_xenpv_exc_debug
 xen_pv_trap asm_exc_int3
-xen_pv_trap asm_exc_xennmi
+xen_pv_trap asm_xenpv_exc_nmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
@@ -161,10 +160,22 @@ SYM_FUNC_END(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
 SYM_FUNC_START(xen_sysenter_target)
-	mov 0*8(%rsp), %rcx
-	mov 1*8(%rsp), %r11
-	mov 5*8(%rsp), %rsp
-	jmp entry_SYSENTER_compat
+	/*
+	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
+	 * that we don't need to guard against single step exceptions here.
+	 */
+	popq %rcx
+	popq %r11
+
+	/*
+	 * Neither Xen nor the kernel really knows what the old SS and
+	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * report those values even though Xen will guess its own values.
+	 */
+	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER32_CS, 1*8(%rsp)
+
+	jmp entry_SYSENTER_compat_after_hwframe
 SYM_FUNC_END(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5f16821c7f63..d2796ea98c5a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -70,10 +70,10 @@ all_64: $(BINARIES_64)
 
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
-$(BINARIES_32): $(OUTPUT)/%_32: %.c
+$(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
 
-$(BINARIES_64): $(OUTPUT)/%_64: %.c
+$(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
 	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
new file mode 100644
index 000000000000..f5ff2a2615df
--- /dev/null
+++ b/tools/testing/selftests/x86/helpers.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __SELFTESTS_X86_HELPERS_H
+#define __SELFTESTS_X86_HELPERS_H
+
+#include <asm/processor-flags.h>
+
+static inline unsigned long get_eflags(void)
+{
+	unsigned long eflags;
+
+	asm volatile (
+#ifdef __x86_64__
+		"subq $128, %%rsp\n\t"
+		"pushfq\n\t"
+		"popq %0\n\t"
+		"addq $128, %%rsp"
+#else
+		"pushfl\n\t"
+		"popl %0"
+#endif
+		: "=r" (eflags) :: "memory");
+
+	return eflags;
+}
+
+static inline void set_eflags(unsigned long eflags)
+{
+	asm volatile (
+#ifdef __x86_64__
+		"subq $128, %%rsp\n\t"
+		"pushq %0\n\t"
+		"popfq\n\t"
+		"addq $128, %%rsp"
+#else
+		"pushl %0\n\t"
+		"popfl"
+#endif
+		:: "r" (eflags) : "flags", "memory");
+}
+
+#endif /* __SELFTESTS_X86_HELPERS_H */
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 1063328e275c..120ac741fe44 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -31,6 +31,8 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 
+#include "helpers.h"
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -67,21 +69,6 @@ static unsigned char altstack_data[SIGSTKSZ];
 # define INT80_CLOBBERS
 #endif
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
-#define X86_EFLAGS_TF (1UL << 8)
-
 static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bc0ecc2e862e..5b7abebbcbb9 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -15,30 +15,11 @@
 #include <setjmp.h>
 #include <errno.h>
 
-#ifdef __x86_64__
-# define WIDTH "q"
-#else
-# define WIDTH "l"
-#endif
+#include "helpers.h"
 
 /* Our sigaltstack scratch space. */
 static unsigned char altstack_data[SIGSTKSZ];
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
-#define X86_EFLAGS_TF (1UL << 8)
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index 02309a195041..a108b80dd082 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -13,29 +13,11 @@
 #include <signal.h>
 #include <err.h>
 #include <sys/syscall.h>
-#include <asm/processor-flags.h>
 
-#ifdef __x86_64__
-# define WIDTH "q"
-#else
-# define WIDTH "l"
-#endif
+#include "helpers.h"
 
 static unsigned int nerrs;
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -59,6 +41,7 @@ static void do_it(unsigned long extraflags)
 	set_eflags(get_eflags() | extraflags);
 	syscall(SYS_getpid);
 	flags = get_eflags();
+	set_eflags(X86_EFLAGS_IF | X86_EFLAGS_FIXED);
 	if ((flags & extraflags) == extraflags) {
 		printf("[OK]\tThe syscall worked and flags are still set\n");
 	} else {
@@ -73,6 +56,12 @@ int main(void)
 	printf("[RUN]\tSet NT and issue a syscall\n");
 	do_it(X86_EFLAGS_NT);
 
+	printf("[RUN]\tSet AC and issue a syscall\n");
+	do_it(X86_EFLAGS_AC);
+
+	printf("[RUN]\tSet NT|AC and issue a syscall\n");
+	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC);
+
 	/*
 	 * Now try it again with TF set -- TF forces returns via IRET in all
 	 * cases except non-ptregs-using 64-bit full fast path syscalls.
@@ -80,8 +69,28 @@ int main(void)
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
+	printf("[RUN]\tSet TF and issue a syscall\n");
+	do_it(X86_EFLAGS_TF);
+
 	printf("[RUN]\tSet NT|TF and issue a syscall\n");
 	do_it(X86_EFLAGS_NT | X86_EFLAGS_TF);
 
+	printf("[RUN]\tSet AC|TF and issue a syscall\n");
+	do_it(X86_EFLAGS_AC | X86_EFLAGS_TF);
+
+	printf("[RUN]\tSet NT|AC|TF and issue a syscall\n");
+	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC | X86_EFLAGS_TF);
+
+	/*
+	 * Now try DF.  This is evil and it's plausible that we will crash
+	 * glibc, but glibc would have to do something rather surprising
+	 * for this to happen.
+	 */
+	printf("[RUN]\tSet DF and issue a syscall\n");
+	do_it(X86_EFLAGS_DF);
+
+	printf("[RUN]\tSet TF|DF and issue a syscall\n");
+	do_it(X86_EFLAGS_TF | X86_EFLAGS_DF);
+
 	return nerrs == 0 ? 0 : 1;
 }
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index a4f4d4cf22c3..c41f24b517f4 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -20,6 +20,8 @@
 #include <setjmp.h>
 #include <sys/uio.h>
 
+#include "helpers.h"
+
 #ifdef __x86_64__
 # define VSYS(x) (x)
 #else
@@ -493,21 +495,8 @@ static int test_process_vm_readv(void)
 }
 
 #ifdef __x86_64__
-#define X86_EFLAGS_TF (1UL << 8)
 static volatile sig_atomic_t num_vsyscall_traps;
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushfq\n\tpopq %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("pushq %0\n\tpopfq" : : "rm" (eflags) : "flags");
-}
-
 static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t *)ctx_void;
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 0075ccd65407..4c311e1af4c7 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -11,6 +11,8 @@
 #include <features.h>
 #include <stdio.h>
 
+#include "helpers.h"
+
 #if defined(__GLIBC__) && __GLIBC__ == 2 && __GLIBC_MINOR__ < 16
 
 int main()
@@ -53,27 +55,6 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		err(1, "sigaction");
 }
 
-#ifdef __x86_64__
-# define WIDTH "q"
-#else
-# define WIDTH "l"
-#endif
-
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
-#define X86_EFLAGS_TF (1UL << 8)
-
 static volatile sig_atomic_t nerrs;
 static unsigned long sysinfo;
 static bool got_sysinfo = false;

