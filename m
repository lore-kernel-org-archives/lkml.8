Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11555C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BEF2074D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599380622;
	bh=DSBBqgK7vt9GFxG4qX9aQ4rWT9uxgr8d+0zc8W3JdOY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=L0BALd+l4mrRvAeGiobbCiu1j4UQ+G4NpHZV5MNvzm01h6A0wUxN14ixdrqamVHYG
	 dPd8BQlt9l+ui+ITbwHpakqycNvPrNZVwyzXlm7LrfTueS6/EZX8enF2KVvBYw2274
	 9/yuWaMIemdrGZGZ0sNlBQQDg4oiDJzNil30yh9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIFIPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 04:15:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B8C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 01:15:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so13960411ejk.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PCGLMEAce2o0FOL3Q1Tpb77DcP3duE/UpFUJzsED0K0=;
        b=F2eRaHkv7gPiF6pF/Ot5PKHP/HCHtQJjYY/nlvbxbpSqhf/Tc/0aTUVMqLJ9Pg2HI7
         XTObnst5ZPKXL7WX8yeTCcs8XBJo4N2smQDOAkIg3n/JG6tyomzFp6dWiRRXPyF4gaQY
         XxXPKdAdHZnAisMw6sha8FS3mnHLDnY2MYIgN4Q+JwmPZEZxXhsGQYEDdCUvraN5HQpB
         Vn7B1O4V2ltRXHoJ3Y5GAt3K4fwgFTJvLYgyY7pTZreRY9nCIcKcFnU4lfHPVLe7V6nd
         CkMCrd8JeCgBcubW237Bu9DSZP2QgeK2pdKRsv1aBlvZQrJGoV49RIV2o613g5uPqAi1
         8UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=PCGLMEAce2o0FOL3Q1Tpb77DcP3duE/UpFUJzsED0K0=;
        b=umi9wuYNbCsGSkmlK5+nq6rG1jDAc2zqUAes3ucOieZ0FF1pQNCx6KNO9tlFaI3Ord
         A1G+L6EtSb4YVIamdY8fQLhP02tioc9Vmxwc8Y0bxuKxw+FhRNmqOQSqEIZiGQfWv6A3
         GdyIvpLGBBVEU1Y5OwYY724qnyqj02wQvMONXi04t2Cep8uQLD1ZonOv2HpQ4o5Cx8a+
         I1n1shBsdmpPZM7C+QeArgIVcMcZk9q/mriSIxqSKKFT872Jn4O5J7fJrYoJx7g05Iog
         om9u7CkaVdmQUyvaauh71nylLneFcy53RAjNSjY9geK+aneJT0KxPG56Y164R/I/IukG
         gQsQ==
X-Gm-Message-State: AOAM531TzF93/7N1cTvSdWtJWBNz8uno2um4Djb+Hw/bmQ3C8WFxpvDy
        CJPN+jaNeOzdUJOsHUe3dD8=
X-Google-Smtp-Source: ABdhPJzL0Yvl+mzCHwYxl+HsAhr15RxzTXe5ReGBZwfZxqQO6O0973VIJWe8PW5UON/ubD002AbPdg==
X-Received: by 2002:a17:906:9346:: with SMTP id p6mr14500197ejw.305.1599380118123;
        Sun, 06 Sep 2020 01:15:18 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o17sm11416901eje.17.2020.09.06.01.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 01:15:17 -0700 (PDT)
Date:   Sun, 6 Sep 2020 10:15:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20200906081515.GA3034383@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-09-06

   # HEAD: 4facb95b7adaf77e2da73aafb9ba60996fe42a12 x86/entry: Unbreak 32bit fast syscall

Misc fixes:

 - Fix more generic entry code ABI fallout
 - Fix debug register handling bugs
 - Fix vmalloc mappings on 32-bit kernels
 - Fix kprobes instrumentation output on 32-bit kernels
 - Fix over-eager WARN_ON_ONCE() on !SMAP hardware
 - Fix NUMA debugging
 - Fix Clang related crash on !RETPOLINE kernels

The most complex fixes are only a few days old and some haven't seen 
-next yet, but I didn't think we should delay them.

  out-of-topic modifications in x86-urgent-2020-09-06:
  ------------------------------------------------------
  include/linux/entry-common.h       # 4facb95b7ada: x86/entry: Unbreak 32bit fas
  kernel/entry/common.c              # 4facb95b7ada: x86/entry: Unbreak 32bit fas

 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      x86/debug: Allow a single level of #DB recursion

Arvind Sankar (1):
      x86/cmdline: Disable jump tables for cmdline.c

Huang Ying (1):
      x86, fakenuma: Fix invalid starting node ID

Joerg Roedel (1):
      x86/mm/32: Bring back vmalloc faulting on x86_32

Peter Zijlstra (1):
      x86/entry: Fix AC assertion

Thomas Gleixner (1):
      x86/entry: Unbreak 32bit fast syscall

Vamshi K Sthambamkadi (1):
      tracing/kprobes, x86/ptrace: Fix regs argument order for i386


 arch/x86/entry/common.c             | 29 +++++++++-----
 arch/x86/include/asm/entry-common.h | 12 +++++-
 arch/x86/include/asm/ptrace.h       |  2 +-
 arch/x86/kernel/traps.c             | 65 +++++++++++++++----------------
 arch/x86/lib/Makefile               |  2 +-
 arch/x86/mm/fault.c                 | 78 +++++++++++++++++++++++++++++++++++++
 arch/x86/mm/numa_emulation.c        |  2 +-
 include/linux/entry-common.h        | 51 +++++++++++++++++++-----
 kernel/entry/common.c               | 35 ++++++++++++++---
 9 files changed, 213 insertions(+), 63 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 48512c7944e7..2f84c7ca74ea 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -60,16 +60,10 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
 {
-	unsigned int nr = (unsigned int)regs->orig_ax;
-
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
-	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
-	 * orig_ax, the unsigned int return value truncates it.  This may
-	 * or may not be necessary, but it matches the old asm behavior.
-	 */
-	return (unsigned int)syscall_enter_from_user_mode(regs, nr);
+
+	return (unsigned int)regs->orig_ax;
 }
 
 /*
@@ -91,15 +85,29 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	unsigned int nr = syscall_32_enter(regs);
 
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * or may not be necessary, but it matches the old asm behavior.
+	 */
+	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+
 	do_syscall_32_irqs_on(regs, nr);
 	syscall_exit_to_user_mode(regs);
 }
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr	= syscall_32_enter(regs);
+	unsigned int nr = syscall_32_enter(regs);
 	int res;
 
+	/*
+	 * This cannot use syscall_enter_from_user_mode() as it has to
+	 * fetch EBP before invoking any of the syscall entry work
+	 * functions.
+	 */
+	syscall_enter_from_user_mode_prepare(regs);
+
 	instrumentation_begin();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
@@ -122,6 +130,9 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		return false;
 	}
 
+	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
+	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
 	syscall_exit_to_user_mode(regs);
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index a8f9315b9eae..6fe54b2813c1 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -18,8 +18,16 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 		 * state, not the interrupt state as imagined by Xen.
 		 */
 		unsigned long flags = native_save_fl();
-		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
-				      X86_EFLAGS_NT));
+		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
+
+		/*
+		 * For !SMAP hardware we patch out CLAC on entry.
+		 */
+		if (boot_cpu_has(X86_FEATURE_SMAP) ||
+		    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
+			mask |= X86_EFLAGS_AC;
+
+		WARN_ON_ONCE(flags & mask);
 
 		/* We think we came from user mode. Make sure pt_regs agrees. */
 		WARN_ON_ONCE(!user_mode(regs));
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 40aa69d04862..d8324a236696 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -327,8 +327,8 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 	static const unsigned int argument_offs[] = {
 #ifdef __i386__
 		offsetof(struct pt_regs, ax),
-		offsetof(struct pt_regs, cx),
 		offsetof(struct pt_regs, dx),
+		offsetof(struct pt_regs, cx),
 #define NR_REG_ARGUMENTS 3
 #else
 		offsetof(struct pt_regs, di),
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1f66d2d1e998..81a2fb711091 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -729,20 +729,9 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
 #endif
 }
 
-static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
+static __always_inline unsigned long debug_read_clear_dr6(void)
 {
-	/*
-	 * Disable breakpoints during exception handling; recursive exceptions
-	 * are exceedingly 'fun'.
-	 *
-	 * Since this function is NOKPROBE, and that also applies to
-	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
-	 * HW_BREAKPOINT_W on our stack)
-	 *
-	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
-	 * includes the entry stack is excluded for everything.
-	 */
-	*dr7 = local_db_save();
+	unsigned long dr6;
 
 	/*
 	 * The Intel SDM says:
@@ -755,15 +744,12 @@ static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
 	 *
 	 * Keep it simple: clear DR6 immediately.
 	 */
-	get_debugreg(*dr6, 6);
+	get_debugreg(dr6, 6);
 	set_debugreg(0, 6);
 	/* Filter out all the reserved bits which are preset to 1 */
-	*dr6 &= ~DR6_RESERVED;
-}
+	dr6 &= ~DR6_RESERVED;
 
-static __always_inline void debug_exit(unsigned long dr7)
-{
-	local_db_restore(dr7);
+	return dr6;
 }
 
 /*
@@ -863,6 +849,18 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
+	/*
+	 * Disable breakpoints during exception handling; recursive exceptions
+	 * are exceedingly 'fun'.
+	 *
+	 * Since this function is NOKPROBE, and that also applies to
+	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
+	 * HW_BREAKPOINT_W on our stack)
+	 *
+	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
+	 * includes the entry stack is excluded for everything.
+	 */
+	unsigned long dr7 = local_db_save();
 	bool irq_state = idtentry_enter_nmi(regs);
 	instrumentation_begin();
 
@@ -883,6 +881,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
+
+	local_db_restore(dr7);
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,
@@ -894,6 +894,15 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	 */
 	WARN_ON_ONCE(!user_mode(regs));
 
+	/*
+	 * NB: We can't easily clear DR7 here because
+	 * idtentry_exit_to_usermode() can invoke ptrace, schedule, access
+	 * user memory, etc.  This means that a recursive #DB is possible.  If
+	 * this happens, that #DB will hit exc_debug_kernel() and clear DR7.
+	 * Since we're not on the IST stack right now, everything will be
+	 * fine.
+	 */
+
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
@@ -907,36 +916,24 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 /* IST stack entry */
 DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
-	exc_debug_kernel(regs, dr6);
-	debug_exit(dr7);
+	exc_debug_kernel(regs, debug_read_clear_dr6());
 }
 
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
-	exc_debug_user(regs, dr6);
-	debug_exit(dr7);
+	exc_debug_user(regs, debug_read_clear_dr6());
 }
 #else
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)
 {
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
+	unsigned long dr6 = debug_read_clear_dr6();
 
 	if (user_mode(regs))
 		exc_debug_user(regs, dr6);
 	else
 		exc_debug_kernel(regs, dr6);
-
-	debug_exit(dr7);
 }
 #endif
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index d46fff11f06f..aa067859a70b 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -24,7 +24,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
 endif
 
-CFLAGS_cmdline.o := -fno-stack-protector
+CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
 endif
 
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498e9832..6e3e8a124903 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -190,6 +190,53 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	return pmd_k;
 }
 
+/*
+ *   Handle a fault on the vmalloc or module mapping area
+ *
+ *   This is needed because there is a race condition between the time
+ *   when the vmalloc mapping code updates the PMD to the point in time
+ *   where it synchronizes this update with the other page-tables in the
+ *   system.
+ *
+ *   In this race window another thread/CPU can map an area on the same
+ *   PMD, finds it already present and does not synchronize it with the
+ *   rest of the system yet. As a result v[mz]alloc might return areas
+ *   which are not mapped in every page-table in the system, causing an
+ *   unhandled page-fault when they are accessed.
+ */
+static noinline int vmalloc_fault(unsigned long address)
+{
+	unsigned long pgd_paddr;
+	pmd_t *pmd_k;
+	pte_t *pte_k;
+
+	/* Make sure we are in vmalloc area: */
+	if (!(address >= VMALLOC_START && address < VMALLOC_END))
+		return -1;
+
+	/*
+	 * Synchronize this task's top level page-table
+	 * with the 'reference' page table.
+	 *
+	 * Do _not_ use "current" here. We might be inside
+	 * an interrupt in the middle of a task switch..
+	 */
+	pgd_paddr = read_cr3_pa();
+	pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
+	if (!pmd_k)
+		return -1;
+
+	if (pmd_large(*pmd_k))
+		return 0;
+
+	pte_k = pte_offset_kernel(pmd_k, address);
+	if (!pte_present(*pte_k))
+		return -1;
+
+	return 0;
+}
+NOKPROBE_SYMBOL(vmalloc_fault);
+
 void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
@@ -1110,6 +1157,37 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 */
 	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
 
+#ifdef CONFIG_X86_32
+	/*
+	 * We can fault-in kernel-space virtual memory on-demand. The
+	 * 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 *
+	 * Before doing this on-demand faulting, ensure that the
+	 * fault is not any of the following:
+	 * 1. A fault on a PTE with a reserved bit set.
+	 * 2. A fault caused by a user-mode access.  (Do not demand-
+	 *    fault kernel memory due to user-mode accesses).
+	 * 3. A fault caused by a page-level protection violation.
+	 *    (A demand fault would be on a non-present page which
+	 *     would have X86_PF_PROT==0).
+	 *
+	 * This is only needed to close a race condition on x86-32 in
+	 * the vmalloc mapping/unmapping code. See the comment above
+	 * vmalloc_fault() for details. On x86-64 the race does not
+	 * exist as the vmalloc mappings don't need to be synchronized
+	 * there.
+	 */
+	if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
+		if (vmalloc_fault(address) >= 0)
+			return;
+	}
+#endif
+
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index c5174b4e318b..683cd12f4793 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -321,7 +321,7 @@ static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
 					      u64 addr, u64 max_addr, u64 size)
 {
 	return split_nodes_size_interleave_uniform(ei, pi, addr, max_addr, size,
-			0, NULL, NUMA_NO_NODE);
+			0, NULL, 0);
 }
 
 static int __init setup_emu2phys_nid(int *dfl_phys_nid)
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index efebbffcd5cc..159c7476b11b 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -110,15 +110,30 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 #endif
 
 /**
- * syscall_enter_from_user_mode - Check and handle work before invoking
- *				 a syscall
+ * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
- * @syscall:	The syscall number
  *
  * Invoked from architecture specific syscall entry code with interrupts
  * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct and the subsequent functions can be
- * instrumented.
+ * function returns all state is correct, interrupts are enabled and the
+ * subsequent functions can be instrumented.
+ *
+ * This handles lockdep, RCU (context tracking) and tracing state.
+ *
+ * This is invoked when there is extra architecture specific functionality
+ * to be done between establishing state and handling user mode entry work.
+ */
+void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
+
+/**
+ * syscall_enter_from_user_mode_work - Check and handle work before invoking
+ *				       a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
+ * architecture specific work.
  *
  * Returns: The original or a modified syscall number
  *
@@ -127,12 +142,30 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
  * syscall_set_return_value() first.  If neither of those are called and -1
  * is returned, then the syscall will fail with ENOSYS.
  *
- * The following functionality is handled here:
+ * It handles the following work items:
  *
- *  1) Establish state (lockdep, RCU (context tracking), tracing)
- *  2) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
+ *  1) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
  *     __secure_computing(), trace_sys_enter()
- *  3) Invocation of audit_syscall_entry()
+ *  2) Invocation of audit_syscall_entry()
+ */
+long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+
+/**
+ * syscall_enter_from_user_mode - Establish state and check and handle work
+ *				  before invoking a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct, interrupts are enabled and the
+ * subsequent functions can be instrumented.
+ *
+ * This is combination of syscall_enter_from_user_mode_prepare() and
+ * syscall_enter_from_user_mode_work().
+ *
+ * Returns: The original or a modified syscall number. See
+ * syscall_enter_from_user_mode_work() for further explanation.
  */
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fcae019158ca..18683598edbc 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -69,22 +69,45 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall_get_nr(current, regs);
 }
 
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+static __always_inline long
+__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
 	unsigned long ti_work;
 
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
 	ti_work = READ_ONCE(current_thread_info()->flags);
 	if (ti_work & SYSCALL_ENTER_WORK)
 		syscall = syscall_trace_enter(regs, syscall, ti_work);
-	instrumentation_end();
 
 	return syscall;
 }
 
+long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	return __syscall_enter_from_user_work(regs, syscall);
+}
+
+noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = __syscall_enter_from_user_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
+
+noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+	instrumentation_begin();
+	local_irq_enable();
+	instrumentation_end();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
