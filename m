Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE7AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD2D21744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAJR7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgAJR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ4-00028n-Il; Fri, 10 Jan 2020 18:59:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 293A41C2D6A;
        Fri, 10 Jan 2020 18:59:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:17 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm, x86/mm: Untangle address space layout definitions
 from basic pgtable type definitions
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86 <x86@kernel.org>
MIME-Version: 1.0
Message-ID: <157867915799.30329.10290582536970737315.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     186525bd6b83efc592672e2d6185e4d7c810d2b4
Gitweb:        https://git.kernel.org/tip/186525bd6b83efc592672e2d6185e4d7c810d2b4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 29 Nov 2019 08:17:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

mm, x86/mm: Untangle address space layout definitions from basic pgtable type definitions

- Untangle the somewhat incestous way of how VMALLOC_START is used all across the
  kernel, but is, on x86, defined deep inside one of the lowest level page table headers.
  It doesn't help that vmalloc.h only includes a single asm header:

     #include <asm/page.h>           /* pgprot_t */

  So there was no existing cross-arch way to decouple address layout
  definitions from page.h details. I used this:

   #ifndef VMALLOC_START
   # include <asm/vmalloc.h>
   #endif

  This way every architecture that wants to simplify page.h can do so.

- Also on x86 we had a couple of LDT related inline functions that used
  the late-stage address space layout positions - but these could be
  uninlined without real trouble - the end result is cleaner this way as
  well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpu_entry_area.h   | 10 +---
 arch/x86/include/asm/mmu_context.h      | 86 +-----------------------
 arch/x86/include/asm/pgtable_32_areas.h | 53 +++++++++++++++-
 arch/x86/include/asm/pgtable_32_types.h | 57 +----------------
 arch/x86/include/asm/pgtable_areas.h    | 16 ++++-
 arch/x86/include/asm/vmalloc.h          |  2 +-
 arch/x86/kernel/ldt.c                   | 83 +++++++++++++++++++++++-
 arch/x86/kernel/setup.c                 |  1 +-
 arch/x86/mm/fault.c                     |  1 +-
 arch/x86/mm/init_32.c                   |  1 +-
 arch/x86/mm/pgtable_32.c                |  1 +-
 arch/x86/mm/physaddr.c                  |  1 +-
 include/linux/mm.h                      | 15 +---
 mm/highmem.c                            |  2 +-
 mm/vmalloc.c                            |  8 ++-
 15 files changed, 183 insertions(+), 154 deletions(-)
 create mode 100644 arch/x86/include/asm/pgtable_32_areas.h
 create mode 100644 arch/x86/include/asm/pgtable_areas.h

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 8047340..02c0078 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -6,6 +6,7 @@
 #include <linux/percpu-defs.h>
 #include <asm/processor.h>
 #include <asm/intel_ds.h>
+#include <asm/pgtable_areas.h>
 
 #ifdef CONFIG_X86_64
 
@@ -134,15 +135,6 @@ DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
 extern void setup_cpu_entry_areas(void);
 extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
 
-/* Single page reserved for the readonly IDT mapping: */
-#define	CPU_ENTRY_AREA_RO_IDT		CPU_ENTRY_AREA_BASE
-#define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE)
-
-#define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
-
-#define CPU_ENTRY_AREA_MAP_SIZE			\
-	(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
-
 extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
 
 static inline struct entry_stack *cpu_entry_stack(int cpu)
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 5f33924..b243234 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -69,14 +69,6 @@ struct ldt_struct {
 	int			slot;
 };
 
-/* This is a multiple of PAGE_SIZE. */
-#define LDT_SLOT_STRIDE (LDT_ENTRIES * LDT_ENTRY_SIZE)
-
-static inline void *ldt_slot_va(int slot)
-{
-	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
-}
-
 /*
  * Used for LDT copy/destruction.
  */
@@ -99,87 +91,21 @@ static inline void destroy_context_ldt(struct mm_struct *mm) { }
 static inline void ldt_arch_exit_mmap(struct mm_struct *mm) { }
 #endif
 
-static inline void load_mm_ldt(struct mm_struct *mm)
-{
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
-	struct ldt_struct *ldt;
-
-	/* READ_ONCE synchronizes with smp_store_release */
-	ldt = READ_ONCE(mm->context.ldt);
-
-	/*
-	 * Any change to mm->context.ldt is followed by an IPI to all
-	 * CPUs with the mm active.  The LDT will not be freed until
-	 * after the IPI is handled by all such CPUs.  This means that,
-	 * if the ldt_struct changes before we return, the values we see
-	 * will be safe, and the new values will be loaded before we run
-	 * any user code.
-	 *
-	 * NB: don't try to convert this to use RCU without extreme care.
-	 * We would still need IRQs off, because we don't want to change
-	 * the local LDT after an IPI loaded a newer value than the one
-	 * that we can see.
-	 */
-
-	if (unlikely(ldt)) {
-		if (static_cpu_has(X86_FEATURE_PTI)) {
-			if (WARN_ON_ONCE((unsigned long)ldt->slot > 1)) {
-				/*
-				 * Whoops -- either the new LDT isn't mapped
-				 * (if slot == -1) or is mapped into a bogus
-				 * slot (if slot > 1).
-				 */
-				clear_LDT();
-				return;
-			}
-
-			/*
-			 * If page table isolation is enabled, ldt->entries
-			 * will not be mapped in the userspace pagetables.
-			 * Tell the CPU to access the LDT through the alias
-			 * at ldt_slot_va(ldt->slot).
-			 */
-			set_ldt(ldt_slot_va(ldt->slot), ldt->nr_entries);
-		} else {
-			set_ldt(ldt->entries, ldt->nr_entries);
-		}
-	} else {
-		clear_LDT();
-	}
+extern void load_mm_ldt(struct mm_struct *mm);
+extern void switch_ldt(struct mm_struct *prev, struct mm_struct *next);
 #else
+static inline void load_mm_ldt(struct mm_struct *mm)
+{
 	clear_LDT();
-#endif
 }
-
 static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-	/*
-	 * Load the LDT if either the old or new mm had an LDT.
-	 *
-	 * An mm will never go from having an LDT to not having an LDT.  Two
-	 * mms never share an LDT, so we don't gain anything by checking to
-	 * see whether the LDT changed.  There's also no guarantee that
-	 * prev->context.ldt actually matches LDTR, but, if LDTR is non-NULL,
-	 * then prev->context.ldt will also be non-NULL.
-	 *
-	 * If we really cared, we could optimize the case where prev == next
-	 * and we're exiting lazy mode.  Most of the time, if this happens,
-	 * we don't actually need to reload LDTR, but modify_ldt() is mostly
-	 * used by legacy code and emulators where we don't need this level of
-	 * performance.
-	 *
-	 * This uses | instead of || because it generates better code.
-	 */
-	if (unlikely((unsigned long)prev->context.ldt |
-		     (unsigned long)next->context.ldt))
-		load_mm_ldt(next);
-#endif
-
 	DEBUG_LOCKS_WARN_ON(preemptible());
 }
+#endif
 
-void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
+extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
 /*
  * Init a new mm.  Used on mm copies, like at fork()
diff --git a/arch/x86/include/asm/pgtable_32_areas.h b/arch/x86/include/asm/pgtable_32_areas.h
new file mode 100644
index 0000000..b635541
--- /dev/null
+++ b/arch/x86/include/asm/pgtable_32_areas.h
@@ -0,0 +1,53 @@
+#ifndef _ASM_X86_PGTABLE_32_AREAS_H
+#define _ASM_X86_PGTABLE_32_AREAS_H
+
+#include <asm/cpu_entry_area.h>
+
+/*
+ * Just any arbitrary offset to the start of the vmalloc VM area: the
+ * current 8MB value just means that there will be a 8MB "hole" after the
+ * physical memory until the kernel virtual memory starts.  That means that
+ * any out-of-bounds memory accesses will hopefully be caught.
+ * The vmalloc() routines leaves a hole of 4kB between each vmalloced
+ * area for the same reason. ;)
+ */
+#define VMALLOC_OFFSET	(8 * 1024 * 1024)
+
+#ifndef __ASSEMBLY__
+extern bool __vmalloc_start_set; /* set once high_memory is set */
+#endif
+
+#define VMALLOC_START	((unsigned long)high_memory + VMALLOC_OFFSET)
+#ifdef CONFIG_X86_PAE
+#define LAST_PKMAP 512
+#else
+#define LAST_PKMAP 1024
+#endif
+
+#define CPU_ENTRY_AREA_PAGES		(NR_CPUS * DIV_ROUND_UP(sizeof(struct cpu_entry_area), PAGE_SIZE))
+
+/* The +1 is for the readonly IDT page: */
+#define CPU_ENTRY_AREA_BASE	\
+	((FIXADDR_TOT_START - PAGE_SIZE*(CPU_ENTRY_AREA_PAGES+1)) & PMD_MASK)
+
+#define LDT_BASE_ADDR		\
+	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
+
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PMD_SIZE)
+
+#define PKMAP_BASE		\
+	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
+
+#ifdef CONFIG_HIGHMEM
+# define VMALLOC_END	(PKMAP_BASE - 2 * PAGE_SIZE)
+#else
+# define VMALLOC_END	(LDT_BASE_ADDR - 2 * PAGE_SIZE)
+#endif
+
+#define MODULES_VADDR	VMALLOC_START
+#define MODULES_END	VMALLOC_END
+#define MODULES_LEN	(MODULES_VADDR - MODULES_END)
+
+#define MAXMEM	(VMALLOC_END - PAGE_OFFSET - __VMALLOC_RESERVE)
+
+#endif /* _ASM_X86_PGTABLE_32_AREAS_H */
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index 0416d42..5356a46 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_PGTABLE_32_DEFS_H
-#define _ASM_X86_PGTABLE_32_DEFS_H
+#ifndef _ASM_X86_PGTABLE_32_TYPES_H
+#define _ASM_X86_PGTABLE_32_TYPES_H
 
 /*
  * The Linux x86 paging architecture is 'compile-time dual-mode', it
@@ -20,55 +20,4 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
 
-/* Just any arbitrary offset to the start of the vmalloc VM area: the
- * current 8MB value just means that there will be a 8MB "hole" after the
- * physical memory until the kernel virtual memory starts.  That means that
- * any out-of-bounds memory accesses will hopefully be caught.
- * The vmalloc() routines leaves a hole of 4kB between each vmalloced
- * area for the same reason. ;)
- */
-#define VMALLOC_OFFSET	(8 * 1024 * 1024)
-
-#ifndef __ASSEMBLY__
-extern bool __vmalloc_start_set; /* set once high_memory is set */
-#endif
-
-#define VMALLOC_START	((unsigned long)high_memory + VMALLOC_OFFSET)
-#ifdef CONFIG_X86_PAE
-#define LAST_PKMAP 512
-#else
-#define LAST_PKMAP 1024
-#endif
-
-/*
- * This is an upper bound on sizeof(struct cpu_entry_area) / PAGE_SIZE.
- * Define this here and validate with BUILD_BUG_ON() in cpu_entry_area.c
- * to avoid include recursion hell.
- */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 43)
-
-/* The +1 is for the readonly IDT page: */
-#define CPU_ENTRY_AREA_BASE	\
-	((FIXADDR_TOT_START - PAGE_SIZE*(CPU_ENTRY_AREA_PAGES+1)) & PMD_MASK)
-
-#define LDT_BASE_ADDR		\
-	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
-
-#define LDT_END_ADDR		(LDT_BASE_ADDR + PMD_SIZE)
-
-#define PKMAP_BASE		\
-	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
-
-#ifdef CONFIG_HIGHMEM
-# define VMALLOC_END	(PKMAP_BASE - 2 * PAGE_SIZE)
-#else
-# define VMALLOC_END	(LDT_BASE_ADDR - 2 * PAGE_SIZE)
-#endif
-
-#define MODULES_VADDR	VMALLOC_START
-#define MODULES_END	VMALLOC_END
-#define MODULES_LEN	(MODULES_VADDR - MODULES_END)
-
-#define MAXMEM	(VMALLOC_END - PAGE_OFFSET - __VMALLOC_RESERVE)
-
-#endif /* _ASM_X86_PGTABLE_32_DEFS_H */
+#endif /* _ASM_X86_PGTABLE_32_TYPES_H */
diff --git a/arch/x86/include/asm/pgtable_areas.h b/arch/x86/include/asm/pgtable_areas.h
new file mode 100644
index 0000000..d34cce1
--- /dev/null
+++ b/arch/x86/include/asm/pgtable_areas.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_X86_PGTABLE_AREAS_H
+#define _ASM_X86_PGTABLE_AREAS_H
+
+#ifdef CONFIG_X86_32
+# include <asm/pgtable_32_areas.h>
+#endif
+
+/* Single page reserved for the readonly IDT mapping: */
+#define CPU_ENTRY_AREA_RO_IDT		CPU_ENTRY_AREA_BASE
+#define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE)
+
+#define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
+
+#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
+
+#endif /* _ASM_X86_PGTABLE_AREAS_H */
diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
index ba6295f..2983774 100644
--- a/arch/x86/include/asm/vmalloc.h
+++ b/arch/x86/include/asm/vmalloc.h
@@ -1,4 +1,6 @@
 #ifndef _ASM_X86_VMALLOC_H
 #define _ASM_X86_VMALLOC_H
 
+#include <asm/pgtable_areas.h>
+
 #endif /* _ASM_X86_VMALLOC_H */
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index b2463fc..c57e1ca 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -28,6 +28,89 @@
 #include <asm/desc.h>
 #include <asm/mmu_context.h>
 #include <asm/syscalls.h>
+#include <asm/pgtable_areas.h>
+
+/* This is a multiple of PAGE_SIZE. */
+#define LDT_SLOT_STRIDE (LDT_ENTRIES * LDT_ENTRY_SIZE)
+
+static inline void *ldt_slot_va(int slot)
+{
+	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
+}
+
+void load_mm_ldt(struct mm_struct *mm)
+{
+	struct ldt_struct *ldt;
+
+	/* READ_ONCE synchronizes with smp_store_release */
+	ldt = READ_ONCE(mm->context.ldt);
+
+	/*
+	 * Any change to mm->context.ldt is followed by an IPI to all
+	 * CPUs with the mm active.  The LDT will not be freed until
+	 * after the IPI is handled by all such CPUs.  This means that,
+	 * if the ldt_struct changes before we return, the values we see
+	 * will be safe, and the new values will be loaded before we run
+	 * any user code.
+	 *
+	 * NB: don't try to convert this to use RCU without extreme care.
+	 * We would still need IRQs off, because we don't want to change
+	 * the local LDT after an IPI loaded a newer value than the one
+	 * that we can see.
+	 */
+
+	if (unlikely(ldt)) {
+		if (static_cpu_has(X86_FEATURE_PTI)) {
+			if (WARN_ON_ONCE((unsigned long)ldt->slot > 1)) {
+				/*
+				 * Whoops -- either the new LDT isn't mapped
+				 * (if slot == -1) or is mapped into a bogus
+				 * slot (if slot > 1).
+				 */
+				clear_LDT();
+				return;
+			}
+
+			/*
+			 * If page table isolation is enabled, ldt->entries
+			 * will not be mapped in the userspace pagetables.
+			 * Tell the CPU to access the LDT through the alias
+			 * at ldt_slot_va(ldt->slot).
+			 */
+			set_ldt(ldt_slot_va(ldt->slot), ldt->nr_entries);
+		} else {
+			set_ldt(ldt->entries, ldt->nr_entries);
+		}
+	} else {
+		clear_LDT();
+	}
+}
+
+void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
+{
+	/*
+	 * Load the LDT if either the old or new mm had an LDT.
+	 *
+	 * An mm will never go from having an LDT to not having an LDT.  Two
+	 * mms never share an LDT, so we don't gain anything by checking to
+	 * see whether the LDT changed.  There's also no guarantee that
+	 * prev->context.ldt actually matches LDTR, but, if LDTR is non-NULL,
+	 * then prev->context.ldt will also be non-NULL.
+	 *
+	 * If we really cared, we could optimize the case where prev == next
+	 * and we're exiting lazy mode.  Most of the time, if this happens,
+	 * we don't actually need to reload LDTR, but modify_ldt() is mostly
+	 * used by legacy code and emulators where we don't need this level of
+	 * performance.
+	 *
+	 * This uses | instead of || because it generates better code.
+	 */
+	if (unlikely((unsigned long)prev->context.ldt |
+		     (unsigned long)next->context.ldt))
+		load_mm_ldt(next);
+
+	DEBUG_LOCKS_WARN_ON(preemptible());
+}
 
 static void refresh_ldt_segments(void)
 {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b5ac993..90296a0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -41,6 +41,7 @@
 #include <asm/proto.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
+#include <linux/vmalloc.h>
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 304d31d..c9c8523 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -29,6 +29,7 @@
 #include <asm/efi.h>			/* efi_recover_from_page_fault()*/
 #include <asm/desc.h>			/* store_idt(), ...		*/
 #include <asm/cpu_entry_area.h>		/* exception stack		*/
+#include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 930edeb..16274a3 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -52,6 +52,7 @@
 #include <asm/page_types.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/init.h>
+#include <asm/pgtable_areas.h>
 
 #include "mm_internal.h"
 
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index 9bb7f0a..0e6700e 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -18,6 +18,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
+#include <linux/vmalloc.h>
 
 unsigned int __VMALLOC_RESERVE = 128 << 20;
 
diff --git a/arch/x86/mm/physaddr.c b/arch/x86/mm/physaddr.c
index bdc9815..fc3f3d3 100644
--- a/arch/x86/mm/physaddr.c
+++ b/arch/x86/mm/physaddr.c
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 
 #include <asm/page.h>
+#include <linux/vmalloc.h>
 
 #include "physaddr.h"
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c97ea3b..fb8f941 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -625,24 +625,19 @@ unsigned long vmalloc_to_pfn(const void *addr);
  * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
  * is no special casing required.
  */
-static inline bool is_vmalloc_addr(const void *x)
-{
-#ifdef CONFIG_MMU
-	unsigned long addr = (unsigned long)x;
-
-	return addr >= VMALLOC_START && addr < VMALLOC_END;
-#else
-	return false;
-#endif
-}
 
 #ifndef is_ioremap_addr
 #define is_ioremap_addr(x) is_vmalloc_addr(x)
 #endif
 
 #ifdef CONFIG_MMU
+extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
 #else
+static inline bool is_vmalloc_addr(const void *x)
+{
+	return false;
+}
 static inline int is_vmalloc_or_module_addr(const void *x)
 {
 	return 0;
diff --git a/mm/highmem.c b/mm/highmem.c
index 107b10f..64d8dea 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -29,7 +29,7 @@
 #include <linux/highmem.h>
 #include <linux/kgdb.h>
 #include <asm/tlbflush.h>
-
+#include <linux/vmalloc.h>
 
 #if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
 DEFINE_PER_CPU(int, __kmap_atomic_idx);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4d3b3d6..19cdbb1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -41,6 +41,14 @@
 
 #include "internal.h"
 
+bool is_vmalloc_addr(const void *x)
+{
+	unsigned long addr = (unsigned long)x;
+
+	return addr >= VMALLOC_START && addr < VMALLOC_END;
+}
+EXPORT_SYMBOL(is_vmalloc_addr);
+
 struct vfree_deferred {
 	struct llist_head list;
 	struct work_struct wq;
