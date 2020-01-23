Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31787C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70A921D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAWTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:06:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:54177 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgAWTGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:06:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 11:06:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="276121452"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2020 11:06:07 -0800
Subject: [PATCH 5/5] x86/mpx: remove MPX from arch/x86
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 23 Jan 2020 11:05:05 -0800
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Message-Id: <20200123190505.F35BB130@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX is being removed from the kernel due to a lack of support
in the toolchain going forward (gcc).

This removes all the remaining (dead at this point) MPX handling
code remaining in the tree.  The only remaining code is the XSAVE
support for MPX state which is currently needd for KVM to handle
VMs which might use MPX.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 a/Documentation/x86/intel_mpx.rst          |  252 -------
 a/arch/x86/include/asm/mpx.h               |  116 ---
 a/arch/x86/include/asm/trace/mpx.h         |  134 ----
 a/arch/x86/mm/mpx.c                        |  938 -----------------------------
 b/arch/x86/include/asm/bugs.h              |    6 
 b/arch/x86/include/asm/disabled-features.h |    8 
 b/arch/x86/include/asm/mmu.h               |    4 
 b/arch/x86/include/asm/mmu_context.h       |   20 
 b/arch/x86/include/asm/processor.h         |   18 
 b/arch/x86/kernel/cpu/common.c             |   18 
 b/arch/x86/kernel/cpu/intel.c              |   36 -
 b/arch/x86/kernel/setup.c                  |    2 
 b/arch/x86/kernel/sys_x86_64.c             |    9 
 b/arch/x86/mm/hugetlbpage.c                |    5 
 b/arch/x86/mm/mmap.c                       |    2 
 15 files changed, 1 insertion(+), 1567 deletions(-)

diff -puN arch/x86/include/asm/bugs.h~mpx-remove-x86 arch/x86/include/asm/bugs.h
--- a/arch/x86/include/asm/bugs.h~mpx-remove-x86	2020-01-23 10:41:08.520942430 -0800
+++ b/arch/x86/include/asm/bugs.h	2020-01-23 10:41:08.554942430 -0800
@@ -6,12 +6,6 @@
 
 extern void check_bugs(void);
 
-#if defined(CONFIG_CPU_SUP_INTEL)
-void check_mpx_erratum(struct cpuinfo_x86 *c);
-#else
-static inline void check_mpx_erratum(struct cpuinfo_x86 *c) {}
-#endif
-
 #if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_X86_32)
 int ppro_with_ram_bug(void);
 #else
diff -puN arch/x86/include/asm/disabled-features.h~mpx-remove-x86 arch/x86/include/asm/disabled-features.h
--- a/arch/x86/include/asm/disabled-features.h~mpx-remove-x86	2020-01-23 10:41:08.522942430 -0800
+++ b/arch/x86/include/asm/disabled-features.h	2020-01-23 10:41:08.554942430 -0800
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_INTEL_MPX
-# define DISABLE_MPX	0
-#else
-# define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
-#endif
-
 #ifdef CONFIG_X86_SMAP
 # define DISABLE_SMAP	0
 #else
@@ -74,7 +68,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
+#define DISABLED_MASK9	(DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff -puN arch/x86/include/asm/mmu_context.h~mpx-remove-x86 arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~mpx-remove-x86	2020-01-23 10:41:08.524942430 -0800
+++ b/arch/x86/include/asm/mmu_context.h	2020-01-23 10:41:08.554942430 -0800
@@ -12,7 +12,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
-#include <asm/mpx.h>
 #include <asm/debugreg.h>
 
 extern atomic64_t last_mm_ctx_id;
@@ -275,25 +274,6 @@ static inline bool is_64bit_mm(struct mm
 static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
 			      unsigned long end)
 {
-	/*
-	 * mpx_notify_unmap() goes and reads a rarely-hot
-	 * cacheline in the mm_struct.  That can be expensive
-	 * enough to be seen in profiles.
-	 *
-	 * The mpx_notify_unmap() call and its contents have been
-	 * observed to affect munmap() performance on hardware
-	 * where MPX is not present.
-	 *
-	 * The unlikely() optimizes for the fast case: no MPX
-	 * in the CPU, or no MPX use in the process.  Even if
-	 * we get this wrong (in the unlikely event that MPX
-	 * is widely enabled on some system) the overhead of
-	 * MPX itself (reading bounds tables) is expected to
-	 * overwhelm the overhead of getting this unlikely()
-	 * consistently wrong.
-	 */
-	if (unlikely(cpu_feature_enabled(X86_FEATURE_MPX)))
-		mpx_notify_unmap(mm, start, end);
 }
 
 /*
diff -puN arch/x86/include/asm/mmu.h~mpx-remove-x86 arch/x86/include/asm/mmu.h
--- a/arch/x86/include/asm/mmu.h~mpx-remove-x86	2020-01-23 10:41:08.526942430 -0800
+++ b/arch/x86/include/asm/mmu.h	2020-01-23 10:41:08.554942430 -0800
@@ -50,10 +50,6 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
-#ifdef CONFIG_X86_INTEL_MPX
-	/* address of the bounds directory */
-	void __user *bd_addr;
-#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff -L arch/x86/include/asm/mpx.h -puN arch/x86/include/asm/mpx.h~mpx-remove-x86 /dev/null
--- a/arch/x86/include/asm/mpx.h
+++ /dev/null	2019-02-15 15:42:29.903470860 -0800
@@ -1,116 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MPX_H
-#define _ASM_X86_MPX_H
-
-#include <linux/types.h>
-#include <linux/mm_types.h>
-
-#include <asm/ptrace.h>
-#include <asm/insn.h>
-
-/*
- * NULL is theoretically a valid place to put the bounds
- * directory, so point this at an invalid address.
- */
-#define MPX_INVALID_BOUNDS_DIR	((void __user *)-1)
-#define MPX_BNDCFG_ENABLE_FLAG	0x1
-#define MPX_BD_ENTRY_VALID_FLAG	0x1
-
-/*
- * The upper 28 bits [47:20] of the virtual address in 64-bit
- * are used to index into bounds directory (BD).
- *
- * The directory is 2G (2^31) in size, and with 8-byte entries
- * it has 2^28 entries.
- */
-#define MPX_BD_SIZE_BYTES_64	(1UL<<31)
-#define MPX_BD_ENTRY_BYTES_64	8
-#define MPX_BD_NR_ENTRIES_64	(MPX_BD_SIZE_BYTES_64/MPX_BD_ENTRY_BYTES_64)
-
-/*
- * The 32-bit directory is 4MB (2^22) in size, and with 4-byte
- * entries it has 2^20 entries.
- */
-#define MPX_BD_SIZE_BYTES_32	(1UL<<22)
-#define MPX_BD_ENTRY_BYTES_32	4
-#define MPX_BD_NR_ENTRIES_32	(MPX_BD_SIZE_BYTES_32/MPX_BD_ENTRY_BYTES_32)
-
-/*
- * A 64-bit table is 4MB total in size, and an entry is
- * 4 64-bit pointers in size.
- */
-#define MPX_BT_SIZE_BYTES_64	(1UL<<22)
-#define MPX_BT_ENTRY_BYTES_64	32
-#define MPX_BT_NR_ENTRIES_64	(MPX_BT_SIZE_BYTES_64/MPX_BT_ENTRY_BYTES_64)
-
-/*
- * A 32-bit table is 16kB total in size, and an entry is
- * 4 32-bit pointers in size.
- */
-#define MPX_BT_SIZE_BYTES_32	(1UL<<14)
-#define MPX_BT_ENTRY_BYTES_32	16
-#define MPX_BT_NR_ENTRIES_32	(MPX_BT_SIZE_BYTES_32/MPX_BT_ENTRY_BYTES_32)
-
-#define MPX_BNDSTA_TAIL		2
-#define MPX_BNDCFG_TAIL		12
-#define MPX_BNDSTA_ADDR_MASK	(~((1UL<<MPX_BNDSTA_TAIL)-1))
-#define MPX_BNDCFG_ADDR_MASK	(~((1UL<<MPX_BNDCFG_TAIL)-1))
-#define MPX_BNDSTA_ERROR_CODE	0x3
-
-struct mpx_fault_info {
-	void __user *addr;
-	void __user *lower;
-	void __user *upper;
-};
-
-#ifdef CONFIG_X86_INTEL_MPX
-
-extern int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
-extern int mpx_handle_bd_fault(void);
-
-static inline int kernel_managing_mpx_tables(struct mm_struct *mm)
-{
-	return (mm->context.bd_addr != MPX_INVALID_BOUNDS_DIR);
-}
-
-static inline void mpx_mm_init(struct mm_struct *mm)
-{
-	/*
-	 * NULL is theoretically a valid place to put the bounds
-	 * directory, so point this at an invalid address.
-	 */
-	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
-}
-
-extern void mpx_notify_unmap(struct mm_struct *mm, unsigned long start, unsigned long end);
-extern unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len, unsigned long flags);
-
-#else
-static inline int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
-{
-	return -EINVAL;
-}
-static inline int mpx_handle_bd_fault(void)
-{
-	return -EINVAL;
-}
-static inline int kernel_managing_mpx_tables(struct mm_struct *mm)
-{
-	return 0;
-}
-static inline void mpx_mm_init(struct mm_struct *mm)
-{
-}
-static inline void mpx_notify_unmap(struct mm_struct *mm,
-				    unsigned long start, unsigned long end)
-{
-}
-
-static inline unsigned long mpx_unmapped_area_check(unsigned long addr,
-		unsigned long len, unsigned long flags)
-{
-	return addr;
-}
-#endif /* CONFIG_X86_INTEL_MPX */
-
-#endif /* _ASM_X86_MPX_H */
diff -puN arch/x86/include/asm/processor.h~mpx-remove-x86 arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~mpx-remove-x86	2020-01-23 10:41:08.530942430 -0800
+++ b/arch/x86/include/asm/processor.h	2020-01-23 10:41:08.555942430 -0800
@@ -915,24 +915,6 @@ extern int set_tsc_mode(unsigned int val
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
-/* Register/unregister a process' MPX related resource */
-#define MPX_ENABLE_MANAGEMENT()	mpx_enable_management()
-#define MPX_DISABLE_MANAGEMENT()	mpx_disable_management()
-
-#ifdef CONFIG_X86_INTEL_MPX
-extern int mpx_enable_management(void);
-extern int mpx_disable_management(void);
-#else
-static inline int mpx_enable_management(void)
-{
-	return -EINVAL;
-}
-static inline int mpx_disable_management(void)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_X86_INTEL_MPX */
-
 #ifdef CONFIG_CPU_SUP_AMD
 extern u16 amd_get_nb_id(int cpu);
 extern u32 amd_get_nodes_per_socket(void);
diff -L arch/x86/include/asm/trace/mpx.h -puN arch/x86/include/asm/trace/mpx.h~mpx-remove-x86 /dev/null
--- a/arch/x86/include/asm/trace/mpx.h
+++ /dev/null	2019-02-15 15:42:29.903470860 -0800
@@ -1,134 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM mpx
-
-#if !defined(_TRACE_MPX_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_MPX_H
-
-#include <linux/tracepoint.h>
-
-#ifdef CONFIG_X86_INTEL_MPX
-
-TRACE_EVENT(mpx_bounds_register_exception,
-
-	TP_PROTO(void __user *addr_referenced,
-		 const struct mpx_bndreg *bndreg),
-	TP_ARGS(addr_referenced, bndreg),
-
-	TP_STRUCT__entry(
-		__field(void __user *, addr_referenced)
-		__field(u64, lower_bound)
-		__field(u64, upper_bound)
-	),
-
-	TP_fast_assign(
-		__entry->addr_referenced = addr_referenced;
-		__entry->lower_bound = bndreg->lower_bound;
-		__entry->upper_bound = bndreg->upper_bound;
-	),
-	/*
-	 * Note that we are printing out the '~' of the upper
-	 * bounds register here.  It is actually stored in its
-	 * one's complement form so that its 'init' state
-	 * corresponds to all 0's.  But, that looks like
-	 * gibberish when printed out, so print out the 1's
-	 * complement instead of the actual value here.  Note
-	 * though that you still need to specify filters for the
-	 * actual value, not the displayed one.
-	 */
-	TP_printk("address referenced: 0x%p bounds: lower: 0x%llx ~upper: 0x%llx",
-		__entry->addr_referenced,
-		__entry->lower_bound,
-		~__entry->upper_bound
-	)
-);
-
-TRACE_EVENT(bounds_exception_mpx,
-
-	TP_PROTO(const struct mpx_bndcsr *bndcsr),
-	TP_ARGS(bndcsr),
-
-	TP_STRUCT__entry(
-		__field(u64, bndcfgu)
-		__field(u64, bndstatus)
-	),
-
-	TP_fast_assign(
-		/* need to get rid of the 'const' on bndcsr */
-		__entry->bndcfgu   = (u64)bndcsr->bndcfgu;
-		__entry->bndstatus = (u64)bndcsr->bndstatus;
-	),
-
-	TP_printk("bndcfgu:0x%llx bndstatus:0x%llx",
-		__entry->bndcfgu,
-		__entry->bndstatus)
-);
-
-DECLARE_EVENT_CLASS(mpx_range_trace,
-
-	TP_PROTO(unsigned long start,
-		 unsigned long end),
-	TP_ARGS(start, end),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, start)
-		__field(unsigned long, end)
-	),
-
-	TP_fast_assign(
-		__entry->start = start;
-		__entry->end   = end;
-	),
-
-	TP_printk("[0x%p:0x%p]",
-		(void *)__entry->start,
-		(void *)__entry->end
-	)
-);
-
-DEFINE_EVENT(mpx_range_trace, mpx_unmap_zap,
-	TP_PROTO(unsigned long start, unsigned long end),
-	TP_ARGS(start, end)
-);
-
-DEFINE_EVENT(mpx_range_trace, mpx_unmap_search,
-	TP_PROTO(unsigned long start, unsigned long end),
-	TP_ARGS(start, end)
-);
-
-TRACE_EVENT(mpx_new_bounds_table,
-
-	TP_PROTO(unsigned long table_vaddr),
-	TP_ARGS(table_vaddr),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, table_vaddr)
-	),
-
-	TP_fast_assign(
-		__entry->table_vaddr = table_vaddr;
-	),
-
-	TP_printk("table vaddr:%p", (void *)__entry->table_vaddr)
-);
-
-#else
-
-/*
- * This gets used outside of MPX-specific code, so we need a stub.
- */
-static inline
-void trace_bounds_exception_mpx(const struct mpx_bndcsr *bndcsr)
-{
-}
-
-#endif /* CONFIG_X86_INTEL_MPX */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH asm/trace/
-#undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE mpx
-#endif /* _TRACE_MPX_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff -puN arch/x86/kernel/cpu/common.c~mpx-remove-x86 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~mpx-remove-x86	2020-01-23 10:41:08.534942430 -0800
+++ b/arch/x86/kernel/cpu/common.c	2020-01-23 10:41:08.556942430 -0800
@@ -165,22 +165,6 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_p
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
 
-static int __init x86_mpx_setup(char *s)
-{
-	/* require an exact match without trailing characters */
-	if (strlen(s))
-		return 0;
-
-	/* do not emit a message if the feature is not present */
-	if (!boot_cpu_has(X86_FEATURE_MPX))
-		return 1;
-
-	setup_clear_cpu_cap(X86_FEATURE_MPX);
-	pr_info("nompx: Intel Memory Protection Extensions (MPX) disabled\n");
-	return 1;
-}
-__setup("nompx", x86_mpx_setup);
-
 #ifdef CONFIG_X86_64
 static int __init x86_nopcid_setup(char *s)
 {
@@ -307,8 +291,6 @@ static inline void squash_the_stupid_ser
 static __init int setup_disable_smep(char *arg)
 {
 	setup_clear_cpu_cap(X86_FEATURE_SMEP);
-	/* Check for things that depend on SMEP being enabled: */
-	check_mpx_erratum(&boot_cpu_data);
 	return 1;
 }
 __setup("nosmep", setup_disable_smep);
diff -puN arch/x86/kernel/cpu/intel.c~mpx-remove-x86 arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~mpx-remove-x86	2020-01-23 10:41:08.537942430 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2020-01-23 10:41:08.556942430 -0800
@@ -32,41 +32,6 @@
 #endif
 
 /*
- * Just in case our CPU detection goes bad, or you have a weird system,
- * allow a way to override the automatic disabling of MPX.
- */
-static int forcempx;
-
-static int __init forcempx_setup(char *__unused)
-{
-	forcempx = 1;
-
-	return 1;
-}
-__setup("intel-skd-046-workaround=disable", forcempx_setup);
-
-void check_mpx_erratum(struct cpuinfo_x86 *c)
-{
-	if (forcempx)
-		return;
-	/*
-	 * Turn off the MPX feature on CPUs where SMEP is not
-	 * available or disabled.
-	 *
-	 * Works around Intel Erratum SKD046: "Branch Instructions
-	 * May Initialize MPX Bound Registers Incorrectly".
-	 *
-	 * This might falsely disable MPX on systems without
-	 * SMEP, like Atom processors without SMEP.  But there
-	 * is no such hardware known at the moment.
-	 */
-	if (cpu_has(c, X86_FEATURE_MPX) && !cpu_has(c, X86_FEATURE_SMEP)) {
-		setup_clear_cpu_cap(X86_FEATURE_MPX);
-		pr_warn("x86/mpx: Disabling MPX since SMEP not present\n");
-	}
-}
-
-/*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
  * CPU models in which having conflicting memory types still leads to
@@ -330,7 +295,6 @@ static void early_init_intel(struct cpui
 			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
 	}
 
-	check_mpx_erratum(c);
 	check_memory_type_self_snoop_errata(c);
 
 	/*
diff -puN arch/x86/kernel/setup.c~mpx-remove-x86 arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~mpx-remove-x86	2020-01-23 10:41:08.539942430 -0800
+++ b/arch/x86/kernel/setup.c	2020-01-23 10:41:08.557942430 -0800
@@ -947,8 +947,6 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = _brk_end;
 
-	mpx_mm_init(&init_mm);
-
 	code_resource.start = __pa_symbol(_text);
 	code_resource.end = __pa_symbol(_etext)-1;
 	data_resource.start = __pa_symbol(_etext);
diff -puN arch/x86/kernel/sys_x86_64.c~mpx-remove-x86 arch/x86/kernel/sys_x86_64.c
--- a/arch/x86/kernel/sys_x86_64.c~mpx-remove-x86	2020-01-23 10:41:08.541942430 -0800
+++ b/arch/x86/kernel/sys_x86_64.c	2020-01-23 10:41:08.557942430 -0800
@@ -22,7 +22,6 @@
 #include <asm/elf.h>
 #include <asm/ia32.h>
 #include <asm/syscalls.h>
-#include <asm/mpx.h>
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
@@ -137,10 +136,6 @@ arch_get_unmapped_area(struct file *filp
 	struct vm_unmapped_area_info info;
 	unsigned long begin, end;
 
-	addr = mpx_unmapped_area_check(addr, len, flags);
-	if (IS_ERR_VALUE(addr))
-		return addr;
-
 	if (flags & MAP_FIXED)
 		return addr;
 
@@ -180,10 +175,6 @@ arch_get_unmapped_area_topdown(struct fi
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
 
-	addr = mpx_unmapped_area_check(addr, len, flags);
-	if (IS_ERR_VALUE(addr))
-		return addr;
-
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
 		return -ENOMEM;
diff -puN arch/x86/mm/hugetlbpage.c~mpx-remove-x86 arch/x86/mm/hugetlbpage.c
--- a/arch/x86/mm/hugetlbpage.c~mpx-remove-x86	2020-01-23 10:41:08.543942430 -0800
+++ b/arch/x86/mm/hugetlbpage.c	2020-01-23 10:41:08.557942430 -0800
@@ -19,7 +19,6 @@
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
 #include <asm/elf.h>
-#include <asm/mpx.h>
 
 #if 0	/* This is just for testing */
 struct page *
@@ -151,10 +150,6 @@ hugetlb_get_unmapped_area(struct file *f
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
 
-	addr = mpx_unmapped_area_check(addr, len, flags);
-	if (IS_ERR_VALUE(addr))
-		return addr;
-
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
diff -puN arch/x86/mm/mmap.c~mpx-remove-x86 arch/x86/mm/mmap.c
--- a/arch/x86/mm/mmap.c~mpx-remove-x86	2020-01-23 10:41:08.546942430 -0800
+++ b/arch/x86/mm/mmap.c	2020-01-23 10:41:08.557942430 -0800
@@ -163,8 +163,6 @@ unsigned long get_mmap_base(int is_legac
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & VM_MPX)
-		return "[mpx]";
 	return NULL;
 }
 
diff -L arch/x86/mm/mpx.c -puN arch/x86/mm/mpx.c~mpx-remove-x86 /dev/null
--- a/arch/x86/mm/mpx.c
+++ /dev/null	2019-02-15 15:42:29.903470860 -0800
@@ -1,938 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * mpx.c - Memory Protection eXtensions
- *
- * Copyright (c) 2014, Intel Corporation.
- * Qiaowei Ren <qiaowei.ren@intel.com>
- * Dave Hansen <dave.hansen@intel.com>
- */
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/mm_types.h>
-#include <linux/mman.h>
-#include <linux/syscalls.h>
-#include <linux/sched/sysctl.h>
-
-#include <asm/insn.h>
-#include <asm/insn-eval.h>
-#include <asm/mmu_context.h>
-#include <asm/mpx.h>
-#include <asm/processor.h>
-#include <asm/fpu/internal.h>
-
-#define CREATE_TRACE_POINTS
-#include <asm/trace/mpx.h>
-
-static inline unsigned long mpx_bd_size_bytes(struct mm_struct *mm)
-{
-	if (is_64bit_mm(mm))
-		return MPX_BD_SIZE_BYTES_64;
-	else
-		return MPX_BD_SIZE_BYTES_32;
-}
-
-static inline unsigned long mpx_bt_size_bytes(struct mm_struct *mm)
-{
-	if (is_64bit_mm(mm))
-		return MPX_BT_SIZE_BYTES_64;
-	else
-		return MPX_BT_SIZE_BYTES_32;
-}
-
-/*
- * This is really a simplified "vm_mmap". it only handles MPX
- * bounds tables (the bounds directory is user-allocated).
- */
-static unsigned long mpx_mmap(unsigned long len)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr, populate;
-
-	/* Only bounds table can be allocated here */
-	if (len != mpx_bt_size_bytes(mm))
-		return -EINVAL;
-
-	down_write(&mm->mmap_sem);
-	addr = do_mmap(NULL, 0, len, PROT_READ | PROT_WRITE,
-		       MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate, NULL);
-	up_write(&mm->mmap_sem);
-	if (populate)
-		mm_populate(addr, populate);
-
-	return addr;
-}
-
-static int mpx_insn_decode(struct insn *insn,
-			   struct pt_regs *regs)
-{
-	unsigned char buf[MAX_INSN_SIZE];
-	int x86_64 = !test_thread_flag(TIF_IA32);
-	int not_copied;
-	int nr_copied;
-
-	not_copied = copy_from_user(buf, (void __user *)regs->ip, sizeof(buf));
-	nr_copied = sizeof(buf) - not_copied;
-	/*
-	 * The decoder _should_ fail nicely if we pass it a short buffer.
-	 * But, let's not depend on that implementation detail.  If we
-	 * did not get anything, just error out now.
-	 */
-	if (!nr_copied)
-		return -EFAULT;
-	insn_init(insn, buf, nr_copied, x86_64);
-	insn_get_length(insn);
-	/*
-	 * copy_from_user() tries to get as many bytes as we could see in
-	 * the largest possible instruction.  If the instruction we are
-	 * after is shorter than that _and_ we attempt to copy from
-	 * something unreadable, we might get a short read.  This is OK
-	 * as long as the read did not stop in the middle of the
-	 * instruction.  Check to see if we got a partial instruction.
-	 */
-	if (nr_copied < insn->length)
-		return -EFAULT;
-
-	insn_get_opcode(insn);
-	/*
-	 * We only _really_ need to decode bndcl/bndcn/bndcu
-	 * Error out on anything else.
-	 */
-	if (insn->opcode.bytes[0] != 0x0f)
-		goto bad_opcode;
-	if ((insn->opcode.bytes[1] != 0x1a) &&
-	    (insn->opcode.bytes[1] != 0x1b))
-		goto bad_opcode;
-
-	return 0;
-bad_opcode:
-	return -EINVAL;
-}
-
-/*
- * If a bounds overflow occurs then a #BR is generated. This
- * function decodes MPX instructions to get violation address
- * and set this address into extended struct siginfo.
- *
- * Note that this is not a super precise way of doing this.
- * Userspace could have, by the time we get here, written
- * anything it wants in to the instructions.  We can not
- * trust anything about it.  They might not be valid
- * instructions or might encode invalid registers, etc...
- */
-int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
-{
-	const struct mpx_bndreg_state *bndregs;
-	const struct mpx_bndreg *bndreg;
-	struct insn insn;
-	uint8_t bndregno;
-	int err;
-
-	err = mpx_insn_decode(&insn, regs);
-	if (err)
-		goto err_out;
-
-	/*
-	 * We know at this point that we are only dealing with
-	 * MPX instructions.
-	 */
-	insn_get_modrm(&insn);
-	bndregno = X86_MODRM_REG(insn.modrm.value);
-	if (bndregno > 3) {
-		err = -EINVAL;
-		goto err_out;
-	}
-	/* get bndregs field from current task's xsave area */
-	bndregs = get_xsave_field_ptr(XFEATURE_BNDREGS);
-	if (!bndregs) {
-		err = -EINVAL;
-		goto err_out;
-	}
-	/* now go select the individual register in the set of 4 */
-	bndreg = &bndregs->bndreg[bndregno];
-
-	/*
-	 * The registers are always 64-bit, but the upper 32
-	 * bits are ignored in 32-bit mode.  Also, note that the
-	 * upper bounds are architecturally represented in 1's
-	 * complement form.
-	 *
-	 * The 'unsigned long' cast is because the compiler
-	 * complains when casting from integers to different-size
-	 * pointers.
-	 */
-	info->lower = (void __user *)(unsigned long)bndreg->lower_bound;
-	info->upper = (void __user *)(unsigned long)~bndreg->upper_bound;
-	info->addr  = insn_get_addr_ref(&insn, regs);
-
-	/*
-	 * We were not able to extract an address from the instruction,
-	 * probably because there was something invalid in it.
-	 */
-	if (info->addr == (void __user *)-1) {
-		err = -EINVAL;
-		goto err_out;
-	}
-	trace_mpx_bounds_register_exception(info->addr, bndreg);
-	return 0;
-err_out:
-	/* info might be NULL, but kfree() handles that */
-	return err;
-}
-
-static __user void *mpx_get_bounds_dir(void)
-{
-	const struct mpx_bndcsr *bndcsr;
-
-	if (!cpu_feature_enabled(X86_FEATURE_MPX))
-		return MPX_INVALID_BOUNDS_DIR;
-
-	/*
-	 * The bounds directory pointer is stored in a register
-	 * only accessible if we first do an xsave.
-	 */
-	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
-	if (!bndcsr)
-		return MPX_INVALID_BOUNDS_DIR;
-
-	/*
-	 * Make sure the register looks valid by checking the
-	 * enable bit.
-	 */
-	if (!(bndcsr->bndcfgu & MPX_BNDCFG_ENABLE_FLAG))
-		return MPX_INVALID_BOUNDS_DIR;
-
-	/*
-	 * Lastly, mask off the low bits used for configuration
-	 * flags, and return the address of the bounds table.
-	 */
-	return (void __user *)(unsigned long)
-		(bndcsr->bndcfgu & MPX_BNDCFG_ADDR_MASK);
-}
-
-int mpx_enable_management(void)
-{
-	void __user *bd_base = MPX_INVALID_BOUNDS_DIR;
-	struct mm_struct *mm = current->mm;
-	int ret = 0;
-
-	/*
-	 * runtime in the userspace will be responsible for allocation of
-	 * the bounds directory. Then, it will save the base of the bounds
-	 * directory into XSAVE/XRSTOR Save Area and enable MPX through
-	 * XRSTOR instruction.
-	 *
-	 * The copy_xregs_to_kernel() beneath get_xsave_field_ptr() is
-	 * expected to be relatively expensive. Storing the bounds
-	 * directory here means that we do not have to do xsave in the
-	 * unmap path; we can just use mm->context.bd_addr instead.
-	 */
-	bd_base = mpx_get_bounds_dir();
-	down_write(&mm->mmap_sem);
-
-	/* MPX doesn't support addresses above 47 bits yet. */
-	if (find_vma(mm, DEFAULT_MAP_WINDOW)) {
-		pr_warn_once("%s (%d): MPX cannot handle addresses "
-				"above 47-bits. Disabling.",
-				current->comm, current->pid);
-		ret = -ENXIO;
-		goto out;
-	}
-	mm->context.bd_addr = bd_base;
-	if (mm->context.bd_addr == MPX_INVALID_BOUNDS_DIR)
-		ret = -ENXIO;
-out:
-	up_write(&mm->mmap_sem);
-	return ret;
-}
-
-int mpx_disable_management(void)
-{
-	struct mm_struct *mm = current->mm;
-
-	if (!cpu_feature_enabled(X86_FEATURE_MPX))
-		return -ENXIO;
-
-	down_write(&mm->mmap_sem);
-	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
-	up_write(&mm->mmap_sem);
-	return 0;
-}
-
-static int mpx_cmpxchg_bd_entry(struct mm_struct *mm,
-		unsigned long *curval,
-		unsigned long __user *addr,
-		unsigned long old_val, unsigned long new_val)
-{
-	int ret;
-	/*
-	 * user_atomic_cmpxchg_inatomic() actually uses sizeof()
-	 * the pointer that we pass to it to figure out how much
-	 * data to cmpxchg.  We have to be careful here not to
-	 * pass a pointer to a 64-bit data type when we only want
-	 * a 32-bit copy.
-	 */
-	if (is_64bit_mm(mm)) {
-		ret = user_atomic_cmpxchg_inatomic(curval,
-				addr, old_val, new_val);
-	} else {
-		u32 uninitialized_var(curval_32);
-		u32 old_val_32 = old_val;
-		u32 new_val_32 = new_val;
-		u32 __user *addr_32 = (u32 __user *)addr;
-
-		ret = user_atomic_cmpxchg_inatomic(&curval_32,
-				addr_32, old_val_32, new_val_32);
-		*curval = curval_32;
-	}
-	return ret;
-}
-
-/*
- * With 32-bit mode, a bounds directory is 4MB, and the size of each
- * bounds table is 16KB. With 64-bit mode, a bounds directory is 2GB,
- * and the size of each bounds table is 4MB.
- */
-static int allocate_bt(struct mm_struct *mm, long __user *bd_entry)
-{
-	unsigned long expected_old_val = 0;
-	unsigned long actual_old_val = 0;
-	unsigned long bt_addr;
-	unsigned long bd_new_entry;
-	int ret = 0;
-
-	/*
-	 * Carve the virtual space out of userspace for the new
-	 * bounds table:
-	 */
-	bt_addr = mpx_mmap(mpx_bt_size_bytes(mm));
-	if (IS_ERR((void *)bt_addr))
-		return PTR_ERR((void *)bt_addr);
-	/*
-	 * Set the valid flag (kinda like _PAGE_PRESENT in a pte)
-	 */
-	bd_new_entry = bt_addr | MPX_BD_ENTRY_VALID_FLAG;
-
-	/*
-	 * Go poke the address of the new bounds table in to the
-	 * bounds directory entry out in userspace memory.  Note:
-	 * we may race with another CPU instantiating the same table.
-	 * In that case the cmpxchg will see an unexpected
-	 * 'actual_old_val'.
-	 *
-	 * This can fault, but that's OK because we do not hold
-	 * mmap_sem at this point, unlike some of the other part
-	 * of the MPX code that have to pagefault_disable().
-	 */
-	ret = mpx_cmpxchg_bd_entry(mm, &actual_old_val,	bd_entry,
-				   expected_old_val, bd_new_entry);
-	if (ret)
-		goto out_unmap;
-
-	/*
-	 * The user_atomic_cmpxchg_inatomic() will only return nonzero
-	 * for faults, *not* if the cmpxchg itself fails.  Now we must
-	 * verify that the cmpxchg itself completed successfully.
-	 */
-	/*
-	 * We expected an empty 'expected_old_val', but instead found
-	 * an apparently valid entry.  Assume we raced with another
-	 * thread to instantiate this table and desclare succecss.
-	 */
-	if (actual_old_val & MPX_BD_ENTRY_VALID_FLAG) {
-		ret = 0;
-		goto out_unmap;
-	}
-	/*
-	 * We found a non-empty bd_entry but it did not have the
-	 * VALID_FLAG set.  Return an error which will result in
-	 * a SEGV since this probably means that somebody scribbled
-	 * some invalid data in to a bounds table.
-	 */
-	if (expected_old_val != actual_old_val) {
-		ret = -EINVAL;
-		goto out_unmap;
-	}
-	trace_mpx_new_bounds_table(bt_addr);
-	return 0;
-out_unmap:
-	vm_munmap(bt_addr, mpx_bt_size_bytes(mm));
-	return ret;
-}
-
-/*
- * When a BNDSTX instruction attempts to save bounds to a bounds
- * table, it will first attempt to look up the table in the
- * first-level bounds directory.  If it does not find a table in
- * the directory, a #BR is generated and we get here in order to
- * allocate a new table.
- *
- * With 32-bit mode, the size of BD is 4MB, and the size of each
- * bound table is 16KB. With 64-bit mode, the size of BD is 2GB,
- * and the size of each bound table is 4MB.
- */
-static int do_mpx_bt_fault(void)
-{
-	unsigned long bd_entry, bd_base;
-	const struct mpx_bndcsr *bndcsr;
-	struct mm_struct *mm = current->mm;
-
-	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
-	if (!bndcsr)
-		return -EINVAL;
-	/*
-	 * Mask off the preserve and enable bits
-	 */
-	bd_base = bndcsr->bndcfgu & MPX_BNDCFG_ADDR_MASK;
-	/*
-	 * The hardware provides the address of the missing or invalid
-	 * entry via BNDSTATUS, so we don't have to go look it up.
-	 */
-	bd_entry = bndcsr->bndstatus & MPX_BNDSTA_ADDR_MASK;
-	/*
-	 * Make sure the directory entry is within where we think
-	 * the directory is.
-	 */
-	if ((bd_entry < bd_base) ||
-	    (bd_entry >= bd_base + mpx_bd_size_bytes(mm)))
-		return -EINVAL;
-
-	return allocate_bt(mm, (long __user *)bd_entry);
-}
-
-int mpx_handle_bd_fault(void)
-{
-	/*
-	 * Userspace never asked us to manage the bounds tables,
-	 * so refuse to help.
-	 */
-	if (!kernel_managing_mpx_tables(current->mm))
-		return -EINVAL;
-
-	return do_mpx_bt_fault();
-}
-
-/*
- * A thin wrapper around get_user_pages().  Returns 0 if the
- * fault was resolved or -errno if not.
- */
-static int mpx_resolve_fault(long __user *addr, int write)
-{
-	long gup_ret;
-	int nr_pages = 1;
-
-	gup_ret = get_user_pages((unsigned long)addr, nr_pages,
-			write ? FOLL_WRITE : 0,	NULL, NULL);
-	/*
-	 * get_user_pages() returns number of pages gotten.
-	 * 0 means we failed to fault in and get anything,
-	 * probably because 'addr' is bad.
-	 */
-	if (!gup_ret)
-		return -EFAULT;
-	/* Other error, return it */
-	if (gup_ret < 0)
-		return gup_ret;
-	/* must have gup'd a page and gup_ret>0, success */
-	return 0;
-}
-
-static unsigned long mpx_bd_entry_to_bt_addr(struct mm_struct *mm,
-					     unsigned long bd_entry)
-{
-	unsigned long bt_addr = bd_entry;
-	int align_to_bytes;
-	/*
-	 * Bit 0 in a bt_entry is always the valid bit.
-	 */
-	bt_addr &= ~MPX_BD_ENTRY_VALID_FLAG;
-	/*
-	 * Tables are naturally aligned at 8-byte boundaries
-	 * on 64-bit and 4-byte boundaries on 32-bit.  The
-	 * documentation makes it appear that the low bits
-	 * are ignored by the hardware, so we do the same.
-	 */
-	if (is_64bit_mm(mm))
-		align_to_bytes = 8;
-	else
-		align_to_bytes = 4;
-	bt_addr &= ~(align_to_bytes-1);
-	return bt_addr;
-}
-
-/*
- * We only want to do a 4-byte get_user() on 32-bit.  Otherwise,
- * we might run off the end of the bounds table if we are on
- * a 64-bit kernel and try to get 8 bytes.
- */
-static int get_user_bd_entry(struct mm_struct *mm, unsigned long *bd_entry_ret,
-		long __user *bd_entry_ptr)
-{
-	u32 bd_entry_32;
-	int ret;
-
-	if (is_64bit_mm(mm))
-		return get_user(*bd_entry_ret, bd_entry_ptr);
-
-	/*
-	 * Note that get_user() uses the type of the *pointer* to
-	 * establish the size of the get, not the destination.
-	 */
-	ret = get_user(bd_entry_32, (u32 __user *)bd_entry_ptr);
-	*bd_entry_ret = bd_entry_32;
-	return ret;
-}
-
-/*
- * Get the base of bounds tables pointed by specific bounds
- * directory entry.
- */
-static int get_bt_addr(struct mm_struct *mm,
-			long __user *bd_entry_ptr,
-			unsigned long *bt_addr_result)
-{
-	int ret;
-	int valid_bit;
-	unsigned long bd_entry;
-	unsigned long bt_addr;
-
-	if (!access_ok((bd_entry_ptr), sizeof(*bd_entry_ptr)))
-		return -EFAULT;
-
-	while (1) {
-		int need_write = 0;
-
-		pagefault_disable();
-		ret = get_user_bd_entry(mm, &bd_entry, bd_entry_ptr);
-		pagefault_enable();
-		if (!ret)
-			break;
-		if (ret == -EFAULT)
-			ret = mpx_resolve_fault(bd_entry_ptr, need_write);
-		/*
-		 * If we could not resolve the fault, consider it
-		 * userspace's fault and error out.
-		 */
-		if (ret)
-			return ret;
-	}
-
-	valid_bit = bd_entry & MPX_BD_ENTRY_VALID_FLAG;
-	bt_addr = mpx_bd_entry_to_bt_addr(mm, bd_entry);
-
-	/*
-	 * When the kernel is managing bounds tables, a bounds directory
-	 * entry will either have a valid address (plus the valid bit)
-	 * *OR* be completely empty. If we see a !valid entry *and* some
-	 * data in the address field, we know something is wrong. This
-	 * -EINVAL return will cause a SIGSEGV.
-	 */
-	if (!valid_bit && bt_addr)
-		return -EINVAL;
-	/*
-	 * Do we have an completely zeroed bt entry?  That is OK.  It
-	 * just means there was no bounds table for this memory.  Make
-	 * sure to distinguish this from -EINVAL, which will cause
-	 * a SEGV.
-	 */
-	if (!valid_bit)
-		return -ENOENT;
-
-	*bt_addr_result = bt_addr;
-	return 0;
-}
-
-static inline int bt_entry_size_bytes(struct mm_struct *mm)
-{
-	if (is_64bit_mm(mm))
-		return MPX_BT_ENTRY_BYTES_64;
-	else
-		return MPX_BT_ENTRY_BYTES_32;
-}
-
-/*
- * Take a virtual address and turns it in to the offset in bytes
- * inside of the bounds table where the bounds table entry
- * controlling 'addr' can be found.
- */
-static unsigned long mpx_get_bt_entry_offset_bytes(struct mm_struct *mm,
-		unsigned long addr)
-{
-	unsigned long bt_table_nr_entries;
-	unsigned long offset = addr;
-
-	if (is_64bit_mm(mm)) {
-		/* Bottom 3 bits are ignored on 64-bit */
-		offset >>= 3;
-		bt_table_nr_entries = MPX_BT_NR_ENTRIES_64;
-	} else {
-		/* Bottom 2 bits are ignored on 32-bit */
-		offset >>= 2;
-		bt_table_nr_entries = MPX_BT_NR_ENTRIES_32;
-	}
-	/*
-	 * We know the size of the table in to which we are
-	 * indexing, and we have eliminated all the low bits
-	 * which are ignored for indexing.
-	 *
-	 * Mask out all the high bits which we do not need
-	 * to index in to the table.  Note that the tables
-	 * are always powers of two so this gives us a proper
-	 * mask.
-	 */
-	offset &= (bt_table_nr_entries-1);
-	/*
-	 * We now have an entry offset in terms of *entries* in
-	 * the table.  We need to scale it back up to bytes.
-	 */
-	offset *= bt_entry_size_bytes(mm);
-	return offset;
-}
-
-/*
- * How much virtual address space does a single bounds
- * directory entry cover?
- *
- * Note, we need a long long because 4GB doesn't fit in
- * to a long on 32-bit.
- */
-static inline unsigned long bd_entry_virt_space(struct mm_struct *mm)
-{
-	unsigned long long virt_space;
-	unsigned long long GB = (1ULL << 30);
-
-	/*
-	 * This covers 32-bit emulation as well as 32-bit kernels
-	 * running on 64-bit hardware.
-	 */
-	if (!is_64bit_mm(mm))
-		return (4ULL * GB) / MPX_BD_NR_ENTRIES_32;
-
-	/*
-	 * 'x86_virt_bits' returns what the hardware is capable
-	 * of, and returns the full >32-bit address space when
-	 * running 32-bit kernels on 64-bit hardware.
-	 */
-	virt_space = (1ULL << boot_cpu_data.x86_virt_bits);
-	return virt_space / MPX_BD_NR_ENTRIES_64;
-}
-
-/*
- * Free the backing physical pages of bounds table 'bt_addr'.
- * Assume start...end is within that bounds table.
- */
-static noinline int zap_bt_entries_mapping(struct mm_struct *mm,
-		unsigned long bt_addr,
-		unsigned long start_mapping, unsigned long end_mapping)
-{
-	struct vm_area_struct *vma;
-	unsigned long addr, len;
-	unsigned long start;
-	unsigned long end;
-
-	/*
-	 * if we 'end' on a boundary, the offset will be 0 which
-	 * is not what we want.  Back it up a byte to get the
-	 * last bt entry.  Then once we have the entry itself,
-	 * move 'end' back up by the table entry size.
-	 */
-	start = bt_addr + mpx_get_bt_entry_offset_bytes(mm, start_mapping);
-	end   = bt_addr + mpx_get_bt_entry_offset_bytes(mm, end_mapping - 1);
-	/*
-	 * Move end back up by one entry.  Among other things
-	 * this ensures that it remains page-aligned and does
-	 * not screw up zap_page_range()
-	 */
-	end += bt_entry_size_bytes(mm);
-
-	/*
-	 * Find the first overlapping vma. If vma->vm_start > start, there
-	 * will be a hole in the bounds table. This -EINVAL return will
-	 * cause a SIGSEGV.
-	 */
-	vma = find_vma(mm, start);
-	if (!vma || vma->vm_start > start)
-		return -EINVAL;
-
-	/*
-	 * A NUMA policy on a VM_MPX VMA could cause this bounds table to
-	 * be split. So we need to look across the entire 'start -> end'
-	 * range of this bounds table, find all of the VM_MPX VMAs, and
-	 * zap only those.
-	 */
-	addr = start;
-	while (vma && vma->vm_start < end) {
-		/*
-		 * We followed a bounds directory entry down
-		 * here.  If we find a non-MPX VMA, that's bad,
-		 * so stop immediately and return an error.  This
-		 * probably results in a SIGSEGV.
-		 */
-		if (!(vma->vm_flags & VM_MPX))
-			return -EINVAL;
-
-		len = min(vma->vm_end, end) - addr;
-		zap_page_range(vma, addr, len);
-		trace_mpx_unmap_zap(addr, addr+len);
-
-		vma = vma->vm_next;
-		addr = vma->vm_start;
-	}
-	return 0;
-}
-
-static unsigned long mpx_get_bd_entry_offset(struct mm_struct *mm,
-		unsigned long addr)
-{
-	/*
-	 * There are several ways to derive the bd offsets.  We
-	 * use the following approach here:
-	 * 1. We know the size of the virtual address space
-	 * 2. We know the number of entries in a bounds table
-	 * 3. We know that each entry covers a fixed amount of
-	 *    virtual address space.
-	 * So, we can just divide the virtual address by the
-	 * virtual space used by one entry to determine which
-	 * entry "controls" the given virtual address.
-	 */
-	if (is_64bit_mm(mm)) {
-		int bd_entry_size = 8; /* 64-bit pointer */
-		/*
-		 * Take the 64-bit addressing hole in to account.
-		 */
-		addr &= ((1UL << boot_cpu_data.x86_virt_bits) - 1);
-		return (addr / bd_entry_virt_space(mm)) * bd_entry_size;
-	} else {
-		int bd_entry_size = 4; /* 32-bit pointer */
-		/*
-		 * 32-bit has no hole so this case needs no mask
-		 */
-		return (addr / bd_entry_virt_space(mm)) * bd_entry_size;
-	}
-	/*
-	 * The two return calls above are exact copies.  If we
-	 * pull out a single copy and put it in here, gcc won't
-	 * realize that we're doing a power-of-2 divide and use
-	 * shifts.  It uses a real divide.  If we put them up
-	 * there, it manages to figure it out (gcc 4.8.3).
-	 */
-}
-
-static int unmap_entire_bt(struct mm_struct *mm,
-		long __user *bd_entry, unsigned long bt_addr)
-{
-	unsigned long expected_old_val = bt_addr | MPX_BD_ENTRY_VALID_FLAG;
-	unsigned long uninitialized_var(actual_old_val);
-	int ret;
-
-	while (1) {
-		int need_write = 1;
-		unsigned long cleared_bd_entry = 0;
-
-		pagefault_disable();
-		ret = mpx_cmpxchg_bd_entry(mm, &actual_old_val,
-				bd_entry, expected_old_val, cleared_bd_entry);
-		pagefault_enable();
-		if (!ret)
-			break;
-		if (ret == -EFAULT)
-			ret = mpx_resolve_fault(bd_entry, need_write);
-		/*
-		 * If we could not resolve the fault, consider it
-		 * userspace's fault and error out.
-		 */
-		if (ret)
-			return ret;
-	}
-	/*
-	 * The cmpxchg was performed, check the results.
-	 */
-	if (actual_old_val != expected_old_val) {
-		/*
-		 * Someone else raced with us to unmap the table.
-		 * That is OK, since we were both trying to do
-		 * the same thing.  Declare success.
-		 */
-		if (!actual_old_val)
-			return 0;
-		/*
-		 * Something messed with the bounds directory
-		 * entry.  We hold mmap_sem for read or write
-		 * here, so it could not be a _new_ bounds table
-		 * that someone just allocated.  Something is
-		 * wrong, so pass up the error and SIGSEGV.
-		 */
-		return -EINVAL;
-	}
-	/*
-	 * Note, we are likely being called under do_munmap() already. To
-	 * avoid recursion, do_munmap() will check whether it comes
-	 * from one bounds table through VM_MPX flag.
-	 */
-	return do_munmap(mm, bt_addr, mpx_bt_size_bytes(mm), NULL);
-}
-
-static int try_unmap_single_bt(struct mm_struct *mm,
-	       unsigned long start, unsigned long end)
-{
-	struct vm_area_struct *next;
-	struct vm_area_struct *prev;
-	/*
-	 * "bta" == Bounds Table Area: the area controlled by the
-	 * bounds table that we are unmapping.
-	 */
-	unsigned long bta_start_vaddr = start & ~(bd_entry_virt_space(mm)-1);
-	unsigned long bta_end_vaddr = bta_start_vaddr + bd_entry_virt_space(mm);
-	unsigned long uninitialized_var(bt_addr);
-	void __user *bde_vaddr;
-	int ret;
-	/*
-	 * We already unlinked the VMAs from the mm's rbtree so 'start'
-	 * is guaranteed to be in a hole. This gets us the first VMA
-	 * before the hole in to 'prev' and the next VMA after the hole
-	 * in to 'next'.
-	 */
-	next = find_vma_prev(mm, start, &prev);
-	/*
-	 * Do not count other MPX bounds table VMAs as neighbors.
-	 * Although theoretically possible, we do not allow bounds
-	 * tables for bounds tables so our heads do not explode.
-	 * If we count them as neighbors here, we may end up with
-	 * lots of tables even though we have no actual table
-	 * entries in use.
-	 */
-	while (next && (next->vm_flags & VM_MPX))
-		next = next->vm_next;
-	while (prev && (prev->vm_flags & VM_MPX))
-		prev = prev->vm_prev;
-	/*
-	 * We know 'start' and 'end' lie within an area controlled
-	 * by a single bounds table.  See if there are any other
-	 * VMAs controlled by that bounds table.  If there are not
-	 * then we can "expand" the are we are unmapping to possibly
-	 * cover the entire table.
-	 */
-	next = find_vma_prev(mm, start, &prev);
-	if ((!prev || prev->vm_end <= bta_start_vaddr) &&
-	    (!next || next->vm_start >= bta_end_vaddr)) {
-		/*
-		 * No neighbor VMAs controlled by same bounds
-		 * table.  Try to unmap the whole thing
-		 */
-		start = bta_start_vaddr;
-		end = bta_end_vaddr;
-	}
-
-	bde_vaddr = mm->context.bd_addr + mpx_get_bd_entry_offset(mm, start);
-	ret = get_bt_addr(mm, bde_vaddr, &bt_addr);
-	/*
-	 * No bounds table there, so nothing to unmap.
-	 */
-	if (ret == -ENOENT) {
-		ret = 0;
-		return 0;
-	}
-	if (ret)
-		return ret;
-	/*
-	 * We are unmapping an entire table.  Either because the
-	 * unmap that started this whole process was large enough
-	 * to cover an entire table, or that the unmap was small
-	 * but was the area covered by a bounds table.
-	 */
-	if ((start == bta_start_vaddr) &&
-	    (end == bta_end_vaddr))
-		return unmap_entire_bt(mm, bde_vaddr, bt_addr);
-	return zap_bt_entries_mapping(mm, bt_addr, start, end);
-}
-
-static int mpx_unmap_tables(struct mm_struct *mm,
-		unsigned long start, unsigned long end)
-{
-	unsigned long one_unmap_start;
-	trace_mpx_unmap_search(start, end);
-
-	one_unmap_start = start;
-	while (one_unmap_start < end) {
-		int ret;
-		unsigned long next_unmap_start = ALIGN(one_unmap_start+1,
-						       bd_entry_virt_space(mm));
-		unsigned long one_unmap_end = end;
-		/*
-		 * if the end is beyond the current bounds table,
-		 * move it back so we only deal with a single one
-		 * at a time
-		 */
-		if (one_unmap_end > next_unmap_start)
-			one_unmap_end = next_unmap_start;
-		ret = try_unmap_single_bt(mm, one_unmap_start, one_unmap_end);
-		if (ret)
-			return ret;
-
-		one_unmap_start = next_unmap_start;
-	}
-	return 0;
-}
-
-/*
- * Free unused bounds tables covered in a virtual address region being
- * munmap()ed. Assume end > start.
- *
- * This function will be called by do_munmap(), and the VMAs covering
- * the virtual address region start...end have already been split if
- * necessary, and the 'vma' is the first vma in this range (start -> end).
- */
-void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
-		      unsigned long end)
-{
-	struct vm_area_struct *vma;
-	int ret;
-
-	/*
-	 * Refuse to do anything unless userspace has asked
-	 * the kernel to help manage the bounds tables,
-	 */
-	if (!kernel_managing_mpx_tables(current->mm))
-		return;
-	/*
-	 * This will look across the entire 'start -> end' range,
-	 * and find all of the non-VM_MPX VMAs.
-	 *
-	 * To avoid recursion, if a VM_MPX vma is found in the range
-	 * (start->end), we will not continue follow-up work. This
-	 * recursion represents having bounds tables for bounds tables,
-	 * which should not occur normally. Being strict about it here
-	 * helps ensure that we do not have an exploitable stack overflow.
-	 */
-	vma = find_vma(mm, start);
-	while (vma && vma->vm_start < end) {
-		if (vma->vm_flags & VM_MPX)
-			return;
-		vma = vma->vm_next;
-	}
-
-	ret = mpx_unmap_tables(mm, start, end);
-	if (ret)
-		force_sig(SIGSEGV);
-}
-
-/* MPX cannot handle addresses above 47 bits yet. */
-unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
-		unsigned long flags)
-{
-	if (!kernel_managing_mpx_tables(current->mm))
-		return addr;
-	if (addr + len <= DEFAULT_MAP_WINDOW)
-		return addr;
-	if (flags & MAP_FIXED)
-		return -ENOMEM;
-
-	/*
-	 * Requested len is larger than the whole area we're allowed to map in.
-	 * Resetting hinting address wouldn't do much good -- fail early.
-	 */
-	if (len > DEFAULT_MAP_WINDOW)
-		return -ENOMEM;
-
-	/* Look for unmap area within DEFAULT_MAP_WINDOW */
-	return 0;
-}
diff -L Documentation/x86/intel_mpx.rst -puN Documentation/x86/intel_mpx.rst~mpx-remove-x86 /dev/null
--- a/Documentation/x86/intel_mpx.rst
+++ /dev/null	2019-02-15 15:42:29.903470860 -0800
@@ -1,252 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-===========================================
-Intel(R) Memory Protection Extensions (MPX)
-===========================================
-
-Intel(R) MPX Overview
-=====================
-
-Intel(R) Memory Protection Extensions (Intel(R) MPX) is a new capability
-introduced into Intel Architecture. Intel MPX provides hardware features
-that can be used in conjunction with compiler changes to check memory
-references, for those references whose compile-time normal intentions are
-usurped at runtime due to buffer overflow or underflow.
-
-You can tell if your CPU supports MPX by looking in /proc/cpuinfo::
-
-	cat /proc/cpuinfo  | grep ' mpx '
-
-For more information, please refer to Intel(R) Architecture Instruction
-Set Extensions Programming Reference, Chapter 9: Intel(R) Memory Protection
-Extensions.
-
-Note: As of December 2014, no hardware with MPX is available but it is
-possible to use SDE (Intel(R) Software Development Emulator) instead, which
-can be downloaded from
-http://software.intel.com/en-us/articles/intel-software-development-emulator
-
-
-How to get the advantage of MPX
-===============================
-
-For MPX to work, changes are required in the kernel, binutils and compiler.
-No source changes are required for applications, just a recompile.
-
-There are a lot of moving parts of this to all work right. The following
-is how we expect the compiler, application and kernel to work together.
-
-1) Application developer compiles with -fmpx. The compiler will add the
-   instrumentation as well as some setup code called early after the app
-   starts. New instruction prefixes are noops for old CPUs.
-2) That setup code allocates (virtual) space for the "bounds directory",
-   points the "bndcfgu" register to the directory (must also set the valid
-   bit) and notifies the kernel (via the new prctl(PR_MPX_ENABLE_MANAGEMENT))
-   that the app will be using MPX.  The app must be careful not to access
-   the bounds tables between the time when it populates "bndcfgu" and
-   when it calls the prctl().  This might be hard to guarantee if the app
-   is compiled with MPX.  You can add "__attribute__((bnd_legacy))" to
-   the function to disable MPX instrumentation to help guarantee this.
-   Also be careful not to call out to any other code which might be
-   MPX-instrumented.
-3) The kernel detects that the CPU has MPX, allows the new prctl() to
-   succeed, and notes the location of the bounds directory. Userspace is
-   expected to keep the bounds directory at that location. We note it
-   instead of reading it each time because the 'xsave' operation needed
-   to access the bounds directory register is an expensive operation.
-4) If the application needs to spill bounds out of the 4 registers, it
-   issues a bndstx instruction. Since the bounds directory is empty at
-   this point, a bounds fault (#BR) is raised, the kernel allocates a
-   bounds table (in the user address space) and makes the relevant entry
-   in the bounds directory point to the new table.
-5) If the application violates the bounds specified in the bounds registers,
-   a separate kind of #BR is raised which will deliver a signal with
-   information about the violation in the 'struct siginfo'.
-6) Whenever memory is freed, we know that it can no longer contain valid
-   pointers, and we attempt to free the associated space in the bounds
-   tables. If an entire table becomes unused, we will attempt to free
-   the table and remove the entry in the directory.
-
-To summarize, there are essentially three things interacting here:
-
-GCC with -fmpx:
- * enables annotation of code with MPX instructions and prefixes
- * inserts code early in the application to call in to the "gcc runtime"
-GCC MPX Runtime:
- * Checks for hardware MPX support in cpuid leaf
- * allocates virtual space for the bounds directory (malloc() essentially)
- * points the hardware BNDCFGU register at the directory
- * calls a new prctl(PR_MPX_ENABLE_MANAGEMENT) to notify the kernel to
-   start managing the bounds directories
-Kernel MPX Code:
- * Checks for hardware MPX support in cpuid leaf
- * Handles #BR exceptions and sends SIGSEGV to the app when it violates
-   bounds, like during a buffer overflow.
- * When bounds are spilled in to an unallocated bounds table, the kernel
-   notices in the #BR exception, allocates the virtual space, then
-   updates the bounds directory to point to the new table. It keeps
-   special track of the memory with a VM_MPX flag.
- * Frees unused bounds tables at the time that the memory they described
-   is unmapped.
-
-
-How does MPX kernel code work
-=============================
-
-Handling #BR faults caused by MPX
----------------------------------
-
-When MPX is enabled, there are 2 new situations that can generate
-#BR faults.
-
-  * new bounds tables (BT) need to be allocated to save bounds.
-  * bounds violation caused by MPX instructions.
-
-We hook #BR handler to handle these two new situations.
-
-On-demand kernel allocation of bounds tables
---------------------------------------------
-
-MPX only has 4 hardware registers for storing bounds information. If
-MPX-enabled code needs more than these 4 registers, it needs to spill
-them somewhere. It has two special instructions for this which allow
-the bounds to be moved between the bounds registers and some new "bounds
-tables".
-
-#BR exceptions are a new class of exceptions just for MPX. They are
-similar conceptually to a page fault and will be raised by the MPX
-hardware during both bounds violations or when the tables are not
-present. The kernel handles those #BR exceptions for not-present tables
-by carving the space out of the normal processes address space and then
-pointing the bounds-directory over to it.
-
-The tables need to be accessed and controlled by userspace because
-the instructions for moving bounds in and out of them are extremely
-frequent. They potentially happen every time a register points to
-memory. Any direct kernel involvement (like a syscall) to access the
-tables would obviously destroy performance.
-
-Why not do this in userspace? MPX does not strictly require anything in
-the kernel. It can theoretically be done completely from userspace. Here
-are a few ways this could be done. We don't think any of them are practical
-in the real-world, but here they are.
-
-:Q: Can virtual space simply be reserved for the bounds tables so that we
-    never have to allocate them?
-:A: MPX-enabled application will possibly create a lot of bounds tables in
-    process address space to save bounds information. These tables can take
-    up huge swaths of memory (as much as 80% of the memory on the system)
-    even if we clean them up aggressively. In the worst-case scenario, the
-    tables can be 4x the size of the data structure being tracked. IOW, a
-    1-page structure can require 4 bounds-table pages. An X-GB virtual
-    area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
-    If we were to preallocate them for the 128TB of user virtual address
-    space, we would need to reserve 512TB+2GB, which is larger than the
-    entire virtual address space today. This means they can not be reserved
-    ahead of time. Also, a single process's pre-populated bounds directory
-    consumes 2GB of virtual *AND* physical memory. IOW, it's completely
-    infeasible to prepopulate bounds directories.
-
-:Q: Can we preallocate bounds table space at the same time memory is
-    allocated which might contain pointers that might eventually need
-    bounds tables?
-:A: This would work if we could hook the site of each and every memory
-    allocation syscall. This can be done for small, constrained applications.
-    But, it isn't practical at a larger scale since a given app has no
-    way of controlling how all the parts of the app might allocate memory
-    (think libraries). The kernel is really the only place to intercept
-    these calls.
-
-:Q: Could a bounds fault be handed to userspace and the tables allocated
-    there in a signal handler instead of in the kernel?
-:A: mmap() is not on the list of safe async handler functions and even
-    if mmap() would work it still requires locking or nasty tricks to
-    keep track of the allocation state there.
-
-Having ruled out all of the userspace-only approaches for managing
-bounds tables that we could think of, we create them on demand in
-the kernel.
-
-Decoding MPX instructions
--------------------------
-
-If a #BR is generated due to a bounds violation caused by MPX.
-We need to decode MPX instructions to get violation address and
-set this address into extended struct siginfo.
-
-The _sigfault field of struct siginfo is extended as follow::
-
-  87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-  88		struct {
-  89			void __user *_addr; /* faulting insn/memory ref. */
-  90 #ifdef __ARCH_SI_TRAPNO
-  91			int _trapno;	/* TRAP # which caused the signal */
-  92 #endif
-  93			short _addr_lsb; /* LSB of the reported address */
-  94			struct {
-  95				void __user *_lower;
-  96				void __user *_upper;
-  97			} _addr_bnd;
-  98		} _sigfault;
-
-The '_addr' field refers to violation address, and new '_addr_and'
-field refers to the upper/lower bounds when a #BR is caused.
-
-Glibc will be also updated to support this new siginfo. So user
-can get violation address and bounds when bounds violations occur.
-
-Cleanup unused bounds tables
-----------------------------
-
-When a BNDSTX instruction attempts to save bounds to a bounds directory
-entry marked as invalid, a #BR is generated. This is an indication that
-no bounds table exists for this entry. In this case the fault handler
-will allocate a new bounds table on demand.
-
-Since the kernel allocated those tables on-demand without userspace
-knowledge, it is also responsible for freeing them when the associated
-mappings go away.
-
-Here, the solution for this issue is to hook do_munmap() to check
-whether one process is MPX enabled. If yes, those bounds tables covered
-in the virtual address region which is being unmapped will be freed also.
-
-Adding new prctl commands
--------------------------
-
-Two new prctl commands are added to enable and disable MPX bounds tables
-management in kernel.
-::
-
-  155	#define PR_MPX_ENABLE_MANAGEMENT	43
-  156	#define PR_MPX_DISABLE_MANAGEMENT	44
-
-Runtime library in userspace is responsible for allocation of bounds
-directory. So kernel have to use XSAVE instruction to get the base
-of bounds directory from BNDCFG register.
-
-But XSAVE is expected to be very expensive. In order to do performance
-optimization, we have to get the base of bounds directory and save it
-into struct mm_struct to be used in future during PR_MPX_ENABLE_MANAGEMENT
-command execution.
-
-
-Special rules
-=============
-
-1) If userspace is requesting help from the kernel to do the management
-of bounds tables, it may not create or modify entries in the bounds directory.
-
-Certainly users can allocate bounds tables and forcibly point the bounds
-directory at them through XSAVE instruction, and then set valid bit
-of bounds entry to have this entry valid.  But, the kernel will decline
-to assist in managing these tables.
-
-2) Userspace may not take multiple bounds directory entries and point
-them at the same bounds table.
-
-This is allowed architecturally.  See more information "Intel(R) Architecture
-Instruction Set Extensions Programming Reference" (9.3.4).
-
-However, if users did this, the kernel might be fooled in to unmapping an
-in-use bounds table since it does not recognize sharing.
_
