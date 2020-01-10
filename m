Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF1424677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgAJR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgAJR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZB-0002AT-HU; Fri, 10 Jan 2020 18:59:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 16BD31C2D6C;
        Fri, 10 Jan 2020 18:59:20 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:19 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Move the memtype related files to arch/x86/mm/pat/
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915986.30329.17500949467391840558.tip-bot2@tip-bot2>
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

Commit-ID:     f9b57cf80c8b585614ba223732be0d8f19d558d8
Gitweb:        https://git.kernel.org/tip/f9b57cf80c8b585614ba223732be0d8f19d558d8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 10 Dec 2019 10:08:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Move the memtype related files to arch/x86/mm/pat/

- pat.c offers, dominantly, the memtype APIs - so rename it to memtype.c.

- pageattr.c is offering, primarily, the set_memory*() page attribute APIs,
  which is offered via the <asm/set_memory.h> header: name the .c file
  along the same pattern.

I.e. perform these renames, and move them all next to each other in arch/x86/mm/pat/:

    pat.c             => memtype.c
    pat_internal.h    => memtype.h
    pat_interval.c    => memtype_interval.c

    pageattr.c        => set_memory.c
    pageattr-test.c   => cpa-test.c

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/Makefile               |    8 +-
 arch/x86/mm/pageattr-test.c        |  278 +---
 arch/x86/mm/pageattr.c             | 2285 +---------------------------
 arch/x86/mm/pat.c                  | 1219 +--------------
 arch/x86/mm/pat/Makefile           |    5 +-
 arch/x86/mm/pat/cpa-test.c         |  278 +++-
 arch/x86/mm/pat/memtype.c          | 1219 ++++++++++++++-
 arch/x86/mm/pat/memtype.h          |   49 +-
 arch/x86/mm/pat/memtype_interval.c |  194 ++-
 arch/x86/mm/pat/set_memory.c       | 2285 +++++++++++++++++++++++++++-
 arch/x86/mm/pat_internal.h         |   49 +-
 arch/x86/mm/pat_interval.c         |  194 +--
 12 files changed, 4034 insertions(+), 4029 deletions(-)
 delete mode 100644 arch/x86/mm/pageattr-test.c
 delete mode 100644 arch/x86/mm/pageattr.c
 delete mode 100644 arch/x86/mm/pat.c
 create mode 100644 arch/x86/mm/pat/Makefile
 create mode 100644 arch/x86/mm/pat/cpa-test.c
 create mode 100644 arch/x86/mm/pat/memtype.c
 create mode 100644 arch/x86/mm/pat/memtype.h
 create mode 100644 arch/x86/mm/pat/memtype_interval.c
 create mode 100644 arch/x86/mm/pat/set_memory.c
 delete mode 100644 arch/x86/mm/pat_internal.h
 delete mode 100644 arch/x86/mm/pat_interval.c

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 3b89c20..345848f 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -12,8 +12,10 @@ CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
-obj-y	:=  init.o init_$(BITS).o fault.o ioremap.o extable.o pageattr.o mmap.o \
-	    pat.o pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o
+obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
+				    pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o
+
+obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
@@ -23,8 +25,6 @@ CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-$(CONFIG_X86_PAT)		+= pat_interval.o
-
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/x86/mm/pageattr-test.c b/arch/x86/mm/pageattr-test.c
deleted file mode 100644
index facce27..0000000
--- a/arch/x86/mm/pageattr-test.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * self test for change_page_attr.
- *
- * Clears the a test pte bit on random pages in the direct mapping,
- * then reverts and compares page tables forwards and afterwards.
- */
-#include <linux/memblock.h>
-#include <linux/kthread.h>
-#include <linux/random.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/vmalloc.h>
-
-#include <asm/cacheflush.h>
-#include <asm/pgtable.h>
-#include <asm/kdebug.h>
-
-/*
- * Only print the results of the first pass:
- */
-static __read_mostly int print = 1;
-
-enum {
-	NTEST			= 3 * 100,
-	NPAGES			= 100,
-#ifdef CONFIG_X86_64
-	LPS			= (1 << PMD_SHIFT),
-#elif defined(CONFIG_X86_PAE)
-	LPS			= (1 << PMD_SHIFT),
-#else
-	LPS			= (1 << 22),
-#endif
-	GPS			= (1<<30)
-};
-
-#define PAGE_CPA_TEST	__pgprot(_PAGE_CPA_TEST)
-
-static int pte_testbit(pte_t pte)
-{
-	return pte_flags(pte) & _PAGE_SOFTW1;
-}
-
-struct split_state {
-	long lpg, gpg, spg, exec;
-	long min_exec, max_exec;
-};
-
-static int print_split(struct split_state *s)
-{
-	long i, expected, missed = 0;
-	int err = 0;
-
-	s->lpg = s->gpg = s->spg = s->exec = 0;
-	s->min_exec = ~0UL;
-	s->max_exec = 0;
-	for (i = 0; i < max_pfn_mapped; ) {
-		unsigned long addr = (unsigned long)__va(i << PAGE_SHIFT);
-		unsigned int level;
-		pte_t *pte;
-
-		pte = lookup_address(addr, &level);
-		if (!pte) {
-			missed++;
-			i++;
-			continue;
-		}
-
-		if (level == PG_LEVEL_1G && sizeof(long) == 8) {
-			s->gpg++;
-			i += GPS/PAGE_SIZE;
-		} else if (level == PG_LEVEL_2M) {
-			if ((pte_val(*pte) & _PAGE_PRESENT) && !(pte_val(*pte) & _PAGE_PSE)) {
-				printk(KERN_ERR
-					"%lx level %d but not PSE %Lx\n",
-					addr, level, (u64)pte_val(*pte));
-				err = 1;
-			}
-			s->lpg++;
-			i += LPS/PAGE_SIZE;
-		} else {
-			s->spg++;
-			i++;
-		}
-		if (!(pte_val(*pte) & _PAGE_NX)) {
-			s->exec++;
-			if (addr < s->min_exec)
-				s->min_exec = addr;
-			if (addr > s->max_exec)
-				s->max_exec = addr;
-		}
-	}
-	if (print) {
-		printk(KERN_INFO
-			" 4k %lu large %lu gb %lu x %lu[%lx-%lx] miss %lu\n",
-			s->spg, s->lpg, s->gpg, s->exec,
-			s->min_exec != ~0UL ? s->min_exec : 0,
-			s->max_exec, missed);
-	}
-
-	expected = (s->gpg*GPS + s->lpg*LPS)/PAGE_SIZE + s->spg + missed;
-	if (expected != i) {
-		printk(KERN_ERR "CPA max_pfn_mapped %lu but expected %lu\n",
-			max_pfn_mapped, expected);
-		return 1;
-	}
-	return err;
-}
-
-static unsigned long addr[NTEST];
-static unsigned int len[NTEST];
-
-static struct page *pages[NPAGES];
-static unsigned long addrs[NPAGES];
-
-/* Change the global bit on random pages in the direct mapping */
-static int pageattr_test(void)
-{
-	struct split_state sa, sb, sc;
-	unsigned long *bm;
-	pte_t *pte, pte0;
-	int failed = 0;
-	unsigned int level;
-	int i, k;
-	int err;
-
-	if (print)
-		printk(KERN_INFO "CPA self-test:\n");
-
-	bm = vzalloc((max_pfn_mapped + 7) / 8);
-	if (!bm) {
-		printk(KERN_ERR "CPA Cannot vmalloc bitmap\n");
-		return -ENOMEM;
-	}
-
-	failed += print_split(&sa);
-
-	for (i = 0; i < NTEST; i++) {
-		unsigned long pfn = prandom_u32() % max_pfn_mapped;
-
-		addr[i] = (unsigned long)__va(pfn << PAGE_SHIFT);
-		len[i] = prandom_u32() % NPAGES;
-		len[i] = min_t(unsigned long, len[i], max_pfn_mapped - pfn - 1);
-
-		if (len[i] == 0)
-			len[i] = 1;
-
-		pte = NULL;
-		pte0 = pfn_pte(0, __pgprot(0)); /* shut gcc up */
-
-		for (k = 0; k < len[i]; k++) {
-			pte = lookup_address(addr[i] + k*PAGE_SIZE, &level);
-			if (!pte || pgprot_val(pte_pgprot(*pte)) == 0 ||
-			    !(pte_val(*pte) & _PAGE_PRESENT)) {
-				addr[i] = 0;
-				break;
-			}
-			if (k == 0) {
-				pte0 = *pte;
-			} else {
-				if (pgprot_val(pte_pgprot(*pte)) !=
-					pgprot_val(pte_pgprot(pte0))) {
-					len[i] = k;
-					break;
-				}
-			}
-			if (test_bit(pfn + k, bm)) {
-				len[i] = k;
-				break;
-			}
-			__set_bit(pfn + k, bm);
-			addrs[k] = addr[i] + k*PAGE_SIZE;
-			pages[k] = pfn_to_page(pfn + k);
-		}
-		if (!addr[i] || !pte || !k) {
-			addr[i] = 0;
-			continue;
-		}
-
-		switch (i % 3) {
-		case 0:
-			err = change_page_attr_set(&addr[i], len[i], PAGE_CPA_TEST, 0);
-			break;
-
-		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
-			break;
-
-		case 2:
-			err = cpa_set_pages_array(pages, len[i], PAGE_CPA_TEST);
-			break;
-		}
-
-
-		if (err < 0) {
-			printk(KERN_ERR "CPA %d failed %d\n", i, err);
-			failed++;
-		}
-
-		pte = lookup_address(addr[i], &level);
-		if (!pte || !pte_testbit(*pte) || pte_huge(*pte)) {
-			printk(KERN_ERR "CPA %lx: bad pte %Lx\n", addr[i],
-				pte ? (u64)pte_val(*pte) : 0ULL);
-			failed++;
-		}
-		if (level != PG_LEVEL_4K) {
-			printk(KERN_ERR "CPA %lx: unexpected level %d\n",
-				addr[i], level);
-			failed++;
-		}
-
-	}
-	vfree(bm);
-
-	failed += print_split(&sb);
-
-	for (i = 0; i < NTEST; i++) {
-		if (!addr[i])
-			continue;
-		pte = lookup_address(addr[i], &level);
-		if (!pte) {
-			printk(KERN_ERR "CPA lookup of %lx failed\n", addr[i]);
-			failed++;
-			continue;
-		}
-		err = change_page_attr_clear(&addr[i], len[i], PAGE_CPA_TEST, 0);
-		if (err < 0) {
-			printk(KERN_ERR "CPA reverting failed: %d\n", err);
-			failed++;
-		}
-		pte = lookup_address(addr[i], &level);
-		if (!pte || pte_testbit(*pte)) {
-			printk(KERN_ERR "CPA %lx: bad pte after revert %Lx\n",
-				addr[i], pte ? (u64)pte_val(*pte) : 0ULL);
-			failed++;
-		}
-
-	}
-
-	failed += print_split(&sc);
-
-	if (failed) {
-		WARN(1, KERN_ERR "NOT PASSED. Please report.\n");
-		return -EINVAL;
-	} else {
-		if (print)
-			printk(KERN_INFO "ok.\n");
-	}
-
-	return 0;
-}
-
-static int do_pageattr_test(void *__unused)
-{
-	while (!kthread_should_stop()) {
-		schedule_timeout_interruptible(HZ*30);
-		if (pageattr_test() < 0)
-			break;
-		if (print)
-			print--;
-	}
-	return 0;
-}
-
-static int start_pageattr_test(void)
-{
-	struct task_struct *p;
-
-	p = kthread_create(do_pageattr_test, NULL, "pageattr-test");
-	if (!IS_ERR(p))
-		wake_up_process(p);
-	else
-		WARN_ON(1);
-
-	return 0;
-}
-device_initcall(start_pageattr_test);
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
deleted file mode 100644
index 1b99ad0..0000000
--- a/arch/x86/mm/pageattr.c
+++ /dev/null
@@ -1,2285 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2002 Andi Kleen, SuSE Labs.
- * Thanks to Ben LaHaise for precious feedback.
- */
-#include <linux/highmem.h>
-#include <linux/memblock.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/seq_file.h>
-#include <linux/debugfs.h>
-#include <linux/pfn.h>
-#include <linux/percpu.h>
-#include <linux/gfp.h>
-#include <linux/pci.h>
-#include <linux/vmalloc.h>
-
-#include <asm/e820/api.h>
-#include <asm/processor.h>
-#include <asm/tlbflush.h>
-#include <asm/sections.h>
-#include <asm/setup.h>
-#include <linux/uaccess.h>
-#include <asm/pgalloc.h>
-#include <asm/proto.h>
-#include <asm/pat.h>
-#include <asm/set_memory.h>
-
-#include "mm_internal.h"
-
-/*
- * The current flushing context - we pass it instead of 5 arguments:
- */
-struct cpa_data {
-	unsigned long	*vaddr;
-	pgd_t		*pgd;
-	pgprot_t	mask_set;
-	pgprot_t	mask_clr;
-	unsigned long	numpages;
-	unsigned long	curpage;
-	unsigned long	pfn;
-	unsigned int	flags;
-	unsigned int	force_split		: 1,
-			force_static_prot	: 1;
-	struct page	**pages;
-};
-
-enum cpa_warn {
-	CPA_CONFLICT,
-	CPA_PROTECT,
-	CPA_DETECT,
-};
-
-static const int cpa_warn_level = CPA_PROTECT;
-
-/*
- * Serialize cpa() (for !DEBUG_PAGEALLOC which uses large identity mappings)
- * using cpa_lock. So that we don't allow any other cpu, with stale large tlb
- * entries change the page attribute in parallel to some other cpu
- * splitting a large page entry along with changing the attribute.
- */
-static DEFINE_SPINLOCK(cpa_lock);
-
-#define CPA_FLUSHTLB 1
-#define CPA_ARRAY 2
-#define CPA_PAGES_ARRAY 4
-#define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
-
-#ifdef CONFIG_PROC_FS
-static unsigned long direct_pages_count[PG_LEVEL_NUM];
-
-void update_page_count(int level, unsigned long pages)
-{
-	/* Protect against CPA */
-	spin_lock(&pgd_lock);
-	direct_pages_count[level] += pages;
-	spin_unlock(&pgd_lock);
-}
-
-static void split_page_count(int level)
-{
-	if (direct_pages_count[level] == 0)
-		return;
-
-	direct_pages_count[level]--;
-	direct_pages_count[level - 1] += PTRS_PER_PTE;
-}
-
-void arch_report_meminfo(struct seq_file *m)
-{
-	seq_printf(m, "DirectMap4k:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_4K] << 2);
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-	seq_printf(m, "DirectMap2M:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_2M] << 11);
-#else
-	seq_printf(m, "DirectMap4M:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_2M] << 12);
-#endif
-	if (direct_gbpages)
-		seq_printf(m, "DirectMap1G:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_1G] << 20);
-}
-#else
-static inline void split_page_count(int level) { }
-#endif
-
-#ifdef CONFIG_X86_CPA_STATISTICS
-
-static unsigned long cpa_1g_checked;
-static unsigned long cpa_1g_sameprot;
-static unsigned long cpa_1g_preserved;
-static unsigned long cpa_2m_checked;
-static unsigned long cpa_2m_sameprot;
-static unsigned long cpa_2m_preserved;
-static unsigned long cpa_4k_install;
-
-static inline void cpa_inc_1g_checked(void)
-{
-	cpa_1g_checked++;
-}
-
-static inline void cpa_inc_2m_checked(void)
-{
-	cpa_2m_checked++;
-}
-
-static inline void cpa_inc_4k_install(void)
-{
-	cpa_4k_install++;
-}
-
-static inline void cpa_inc_lp_sameprot(int level)
-{
-	if (level == PG_LEVEL_1G)
-		cpa_1g_sameprot++;
-	else
-		cpa_2m_sameprot++;
-}
-
-static inline void cpa_inc_lp_preserved(int level)
-{
-	if (level == PG_LEVEL_1G)
-		cpa_1g_preserved++;
-	else
-		cpa_2m_preserved++;
-}
-
-static int cpastats_show(struct seq_file *m, void *p)
-{
-	seq_printf(m, "1G pages checked:     %16lu\n", cpa_1g_checked);
-	seq_printf(m, "1G pages sameprot:    %16lu\n", cpa_1g_sameprot);
-	seq_printf(m, "1G pages preserved:   %16lu\n", cpa_1g_preserved);
-	seq_printf(m, "2M pages checked:     %16lu\n", cpa_2m_checked);
-	seq_printf(m, "2M pages sameprot:    %16lu\n", cpa_2m_sameprot);
-	seq_printf(m, "2M pages preserved:   %16lu\n", cpa_2m_preserved);
-	seq_printf(m, "4K pages set-checked: %16lu\n", cpa_4k_install);
-	return 0;
-}
-
-static int cpastats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cpastats_show, NULL);
-}
-
-static const struct file_operations cpastats_fops = {
-	.open		= cpastats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init cpa_stats_init(void)
-{
-	debugfs_create_file("cpa_stats", S_IRUSR, arch_debugfs_dir, NULL,
-			    &cpastats_fops);
-	return 0;
-}
-late_initcall(cpa_stats_init);
-#else
-static inline void cpa_inc_1g_checked(void) { }
-static inline void cpa_inc_2m_checked(void) { }
-static inline void cpa_inc_4k_install(void) { }
-static inline void cpa_inc_lp_sameprot(int level) { }
-static inline void cpa_inc_lp_preserved(int level) { }
-#endif
-
-
-static inline int
-within(unsigned long addr, unsigned long start, unsigned long end)
-{
-	return addr >= start && addr < end;
-}
-
-static inline int
-within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
-{
-	return addr >= start && addr <= end;
-}
-
-#ifdef CONFIG_X86_64
-
-static inline unsigned long highmap_start_pfn(void)
-{
-	return __pa_symbol(_text) >> PAGE_SHIFT;
-}
-
-static inline unsigned long highmap_end_pfn(void)
-{
-	/* Do not reference physical address outside the kernel. */
-	return __pa_symbol(roundup(_brk_end, PMD_SIZE) - 1) >> PAGE_SHIFT;
-}
-
-static bool __cpa_pfn_in_highmap(unsigned long pfn)
-{
-	/*
-	 * Kernel text has an alias mapping at a high address, known
-	 * here as "highmap".
-	 */
-	return within_inclusive(pfn, highmap_start_pfn(), highmap_end_pfn());
-}
-
-#else
-
-static bool __cpa_pfn_in_highmap(unsigned long pfn)
-{
-	/* There is no highmap on 32-bit */
-	return false;
-}
-
-#endif
-
-/*
- * See set_mce_nospec().
- *
- * Machine check recovery code needs to change cache mode of poisoned pages to
- * UC to avoid speculative access logging another error. But passing the
- * address of the 1:1 mapping to set_memory_uc() is a fine way to encourage a
- * speculative access. So we cheat and flip the top bit of the address. This
- * works fine for the code that updates the page tables. But at the end of the
- * process we need to flush the TLB and cache and the non-canonical address
- * causes a #GP fault when used by the INVLPG and CLFLUSH instructions.
- *
- * But in the common case we already have a canonical address. This code
- * will fix the top bit if needed and is a no-op otherwise.
- */
-static inline unsigned long fix_addr(unsigned long addr)
-{
-#ifdef CONFIG_X86_64
-	return (long)(addr << 1) >> 1;
-#else
-	return addr;
-#endif
-}
-
-static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
-{
-	if (cpa->flags & CPA_PAGES_ARRAY) {
-		struct page *page = cpa->pages[idx];
-
-		if (unlikely(PageHighMem(page)))
-			return 0;
-
-		return (unsigned long)page_address(page);
-	}
-
-	if (cpa->flags & CPA_ARRAY)
-		return cpa->vaddr[idx];
-
-	return *cpa->vaddr + idx * PAGE_SIZE;
-}
-
-/*
- * Flushing functions
- */
-
-static void clflush_cache_range_opt(void *vaddr, unsigned int size)
-{
-	const unsigned long clflush_size = boot_cpu_data.x86_clflush_size;
-	void *p = (void *)((unsigned long)vaddr & ~(clflush_size - 1));
-	void *vend = vaddr + size;
-
-	if (p >= vend)
-		return;
-
-	for (; p < vend; p += clflush_size)
-		clflushopt(p);
-}
-
-/**
- * clflush_cache_range - flush a cache range with clflush
- * @vaddr:	virtual start address
- * @size:	number of bytes to flush
- *
- * CLFLUSHOPT is an unordered instruction which needs fencing with MFENCE or
- * SFENCE to avoid ordering issues.
- */
-void clflush_cache_range(void *vaddr, unsigned int size)
-{
-	mb();
-	clflush_cache_range_opt(vaddr, size);
-	mb();
-}
-EXPORT_SYMBOL_GPL(clflush_cache_range);
-
-void arch_invalidate_pmem(void *addr, size_t size)
-{
-	clflush_cache_range(addr, size);
-}
-EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-
-static void __cpa_flush_all(void *arg)
-{
-	unsigned long cache = (unsigned long)arg;
-
-	/*
-	 * Flush all to work around Errata in early athlons regarding
-	 * large page flushing.
-	 */
-	__flush_tlb_all();
-
-	if (cache && boot_cpu_data.x86 >= 4)
-		wbinvd();
-}
-
-static void cpa_flush_all(unsigned long cache)
-{
-	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
-
-	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
-}
-
-void __cpa_flush_tlb(void *data)
-{
-	struct cpa_data *cpa = data;
-	unsigned int i;
-
-	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
-}
-
-static void cpa_flush(struct cpa_data *data, int cache)
-{
-	struct cpa_data *cpa = data;
-	unsigned int i;
-
-	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
-
-	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
-		cpa_flush_all(cache);
-		return;
-	}
-
-	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
-	else
-		flush_tlb_all();
-
-	if (!cache)
-		return;
-
-	mb();
-	for (i = 0; i < cpa->numpages; i++) {
-		unsigned long addr = __cpa_addr(cpa, i);
-		unsigned int level;
-
-		pte_t *pte = lookup_address(addr, &level);
-
-		/*
-		 * Only flush present addresses:
-		 */
-		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
-	}
-	mb();
-}
-
-static bool overlaps(unsigned long r1_start, unsigned long r1_end,
-		     unsigned long r2_start, unsigned long r2_end)
-{
-	return (r1_start <= r2_end && r1_end >= r2_start) ||
-		(r2_start <= r1_end && r2_end >= r1_start);
-}
-
-#ifdef CONFIG_PCI_BIOS
-/*
- * The BIOS area between 640k and 1Mb needs to be executable for PCI BIOS
- * based config access (CONFIG_PCI_GOBIOS) support.
- */
-#define BIOS_PFN	PFN_DOWN(BIOS_BEGIN)
-#define BIOS_PFN_END	PFN_DOWN(BIOS_END - 1)
-
-static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
-{
-	if (pcibios_enabled && overlaps(spfn, epfn, BIOS_PFN, BIOS_PFN_END))
-		return _PAGE_NX;
-	return 0;
-}
-#else
-static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
-{
-	return 0;
-}
-#endif
-
-/*
- * The .rodata section needs to be read-only. Using the pfn catches all
- * aliases.  This also includes __ro_after_init, so do not enforce until
- * kernel_set_to_readonly is true.
- */
-static pgprotval_t protect_rodata(unsigned long spfn, unsigned long epfn)
-{
-	unsigned long epfn_ro, spfn_ro = PFN_DOWN(__pa_symbol(__start_rodata));
-
-	/*
-	 * Note: __end_rodata is at page aligned and not inclusive, so
-	 * subtract 1 to get the last enforced PFN in the rodata area.
-	 */
-	epfn_ro = PFN_DOWN(__pa_symbol(__end_rodata)) - 1;
-
-	if (kernel_set_to_readonly && overlaps(spfn, epfn, spfn_ro, epfn_ro))
-		return _PAGE_RW;
-	return 0;
-}
-
-/*
- * Protect kernel text against becoming non executable by forbidding
- * _PAGE_NX.  This protects only the high kernel mapping (_text -> _etext)
- * out of which the kernel actually executes.  Do not protect the low
- * mapping.
- *
- * This does not cover __inittext since that is gone after boot.
- */
-static pgprotval_t protect_kernel_text(unsigned long start, unsigned long end)
-{
-	unsigned long t_end = (unsigned long)_etext - 1;
-	unsigned long t_start = (unsigned long)_text;
-
-	if (overlaps(start, end, t_start, t_end))
-		return _PAGE_NX;
-	return 0;
-}
-
-#if defined(CONFIG_X86_64)
-/*
- * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
- * kernel text mappings for the large page aligned text, rodata sections
- * will be always read-only. For the kernel identity mappings covering the
- * holes caused by this alignment can be anything that user asks.
- *
- * This will preserve the large page mappings for kernel text/data at no
- * extra cost.
- */
-static pgprotval_t protect_kernel_text_ro(unsigned long start,
-					  unsigned long end)
-{
-	unsigned long t_end = (unsigned long)__end_rodata_hpage_align - 1;
-	unsigned long t_start = (unsigned long)_text;
-	unsigned int level;
-
-	if (!kernel_set_to_readonly || !overlaps(start, end, t_start, t_end))
-		return 0;
-	/*
-	 * Don't enforce the !RW mapping for the kernel text mapping, if
-	 * the current mapping is already using small page mapping.  No
-	 * need to work hard to preserve large page mappings in this case.
-	 *
-	 * This also fixes the Linux Xen paravirt guest boot failure caused
-	 * by unexpected read-only mappings for kernel identity
-	 * mappings. In this paravirt guest case, the kernel text mapping
-	 * and the kernel identity mapping share the same page-table pages,
-	 * so the protections for kernel text and identity mappings have to
-	 * be the same.
-	 */
-	if (lookup_address(start, &level) && (level != PG_LEVEL_4K))
-		return _PAGE_RW;
-	return 0;
-}
-#else
-static pgprotval_t protect_kernel_text_ro(unsigned long start,
-					  unsigned long end)
-{
-	return 0;
-}
-#endif
-
-static inline bool conflicts(pgprot_t prot, pgprotval_t val)
-{
-	return (pgprot_val(prot) & ~val) != pgprot_val(prot);
-}
-
-static inline void check_conflict(int warnlvl, pgprot_t prot, pgprotval_t val,
-				  unsigned long start, unsigned long end,
-				  unsigned long pfn, const char *txt)
-{
-	static const char *lvltxt[] = {
-		[CPA_CONFLICT]	= "conflict",
-		[CPA_PROTECT]	= "protect",
-		[CPA_DETECT]	= "detect",
-	};
-
-	if (warnlvl > cpa_warn_level || !conflicts(prot, val))
-		return;
-
-	pr_warn("CPA %8s %10s: 0x%016lx - 0x%016lx PFN %lx req %016llx prevent %016llx\n",
-		lvltxt[warnlvl], txt, start, end, pfn, (unsigned long long)pgprot_val(prot),
-		(unsigned long long)val);
-}
-
-/*
- * Certain areas of memory on x86 require very specific protection flags,
- * for example the BIOS area or kernel text. Callers don't always get this
- * right (again, ioremap() on BIOS memory is not uncommon) so this function
- * checks and fixes these known static required protection bits.
- */
-static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
-					  unsigned long pfn, unsigned long npg,
-					  unsigned long lpsize, int warnlvl)
-{
-	pgprotval_t forbidden, res;
-	unsigned long end;
-
-	/*
-	 * There is no point in checking RW/NX conflicts when the requested
-	 * mapping is setting the page !PRESENT.
-	 */
-	if (!(pgprot_val(prot) & _PAGE_PRESENT))
-		return prot;
-
-	/* Operate on the virtual address */
-	end = start + npg * PAGE_SIZE - 1;
-
-	res = protect_kernel_text(start, end);
-	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
-	forbidden = res;
-
-	/*
-	 * Special case to preserve a large page. If the change spawns the
-	 * full large page mapping then there is no point to split it
-	 * up. Happens with ftrace and is going to be removed once ftrace
-	 * switched to text_poke().
-	 */
-	if (lpsize != (npg * PAGE_SIZE) || (start & (lpsize - 1))) {
-		res = protect_kernel_text_ro(start, end);
-		check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
-		forbidden |= res;
-	}
-
-	/* Check the PFN directly */
-	res = protect_pci_bios(pfn, pfn + npg - 1);
-	check_conflict(warnlvl, prot, res, start, end, pfn, "PCIBIOS NX");
-	forbidden |= res;
-
-	res = protect_rodata(pfn, pfn + npg - 1);
-	check_conflict(warnlvl, prot, res, start, end, pfn, "Rodata RO");
-	forbidden |= res;
-
-	return __pgprot(pgprot_val(prot) & ~forbidden);
-}
-
-/*
- * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
- */
-pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
-			     unsigned int *level)
-{
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	*level = PG_LEVEL_NONE;
-
-	if (pgd_none(*pgd))
-		return NULL;
-
-	p4d = p4d_offset(pgd, address);
-	if (p4d_none(*p4d))
-		return NULL;
-
-	*level = PG_LEVEL_512G;
-	if (p4d_large(*p4d) || !p4d_present(*p4d))
-		return (pte_t *)p4d;
-
-	pud = pud_offset(p4d, address);
-	if (pud_none(*pud))
-		return NULL;
-
-	*level = PG_LEVEL_1G;
-	if (pud_large(*pud) || !pud_present(*pud))
-		return (pte_t *)pud;
-
-	pmd = pmd_offset(pud, address);
-	if (pmd_none(*pmd))
-		return NULL;
-
-	*level = PG_LEVEL_2M;
-	if (pmd_large(*pmd) || !pmd_present(*pmd))
-		return (pte_t *)pmd;
-
-	*level = PG_LEVEL_4K;
-
-	return pte_offset_kernel(pmd, address);
-}
-
-/*
- * Lookup the page table entry for a virtual address. Return a pointer
- * to the entry and the level of the mapping.
- *
- * Note: We return pud and pmd either when the entry is marked large
- * or when the present bit is not set. Otherwise we would return a
- * pointer to a nonexisting mapping.
- */
-pte_t *lookup_address(unsigned long address, unsigned int *level)
-{
-	return lookup_address_in_pgd(pgd_offset_k(address), address, level);
-}
-EXPORT_SYMBOL_GPL(lookup_address);
-
-static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
-				  unsigned int *level)
-{
-	if (cpa->pgd)
-		return lookup_address_in_pgd(cpa->pgd + pgd_index(address),
-					       address, level);
-
-	return lookup_address(address, level);
-}
-
-/*
- * Lookup the PMD entry for a virtual address. Return a pointer to the entry
- * or NULL if not present.
- */
-pmd_t *lookup_pmd_address(unsigned long address)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-
-	pgd = pgd_offset_k(address);
-	if (pgd_none(*pgd))
-		return NULL;
-
-	p4d = p4d_offset(pgd, address);
-	if (p4d_none(*p4d) || p4d_large(*p4d) || !p4d_present(*p4d))
-		return NULL;
-
-	pud = pud_offset(p4d, address);
-	if (pud_none(*pud) || pud_large(*pud) || !pud_present(*pud))
-		return NULL;
-
-	return pmd_offset(pud, address);
-}
-
-/*
- * This is necessary because __pa() does not work on some
- * kinds of memory, like vmalloc() or the alloc_remap()
- * areas on 32-bit NUMA systems.  The percpu areas can
- * end up in this kind of memory, for instance.
- *
- * This could be optimized, but it is only intended to be
- * used at inititalization time, and keeping it
- * unoptimized should increase the testing coverage for
- * the more obscure platforms.
- */
-phys_addr_t slow_virt_to_phys(void *__virt_addr)
-{
-	unsigned long virt_addr = (unsigned long)__virt_addr;
-	phys_addr_t phys_addr;
-	unsigned long offset;
-	enum pg_level level;
-	pte_t *pte;
-
-	pte = lookup_address(virt_addr, &level);
-	BUG_ON(!pte);
-
-	/*
-	 * pXX_pfn() returns unsigned long, which must be cast to phys_addr_t
-	 * before being left-shifted PAGE_SHIFT bits -- this trick is to
-	 * make 32-PAE kernel work correctly.
-	 */
-	switch (level) {
-	case PG_LEVEL_1G:
-		phys_addr = (phys_addr_t)pud_pfn(*(pud_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PUD_PAGE_MASK;
-		break;
-	case PG_LEVEL_2M:
-		phys_addr = (phys_addr_t)pmd_pfn(*(pmd_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PMD_PAGE_MASK;
-		break;
-	default:
-		phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PAGE_MASK;
-	}
-
-	return (phys_addr_t)(phys_addr | offset);
-}
-EXPORT_SYMBOL_GPL(slow_virt_to_phys);
-
-/*
- * Set the new pmd in all the pgds we know about:
- */
-static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
-{
-	/* change init_mm */
-	set_pte_atomic(kpte, pte);
-#ifdef CONFIG_X86_32
-	if (!SHARED_KERNEL_PMD) {
-		struct page *page;
-
-		list_for_each_entry(page, &pgd_list, lru) {
-			pgd_t *pgd;
-			p4d_t *p4d;
-			pud_t *pud;
-			pmd_t *pmd;
-
-			pgd = (pgd_t *)page_address(page) + pgd_index(address);
-			p4d = p4d_offset(pgd, address);
-			pud = pud_offset(p4d, address);
-			pmd = pmd_offset(pud, address);
-			set_pte_atomic((pte_t *)pmd, pte);
-		}
-	}
-#endif
-}
-
-static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
-{
-	/*
-	 * _PAGE_GLOBAL means "global page" for present PTEs.
-	 * But, it is also used to indicate _PAGE_PROTNONE
-	 * for non-present PTEs.
-	 *
-	 * This ensures that a _PAGE_GLOBAL PTE going from
-	 * present to non-present is not confused as
-	 * _PAGE_PROTNONE.
-	 */
-	if (!(pgprot_val(prot) & _PAGE_PRESENT))
-		pgprot_val(prot) &= ~_PAGE_GLOBAL;
-
-	return prot;
-}
-
-static int __should_split_large_page(pte_t *kpte, unsigned long address,
-				     struct cpa_data *cpa)
-{
-	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
-	pgprot_t old_prot, new_prot, req_prot, chk_prot;
-	pte_t new_pte, *tmp;
-	enum pg_level level;
-
-	/*
-	 * Check for races, another CPU might have split this page
-	 * up already:
-	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
-	if (tmp != kpte)
-		return 1;
-
-	switch (level) {
-	case PG_LEVEL_2M:
-		old_prot = pmd_pgprot(*(pmd_t *)kpte);
-		old_pfn = pmd_pfn(*(pmd_t *)kpte);
-		cpa_inc_2m_checked();
-		break;
-	case PG_LEVEL_1G:
-		old_prot = pud_pgprot(*(pud_t *)kpte);
-		old_pfn = pud_pfn(*(pud_t *)kpte);
-		cpa_inc_1g_checked();
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	psize = page_level_size(level);
-	pmask = page_level_mask(level);
-
-	/*
-	 * Calculate the number of pages, which fit into this large
-	 * page starting at address:
-	 */
-	lpaddr = (address + psize) & pmask;
-	numpages = (lpaddr - address) >> PAGE_SHIFT;
-	if (numpages < cpa->numpages)
-		cpa->numpages = numpages;
-
-	/*
-	 * We are safe now. Check whether the new pgprot is the same:
-	 * Convert protection attributes to 4k-format, as cpa->mask* are set
-	 * up accordingly.
-	 */
-
-	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
-	req_prot = pgprot_large_2_4k(old_prot);
-
-	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
-	pgprot_val(req_prot) |= pgprot_val(cpa->mask_set);
-
-	/*
-	 * req_prot is in format of 4k pages. It must be converted to large
-	 * page format: the caching mode includes the PAT bit located at
-	 * different bit positions in the two formats.
-	 */
-	req_prot = pgprot_4k_2_large(req_prot);
-	req_prot = pgprot_clear_protnone_bits(req_prot);
-	if (pgprot_val(req_prot) & _PAGE_PRESENT)
-		pgprot_val(req_prot) |= _PAGE_PSE;
-
-	/*
-	 * old_pfn points to the large page base pfn. So we need to add the
-	 * offset of the virtual address:
-	 */
-	pfn = old_pfn + ((address & (psize - 1)) >> PAGE_SHIFT);
-	cpa->pfn = pfn;
-
-	/*
-	 * Calculate the large page base address and the number of 4K pages
-	 * in the large page
-	 */
-	lpaddr = address & pmask;
-	numpages = psize >> PAGE_SHIFT;
-
-	/*
-	 * Sanity check that the existing mapping is correct versus the static
-	 * protections. static_protections() guards against !PRESENT, so no
-	 * extra conditional required here.
-	 */
-	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
-				      psize, CPA_CONFLICT);
-
-	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
-		/*
-		 * Split the large page and tell the split code to
-		 * enforce static protections.
-		 */
-		cpa->force_static_prot = 1;
-		return 1;
-	}
-
-	/*
-	 * Optimization: If the requested pgprot is the same as the current
-	 * pgprot, then the large page can be preserved and no updates are
-	 * required independent of alignment and length of the requested
-	 * range. The above already established that the current pgprot is
-	 * correct, which in consequence makes the requested pgprot correct
-	 * as well if it is the same. The static protection scan below will
-	 * not come to a different conclusion.
-	 */
-	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
-		cpa_inc_lp_sameprot(level);
-		return 0;
-	}
-
-	/*
-	 * If the requested range does not cover the full page, split it up
-	 */
-	if (address != lpaddr || cpa->numpages != numpages)
-		return 1;
-
-	/*
-	 * Check whether the requested pgprot is conflicting with a static
-	 * protection requirement in the large page.
-	 */
-	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
-				      psize, CPA_DETECT);
-
-	/*
-	 * If there is a conflict, split the large page.
-	 *
-	 * There used to be a 4k wise evaluation trying really hard to
-	 * preserve the large pages, but experimentation has shown, that this
-	 * does not help at all. There might be corner cases which would
-	 * preserve one large page occasionally, but it's really not worth the
-	 * extra code and cycles for the common case.
-	 */
-	if (pgprot_val(req_prot) != pgprot_val(new_prot))
-		return 1;
-
-	/* All checks passed. Update the large page mapping. */
-	new_pte = pfn_pte(old_pfn, new_prot);
-	__set_pmd_pte(kpte, address, new_pte);
-	cpa->flags |= CPA_FLUSHTLB;
-	cpa_inc_lp_preserved(level);
-	return 0;
-}
-
-static int should_split_large_page(pte_t *kpte, unsigned long address,
-				   struct cpa_data *cpa)
-{
-	int do_split;
-
-	if (cpa->force_split)
-		return 1;
-
-	spin_lock(&pgd_lock);
-	do_split = __should_split_large_page(kpte, address, cpa);
-	spin_unlock(&pgd_lock);
-
-	return do_split;
-}
-
-static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
-			  pgprot_t ref_prot, unsigned long address,
-			  unsigned long size)
-{
-	unsigned int npg = PFN_DOWN(size);
-	pgprot_t prot;
-
-	/*
-	 * If should_split_large_page() discovered an inconsistent mapping,
-	 * remove the invalid protection in the split mapping.
-	 */
-	if (!cpa->force_static_prot)
-		goto set;
-
-	/* Hand in lpsize = 0 to enforce the protection mechanism */
-	prot = static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT);
-
-	if (pgprot_val(prot) == pgprot_val(ref_prot))
-		goto set;
-
-	/*
-	 * If this is splitting a PMD, fix it up. PUD splits cannot be
-	 * fixed trivially as that would require to rescan the newly
-	 * installed PMD mappings after returning from split_large_page()
-	 * so an eventual further split can allocate the necessary PTE
-	 * pages. Warn for now and revisit it in case this actually
-	 * happens.
-	 */
-	if (size == PAGE_SIZE)
-		ref_prot = prot;
-	else
-		pr_warn_once("CPA: Cannot fixup static protections for PUD split\n");
-set:
-	set_pte(pte, pfn_pte(pfn, ref_prot));
-}
-
-static int
-__split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct page *base)
-{
-	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
-	pte_t *pbase = (pte_t *)page_address(base);
-	unsigned int i, level;
-	pgprot_t ref_prot;
-	pte_t *tmp;
-
-	spin_lock(&pgd_lock);
-	/*
-	 * Check for races, another CPU might have split this page
-	 * up for us already:
-	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
-	if (tmp != kpte) {
-		spin_unlock(&pgd_lock);
-		return 1;
-	}
-
-	paravirt_alloc_pte(&init_mm, page_to_pfn(base));
-
-	switch (level) {
-	case PG_LEVEL_2M:
-		ref_prot = pmd_pgprot(*(pmd_t *)kpte);
-		/*
-		 * Clear PSE (aka _PAGE_PAT) and move
-		 * PAT bit to correct position.
-		 */
-		ref_prot = pgprot_large_2_4k(ref_prot);
-		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
-		lpaddr = address & PMD_MASK;
-		lpinc = PAGE_SIZE;
-		break;
-
-	case PG_LEVEL_1G:
-		ref_prot = pud_pgprot(*(pud_t *)kpte);
-		ref_pfn = pud_pfn(*(pud_t *)kpte);
-		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
-		lpaddr = address & PUD_MASK;
-		lpinc = PMD_SIZE;
-		/*
-		 * Clear the PSE flags if the PRESENT flag is not set
-		 * otherwise pmd_present/pmd_huge will return true
-		 * even on a non present pmd.
-		 */
-		if (!(pgprot_val(ref_prot) & _PAGE_PRESENT))
-			pgprot_val(ref_prot) &= ~_PAGE_PSE;
-		break;
-
-	default:
-		spin_unlock(&pgd_lock);
-		return 1;
-	}
-
-	ref_prot = pgprot_clear_protnone_bits(ref_prot);
-
-	/*
-	 * Get the target pfn from the original entry:
-	 */
-	pfn = ref_pfn;
-	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc, lpaddr += lpinc)
-		split_set_pte(cpa, pbase + i, pfn, ref_prot, lpaddr, lpinc);
-
-	if (virt_addr_valid(address)) {
-		unsigned long pfn = PFN_DOWN(__pa(address));
-
-		if (pfn_range_is_mapped(pfn, pfn + 1))
-			split_page_count(level);
-	}
-
-	/*
-	 * Install the new, split up pagetable.
-	 *
-	 * We use the standard kernel pagetable protections for the new
-	 * pagetable protections, the actual ptes set above control the
-	 * primary protection behavior:
-	 */
-	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
-
-	/*
-	 * Do a global flush tlb after splitting the large page
-	 * and before we do the actual change page attribute in the PTE.
-	 *
-	 * Without this, we violate the TLB application note, that says:
-	 * "The TLBs may contain both ordinary and large-page
-	 *  translations for a 4-KByte range of linear addresses. This
-	 *  may occur if software modifies the paging structures so that
-	 *  the page size used for the address range changes. If the two
-	 *  translations differ with respect to page frame or attributes
-	 *  (e.g., permissions), processor behavior is undefined and may
-	 *  be implementation-specific."
-	 *
-	 * We do this global tlb flush inside the cpa_lock, so that we
-	 * don't allow any other cpu, with stale tlb entries change the
-	 * page attribute in parallel, that also falls into the
-	 * just split large page entry.
-	 */
-	flush_tlb_all();
-	spin_unlock(&pgd_lock);
-
-	return 0;
-}
-
-static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
-			    unsigned long address)
-{
-	struct page *base;
-
-	if (!debug_pagealloc_enabled())
-		spin_unlock(&cpa_lock);
-	base = alloc_pages(GFP_KERNEL, 0);
-	if (!debug_pagealloc_enabled())
-		spin_lock(&cpa_lock);
-	if (!base)
-		return -ENOMEM;
-
-	if (__split_large_page(cpa, kpte, address, base))
-		__free_page(base);
-
-	return 0;
-}
-
-static bool try_to_free_pte_page(pte_t *pte)
-{
-	int i;
-
-	for (i = 0; i < PTRS_PER_PTE; i++)
-		if (!pte_none(pte[i]))
-			return false;
-
-	free_page((unsigned long)pte);
-	return true;
-}
-
-static bool try_to_free_pmd_page(pmd_t *pmd)
-{
-	int i;
-
-	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_none(pmd[i]))
-			return false;
-
-	free_page((unsigned long)pmd);
-	return true;
-}
-
-static bool unmap_pte_range(pmd_t *pmd, unsigned long start, unsigned long end)
-{
-	pte_t *pte = pte_offset_kernel(pmd, start);
-
-	while (start < end) {
-		set_pte(pte, __pte(0));
-
-		start += PAGE_SIZE;
-		pte++;
-	}
-
-	if (try_to_free_pte_page((pte_t *)pmd_page_vaddr(*pmd))) {
-		pmd_clear(pmd);
-		return true;
-	}
-	return false;
-}
-
-static void __unmap_pmd_range(pud_t *pud, pmd_t *pmd,
-			      unsigned long start, unsigned long end)
-{
-	if (unmap_pte_range(pmd, start, end))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
-			pud_clear(pud);
-}
-
-static void unmap_pmd_range(pud_t *pud, unsigned long start, unsigned long end)
-{
-	pmd_t *pmd = pmd_offset(pud, start);
-
-	/*
-	 * Not on a 2MB page boundary?
-	 */
-	if (start & (PMD_SIZE - 1)) {
-		unsigned long next_page = (start + PMD_SIZE) & PMD_MASK;
-		unsigned long pre_end = min_t(unsigned long, end, next_page);
-
-		__unmap_pmd_range(pud, pmd, start, pre_end);
-
-		start = pre_end;
-		pmd++;
-	}
-
-	/*
-	 * Try to unmap in 2M chunks.
-	 */
-	while (end - start >= PMD_SIZE) {
-		if (pmd_large(*pmd))
-			pmd_clear(pmd);
-		else
-			__unmap_pmd_range(pud, pmd, start, start + PMD_SIZE);
-
-		start += PMD_SIZE;
-		pmd++;
-	}
-
-	/*
-	 * 4K leftovers?
-	 */
-	if (start < end)
-		return __unmap_pmd_range(pud, pmd, start, end);
-
-	/*
-	 * Try again to free the PMD page if haven't succeeded above.
-	 */
-	if (!pud_none(*pud))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
-			pud_clear(pud);
-}
-
-static void unmap_pud_range(p4d_t *p4d, unsigned long start, unsigned long end)
-{
-	pud_t *pud = pud_offset(p4d, start);
-
-	/*
-	 * Not on a GB page boundary?
-	 */
-	if (start & (PUD_SIZE - 1)) {
-		unsigned long next_page = (start + PUD_SIZE) & PUD_MASK;
-		unsigned long pre_end	= min_t(unsigned long, end, next_page);
-
-		unmap_pmd_range(pud, start, pre_end);
-
-		start = pre_end;
-		pud++;
-	}
-
-	/*
-	 * Try to unmap in 1G chunks?
-	 */
-	while (end - start >= PUD_SIZE) {
-
-		if (pud_large(*pud))
-			pud_clear(pud);
-		else
-			unmap_pmd_range(pud, start, start + PUD_SIZE);
-
-		start += PUD_SIZE;
-		pud++;
-	}
-
-	/*
-	 * 2M leftovers?
-	 */
-	if (start < end)
-		unmap_pmd_range(pud, start, end);
-
-	/*
-	 * No need to try to free the PUD page because we'll free it in
-	 * populate_pgd's error path
-	 */
-}
-
-static int alloc_pte_page(pmd_t *pmd)
-{
-	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
-	if (!pte)
-		return -1;
-
-	set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
-	return 0;
-}
-
-static int alloc_pmd_page(pud_t *pud)
-{
-	pmd_t *pmd = (pmd_t *)get_zeroed_page(GFP_KERNEL);
-	if (!pmd)
-		return -1;
-
-	set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
-	return 0;
-}
-
-static void populate_pte(struct cpa_data *cpa,
-			 unsigned long start, unsigned long end,
-			 unsigned num_pages, pmd_t *pmd, pgprot_t pgprot)
-{
-	pte_t *pte;
-
-	pte = pte_offset_kernel(pmd, start);
-
-	pgprot = pgprot_clear_protnone_bits(pgprot);
-
-	while (num_pages-- && start < end) {
-		set_pte(pte, pfn_pte(cpa->pfn, pgprot));
-
-		start	 += PAGE_SIZE;
-		cpa->pfn++;
-		pte++;
-	}
-}
-
-static long populate_pmd(struct cpa_data *cpa,
-			 unsigned long start, unsigned long end,
-			 unsigned num_pages, pud_t *pud, pgprot_t pgprot)
-{
-	long cur_pages = 0;
-	pmd_t *pmd;
-	pgprot_t pmd_pgprot;
-
-	/*
-	 * Not on a 2M boundary?
-	 */
-	if (start & (PMD_SIZE - 1)) {
-		unsigned long pre_end = start + (num_pages << PAGE_SHIFT);
-		unsigned long next_page = (start + PMD_SIZE) & PMD_MASK;
-
-		pre_end   = min_t(unsigned long, pre_end, next_page);
-		cur_pages = (pre_end - start) >> PAGE_SHIFT;
-		cur_pages = min_t(unsigned int, num_pages, cur_pages);
-
-		/*
-		 * Need a PTE page?
-		 */
-		pmd = pmd_offset(pud, start);
-		if (pmd_none(*pmd))
-			if (alloc_pte_page(pmd))
-				return -1;
-
-		populate_pte(cpa, start, pre_end, cur_pages, pmd, pgprot);
-
-		start = pre_end;
-	}
-
-	/*
-	 * We mapped them all?
-	 */
-	if (num_pages == cur_pages)
-		return cur_pages;
-
-	pmd_pgprot = pgprot_4k_2_large(pgprot);
-
-	while (end - start >= PMD_SIZE) {
-
-		/*
-		 * We cannot use a 1G page so allocate a PMD page if needed.
-		 */
-		if (pud_none(*pud))
-			if (alloc_pmd_page(pud))
-				return -1;
-
-		pmd = pmd_offset(pud, start);
-
-		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
-					canon_pgprot(pmd_pgprot))));
-
-		start	  += PMD_SIZE;
-		cpa->pfn  += PMD_SIZE >> PAGE_SHIFT;
-		cur_pages += PMD_SIZE >> PAGE_SHIFT;
-	}
-
-	/*
-	 * Map trailing 4K pages.
-	 */
-	if (start < end) {
-		pmd = pmd_offset(pud, start);
-		if (pmd_none(*pmd))
-			if (alloc_pte_page(pmd))
-				return -1;
-
-		populate_pte(cpa, start, end, num_pages - cur_pages,
-			     pmd, pgprot);
-	}
-	return num_pages;
-}
-
-static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
-			pgprot_t pgprot)
-{
-	pud_t *pud;
-	unsigned long end;
-	long cur_pages = 0;
-	pgprot_t pud_pgprot;
-
-	end = start + (cpa->numpages << PAGE_SHIFT);
-
-	/*
-	 * Not on a Gb page boundary? => map everything up to it with
-	 * smaller pages.
-	 */
-	if (start & (PUD_SIZE - 1)) {
-		unsigned long pre_end;
-		unsigned long next_page = (start + PUD_SIZE) & PUD_MASK;
-
-		pre_end   = min_t(unsigned long, end, next_page);
-		cur_pages = (pre_end - start) >> PAGE_SHIFT;
-		cur_pages = min_t(int, (int)cpa->numpages, cur_pages);
-
-		pud = pud_offset(p4d, start);
-
-		/*
-		 * Need a PMD page?
-		 */
-		if (pud_none(*pud))
-			if (alloc_pmd_page(pud))
-				return -1;
-
-		cur_pages = populate_pmd(cpa, start, pre_end, cur_pages,
-					 pud, pgprot);
-		if (cur_pages < 0)
-			return cur_pages;
-
-		start = pre_end;
-	}
-
-	/* We mapped them all? */
-	if (cpa->numpages == cur_pages)
-		return cur_pages;
-
-	pud = pud_offset(p4d, start);
-	pud_pgprot = pgprot_4k_2_large(pgprot);
-
-	/*
-	 * Map everything starting from the Gb boundary, possibly with 1G pages
-	 */
-	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
-		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
-				   canon_pgprot(pud_pgprot))));
-
-		start	  += PUD_SIZE;
-		cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;
-		cur_pages += PUD_SIZE >> PAGE_SHIFT;
-		pud++;
-	}
-
-	/* Map trailing leftover */
-	if (start < end) {
-		long tmp;
-
-		pud = pud_offset(p4d, start);
-		if (pud_none(*pud))
-			if (alloc_pmd_page(pud))
-				return -1;
-
-		tmp = populate_pmd(cpa, start, end, cpa->numpages - cur_pages,
-				   pud, pgprot);
-		if (tmp < 0)
-			return cur_pages;
-
-		cur_pages += tmp;
-	}
-	return cur_pages;
-}
-
-/*
- * Restrictions for kernel page table do not necessarily apply when mapping in
- * an alternate PGD.
- */
-static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
-{
-	pgprot_t pgprot = __pgprot(_KERNPG_TABLE);
-	pud_t *pud = NULL;	/* shut up gcc */
-	p4d_t *p4d;
-	pgd_t *pgd_entry;
-	long ret;
-
-	pgd_entry = cpa->pgd + pgd_index(addr);
-
-	if (pgd_none(*pgd_entry)) {
-		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
-		if (!p4d)
-			return -1;
-
-		set_pgd(pgd_entry, __pgd(__pa(p4d) | _KERNPG_TABLE));
-	}
-
-	/*
-	 * Allocate a PUD page and hand it down for mapping.
-	 */
-	p4d = p4d_offset(pgd_entry, addr);
-	if (p4d_none(*p4d)) {
-		pud = (pud_t *)get_zeroed_page(GFP_KERNEL);
-		if (!pud)
-			return -1;
-
-		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
-	}
-
-	pgprot_val(pgprot) &= ~pgprot_val(cpa->mask_clr);
-	pgprot_val(pgprot) |=  pgprot_val(cpa->mask_set);
-
-	ret = populate_pud(cpa, addr, p4d, pgprot);
-	if (ret < 0) {
-		/*
-		 * Leave the PUD page in place in case some other CPU or thread
-		 * already found it, but remove any useless entries we just
-		 * added to it.
-		 */
-		unmap_pud_range(p4d, addr,
-				addr + (cpa->numpages << PAGE_SHIFT));
-		return ret;
-	}
-
-	cpa->numpages = ret;
-	return 0;
-}
-
-static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
-			       int primary)
-{
-	if (cpa->pgd) {
-		/*
-		 * Right now, we only execute this code path when mapping
-		 * the EFI virtual memory map regions, no other users
-		 * provide a ->pgd value. This may change in the future.
-		 */
-		return populate_pgd(cpa, vaddr);
-	}
-
-	/*
-	 * Ignore all non primary paths.
-	 */
-	if (!primary) {
-		cpa->numpages = 1;
-		return 0;
-	}
-
-	/*
-	 * Ignore the NULL PTE for kernel identity mapping, as it is expected
-	 * to have holes.
-	 * Also set numpages to '1' indicating that we processed cpa req for
-	 * one virtual address page and its pfn. TBD: numpages can be set based
-	 * on the initial value and the level returned by lookup_address().
-	 */
-	if (within(vaddr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT))) {
-		cpa->numpages = 1;
-		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
-		return 0;
-
-	} else if (__cpa_pfn_in_highmap(cpa->pfn)) {
-		/* Faults in the highmap are OK, so do not warn: */
-		return -EFAULT;
-	} else {
-		WARN(1, KERN_WARNING "CPA: called for zero pte. "
-			"vaddr = %lx cpa->vaddr = %lx\n", vaddr,
-			*cpa->vaddr);
-
-		return -EFAULT;
-	}
-}
-
-static int __change_page_attr(struct cpa_data *cpa, int primary)
-{
-	unsigned long address;
-	int do_split, err;
-	unsigned int level;
-	pte_t *kpte, old_pte;
-
-	address = __cpa_addr(cpa, cpa->curpage);
-repeat:
-	kpte = _lookup_address_cpa(cpa, address, &level);
-	if (!kpte)
-		return __cpa_process_fault(cpa, address, primary);
-
-	old_pte = *kpte;
-	if (pte_none(old_pte))
-		return __cpa_process_fault(cpa, address, primary);
-
-	if (level == PG_LEVEL_4K) {
-		pte_t new_pte;
-		pgprot_t new_prot = pte_pgprot(old_pte);
-		unsigned long pfn = pte_pfn(old_pte);
-
-		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
-		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
-
-		cpa_inc_4k_install();
-		/* Hand in lpsize = 0 to enforce the protection mechanism */
-		new_prot = static_protections(new_prot, address, pfn, 1, 0,
-					      CPA_PROTECT);
-
-		new_prot = pgprot_clear_protnone_bits(new_prot);
-
-		/*
-		 * We need to keep the pfn from the existing PTE,
-		 * after all we're only going to change it's attributes
-		 * not the memory it points to
-		 */
-		new_pte = pfn_pte(pfn, new_prot);
-		cpa->pfn = pfn;
-		/*
-		 * Do we really change anything ?
-		 */
-		if (pte_val(old_pte) != pte_val(new_pte)) {
-			set_pte_atomic(kpte, new_pte);
-			cpa->flags |= CPA_FLUSHTLB;
-		}
-		cpa->numpages = 1;
-		return 0;
-	}
-
-	/*
-	 * Check, whether we can keep the large page intact
-	 * and just change the pte:
-	 */
-	do_split = should_split_large_page(kpte, address, cpa);
-	/*
-	 * When the range fits into the existing large page,
-	 * return. cp->numpages and cpa->tlbflush have been updated in
-	 * try_large_page:
-	 */
-	if (do_split <= 0)
-		return do_split;
-
-	/*
-	 * We have to split the large page:
-	 */
-	err = split_large_page(cpa, kpte, address);
-	if (!err)
-		goto repeat;
-
-	return err;
-}
-
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
-
-static int cpa_process_alias(struct cpa_data *cpa)
-{
-	struct cpa_data alias_cpa;
-	unsigned long laddr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);
-	unsigned long vaddr;
-	int ret;
-
-	if (!pfn_range_is_mapped(cpa->pfn, cpa->pfn + 1))
-		return 0;
-
-	/*
-	 * No need to redo, when the primary call touched the direct
-	 * mapping already:
-	 */
-	vaddr = __cpa_addr(cpa, cpa->curpage);
-	if (!(within(vaddr, PAGE_OFFSET,
-		    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
-
-		alias_cpa = *cpa;
-		alias_cpa.vaddr = &laddr;
-		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
-		alias_cpa.curpage = 0;
-
-		ret = __change_page_attr_set_clr(&alias_cpa, 0);
-		if (ret)
-			return ret;
-	}
-
-#ifdef CONFIG_X86_64
-	/*
-	 * If the primary call didn't touch the high mapping already
-	 * and the physical address is inside the kernel map, we need
-	 * to touch the high mapped kernel as well:
-	 */
-	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
-	    __cpa_pfn_in_highmap(cpa->pfn)) {
-		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
-					       __START_KERNEL_map - phys_base;
-		alias_cpa = *cpa;
-		alias_cpa.vaddr = &temp_cpa_vaddr;
-		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
-		alias_cpa.curpage = 0;
-
-		/*
-		 * The high mapping range is imprecise, so ignore the
-		 * return value.
-		 */
-		__change_page_attr_set_clr(&alias_cpa, 0);
-	}
-#endif
-
-	return 0;
-}
-
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
-{
-	unsigned long numpages = cpa->numpages;
-	unsigned long rempages = numpages;
-	int ret = 0;
-
-	while (rempages) {
-		/*
-		 * Store the remaining nr of pages for the large page
-		 * preservation check.
-		 */
-		cpa->numpages = rempages;
-		/* for array changes, we can't use large page */
-		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
-			cpa->numpages = 1;
-
-		if (!debug_pagealloc_enabled())
-			spin_lock(&cpa_lock);
-		ret = __change_page_attr(cpa, checkalias);
-		if (!debug_pagealloc_enabled())
-			spin_unlock(&cpa_lock);
-		if (ret)
-			goto out;
-
-		if (checkalias) {
-			ret = cpa_process_alias(cpa);
-			if (ret)
-				goto out;
-		}
-
-		/*
-		 * Adjust the number of pages with the result of the
-		 * CPA operation. Either a large page has been
-		 * preserved or a single page update happened.
-		 */
-		BUG_ON(cpa->numpages > rempages || !cpa->numpages);
-		rempages -= cpa->numpages;
-		cpa->curpage += cpa->numpages;
-	}
-
-out:
-	/* Restore the original numpages */
-	cpa->numpages = numpages;
-	return ret;
-}
-
-static int change_page_attr_set_clr(unsigned long *addr, int numpages,
-				    pgprot_t mask_set, pgprot_t mask_clr,
-				    int force_split, int in_flag,
-				    struct page **pages)
-{
-	struct cpa_data cpa;
-	int ret, cache, checkalias;
-
-	memset(&cpa, 0, sizeof(cpa));
-
-	/*
-	 * Check, if we are requested to set a not supported
-	 * feature.  Clearing non-supported features is OK.
-	 */
-	mask_set = canon_pgprot(mask_set);
-
-	if (!pgprot_val(mask_set) && !pgprot_val(mask_clr) && !force_split)
-		return 0;
-
-	/* Ensure we are PAGE_SIZE aligned */
-	if (in_flag & CPA_ARRAY) {
-		int i;
-		for (i = 0; i < numpages; i++) {
-			if (addr[i] & ~PAGE_MASK) {
-				addr[i] &= PAGE_MASK;
-				WARN_ON_ONCE(1);
-			}
-		}
-	} else if (!(in_flag & CPA_PAGES_ARRAY)) {
-		/*
-		 * in_flag of CPA_PAGES_ARRAY implies it is aligned.
-		 * No need to check in that case
-		 */
-		if (*addr & ~PAGE_MASK) {
-			*addr &= PAGE_MASK;
-			/*
-			 * People should not be passing in unaligned addresses:
-			 */
-			WARN_ON_ONCE(1);
-		}
-	}
-
-	/* Must avoid aliasing mappings in the highmem code */
-	kmap_flush_unused();
-
-	vm_unmap_aliases();
-
-	cpa.vaddr = addr;
-	cpa.pages = pages;
-	cpa.numpages = numpages;
-	cpa.mask_set = mask_set;
-	cpa.mask_clr = mask_clr;
-	cpa.flags = 0;
-	cpa.curpage = 0;
-	cpa.force_split = force_split;
-
-	if (in_flag & (CPA_ARRAY | CPA_PAGES_ARRAY))
-		cpa.flags |= in_flag;
-
-	/* No alias checking for _NX bit modifications */
-	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
-	/* Has caller explicitly disabled alias checking? */
-	if (in_flag & CPA_NO_CHECK_ALIAS)
-		checkalias = 0;
-
-	ret = __change_page_attr_set_clr(&cpa, checkalias);
-
-	/*
-	 * Check whether we really changed something:
-	 */
-	if (!(cpa.flags & CPA_FLUSHTLB))
-		goto out;
-
-	/*
-	 * No need to flush, when we did not set any of the caching
-	 * attributes:
-	 */
-	cache = !!pgprot2cachemode(mask_set);
-
-	/*
-	 * On error; flush everything to be sure.
-	 */
-	if (ret) {
-		cpa_flush_all(cache);
-		goto out;
-	}
-
-	cpa_flush(&cpa, cache);
-out:
-	return ret;
-}
-
-static inline int change_page_attr_set(unsigned long *addr, int numpages,
-				       pgprot_t mask, int array)
-{
-	return change_page_attr_set_clr(addr, numpages, mask, __pgprot(0), 0,
-		(array ? CPA_ARRAY : 0), NULL);
-}
-
-static inline int change_page_attr_clear(unsigned long *addr, int numpages,
-					 pgprot_t mask, int array)
-{
-	return change_page_attr_set_clr(addr, numpages, __pgprot(0), mask, 0,
-		(array ? CPA_ARRAY : 0), NULL);
-}
-
-static inline int cpa_set_pages_array(struct page **pages, int numpages,
-				       pgprot_t mask)
-{
-	return change_page_attr_set_clr(NULL, numpages, mask, __pgprot(0), 0,
-		CPA_PAGES_ARRAY, pages);
-}
-
-static inline int cpa_clear_pages_array(struct page **pages, int numpages,
-					 pgprot_t mask)
-{
-	return change_page_attr_set_clr(NULL, numpages, __pgprot(0), mask, 0,
-		CPA_PAGES_ARRAY, pages);
-}
-
-int _set_memory_uc(unsigned long addr, int numpages)
-{
-	/*
-	 * for now UC MINUS. see comments in ioremap()
-	 * If you really need strong UC use ioremap_uc(), but note
-	 * that you cannot override IO areas with set_memory_*() as
-	 * these helpers cannot work with IO memory.
-	 */
-	return change_page_attr_set(&addr, numpages,
-				    cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
-				    0);
-}
-
-int set_memory_uc(unsigned long addr, int numpages)
-{
-	int ret;
-
-	/*
-	 * for now UC MINUS. see comments in ioremap()
-	 */
-	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
-			      _PAGE_CACHE_MODE_UC_MINUS, NULL);
-	if (ret)
-		goto out_err;
-
-	ret = _set_memory_uc(addr, numpages);
-	if (ret)
-		goto out_free;
-
-	return 0;
-
-out_free:
-	free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
-out_err:
-	return ret;
-}
-EXPORT_SYMBOL(set_memory_uc);
-
-int _set_memory_wc(unsigned long addr, int numpages)
-{
-	int ret;
-
-	ret = change_page_attr_set(&addr, numpages,
-				   cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
-				   0);
-	if (!ret) {
-		ret = change_page_attr_set_clr(&addr, numpages,
-					       cachemode2pgprot(_PAGE_CACHE_MODE_WC),
-					       __pgprot(_PAGE_CACHE_MASK),
-					       0, 0, NULL);
-	}
-	return ret;
-}
-
-int set_memory_wc(unsigned long addr, int numpages)
-{
-	int ret;
-
-	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
-		_PAGE_CACHE_MODE_WC, NULL);
-	if (ret)
-		return ret;
-
-	ret = _set_memory_wc(addr, numpages);
-	if (ret)
-		free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
-
-	return ret;
-}
-EXPORT_SYMBOL(set_memory_wc);
-
-int _set_memory_wt(unsigned long addr, int numpages)
-{
-	return change_page_attr_set(&addr, numpages,
-				    cachemode2pgprot(_PAGE_CACHE_MODE_WT), 0);
-}
-
-int _set_memory_wb(unsigned long addr, int numpages)
-{
-	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	return change_page_attr_clear(&addr, numpages,
-				      __pgprot(_PAGE_CACHE_MASK), 0);
-}
-
-int set_memory_wb(unsigned long addr, int numpages)
-{
-	int ret;
-
-	ret = _set_memory_wb(addr, numpages);
-	if (ret)
-		return ret;
-
-	free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
-	return 0;
-}
-EXPORT_SYMBOL(set_memory_wb);
-
-int set_memory_x(unsigned long addr, int numpages)
-{
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return 0;
-
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX), 0);
-}
-
-int set_memory_nx(unsigned long addr, int numpages)
-{
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return 0;
-
-	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX), 0);
-}
-
-int set_memory_ro(unsigned long addr, int numpages)
-{
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
-}
-
-int set_memory_rw(unsigned long addr, int numpages)
-{
-	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_RW), 0);
-}
-
-int set_memory_np(unsigned long addr, int numpages)
-{
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
-}
-
-int set_memory_np_noalias(unsigned long addr, int numpages)
-{
-	int cpa_flags = CPA_NO_CHECK_ALIAS;
-
-	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
-					__pgprot(_PAGE_PRESENT), 0,
-					cpa_flags, NULL);
-}
-
-int set_memory_4k(unsigned long addr, int numpages)
-{
-	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
-					__pgprot(0), 1, 0, NULL);
-}
-
-int set_memory_nonglobal(unsigned long addr, int numpages)
-{
-	return change_page_attr_clear(&addr, numpages,
-				      __pgprot(_PAGE_GLOBAL), 0);
-}
-
-int set_memory_global(unsigned long addr, int numpages)
-{
-	return change_page_attr_set(&addr, numpages,
-				    __pgprot(_PAGE_GLOBAL), 0);
-}
-
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-{
-	struct cpa_data cpa;
-	int ret;
-
-	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
-		return 0;
-
-	/* Should not be working on unaligned addresses */
-	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
-		addr &= PAGE_MASK;
-
-	memset(&cpa, 0, sizeof(cpa));
-	cpa.vaddr = &addr;
-	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
-	cpa.pgd = init_mm.pgd;
-
-	/* Must avoid aliasing mappings in the highmem code */
-	kmap_flush_unused();
-	vm_unmap_aliases();
-
-	/*
-	 * Before changing the encryption attribute, we need to flush caches.
-	 */
-	cpa_flush(&cpa, 1);
-
-	ret = __change_page_attr_set_clr(&cpa, 1);
-
-	/*
-	 * After changing the encryption attribute, we need to flush TLBs again
-	 * in case any speculative TLB caching occurred (but no need to flush
-	 * caches again).  We could just use cpa_flush_all(), but in case TLB
-	 * flushing gets optimized in the cpa_flush() path use the same logic
-	 * as above.
-	 */
-	cpa_flush(&cpa, 0);
-
-	return ret;
-}
-
-int set_memory_encrypted(unsigned long addr, int numpages)
-{
-	return __set_memory_enc_dec(addr, numpages, true);
-}
-EXPORT_SYMBOL_GPL(set_memory_encrypted);
-
-int set_memory_decrypted(unsigned long addr, int numpages)
-{
-	return __set_memory_enc_dec(addr, numpages, false);
-}
-EXPORT_SYMBOL_GPL(set_memory_decrypted);
-
-int set_pages_uc(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_uc(addr, numpages);
-}
-EXPORT_SYMBOL(set_pages_uc);
-
-static int _set_pages_array(struct page **pages, int numpages,
-		enum page_cache_mode new_type)
-{
-	unsigned long start;
-	unsigned long end;
-	enum page_cache_mode set_type;
-	int i;
-	int free_idx;
-	int ret;
-
-	for (i = 0; i < numpages; i++) {
-		if (PageHighMem(pages[i]))
-			continue;
-		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
-		end = start + PAGE_SIZE;
-		if (reserve_memtype(start, end, new_type, NULL))
-			goto err_out;
-	}
-
-	/* If WC, set to UC- first and then WC */
-	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
-				_PAGE_CACHE_MODE_UC_MINUS : new_type;
-
-	ret = cpa_set_pages_array(pages, numpages,
-				  cachemode2pgprot(set_type));
-	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(NULL, numpages,
-					       cachemode2pgprot(
-						_PAGE_CACHE_MODE_WC),
-					       __pgprot(_PAGE_CACHE_MASK),
-					       0, CPA_PAGES_ARRAY, pages);
-	if (ret)
-		goto err_out;
-	return 0; /* Success */
-err_out:
-	free_idx = i;
-	for (i = 0; i < free_idx; i++) {
-		if (PageHighMem(pages[i]))
-			continue;
-		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
-		end = start + PAGE_SIZE;
-		free_memtype(start, end);
-	}
-	return -EINVAL;
-}
-
-int set_pages_array_uc(struct page **pages, int numpages)
-{
-	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_UC_MINUS);
-}
-EXPORT_SYMBOL(set_pages_array_uc);
-
-int set_pages_array_wc(struct page **pages, int numpages)
-{
-	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WC);
-}
-EXPORT_SYMBOL(set_pages_array_wc);
-
-int set_pages_array_wt(struct page **pages, int numpages)
-{
-	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
-}
-EXPORT_SYMBOL_GPL(set_pages_array_wt);
-
-int set_pages_wb(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_wb(addr, numpages);
-}
-EXPORT_SYMBOL(set_pages_wb);
-
-int set_pages_array_wb(struct page **pages, int numpages)
-{
-	int retval;
-	unsigned long start;
-	unsigned long end;
-	int i;
-
-	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	retval = cpa_clear_pages_array(pages, numpages,
-			__pgprot(_PAGE_CACHE_MASK));
-	if (retval)
-		return retval;
-
-	for (i = 0; i < numpages; i++) {
-		if (PageHighMem(pages[i]))
-			continue;
-		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
-		end = start + PAGE_SIZE;
-		free_memtype(start, end);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(set_pages_array_wb);
-
-int set_pages_ro(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_ro(addr, numpages);
-}
-
-int set_pages_rw(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_rw(addr, numpages);
-}
-
-static int __set_pages_p(struct page *page, int numpages)
-{
-	unsigned long tempaddr = (unsigned long) page_address(page);
-	struct cpa_data cpa = { .vaddr = &tempaddr,
-				.pgd = NULL,
-				.numpages = numpages,
-				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
-				.mask_clr = __pgprot(0),
-				.flags = 0};
-
-	/*
-	 * No alias checking needed for setting present flag. otherwise,
-	 * we may need to break large pages for 64-bit kernel text
-	 * mappings (this adds to complexity if we want to do this from
-	 * atomic context especially). Let's keep it simple!
-	 */
-	return __change_page_attr_set_clr(&cpa, 0);
-}
-
-static int __set_pages_np(struct page *page, int numpages)
-{
-	unsigned long tempaddr = (unsigned long) page_address(page);
-	struct cpa_data cpa = { .vaddr = &tempaddr,
-				.pgd = NULL,
-				.numpages = numpages,
-				.mask_set = __pgprot(0),
-				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
-				.flags = 0};
-
-	/*
-	 * No alias checking needed for setting not present flag. otherwise,
-	 * we may need to break large pages for 64-bit kernel text
-	 * mappings (this adds to complexity if we want to do this from
-	 * atomic context especially). Let's keep it simple!
-	 */
-	return __change_page_attr_set_clr(&cpa, 0);
-}
-
-int set_direct_map_invalid_noflush(struct page *page)
-{
-	return __set_pages_np(page, 1);
-}
-
-int set_direct_map_default_noflush(struct page *page)
-{
-	return __set_pages_p(page, 1);
-}
-
-void __kernel_map_pages(struct page *page, int numpages, int enable)
-{
-	if (PageHighMem(page))
-		return;
-	if (!enable) {
-		debug_check_no_locks_freed(page_address(page),
-					   numpages * PAGE_SIZE);
-	}
-
-	/*
-	 * The return value is ignored as the calls cannot fail.
-	 * Large pages for identity mappings are not used at boot time
-	 * and hence no memory allocations during large page split.
-	 */
-	if (enable)
-		__set_pages_p(page, numpages);
-	else
-		__set_pages_np(page, numpages);
-
-	/*
-	 * We should perform an IPI and flush all tlbs,
-	 * but that can deadlock->flush only current cpu.
-	 * Preemption needs to be disabled around __flush_tlb_all() due to
-	 * CR3 reload in __native_flush_tlb().
-	 */
-	preempt_disable();
-	__flush_tlb_all();
-	preempt_enable();
-
-	arch_flush_lazy_mmu_mode();
-}
-
-#ifdef CONFIG_HIBERNATION
-bool kernel_page_present(struct page *page)
-{
-	unsigned int level;
-	pte_t *pte;
-
-	if (PageHighMem(page))
-		return false;
-
-	pte = lookup_address((unsigned long)page_address(page), &level);
-	return (pte_val(*pte) & _PAGE_PRESENT);
-}
-#endif /* CONFIG_HIBERNATION */
-
-int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-				   unsigned numpages, unsigned long page_flags)
-{
-	int retval = -EINVAL;
-
-	struct cpa_data cpa = {
-		.vaddr = &address,
-		.pfn = pfn,
-		.pgd = pgd,
-		.numpages = numpages,
-		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(0),
-		.flags = 0,
-	};
-
-	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
-
-	if (!(__supported_pte_mask & _PAGE_NX))
-		goto out;
-
-	if (!(page_flags & _PAGE_NX))
-		cpa.mask_clr = __pgprot(_PAGE_NX);
-
-	if (!(page_flags & _PAGE_RW))
-		cpa.mask_clr = __pgprot(_PAGE_RW);
-
-	if (!(page_flags & _PAGE_ENC))
-		cpa.mask_clr = pgprot_encrypted(cpa.mask_clr);
-
-	cpa.mask_set = __pgprot(_PAGE_PRESENT | page_flags);
-
-	retval = __change_page_attr_set_clr(&cpa, 0);
-	__flush_tlb_all();
-
-out:
-	return retval;
-}
-
-/*
- * __flush_tlb_all() flushes mappings only on current CPU and hence this
- * function shouldn't be used in an SMP environment. Presently, it's used only
- * during boot (way before smp_init()) by EFI subsystem and hence is ok.
- */
-int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
-				     unsigned long numpages)
-{
-	int retval;
-
-	/*
-	 * The typical sequence for unmapping is to find a pte through
-	 * lookup_address_in_pgd() (ideally, it should never return NULL because
-	 * the address is already mapped) and change it's protections. As pfn is
-	 * the *target* of a mapping, it's not useful while unmapping.
-	 */
-	struct cpa_data cpa = {
-		.vaddr		= &address,
-		.pfn		= 0,
-		.pgd		= pgd,
-		.numpages	= numpages,
-		.mask_set	= __pgprot(0),
-		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
-		.flags		= 0,
-	};
-
-	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
-
-	retval = __change_page_attr_set_clr(&cpa, 0);
-	__flush_tlb_all();
-
-	return retval;
-}
-
-/*
- * The testcases use internal knowledge of the implementation that shouldn't
- * be exposed to the rest of the kernel. Include these directly here.
- */
-#ifdef CONFIG_CPA_DEBUG
-#include "pageattr-test.c"
-#endif
diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
deleted file mode 100644
index f1677fa..0000000
--- a/arch/x86/mm/pat.c
+++ /dev/null
@@ -1,1219 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Page Attribute Table (PAT) support: handle memory caching attributes in page tables.
- *
- * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- *          Suresh B Siddha <suresh.b.siddha@intel.com>
- *
- * Loosely based on earlier PAT patchset from Eric Biederman and Andi Kleen.
- *
- * Basic principles:
- *
- * PAT is a CPU feature supported by all modern x86 CPUs, to allow the firmware and
- * the kernel to set one of a handful of 'caching type' attributes for physical
- * memory ranges: uncached, write-combining, write-through, write-protected,
- * and the most commonly used and default attribute: write-back caching.
- *
- * PAT support supercedes and augments MTRR support in a compatible fashion: MTRR is
- * a hardware interface to enumerate a limited number of physical memory ranges
- * and set their caching attributes explicitly, programmed into the CPU via MSRs.
- * Even modern CPUs have MTRRs enabled - but these are typically not touched
- * by the kernel or by user-space (such as the X server), we rely on PAT for any
- * additional cache attribute logic.
- *
- * PAT doesn't work via explicit memory ranges, but uses page table entries to add
- * cache attribute information to the mapped memory range: there's 3 bits used,
- * (_PAGE_PWT, _PAGE_PCD, _PAGE_PAT), with the 8 possible values mapped by the
- * CPU to actual cache attributes via an MSR loaded into the CPU (MSR_IA32_CR_PAT).
- *
- * ( There's a metric ton of finer details, such as compatibility with CPU quirks
- *   that only support 4 types of PAT entries, and interaction with MTRRs, see
- *   below for details. )
- */
-
-#include <linux/seq_file.h>
-#include <linux/memblock.h>
-#include <linux/debugfs.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/pfn_t.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-#include <linux/fs.h>
-#include <linux/rbtree.h>
-
-#include <asm/cacheflush.h>
-#include <asm/processor.h>
-#include <asm/tlbflush.h>
-#include <asm/x86_init.h>
-#include <asm/pgtable.h>
-#include <asm/fcntl.h>
-#include <asm/e820/api.h>
-#include <asm/mtrr.h>
-#include <asm/page.h>
-#include <asm/msr.h>
-#include <asm/pat.h>
-#include <asm/io.h>
-
-#include "pat_internal.h"
-#include "mm_internal.h"
-
-#undef pr_fmt
-#define pr_fmt(fmt) "" fmt
-
-static bool __read_mostly pat_bp_initialized;
-static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
-static bool __read_mostly pat_bp_enabled;
-static bool __read_mostly pat_cm_initialized;
-
-/*
- * PAT support is enabled by default, but can be disabled for
- * various user-requested or hardware-forced reasons:
- */
-void pat_disable(const char *msg_reason)
-{
-	if (pat_disabled)
-		return;
-
-	if (pat_bp_initialized) {
-		WARN_ONCE(1, "x86/PAT: PAT cannot be disabled after initialization\n");
-		return;
-	}
-
-	pat_disabled = true;
-	pr_info("x86/PAT: %s\n", msg_reason);
-}
-
-static int __init nopat(char *str)
-{
-	pat_disable("PAT support disabled via boot option.");
-	return 0;
-}
-early_param("nopat", nopat);
-
-bool pat_enabled(void)
-{
-	return pat_bp_enabled;
-}
-EXPORT_SYMBOL_GPL(pat_enabled);
-
-int pat_debug_enable;
-
-static int __init pat_debug_setup(char *str)
-{
-	pat_debug_enable = 1;
-	return 0;
-}
-__setup("debugpat", pat_debug_setup);
-
-#ifdef CONFIG_X86_PAT
-/*
- * X86 PAT uses page flags arch_1 and uncached together to keep track of
- * memory type of pages that have backing page struct.
- *
- * X86 PAT supports 4 different memory types:
- *  - _PAGE_CACHE_MODE_WB
- *  - _PAGE_CACHE_MODE_WC
- *  - _PAGE_CACHE_MODE_UC_MINUS
- *  - _PAGE_CACHE_MODE_WT
- *
- * _PAGE_CACHE_MODE_WB is the default type.
- */
-
-#define _PGMT_WB		0
-#define _PGMT_WC		(1UL << PG_arch_1)
-#define _PGMT_UC_MINUS		(1UL << PG_uncached)
-#define _PGMT_WT		(1UL << PG_uncached | 1UL << PG_arch_1)
-#define _PGMT_MASK		(1UL << PG_uncached | 1UL << PG_arch_1)
-#define _PGMT_CLEAR_MASK	(~_PGMT_MASK)
-
-static inline enum page_cache_mode get_page_memtype(struct page *pg)
-{
-	unsigned long pg_flags = pg->flags & _PGMT_MASK;
-
-	if (pg_flags == _PGMT_WB)
-		return _PAGE_CACHE_MODE_WB;
-	else if (pg_flags == _PGMT_WC)
-		return _PAGE_CACHE_MODE_WC;
-	else if (pg_flags == _PGMT_UC_MINUS)
-		return _PAGE_CACHE_MODE_UC_MINUS;
-	else
-		return _PAGE_CACHE_MODE_WT;
-}
-
-static inline void set_page_memtype(struct page *pg,
-				    enum page_cache_mode memtype)
-{
-	unsigned long memtype_flags;
-	unsigned long old_flags;
-	unsigned long new_flags;
-
-	switch (memtype) {
-	case _PAGE_CACHE_MODE_WC:
-		memtype_flags = _PGMT_WC;
-		break;
-	case _PAGE_CACHE_MODE_UC_MINUS:
-		memtype_flags = _PGMT_UC_MINUS;
-		break;
-	case _PAGE_CACHE_MODE_WT:
-		memtype_flags = _PGMT_WT;
-		break;
-	case _PAGE_CACHE_MODE_WB:
-	default:
-		memtype_flags = _PGMT_WB;
-		break;
-	}
-
-	do {
-		old_flags = pg->flags;
-		new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
-	} while (cmpxchg(&pg->flags, old_flags, new_flags) != old_flags);
-}
-#else
-static inline enum page_cache_mode get_page_memtype(struct page *pg)
-{
-	return -1;
-}
-static inline void set_page_memtype(struct page *pg,
-				    enum page_cache_mode memtype)
-{
-}
-#endif
-
-enum {
-	PAT_UC = 0,		/* uncached */
-	PAT_WC = 1,		/* Write combining */
-	PAT_WT = 4,		/* Write Through */
-	PAT_WP = 5,		/* Write Protected */
-	PAT_WB = 6,		/* Write Back (default) */
-	PAT_UC_MINUS = 7,	/* UC, but can be overridden by MTRR */
-};
-
-#define CM(c) (_PAGE_CACHE_MODE_ ## c)
-
-static enum page_cache_mode pat_get_cache_mode(unsigned pat_val, char *msg)
-{
-	enum page_cache_mode cache;
-	char *cache_mode;
-
-	switch (pat_val) {
-	case PAT_UC:       cache = CM(UC);       cache_mode = "UC  "; break;
-	case PAT_WC:       cache = CM(WC);       cache_mode = "WC  "; break;
-	case PAT_WT:       cache = CM(WT);       cache_mode = "WT  "; break;
-	case PAT_WP:       cache = CM(WP);       cache_mode = "WP  "; break;
-	case PAT_WB:       cache = CM(WB);       cache_mode = "WB  "; break;
-	case PAT_UC_MINUS: cache = CM(UC_MINUS); cache_mode = "UC- "; break;
-	default:           cache = CM(WB);       cache_mode = "WB  "; break;
-	}
-
-	memcpy(msg, cache_mode, 4);
-
-	return cache;
-}
-
-#undef CM
-
-/*
- * Update the cache mode to pgprot translation tables according to PAT
- * configuration.
- * Using lower indices is preferred, so we start with highest index.
- */
-static void __init_cache_modes(u64 pat)
-{
-	enum page_cache_mode cache;
-	char pat_msg[33];
-	int i;
-
-	WARN_ON_ONCE(pat_cm_initialized);
-
-	pat_msg[32] = 0;
-	for (i = 7; i >= 0; i--) {
-		cache = pat_get_cache_mode((pat >> (i * 8)) & 7,
-					   pat_msg + 4 * i);
-		update_cache_mode_entry(i, cache);
-	}
-	pr_info("x86/PAT: Configuration [0-7]: %s\n", pat_msg);
-
-	pat_cm_initialized = true;
-}
-
-#define PAT(x, y)	((u64)PAT_ ## y << ((x)*8))
-
-static void pat_bp_init(u64 pat)
-{
-	u64 tmp_pat;
-
-	if (!boot_cpu_has(X86_FEATURE_PAT)) {
-		pat_disable("PAT not supported by the CPU.");
-		return;
-	}
-
-	rdmsrl(MSR_IA32_CR_PAT, tmp_pat);
-	if (!tmp_pat) {
-		pat_disable("PAT support disabled by the firmware.");
-		return;
-	}
-
-	wrmsrl(MSR_IA32_CR_PAT, pat);
-	pat_bp_enabled = true;
-
-	__init_cache_modes(pat);
-}
-
-static void pat_ap_init(u64 pat)
-{
-	if (!boot_cpu_has(X86_FEATURE_PAT)) {
-		/*
-		 * If this happens we are on a secondary CPU, but switched to
-		 * PAT on the boot CPU. We have no way to undo PAT.
-		 */
-		panic("x86/PAT: PAT enabled, but not supported by secondary CPU\n");
-	}
-
-	wrmsrl(MSR_IA32_CR_PAT, pat);
-}
-
-void init_cache_modes(void)
-{
-	u64 pat = 0;
-
-	if (pat_cm_initialized)
-		return;
-
-	if (boot_cpu_has(X86_FEATURE_PAT)) {
-		/*
-		 * CPU supports PAT. Set PAT table to be consistent with
-		 * PAT MSR. This case supports "nopat" boot option, and
-		 * virtual machine environments which support PAT without
-		 * MTRRs. In specific, Xen has unique setup to PAT MSR.
-		 *
-		 * If PAT MSR returns 0, it is considered invalid and emulates
-		 * as No PAT.
-		 */
-		rdmsrl(MSR_IA32_CR_PAT, pat);
-	}
-
-	if (!pat) {
-		/*
-		 * No PAT. Emulate the PAT table that corresponds to the two
-		 * cache bits, PWT (Write Through) and PCD (Cache Disable).
-		 * This setup is also the same as the BIOS default setup.
-		 *
-		 * PTE encoding:
-		 *
-		 *       PCD
-		 *       |PWT  PAT
-		 *       ||    slot
-		 *       00    0    WB : _PAGE_CACHE_MODE_WB
-		 *       01    1    WT : _PAGE_CACHE_MODE_WT
-		 *       10    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
-		 *       11    3    UC : _PAGE_CACHE_MODE_UC
-		 *
-		 * NOTE: When WC or WP is used, it is redirected to UC- per
-		 * the default setup in __cachemode2pte_tbl[].
-		 */
-		pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
-		      PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
-	}
-
-	__init_cache_modes(pat);
-}
-
-/**
- * pat_init - Initialize the PAT MSR and PAT table on the current CPU
- *
- * This function initializes PAT MSR and PAT table with an OS-defined value
- * to enable additional cache attributes, WC, WT and WP.
- *
- * This function must be called on all CPUs using the specific sequence of
- * operations defined in Intel SDM. mtrr_rendezvous_handler() provides this
- * procedure for PAT.
- */
-void pat_init(void)
-{
-	u64 pat;
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-#ifndef CONFIG_X86_PAT
-	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
-#endif
-
-	if (pat_disabled)
-		return;
-
-	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
-	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
-	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
-		/*
-		 * PAT support with the lower four entries. Intel Pentium 2,
-		 * 3, M, and 4 are affected by PAT errata, which makes the
-		 * upper four entries unusable. To be on the safe side, we don't
-		 * use those.
-		 *
-		 *  PTE encoding:
-		 *      PAT
-		 *      |PCD
-		 *      ||PWT  PAT
-		 *      |||    slot
-		 *      000    0    WB : _PAGE_CACHE_MODE_WB
-		 *      001    1    WC : _PAGE_CACHE_MODE_WC
-		 *      010    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
-		 *      011    3    UC : _PAGE_CACHE_MODE_UC
-		 * PAT bit unused
-		 *
-		 * NOTE: When WT or WP is used, it is redirected to UC- per
-		 * the default setup in __cachemode2pte_tbl[].
-		 */
-		pat = PAT(0, WB) | PAT(1, WC) | PAT(2, UC_MINUS) | PAT(3, UC) |
-		      PAT(4, WB) | PAT(5, WC) | PAT(6, UC_MINUS) | PAT(7, UC);
-	} else {
-		/*
-		 * Full PAT support.  We put WT in slot 7 to improve
-		 * robustness in the presence of errata that might cause
-		 * the high PAT bit to be ignored.  This way, a buggy slot 7
-		 * access will hit slot 3, and slot 3 is UC, so at worst
-		 * we lose performance without causing a correctness issue.
-		 * Pentium 4 erratum N46 is an example for such an erratum,
-		 * although we try not to use PAT at all on affected CPUs.
-		 *
-		 *  PTE encoding:
-		 *      PAT
-		 *      |PCD
-		 *      ||PWT  PAT
-		 *      |||    slot
-		 *      000    0    WB : _PAGE_CACHE_MODE_WB
-		 *      001    1    WC : _PAGE_CACHE_MODE_WC
-		 *      010    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
-		 *      011    3    UC : _PAGE_CACHE_MODE_UC
-		 *      100    4    WB : Reserved
-		 *      101    5    WP : _PAGE_CACHE_MODE_WP
-		 *      110    6    UC-: Reserved
-		 *      111    7    WT : _PAGE_CACHE_MODE_WT
-		 *
-		 * The reserved slots are unused, but mapped to their
-		 * corresponding types in the presence of PAT errata.
-		 */
-		pat = PAT(0, WB) | PAT(1, WC) | PAT(2, UC_MINUS) | PAT(3, UC) |
-		      PAT(4, WB) | PAT(5, WP) | PAT(6, UC_MINUS) | PAT(7, WT);
-	}
-
-	if (!pat_bp_initialized) {
-		pat_bp_init(pat);
-		pat_bp_initialized = true;
-	} else {
-		pat_ap_init(pat);
-	}
-}
-
-#undef PAT
-
-static DEFINE_SPINLOCK(memtype_lock);	/* protects memtype accesses */
-
-/*
- * Does intersection of PAT memory type and MTRR memory type and returns
- * the resulting memory type as PAT understands it.
- * (Type in pat and mtrr will not have same value)
- * The intersection is based on "Effective Memory Type" tables in IA-32
- * SDM vol 3a
- */
-static unsigned long pat_x_mtrr_type(u64 start, u64 end,
-				     enum page_cache_mode req_type)
-{
-	/*
-	 * Look for MTRR hint to get the effective type in case where PAT
-	 * request is for WB.
-	 */
-	if (req_type == _PAGE_CACHE_MODE_WB) {
-		u8 mtrr_type, uniform;
-
-		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK)
-			return _PAGE_CACHE_MODE_UC_MINUS;
-
-		return _PAGE_CACHE_MODE_WB;
-	}
-
-	return req_type;
-}
-
-struct pagerange_state {
-	unsigned long		cur_pfn;
-	int			ram;
-	int			not_ram;
-};
-
-static int
-pagerange_is_ram_callback(unsigned long initial_pfn, unsigned long total_nr_pages, void *arg)
-{
-	struct pagerange_state *state = arg;
-
-	state->not_ram	|= initial_pfn > state->cur_pfn;
-	state->ram	|= total_nr_pages > 0;
-	state->cur_pfn	 = initial_pfn + total_nr_pages;
-
-	return state->ram && state->not_ram;
-}
-
-static int pat_pagerange_is_ram(resource_size_t start, resource_size_t end)
-{
-	int ret = 0;
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long end_pfn = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	struct pagerange_state state = {start_pfn, 0, 0};
-
-	/*
-	 * For legacy reasons, physical address range in the legacy ISA
-	 * region is tracked as non-RAM. This will allow users of
-	 * /dev/mem to map portions of legacy ISA region, even when
-	 * some of those portions are listed(or not even listed) with
-	 * different e820 types(RAM/reserved/..)
-	 */
-	if (start_pfn < ISA_END_ADDRESS >> PAGE_SHIFT)
-		start_pfn = ISA_END_ADDRESS >> PAGE_SHIFT;
-
-	if (start_pfn < end_pfn) {
-		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
-				&state, pagerange_is_ram_callback);
-	}
-
-	return (ret > 0) ? -1 : (state.ram ? 1 : 0);
-}
-
-/*
- * For RAM pages, we use page flags to mark the pages with appropriate type.
- * The page flags are limited to four types, WB (default), WC, WT and UC-.
- * WP request fails with -EINVAL, and UC gets redirected to UC-.  Setting
- * a new memory type is only allowed for a page mapped with the default WB
- * type.
- *
- * Here we do two passes:
- * - Find the memtype of all the pages in the range, look for any conflicts.
- * - In case of no conflicts, set the new memtype for pages in the range.
- */
-static int reserve_ram_pages_type(u64 start, u64 end,
-				  enum page_cache_mode req_type,
-				  enum page_cache_mode *new_type)
-{
-	struct page *page;
-	u64 pfn;
-
-	if (req_type == _PAGE_CACHE_MODE_WP) {
-		if (new_type)
-			*new_type = _PAGE_CACHE_MODE_UC_MINUS;
-		return -EINVAL;
-	}
-
-	if (req_type == _PAGE_CACHE_MODE_UC) {
-		/* We do not support strong UC */
-		WARN_ON_ONCE(1);
-		req_type = _PAGE_CACHE_MODE_UC_MINUS;
-	}
-
-	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
-		enum page_cache_mode type;
-
-		page = pfn_to_page(pfn);
-		type = get_page_memtype(page);
-		if (type != _PAGE_CACHE_MODE_WB) {
-			pr_info("x86/PAT: reserve_ram_pages_type failed [mem %#010Lx-%#010Lx], track 0x%x, req 0x%x\n",
-				start, end - 1, type, req_type);
-			if (new_type)
-				*new_type = type;
-
-			return -EBUSY;
-		}
-	}
-
-	if (new_type)
-		*new_type = req_type;
-
-	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
-		page = pfn_to_page(pfn);
-		set_page_memtype(page, req_type);
-	}
-	return 0;
-}
-
-static int free_ram_pages_type(u64 start, u64 end)
-{
-	struct page *page;
-	u64 pfn;
-
-	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
-		page = pfn_to_page(pfn);
-		set_page_memtype(page, _PAGE_CACHE_MODE_WB);
-	}
-	return 0;
-}
-
-static u64 sanitize_phys(u64 address)
-{
-	/*
-	 * When changing the memtype for pages containing poison allow
-	 * for a "decoy" virtual address (bit 63 clear) passed to
-	 * set_memory_X(). __pa() on a "decoy" address results in a
-	 * physical address with bit 63 set.
-	 *
-	 * Decoy addresses are not present for 32-bit builds, see
-	 * set_mce_nospec().
-	 */
-	if (IS_ENABLED(CONFIG_X86_64))
-		return address & __PHYSICAL_MASK;
-	return address;
-}
-
-/*
- * req_type typically has one of the:
- * - _PAGE_CACHE_MODE_WB
- * - _PAGE_CACHE_MODE_WC
- * - _PAGE_CACHE_MODE_UC_MINUS
- * - _PAGE_CACHE_MODE_UC
- * - _PAGE_CACHE_MODE_WT
- *
- * If new_type is NULL, function will return an error if it cannot reserve the
- * region with req_type. If new_type is non-NULL, function will return
- * available type in new_type in case of no error. In case of any error
- * it will return a negative return value.
- */
-int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
-		    enum page_cache_mode *new_type)
-{
-	struct memtype *entry_new;
-	enum page_cache_mode actual_type;
-	int is_range_ram;
-	int err = 0;
-
-	start = sanitize_phys(start);
-	end = sanitize_phys(end);
-	if (start >= end) {
-		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
-				start, end - 1, cattr_name(req_type));
-		return -EINVAL;
-	}
-
-	if (!pat_enabled()) {
-		/* This is identical to page table setting without PAT */
-		if (new_type)
-			*new_type = req_type;
-		return 0;
-	}
-
-	/* Low ISA region is always mapped WB in page table. No need to track */
-	if (x86_platform.is_untracked_pat_range(start, end)) {
-		if (new_type)
-			*new_type = _PAGE_CACHE_MODE_WB;
-		return 0;
-	}
-
-	/*
-	 * Call mtrr_lookup to get the type hint. This is an
-	 * optimization for /dev/mem mmap'ers into WB memory (BIOS
-	 * tools and ACPI tools). Use WB request for WB memory and use
-	 * UC_MINUS otherwise.
-	 */
-	actual_type = pat_x_mtrr_type(start, end, req_type);
-
-	if (new_type)
-		*new_type = actual_type;
-
-	is_range_ram = pat_pagerange_is_ram(start, end);
-	if (is_range_ram == 1) {
-
-		err = reserve_ram_pages_type(start, end, req_type, new_type);
-
-		return err;
-	} else if (is_range_ram < 0) {
-		return -EINVAL;
-	}
-
-	entry_new = kzalloc(sizeof(struct memtype), GFP_KERNEL);
-	if (!entry_new)
-		return -ENOMEM;
-
-	entry_new->start = start;
-	entry_new->end	 = end;
-	entry_new->type	 = actual_type;
-
-	spin_lock(&memtype_lock);
-
-	err = memtype_check_insert(entry_new, new_type);
-	if (err) {
-		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
-			start, end - 1,
-			cattr_name(entry_new->type), cattr_name(req_type));
-		kfree(entry_new);
-		spin_unlock(&memtype_lock);
-
-		return err;
-	}
-
-	spin_unlock(&memtype_lock);
-
-	dprintk("reserve_memtype added [mem %#010Lx-%#010Lx], track %s, req %s, ret %s\n",
-		start, end - 1, cattr_name(entry_new->type), cattr_name(req_type),
-		new_type ? cattr_name(*new_type) : "-");
-
-	return err;
-}
-
-int free_memtype(u64 start, u64 end)
-{
-	int is_range_ram;
-	struct memtype *entry_old;
-
-	if (!pat_enabled())
-		return 0;
-
-	start = sanitize_phys(start);
-	end = sanitize_phys(end);
-
-	/* Low ISA region is always mapped WB. No need to track */
-	if (x86_platform.is_untracked_pat_range(start, end))
-		return 0;
-
-	is_range_ram = pat_pagerange_is_ram(start, end);
-	if (is_range_ram == 1)
-		return free_ram_pages_type(start, end);
-	if (is_range_ram < 0)
-		return -EINVAL;
-
-	spin_lock(&memtype_lock);
-	entry_old = memtype_erase(start, end);
-	spin_unlock(&memtype_lock);
-
-	if (IS_ERR(entry_old)) {
-		pr_info("x86/PAT: %s:%d freeing invalid memtype [mem %#010Lx-%#010Lx]\n",
-			current->comm, current->pid, start, end - 1);
-		return -EINVAL;
-	}
-
-	kfree(entry_old);
-
-	dprintk("free_memtype request [mem %#010Lx-%#010Lx]\n", start, end - 1);
-
-	return 0;
-}
-
-
-/**
- * lookup_memtype - Looksup the memory type for a physical address
- * @paddr: physical address of which memory type needs to be looked up
- *
- * Only to be called when PAT is enabled
- *
- * Returns _PAGE_CACHE_MODE_WB, _PAGE_CACHE_MODE_WC, _PAGE_CACHE_MODE_UC_MINUS
- * or _PAGE_CACHE_MODE_WT.
- */
-static enum page_cache_mode lookup_memtype(u64 paddr)
-{
-	enum page_cache_mode rettype = _PAGE_CACHE_MODE_WB;
-	struct memtype *entry;
-
-	if (x86_platform.is_untracked_pat_range(paddr, paddr + PAGE_SIZE))
-		return rettype;
-
-	if (pat_pagerange_is_ram(paddr, paddr + PAGE_SIZE)) {
-		struct page *page;
-
-		page = pfn_to_page(paddr >> PAGE_SHIFT);
-		return get_page_memtype(page);
-	}
-
-	spin_lock(&memtype_lock);
-
-	entry = memtype_lookup(paddr);
-	if (entry != NULL)
-		rettype = entry->type;
-	else
-		rettype = _PAGE_CACHE_MODE_UC_MINUS;
-
-	spin_unlock(&memtype_lock);
-
-	return rettype;
-}
-
-/**
- * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
- * of @pfn cannot be overridden by UC MTRR memory type.
- *
- * Only to be called when PAT is enabled.
- *
- * Returns true, if the PAT memory type of @pfn is UC, UC-, or WC.
- * Returns false in other cases.
- */
-bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
-{
-	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
-
-	return cm == _PAGE_CACHE_MODE_UC ||
-	       cm == _PAGE_CACHE_MODE_UC_MINUS ||
-	       cm == _PAGE_CACHE_MODE_WC;
-}
-EXPORT_SYMBOL_GPL(pat_pfn_immune_to_uc_mtrr);
-
-/**
- * io_reserve_memtype - Request a memory type mapping for a region of memory
- * @start: start (physical address) of the region
- * @end: end (physical address) of the region
- * @type: A pointer to memtype, with requested type. On success, requested
- * or any other compatible type that was available for the region is returned
- *
- * On success, returns 0
- * On failure, returns non-zero
- */
-int io_reserve_memtype(resource_size_t start, resource_size_t end,
-			enum page_cache_mode *type)
-{
-	resource_size_t size = end - start;
-	enum page_cache_mode req_type = *type;
-	enum page_cache_mode new_type;
-	int ret;
-
-	WARN_ON_ONCE(iomem_map_sanity_check(start, size));
-
-	ret = reserve_memtype(start, end, req_type, &new_type);
-	if (ret)
-		goto out_err;
-
-	if (!is_new_memtype_allowed(start, size, req_type, new_type))
-		goto out_free;
-
-	if (kernel_map_sync_memtype(start, size, new_type) < 0)
-		goto out_free;
-
-	*type = new_type;
-	return 0;
-
-out_free:
-	free_memtype(start, end);
-	ret = -EBUSY;
-out_err:
-	return ret;
-}
-
-/**
- * io_free_memtype - Release a memory type mapping for a region of memory
- * @start: start (physical address) of the region
- * @end: end (physical address) of the region
- */
-void io_free_memtype(resource_size_t start, resource_size_t end)
-{
-	free_memtype(start, end);
-}
-
-int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
-{
-	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
-
-	return io_reserve_memtype(start, start + size, &type);
-}
-EXPORT_SYMBOL(arch_io_reserve_memtype_wc);
-
-void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
-{
-	io_free_memtype(start, start + size);
-}
-EXPORT_SYMBOL(arch_io_free_memtype_wc);
-
-pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-				unsigned long size, pgprot_t vma_prot)
-{
-	if (!phys_mem_access_encrypted(pfn << PAGE_SHIFT, size))
-		vma_prot = pgprot_decrypted(vma_prot);
-
-	return vma_prot;
-}
-
-#ifdef CONFIG_STRICT_DEVMEM
-/* This check is done in drivers/char/mem.c in case of STRICT_DEVMEM */
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
-}
-#else
-/* This check is needed to avoid cache aliasing when PAT is enabled */
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	u64 from = ((u64)pfn) << PAGE_SHIFT;
-	u64 to = from + size;
-	u64 cursor = from;
-
-	if (!pat_enabled())
-		return 1;
-
-	while (cursor < to) {
-		if (!devmem_is_allowed(pfn))
-			return 0;
-		cursor += PAGE_SIZE;
-		pfn++;
-	}
-	return 1;
-}
-#endif /* CONFIG_STRICT_DEVMEM */
-
-int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
-				unsigned long size, pgprot_t *vma_prot)
-{
-	enum page_cache_mode pcm = _PAGE_CACHE_MODE_WB;
-
-	if (!range_is_allowed(pfn, size))
-		return 0;
-
-	if (file->f_flags & O_DSYNC)
-		pcm = _PAGE_CACHE_MODE_UC_MINUS;
-
-	*vma_prot = __pgprot((pgprot_val(*vma_prot) & ~_PAGE_CACHE_MASK) |
-			     cachemode2protval(pcm));
-	return 1;
-}
-
-/*
- * Change the memory type for the physical address range in kernel identity
- * mapping space if that range is a part of identity map.
- */
-int kernel_map_sync_memtype(u64 base, unsigned long size,
-			    enum page_cache_mode pcm)
-{
-	unsigned long id_sz;
-
-	if (base > __pa(high_memory-1))
-		return 0;
-
-	/*
-	 * Some areas in the middle of the kernel identity range
-	 * are not mapped, for example the PCI space.
-	 */
-	if (!page_is_ram(base >> PAGE_SHIFT))
-		return 0;
-
-	id_sz = (__pa(high_memory-1) <= base + size) ?
-				__pa(high_memory) - base : size;
-
-	if (ioremap_change_attr((unsigned long)__va(base), id_sz, pcm) < 0) {
-		pr_info("x86/PAT: %s:%d ioremap_change_attr failed %s for [mem %#010Lx-%#010Lx]\n",
-			current->comm, current->pid,
-			cattr_name(pcm),
-			base, (unsigned long long)(base + size-1));
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/*
- * Internal interface to reserve a range of physical memory with prot.
- * Reserved non RAM regions only and after successful reserve_memtype,
- * this func also keeps identity mapping (if any) in sync with this new prot.
- */
-static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
-				int strict_prot)
-{
-	int is_ram = 0;
-	int ret;
-	enum page_cache_mode want_pcm = pgprot2cachemode(*vma_prot);
-	enum page_cache_mode pcm = want_pcm;
-
-	is_ram = pat_pagerange_is_ram(paddr, paddr + size);
-
-	/*
-	 * reserve_pfn_range() for RAM pages. We do not refcount to keep
-	 * track of number of mappings of RAM pages. We can assert that
-	 * the type requested matches the type of first page in the range.
-	 */
-	if (is_ram) {
-		if (!pat_enabled())
-			return 0;
-
-		pcm = lookup_memtype(paddr);
-		if (want_pcm != pcm) {
-			pr_warn("x86/PAT: %s:%d map pfn RAM range req %s for [mem %#010Lx-%#010Lx], got %s\n",
-				current->comm, current->pid,
-				cattr_name(want_pcm),
-				(unsigned long long)paddr,
-				(unsigned long long)(paddr + size - 1),
-				cattr_name(pcm));
-			*vma_prot = __pgprot((pgprot_val(*vma_prot) &
-					     (~_PAGE_CACHE_MASK)) |
-					     cachemode2protval(pcm));
-		}
-		return 0;
-	}
-
-	ret = reserve_memtype(paddr, paddr + size, want_pcm, &pcm);
-	if (ret)
-		return ret;
-
-	if (pcm != want_pcm) {
-		if (strict_prot ||
-		    !is_new_memtype_allowed(paddr, size, want_pcm, pcm)) {
-			free_memtype(paddr, paddr + size);
-			pr_err("x86/PAT: %s:%d map pfn expected mapping type %s for [mem %#010Lx-%#010Lx], got %s\n",
-			       current->comm, current->pid,
-			       cattr_name(want_pcm),
-			       (unsigned long long)paddr,
-			       (unsigned long long)(paddr + size - 1),
-			       cattr_name(pcm));
-			return -EINVAL;
-		}
-		/*
-		 * We allow returning different type than the one requested in
-		 * non strict case.
-		 */
-		*vma_prot = __pgprot((pgprot_val(*vma_prot) &
-				      (~_PAGE_CACHE_MASK)) |
-				     cachemode2protval(pcm));
-	}
-
-	if (kernel_map_sync_memtype(paddr, size, pcm) < 0) {
-		free_memtype(paddr, paddr + size);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/*
- * Internal interface to free a range of physical memory.
- * Frees non RAM regions only.
- */
-static void free_pfn_range(u64 paddr, unsigned long size)
-{
-	int is_ram;
-
-	is_ram = pat_pagerange_is_ram(paddr, paddr + size);
-	if (is_ram == 0)
-		free_memtype(paddr, paddr + size);
-}
-
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
-{
-	resource_size_t paddr;
-	unsigned long prot;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
-	pgprot_t pgprot;
-
-	if (vma->vm_flags & VM_PAT) {
-		/*
-		 * reserve the whole chunk covered by vma. We need the
-		 * starting address and protection from pte.
-		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
-			return -EINVAL;
-		}
-		pgprot = __pgprot(prot);
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
-	}
-
-	return 0;
-}
-
-/*
- * prot is passed in as a parameter for the new mapping. If the vma has
- * a linear pfn mapping for the entire range, or no vma is provided,
- * reserve the entire pfn + size range with single reserve_pfn_range
- * call.
- */
-int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
-		    unsigned long pfn, unsigned long addr, unsigned long size)
-{
-	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
-	enum page_cache_mode pcm;
-
-	/* reserve the whole chunk starting from paddr */
-	if (!vma || (addr == vma->vm_start
-				&& size == (vma->vm_end - vma->vm_start))) {
-		int ret;
-
-		ret = reserve_pfn_range(paddr, size, prot, 0);
-		if (ret == 0 && vma)
-			vma->vm_flags |= VM_PAT;
-		return ret;
-	}
-
-	if (!pat_enabled())
-		return 0;
-
-	/*
-	 * For anything smaller than the vma size we set prot based on the
-	 * lookup.
-	 */
-	pcm = lookup_memtype(paddr);
-
-	/* Check memtype for the remaining pages */
-	while (size > PAGE_SIZE) {
-		size -= PAGE_SIZE;
-		paddr += PAGE_SIZE;
-		if (pcm != lookup_memtype(paddr))
-			return -EINVAL;
-	}
-
-	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
-			 cachemode2protval(pcm));
-
-	return 0;
-}
-
-void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
-{
-	enum page_cache_mode pcm;
-
-	if (!pat_enabled())
-		return;
-
-	/* Set prot based on lookup */
-	pcm = lookup_memtype(pfn_t_to_phys(pfn));
-	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
-			 cachemode2protval(pcm));
-}
-
-/*
- * untrack_pfn is called while unmapping a pfnmap for a region.
- * untrack can be called for a specific region indicated by pfn and size or
- * can be for the entire vma (in which case pfn, size are zero).
- */
-void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
-		 unsigned long size)
-{
-	resource_size_t paddr;
-	unsigned long prot;
-
-	if (vma && !(vma->vm_flags & VM_PAT))
-		return;
-
-	/* free the chunk starting from pfn or the whole chunk */
-	paddr = (resource_size_t)pfn << PAGE_SHIFT;
-	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
-			return;
-		}
-
-		size = vma->vm_end - vma->vm_start;
-	}
-	free_pfn_range(paddr, size);
-	if (vma)
-		vma->vm_flags &= ~VM_PAT;
-}
-
-/*
- * untrack_pfn_moved is called, while mremapping a pfnmap for a new region,
- * with the old vma after its pfnmap page table has been removed.  The new
- * vma has a new pfnmap to the same pfn & cache type with VM_PAT set.
- */
-void untrack_pfn_moved(struct vm_area_struct *vma)
-{
-	vma->vm_flags &= ~VM_PAT;
-}
-
-pgprot_t pgprot_writecombine(pgprot_t prot)
-{
-	return __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_WC));
-}
-EXPORT_SYMBOL_GPL(pgprot_writecombine);
-
-pgprot_t pgprot_writethrough(pgprot_t prot)
-{
-	return __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_WT));
-}
-EXPORT_SYMBOL_GPL(pgprot_writethrough);
-
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_X86_PAT)
-
-/*
- * We are allocating a temporary printout-entry to be passed
- * between seq_start()/next() and seq_show():
- */
-static struct memtype *memtype_get_idx(loff_t pos)
-{
-	struct memtype *entry_print;
-	int ret;
-
-	entry_print  = kzalloc(sizeof(struct memtype), GFP_KERNEL);
-	if (!entry_print)
-		return NULL;
-
-	spin_lock(&memtype_lock);
-	ret = memtype_copy_nth_element(entry_print, pos);
-	spin_unlock(&memtype_lock);
-
-	/* Free it on error: */
-	if (ret) {
-		kfree(entry_print);
-		return NULL;
-	}
-
-	return entry_print;
-}
-
-static void *memtype_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	if (*pos == 0) {
-		++*pos;
-		seq_puts(seq, "PAT memtype list:\n");
-	}
-
-	return memtype_get_idx(*pos);
-}
-
-static void *memtype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	++*pos;
-	return memtype_get_idx(*pos);
-}
-
-static void memtype_seq_stop(struct seq_file *seq, void *v)
-{
-}
-
-static int memtype_seq_show(struct seq_file *seq, void *v)
-{
-	struct memtype *entry_print = (struct memtype *)v;
-
-	seq_printf(seq, "PAT: [mem 0x%016Lx-0x%016Lx] %s\n",
-			entry_print->start,
-			entry_print->end,
-			cattr_name(entry_print->type));
-
-	kfree(entry_print);
-
-	return 0;
-}
-
-static const struct seq_operations memtype_seq_ops = {
-	.start = memtype_seq_start,
-	.next  = memtype_seq_next,
-	.stop  = memtype_seq_stop,
-	.show  = memtype_seq_show,
-};
-
-static int memtype_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &memtype_seq_ops);
-}
-
-static const struct file_operations memtype_fops = {
-	.open    = memtype_seq_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
-static int __init pat_memtype_list_init(void)
-{
-	if (pat_enabled()) {
-		debugfs_create_file("pat_memtype_list", S_IRUSR,
-				    arch_debugfs_dir, NULL, &memtype_fops);
-	}
-	return 0;
-}
-late_initcall(pat_memtype_list_init);
-
-#endif /* CONFIG_DEBUG_FS && CONFIG_X86_PAT */
diff --git a/arch/x86/mm/pat/Makefile b/arch/x86/mm/pat/Makefile
new file mode 100644
index 0000000..ea464c9
--- /dev/null
+++ b/arch/x86/mm/pat/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= set_memory.o memtype.o
+
+obj-$(CONFIG_X86_PAT)		+= memtype_interval.o
diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
new file mode 100644
index 0000000..facce27
--- /dev/null
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * self test for change_page_attr.
+ *
+ * Clears the a test pte bit on random pages in the direct mapping,
+ * then reverts and compares page tables forwards and afterwards.
+ */
+#include <linux/memblock.h>
+#include <linux/kthread.h>
+#include <linux/random.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+#include <asm/kdebug.h>
+
+/*
+ * Only print the results of the first pass:
+ */
+static __read_mostly int print = 1;
+
+enum {
+	NTEST			= 3 * 100,
+	NPAGES			= 100,
+#ifdef CONFIG_X86_64
+	LPS			= (1 << PMD_SHIFT),
+#elif defined(CONFIG_X86_PAE)
+	LPS			= (1 << PMD_SHIFT),
+#else
+	LPS			= (1 << 22),
+#endif
+	GPS			= (1<<30)
+};
+
+#define PAGE_CPA_TEST	__pgprot(_PAGE_CPA_TEST)
+
+static int pte_testbit(pte_t pte)
+{
+	return pte_flags(pte) & _PAGE_SOFTW1;
+}
+
+struct split_state {
+	long lpg, gpg, spg, exec;
+	long min_exec, max_exec;
+};
+
+static int print_split(struct split_state *s)
+{
+	long i, expected, missed = 0;
+	int err = 0;
+
+	s->lpg = s->gpg = s->spg = s->exec = 0;
+	s->min_exec = ~0UL;
+	s->max_exec = 0;
+	for (i = 0; i < max_pfn_mapped; ) {
+		unsigned long addr = (unsigned long)__va(i << PAGE_SHIFT);
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		if (!pte) {
+			missed++;
+			i++;
+			continue;
+		}
+
+		if (level == PG_LEVEL_1G && sizeof(long) == 8) {
+			s->gpg++;
+			i += GPS/PAGE_SIZE;
+		} else if (level == PG_LEVEL_2M) {
+			if ((pte_val(*pte) & _PAGE_PRESENT) && !(pte_val(*pte) & _PAGE_PSE)) {
+				printk(KERN_ERR
+					"%lx level %d but not PSE %Lx\n",
+					addr, level, (u64)pte_val(*pte));
+				err = 1;
+			}
+			s->lpg++;
+			i += LPS/PAGE_SIZE;
+		} else {
+			s->spg++;
+			i++;
+		}
+		if (!(pte_val(*pte) & _PAGE_NX)) {
+			s->exec++;
+			if (addr < s->min_exec)
+				s->min_exec = addr;
+			if (addr > s->max_exec)
+				s->max_exec = addr;
+		}
+	}
+	if (print) {
+		printk(KERN_INFO
+			" 4k %lu large %lu gb %lu x %lu[%lx-%lx] miss %lu\n",
+			s->spg, s->lpg, s->gpg, s->exec,
+			s->min_exec != ~0UL ? s->min_exec : 0,
+			s->max_exec, missed);
+	}
+
+	expected = (s->gpg*GPS + s->lpg*LPS)/PAGE_SIZE + s->spg + missed;
+	if (expected != i) {
+		printk(KERN_ERR "CPA max_pfn_mapped %lu but expected %lu\n",
+			max_pfn_mapped, expected);
+		return 1;
+	}
+	return err;
+}
+
+static unsigned long addr[NTEST];
+static unsigned int len[NTEST];
+
+static struct page *pages[NPAGES];
+static unsigned long addrs[NPAGES];
+
+/* Change the global bit on random pages in the direct mapping */
+static int pageattr_test(void)
+{
+	struct split_state sa, sb, sc;
+	unsigned long *bm;
+	pte_t *pte, pte0;
+	int failed = 0;
+	unsigned int level;
+	int i, k;
+	int err;
+
+	if (print)
+		printk(KERN_INFO "CPA self-test:\n");
+
+	bm = vzalloc((max_pfn_mapped + 7) / 8);
+	if (!bm) {
+		printk(KERN_ERR "CPA Cannot vmalloc bitmap\n");
+		return -ENOMEM;
+	}
+
+	failed += print_split(&sa);
+
+	for (i = 0; i < NTEST; i++) {
+		unsigned long pfn = prandom_u32() % max_pfn_mapped;
+
+		addr[i] = (unsigned long)__va(pfn << PAGE_SHIFT);
+		len[i] = prandom_u32() % NPAGES;
+		len[i] = min_t(unsigned long, len[i], max_pfn_mapped - pfn - 1);
+
+		if (len[i] == 0)
+			len[i] = 1;
+
+		pte = NULL;
+		pte0 = pfn_pte(0, __pgprot(0)); /* shut gcc up */
+
+		for (k = 0; k < len[i]; k++) {
+			pte = lookup_address(addr[i] + k*PAGE_SIZE, &level);
+			if (!pte || pgprot_val(pte_pgprot(*pte)) == 0 ||
+			    !(pte_val(*pte) & _PAGE_PRESENT)) {
+				addr[i] = 0;
+				break;
+			}
+			if (k == 0) {
+				pte0 = *pte;
+			} else {
+				if (pgprot_val(pte_pgprot(*pte)) !=
+					pgprot_val(pte_pgprot(pte0))) {
+					len[i] = k;
+					break;
+				}
+			}
+			if (test_bit(pfn + k, bm)) {
+				len[i] = k;
+				break;
+			}
+			__set_bit(pfn + k, bm);
+			addrs[k] = addr[i] + k*PAGE_SIZE;
+			pages[k] = pfn_to_page(pfn + k);
+		}
+		if (!addr[i] || !pte || !k) {
+			addr[i] = 0;
+			continue;
+		}
+
+		switch (i % 3) {
+		case 0:
+			err = change_page_attr_set(&addr[i], len[i], PAGE_CPA_TEST, 0);
+			break;
+
+		case 1:
+			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			break;
+
+		case 2:
+			err = cpa_set_pages_array(pages, len[i], PAGE_CPA_TEST);
+			break;
+		}
+
+
+		if (err < 0) {
+			printk(KERN_ERR "CPA %d failed %d\n", i, err);
+			failed++;
+		}
+
+		pte = lookup_address(addr[i], &level);
+		if (!pte || !pte_testbit(*pte) || pte_huge(*pte)) {
+			printk(KERN_ERR "CPA %lx: bad pte %Lx\n", addr[i],
+				pte ? (u64)pte_val(*pte) : 0ULL);
+			failed++;
+		}
+		if (level != PG_LEVEL_4K) {
+			printk(KERN_ERR "CPA %lx: unexpected level %d\n",
+				addr[i], level);
+			failed++;
+		}
+
+	}
+	vfree(bm);
+
+	failed += print_split(&sb);
+
+	for (i = 0; i < NTEST; i++) {
+		if (!addr[i])
+			continue;
+		pte = lookup_address(addr[i], &level);
+		if (!pte) {
+			printk(KERN_ERR "CPA lookup of %lx failed\n", addr[i]);
+			failed++;
+			continue;
+		}
+		err = change_page_attr_clear(&addr[i], len[i], PAGE_CPA_TEST, 0);
+		if (err < 0) {
+			printk(KERN_ERR "CPA reverting failed: %d\n", err);
+			failed++;
+		}
+		pte = lookup_address(addr[i], &level);
+		if (!pte || pte_testbit(*pte)) {
+			printk(KERN_ERR "CPA %lx: bad pte after revert %Lx\n",
+				addr[i], pte ? (u64)pte_val(*pte) : 0ULL);
+			failed++;
+		}
+
+	}
+
+	failed += print_split(&sc);
+
+	if (failed) {
+		WARN(1, KERN_ERR "NOT PASSED. Please report.\n");
+		return -EINVAL;
+	} else {
+		if (print)
+			printk(KERN_INFO "ok.\n");
+	}
+
+	return 0;
+}
+
+static int do_pageattr_test(void *__unused)
+{
+	while (!kthread_should_stop()) {
+		schedule_timeout_interruptible(HZ*30);
+		if (pageattr_test() < 0)
+			break;
+		if (print)
+			print--;
+	}
+	return 0;
+}
+
+static int start_pageattr_test(void)
+{
+	struct task_struct *p;
+
+	p = kthread_create(do_pageattr_test, NULL, "pageattr-test");
+	if (!IS_ERR(p))
+		wake_up_process(p);
+	else
+		WARN_ON(1);
+
+	return 0;
+}
+device_initcall(start_pageattr_test);
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
new file mode 100644
index 0000000..76532f0
--- /dev/null
+++ b/arch/x86/mm/pat/memtype.c
@@ -0,0 +1,1219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Page Attribute Table (PAT) support: handle memory caching attributes in page tables.
+ *
+ * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *          Suresh B Siddha <suresh.b.siddha@intel.com>
+ *
+ * Loosely based on earlier PAT patchset from Eric Biederman and Andi Kleen.
+ *
+ * Basic principles:
+ *
+ * PAT is a CPU feature supported by all modern x86 CPUs, to allow the firmware and
+ * the kernel to set one of a handful of 'caching type' attributes for physical
+ * memory ranges: uncached, write-combining, write-through, write-protected,
+ * and the most commonly used and default attribute: write-back caching.
+ *
+ * PAT support supercedes and augments MTRR support in a compatible fashion: MTRR is
+ * a hardware interface to enumerate a limited number of physical memory ranges
+ * and set their caching attributes explicitly, programmed into the CPU via MSRs.
+ * Even modern CPUs have MTRRs enabled - but these are typically not touched
+ * by the kernel or by user-space (such as the X server), we rely on PAT for any
+ * additional cache attribute logic.
+ *
+ * PAT doesn't work via explicit memory ranges, but uses page table entries to add
+ * cache attribute information to the mapped memory range: there's 3 bits used,
+ * (_PAGE_PWT, _PAGE_PCD, _PAGE_PAT), with the 8 possible values mapped by the
+ * CPU to actual cache attributes via an MSR loaded into the CPU (MSR_IA32_CR_PAT).
+ *
+ * ( There's a metric ton of finer details, such as compatibility with CPU quirks
+ *   that only support 4 types of PAT entries, and interaction with MTRRs, see
+ *   below for details. )
+ */
+
+#include <linux/seq_file.h>
+#include <linux/memblock.h>
+#include <linux/debugfs.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/pfn_t.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/rbtree.h>
+
+#include <asm/cacheflush.h>
+#include <asm/processor.h>
+#include <asm/tlbflush.h>
+#include <asm/x86_init.h>
+#include <asm/pgtable.h>
+#include <asm/fcntl.h>
+#include <asm/e820/api.h>
+#include <asm/mtrr.h>
+#include <asm/page.h>
+#include <asm/msr.h>
+#include <asm/pat.h>
+#include <asm/io.h>
+
+#include "memtype.h"
+#include "../mm_internal.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "" fmt
+
+static bool __read_mostly pat_bp_initialized;
+static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
+static bool __read_mostly pat_bp_enabled;
+static bool __read_mostly pat_cm_initialized;
+
+/*
+ * PAT support is enabled by default, but can be disabled for
+ * various user-requested or hardware-forced reasons:
+ */
+void pat_disable(const char *msg_reason)
+{
+	if (pat_disabled)
+		return;
+
+	if (pat_bp_initialized) {
+		WARN_ONCE(1, "x86/PAT: PAT cannot be disabled after initialization\n");
+		return;
+	}
+
+	pat_disabled = true;
+	pr_info("x86/PAT: %s\n", msg_reason);
+}
+
+static int __init nopat(char *str)
+{
+	pat_disable("PAT support disabled via boot option.");
+	return 0;
+}
+early_param("nopat", nopat);
+
+bool pat_enabled(void)
+{
+	return pat_bp_enabled;
+}
+EXPORT_SYMBOL_GPL(pat_enabled);
+
+int pat_debug_enable;
+
+static int __init pat_debug_setup(char *str)
+{
+	pat_debug_enable = 1;
+	return 0;
+}
+__setup("debugpat", pat_debug_setup);
+
+#ifdef CONFIG_X86_PAT
+/*
+ * X86 PAT uses page flags arch_1 and uncached together to keep track of
+ * memory type of pages that have backing page struct.
+ *
+ * X86 PAT supports 4 different memory types:
+ *  - _PAGE_CACHE_MODE_WB
+ *  - _PAGE_CACHE_MODE_WC
+ *  - _PAGE_CACHE_MODE_UC_MINUS
+ *  - _PAGE_CACHE_MODE_WT
+ *
+ * _PAGE_CACHE_MODE_WB is the default type.
+ */
+
+#define _PGMT_WB		0
+#define _PGMT_WC		(1UL << PG_arch_1)
+#define _PGMT_UC_MINUS		(1UL << PG_uncached)
+#define _PGMT_WT		(1UL << PG_uncached | 1UL << PG_arch_1)
+#define _PGMT_MASK		(1UL << PG_uncached | 1UL << PG_arch_1)
+#define _PGMT_CLEAR_MASK	(~_PGMT_MASK)
+
+static inline enum page_cache_mode get_page_memtype(struct page *pg)
+{
+	unsigned long pg_flags = pg->flags & _PGMT_MASK;
+
+	if (pg_flags == _PGMT_WB)
+		return _PAGE_CACHE_MODE_WB;
+	else if (pg_flags == _PGMT_WC)
+		return _PAGE_CACHE_MODE_WC;
+	else if (pg_flags == _PGMT_UC_MINUS)
+		return _PAGE_CACHE_MODE_UC_MINUS;
+	else
+		return _PAGE_CACHE_MODE_WT;
+}
+
+static inline void set_page_memtype(struct page *pg,
+				    enum page_cache_mode memtype)
+{
+	unsigned long memtype_flags;
+	unsigned long old_flags;
+	unsigned long new_flags;
+
+	switch (memtype) {
+	case _PAGE_CACHE_MODE_WC:
+		memtype_flags = _PGMT_WC;
+		break;
+	case _PAGE_CACHE_MODE_UC_MINUS:
+		memtype_flags = _PGMT_UC_MINUS;
+		break;
+	case _PAGE_CACHE_MODE_WT:
+		memtype_flags = _PGMT_WT;
+		break;
+	case _PAGE_CACHE_MODE_WB:
+	default:
+		memtype_flags = _PGMT_WB;
+		break;
+	}
+
+	do {
+		old_flags = pg->flags;
+		new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
+	} while (cmpxchg(&pg->flags, old_flags, new_flags) != old_flags);
+}
+#else
+static inline enum page_cache_mode get_page_memtype(struct page *pg)
+{
+	return -1;
+}
+static inline void set_page_memtype(struct page *pg,
+				    enum page_cache_mode memtype)
+{
+}
+#endif
+
+enum {
+	PAT_UC = 0,		/* uncached */
+	PAT_WC = 1,		/* Write combining */
+	PAT_WT = 4,		/* Write Through */
+	PAT_WP = 5,		/* Write Protected */
+	PAT_WB = 6,		/* Write Back (default) */
+	PAT_UC_MINUS = 7,	/* UC, but can be overridden by MTRR */
+};
+
+#define CM(c) (_PAGE_CACHE_MODE_ ## c)
+
+static enum page_cache_mode pat_get_cache_mode(unsigned pat_val, char *msg)
+{
+	enum page_cache_mode cache;
+	char *cache_mode;
+
+	switch (pat_val) {
+	case PAT_UC:       cache = CM(UC);       cache_mode = "UC  "; break;
+	case PAT_WC:       cache = CM(WC);       cache_mode = "WC  "; break;
+	case PAT_WT:       cache = CM(WT);       cache_mode = "WT  "; break;
+	case PAT_WP:       cache = CM(WP);       cache_mode = "WP  "; break;
+	case PAT_WB:       cache = CM(WB);       cache_mode = "WB  "; break;
+	case PAT_UC_MINUS: cache = CM(UC_MINUS); cache_mode = "UC- "; break;
+	default:           cache = CM(WB);       cache_mode = "WB  "; break;
+	}
+
+	memcpy(msg, cache_mode, 4);
+
+	return cache;
+}
+
+#undef CM
+
+/*
+ * Update the cache mode to pgprot translation tables according to PAT
+ * configuration.
+ * Using lower indices is preferred, so we start with highest index.
+ */
+static void __init_cache_modes(u64 pat)
+{
+	enum page_cache_mode cache;
+	char pat_msg[33];
+	int i;
+
+	WARN_ON_ONCE(pat_cm_initialized);
+
+	pat_msg[32] = 0;
+	for (i = 7; i >= 0; i--) {
+		cache = pat_get_cache_mode((pat >> (i * 8)) & 7,
+					   pat_msg + 4 * i);
+		update_cache_mode_entry(i, cache);
+	}
+	pr_info("x86/PAT: Configuration [0-7]: %s\n", pat_msg);
+
+	pat_cm_initialized = true;
+}
+
+#define PAT(x, y)	((u64)PAT_ ## y << ((x)*8))
+
+static void pat_bp_init(u64 pat)
+{
+	u64 tmp_pat;
+
+	if (!boot_cpu_has(X86_FEATURE_PAT)) {
+		pat_disable("PAT not supported by the CPU.");
+		return;
+	}
+
+	rdmsrl(MSR_IA32_CR_PAT, tmp_pat);
+	if (!tmp_pat) {
+		pat_disable("PAT support disabled by the firmware.");
+		return;
+	}
+
+	wrmsrl(MSR_IA32_CR_PAT, pat);
+	pat_bp_enabled = true;
+
+	__init_cache_modes(pat);
+}
+
+static void pat_ap_init(u64 pat)
+{
+	if (!boot_cpu_has(X86_FEATURE_PAT)) {
+		/*
+		 * If this happens we are on a secondary CPU, but switched to
+		 * PAT on the boot CPU. We have no way to undo PAT.
+		 */
+		panic("x86/PAT: PAT enabled, but not supported by secondary CPU\n");
+	}
+
+	wrmsrl(MSR_IA32_CR_PAT, pat);
+}
+
+void init_cache_modes(void)
+{
+	u64 pat = 0;
+
+	if (pat_cm_initialized)
+		return;
+
+	if (boot_cpu_has(X86_FEATURE_PAT)) {
+		/*
+		 * CPU supports PAT. Set PAT table to be consistent with
+		 * PAT MSR. This case supports "nopat" boot option, and
+		 * virtual machine environments which support PAT without
+		 * MTRRs. In specific, Xen has unique setup to PAT MSR.
+		 *
+		 * If PAT MSR returns 0, it is considered invalid and emulates
+		 * as No PAT.
+		 */
+		rdmsrl(MSR_IA32_CR_PAT, pat);
+	}
+
+	if (!pat) {
+		/*
+		 * No PAT. Emulate the PAT table that corresponds to the two
+		 * cache bits, PWT (Write Through) and PCD (Cache Disable).
+		 * This setup is also the same as the BIOS default setup.
+		 *
+		 * PTE encoding:
+		 *
+		 *       PCD
+		 *       |PWT  PAT
+		 *       ||    slot
+		 *       00    0    WB : _PAGE_CACHE_MODE_WB
+		 *       01    1    WT : _PAGE_CACHE_MODE_WT
+		 *       10    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
+		 *       11    3    UC : _PAGE_CACHE_MODE_UC
+		 *
+		 * NOTE: When WC or WP is used, it is redirected to UC- per
+		 * the default setup in __cachemode2pte_tbl[].
+		 */
+		pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
+		      PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
+	}
+
+	__init_cache_modes(pat);
+}
+
+/**
+ * pat_init - Initialize the PAT MSR and PAT table on the current CPU
+ *
+ * This function initializes PAT MSR and PAT table with an OS-defined value
+ * to enable additional cache attributes, WC, WT and WP.
+ *
+ * This function must be called on all CPUs using the specific sequence of
+ * operations defined in Intel SDM. mtrr_rendezvous_handler() provides this
+ * procedure for PAT.
+ */
+void pat_init(void)
+{
+	u64 pat;
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+#ifndef CONFIG_X86_PAT
+	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
+#endif
+
+	if (pat_disabled)
+		return;
+
+	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
+	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
+	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
+		/*
+		 * PAT support with the lower four entries. Intel Pentium 2,
+		 * 3, M, and 4 are affected by PAT errata, which makes the
+		 * upper four entries unusable. To be on the safe side, we don't
+		 * use those.
+		 *
+		 *  PTE encoding:
+		 *      PAT
+		 *      |PCD
+		 *      ||PWT  PAT
+		 *      |||    slot
+		 *      000    0    WB : _PAGE_CACHE_MODE_WB
+		 *      001    1    WC : _PAGE_CACHE_MODE_WC
+		 *      010    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
+		 *      011    3    UC : _PAGE_CACHE_MODE_UC
+		 * PAT bit unused
+		 *
+		 * NOTE: When WT or WP is used, it is redirected to UC- per
+		 * the default setup in __cachemode2pte_tbl[].
+		 */
+		pat = PAT(0, WB) | PAT(1, WC) | PAT(2, UC_MINUS) | PAT(3, UC) |
+		      PAT(4, WB) | PAT(5, WC) | PAT(6, UC_MINUS) | PAT(7, UC);
+	} else {
+		/*
+		 * Full PAT support.  We put WT in slot 7 to improve
+		 * robustness in the presence of errata that might cause
+		 * the high PAT bit to be ignored.  This way, a buggy slot 7
+		 * access will hit slot 3, and slot 3 is UC, so at worst
+		 * we lose performance without causing a correctness issue.
+		 * Pentium 4 erratum N46 is an example for such an erratum,
+		 * although we try not to use PAT at all on affected CPUs.
+		 *
+		 *  PTE encoding:
+		 *      PAT
+		 *      |PCD
+		 *      ||PWT  PAT
+		 *      |||    slot
+		 *      000    0    WB : _PAGE_CACHE_MODE_WB
+		 *      001    1    WC : _PAGE_CACHE_MODE_WC
+		 *      010    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
+		 *      011    3    UC : _PAGE_CACHE_MODE_UC
+		 *      100    4    WB : Reserved
+		 *      101    5    WP : _PAGE_CACHE_MODE_WP
+		 *      110    6    UC-: Reserved
+		 *      111    7    WT : _PAGE_CACHE_MODE_WT
+		 *
+		 * The reserved slots are unused, but mapped to their
+		 * corresponding types in the presence of PAT errata.
+		 */
+		pat = PAT(0, WB) | PAT(1, WC) | PAT(2, UC_MINUS) | PAT(3, UC) |
+		      PAT(4, WB) | PAT(5, WP) | PAT(6, UC_MINUS) | PAT(7, WT);
+	}
+
+	if (!pat_bp_initialized) {
+		pat_bp_init(pat);
+		pat_bp_initialized = true;
+	} else {
+		pat_ap_init(pat);
+	}
+}
+
+#undef PAT
+
+static DEFINE_SPINLOCK(memtype_lock);	/* protects memtype accesses */
+
+/*
+ * Does intersection of PAT memory type and MTRR memory type and returns
+ * the resulting memory type as PAT understands it.
+ * (Type in pat and mtrr will not have same value)
+ * The intersection is based on "Effective Memory Type" tables in IA-32
+ * SDM vol 3a
+ */
+static unsigned long pat_x_mtrr_type(u64 start, u64 end,
+				     enum page_cache_mode req_type)
+{
+	/*
+	 * Look for MTRR hint to get the effective type in case where PAT
+	 * request is for WB.
+	 */
+	if (req_type == _PAGE_CACHE_MODE_WB) {
+		u8 mtrr_type, uniform;
+
+		mtrr_type = mtrr_type_lookup(start, end, &uniform);
+		if (mtrr_type != MTRR_TYPE_WRBACK)
+			return _PAGE_CACHE_MODE_UC_MINUS;
+
+		return _PAGE_CACHE_MODE_WB;
+	}
+
+	return req_type;
+}
+
+struct pagerange_state {
+	unsigned long		cur_pfn;
+	int			ram;
+	int			not_ram;
+};
+
+static int
+pagerange_is_ram_callback(unsigned long initial_pfn, unsigned long total_nr_pages, void *arg)
+{
+	struct pagerange_state *state = arg;
+
+	state->not_ram	|= initial_pfn > state->cur_pfn;
+	state->ram	|= total_nr_pages > 0;
+	state->cur_pfn	 = initial_pfn + total_nr_pages;
+
+	return state->ram && state->not_ram;
+}
+
+static int pat_pagerange_is_ram(resource_size_t start, resource_size_t end)
+{
+	int ret = 0;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long end_pfn = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	struct pagerange_state state = {start_pfn, 0, 0};
+
+	/*
+	 * For legacy reasons, physical address range in the legacy ISA
+	 * region is tracked as non-RAM. This will allow users of
+	 * /dev/mem to map portions of legacy ISA region, even when
+	 * some of those portions are listed(or not even listed) with
+	 * different e820 types(RAM/reserved/..)
+	 */
+	if (start_pfn < ISA_END_ADDRESS >> PAGE_SHIFT)
+		start_pfn = ISA_END_ADDRESS >> PAGE_SHIFT;
+
+	if (start_pfn < end_pfn) {
+		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
+				&state, pagerange_is_ram_callback);
+	}
+
+	return (ret > 0) ? -1 : (state.ram ? 1 : 0);
+}
+
+/*
+ * For RAM pages, we use page flags to mark the pages with appropriate type.
+ * The page flags are limited to four types, WB (default), WC, WT and UC-.
+ * WP request fails with -EINVAL, and UC gets redirected to UC-.  Setting
+ * a new memory type is only allowed for a page mapped with the default WB
+ * type.
+ *
+ * Here we do two passes:
+ * - Find the memtype of all the pages in the range, look for any conflicts.
+ * - In case of no conflicts, set the new memtype for pages in the range.
+ */
+static int reserve_ram_pages_type(u64 start, u64 end,
+				  enum page_cache_mode req_type,
+				  enum page_cache_mode *new_type)
+{
+	struct page *page;
+	u64 pfn;
+
+	if (req_type == _PAGE_CACHE_MODE_WP) {
+		if (new_type)
+			*new_type = _PAGE_CACHE_MODE_UC_MINUS;
+		return -EINVAL;
+	}
+
+	if (req_type == _PAGE_CACHE_MODE_UC) {
+		/* We do not support strong UC */
+		WARN_ON_ONCE(1);
+		req_type = _PAGE_CACHE_MODE_UC_MINUS;
+	}
+
+	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
+		enum page_cache_mode type;
+
+		page = pfn_to_page(pfn);
+		type = get_page_memtype(page);
+		if (type != _PAGE_CACHE_MODE_WB) {
+			pr_info("x86/PAT: reserve_ram_pages_type failed [mem %#010Lx-%#010Lx], track 0x%x, req 0x%x\n",
+				start, end - 1, type, req_type);
+			if (new_type)
+				*new_type = type;
+
+			return -EBUSY;
+		}
+	}
+
+	if (new_type)
+		*new_type = req_type;
+
+	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
+		page = pfn_to_page(pfn);
+		set_page_memtype(page, req_type);
+	}
+	return 0;
+}
+
+static int free_ram_pages_type(u64 start, u64 end)
+{
+	struct page *page;
+	u64 pfn;
+
+	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
+		page = pfn_to_page(pfn);
+		set_page_memtype(page, _PAGE_CACHE_MODE_WB);
+	}
+	return 0;
+}
+
+static u64 sanitize_phys(u64 address)
+{
+	/*
+	 * When changing the memtype for pages containing poison allow
+	 * for a "decoy" virtual address (bit 63 clear) passed to
+	 * set_memory_X(). __pa() on a "decoy" address results in a
+	 * physical address with bit 63 set.
+	 *
+	 * Decoy addresses are not present for 32-bit builds, see
+	 * set_mce_nospec().
+	 */
+	if (IS_ENABLED(CONFIG_X86_64))
+		return address & __PHYSICAL_MASK;
+	return address;
+}
+
+/*
+ * req_type typically has one of the:
+ * - _PAGE_CACHE_MODE_WB
+ * - _PAGE_CACHE_MODE_WC
+ * - _PAGE_CACHE_MODE_UC_MINUS
+ * - _PAGE_CACHE_MODE_UC
+ * - _PAGE_CACHE_MODE_WT
+ *
+ * If new_type is NULL, function will return an error if it cannot reserve the
+ * region with req_type. If new_type is non-NULL, function will return
+ * available type in new_type in case of no error. In case of any error
+ * it will return a negative return value.
+ */
+int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
+		    enum page_cache_mode *new_type)
+{
+	struct memtype *entry_new;
+	enum page_cache_mode actual_type;
+	int is_range_ram;
+	int err = 0;
+
+	start = sanitize_phys(start);
+	end = sanitize_phys(end);
+	if (start >= end) {
+		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
+				start, end - 1, cattr_name(req_type));
+		return -EINVAL;
+	}
+
+	if (!pat_enabled()) {
+		/* This is identical to page table setting without PAT */
+		if (new_type)
+			*new_type = req_type;
+		return 0;
+	}
+
+	/* Low ISA region is always mapped WB in page table. No need to track */
+	if (x86_platform.is_untracked_pat_range(start, end)) {
+		if (new_type)
+			*new_type = _PAGE_CACHE_MODE_WB;
+		return 0;
+	}
+
+	/*
+	 * Call mtrr_lookup to get the type hint. This is an
+	 * optimization for /dev/mem mmap'ers into WB memory (BIOS
+	 * tools and ACPI tools). Use WB request for WB memory and use
+	 * UC_MINUS otherwise.
+	 */
+	actual_type = pat_x_mtrr_type(start, end, req_type);
+
+	if (new_type)
+		*new_type = actual_type;
+
+	is_range_ram = pat_pagerange_is_ram(start, end);
+	if (is_range_ram == 1) {
+
+		err = reserve_ram_pages_type(start, end, req_type, new_type);
+
+		return err;
+	} else if (is_range_ram < 0) {
+		return -EINVAL;
+	}
+
+	entry_new = kzalloc(sizeof(struct memtype), GFP_KERNEL);
+	if (!entry_new)
+		return -ENOMEM;
+
+	entry_new->start = start;
+	entry_new->end	 = end;
+	entry_new->type	 = actual_type;
+
+	spin_lock(&memtype_lock);
+
+	err = memtype_check_insert(entry_new, new_type);
+	if (err) {
+		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
+			start, end - 1,
+			cattr_name(entry_new->type), cattr_name(req_type));
+		kfree(entry_new);
+		spin_unlock(&memtype_lock);
+
+		return err;
+	}
+
+	spin_unlock(&memtype_lock);
+
+	dprintk("reserve_memtype added [mem %#010Lx-%#010Lx], track %s, req %s, ret %s\n",
+		start, end - 1, cattr_name(entry_new->type), cattr_name(req_type),
+		new_type ? cattr_name(*new_type) : "-");
+
+	return err;
+}
+
+int free_memtype(u64 start, u64 end)
+{
+	int is_range_ram;
+	struct memtype *entry_old;
+
+	if (!pat_enabled())
+		return 0;
+
+	start = sanitize_phys(start);
+	end = sanitize_phys(end);
+
+	/* Low ISA region is always mapped WB. No need to track */
+	if (x86_platform.is_untracked_pat_range(start, end))
+		return 0;
+
+	is_range_ram = pat_pagerange_is_ram(start, end);
+	if (is_range_ram == 1)
+		return free_ram_pages_type(start, end);
+	if (is_range_ram < 0)
+		return -EINVAL;
+
+	spin_lock(&memtype_lock);
+	entry_old = memtype_erase(start, end);
+	spin_unlock(&memtype_lock);
+
+	if (IS_ERR(entry_old)) {
+		pr_info("x86/PAT: %s:%d freeing invalid memtype [mem %#010Lx-%#010Lx]\n",
+			current->comm, current->pid, start, end - 1);
+		return -EINVAL;
+	}
+
+	kfree(entry_old);
+
+	dprintk("free_memtype request [mem %#010Lx-%#010Lx]\n", start, end - 1);
+
+	return 0;
+}
+
+
+/**
+ * lookup_memtype - Looksup the memory type for a physical address
+ * @paddr: physical address of which memory type needs to be looked up
+ *
+ * Only to be called when PAT is enabled
+ *
+ * Returns _PAGE_CACHE_MODE_WB, _PAGE_CACHE_MODE_WC, _PAGE_CACHE_MODE_UC_MINUS
+ * or _PAGE_CACHE_MODE_WT.
+ */
+static enum page_cache_mode lookup_memtype(u64 paddr)
+{
+	enum page_cache_mode rettype = _PAGE_CACHE_MODE_WB;
+	struct memtype *entry;
+
+	if (x86_platform.is_untracked_pat_range(paddr, paddr + PAGE_SIZE))
+		return rettype;
+
+	if (pat_pagerange_is_ram(paddr, paddr + PAGE_SIZE)) {
+		struct page *page;
+
+		page = pfn_to_page(paddr >> PAGE_SHIFT);
+		return get_page_memtype(page);
+	}
+
+	spin_lock(&memtype_lock);
+
+	entry = memtype_lookup(paddr);
+	if (entry != NULL)
+		rettype = entry->type;
+	else
+		rettype = _PAGE_CACHE_MODE_UC_MINUS;
+
+	spin_unlock(&memtype_lock);
+
+	return rettype;
+}
+
+/**
+ * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
+ * of @pfn cannot be overridden by UC MTRR memory type.
+ *
+ * Only to be called when PAT is enabled.
+ *
+ * Returns true, if the PAT memory type of @pfn is UC, UC-, or WC.
+ * Returns false in other cases.
+ */
+bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
+{
+	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
+
+	return cm == _PAGE_CACHE_MODE_UC ||
+	       cm == _PAGE_CACHE_MODE_UC_MINUS ||
+	       cm == _PAGE_CACHE_MODE_WC;
+}
+EXPORT_SYMBOL_GPL(pat_pfn_immune_to_uc_mtrr);
+
+/**
+ * io_reserve_memtype - Request a memory type mapping for a region of memory
+ * @start: start (physical address) of the region
+ * @end: end (physical address) of the region
+ * @type: A pointer to memtype, with requested type. On success, requested
+ * or any other compatible type that was available for the region is returned
+ *
+ * On success, returns 0
+ * On failure, returns non-zero
+ */
+int io_reserve_memtype(resource_size_t start, resource_size_t end,
+			enum page_cache_mode *type)
+{
+	resource_size_t size = end - start;
+	enum page_cache_mode req_type = *type;
+	enum page_cache_mode new_type;
+	int ret;
+
+	WARN_ON_ONCE(iomem_map_sanity_check(start, size));
+
+	ret = reserve_memtype(start, end, req_type, &new_type);
+	if (ret)
+		goto out_err;
+
+	if (!is_new_memtype_allowed(start, size, req_type, new_type))
+		goto out_free;
+
+	if (kernel_map_sync_memtype(start, size, new_type) < 0)
+		goto out_free;
+
+	*type = new_type;
+	return 0;
+
+out_free:
+	free_memtype(start, end);
+	ret = -EBUSY;
+out_err:
+	return ret;
+}
+
+/**
+ * io_free_memtype - Release a memory type mapping for a region of memory
+ * @start: start (physical address) of the region
+ * @end: end (physical address) of the region
+ */
+void io_free_memtype(resource_size_t start, resource_size_t end)
+{
+	free_memtype(start, end);
+}
+
+int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
+{
+	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
+
+	return io_reserve_memtype(start, start + size, &type);
+}
+EXPORT_SYMBOL(arch_io_reserve_memtype_wc);
+
+void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
+{
+	io_free_memtype(start, start + size);
+}
+EXPORT_SYMBOL(arch_io_free_memtype_wc);
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				unsigned long size, pgprot_t vma_prot)
+{
+	if (!phys_mem_access_encrypted(pfn << PAGE_SHIFT, size))
+		vma_prot = pgprot_decrypted(vma_prot);
+
+	return vma_prot;
+}
+
+#ifdef CONFIG_STRICT_DEVMEM
+/* This check is done in drivers/char/mem.c in case of STRICT_DEVMEM */
+static inline int range_is_allowed(unsigned long pfn, unsigned long size)
+{
+	return 1;
+}
+#else
+/* This check is needed to avoid cache aliasing when PAT is enabled */
+static inline int range_is_allowed(unsigned long pfn, unsigned long size)
+{
+	u64 from = ((u64)pfn) << PAGE_SHIFT;
+	u64 to = from + size;
+	u64 cursor = from;
+
+	if (!pat_enabled())
+		return 1;
+
+	while (cursor < to) {
+		if (!devmem_is_allowed(pfn))
+			return 0;
+		cursor += PAGE_SIZE;
+		pfn++;
+	}
+	return 1;
+}
+#endif /* CONFIG_STRICT_DEVMEM */
+
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+				unsigned long size, pgprot_t *vma_prot)
+{
+	enum page_cache_mode pcm = _PAGE_CACHE_MODE_WB;
+
+	if (!range_is_allowed(pfn, size))
+		return 0;
+
+	if (file->f_flags & O_DSYNC)
+		pcm = _PAGE_CACHE_MODE_UC_MINUS;
+
+	*vma_prot = __pgprot((pgprot_val(*vma_prot) & ~_PAGE_CACHE_MASK) |
+			     cachemode2protval(pcm));
+	return 1;
+}
+
+/*
+ * Change the memory type for the physical address range in kernel identity
+ * mapping space if that range is a part of identity map.
+ */
+int kernel_map_sync_memtype(u64 base, unsigned long size,
+			    enum page_cache_mode pcm)
+{
+	unsigned long id_sz;
+
+	if (base > __pa(high_memory-1))
+		return 0;
+
+	/*
+	 * Some areas in the middle of the kernel identity range
+	 * are not mapped, for example the PCI space.
+	 */
+	if (!page_is_ram(base >> PAGE_SHIFT))
+		return 0;
+
+	id_sz = (__pa(high_memory-1) <= base + size) ?
+				__pa(high_memory) - base : size;
+
+	if (ioremap_change_attr((unsigned long)__va(base), id_sz, pcm) < 0) {
+		pr_info("x86/PAT: %s:%d ioremap_change_attr failed %s for [mem %#010Lx-%#010Lx]\n",
+			current->comm, current->pid,
+			cattr_name(pcm),
+			base, (unsigned long long)(base + size-1));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Internal interface to reserve a range of physical memory with prot.
+ * Reserved non RAM regions only and after successful reserve_memtype,
+ * this func also keeps identity mapping (if any) in sync with this new prot.
+ */
+static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
+				int strict_prot)
+{
+	int is_ram = 0;
+	int ret;
+	enum page_cache_mode want_pcm = pgprot2cachemode(*vma_prot);
+	enum page_cache_mode pcm = want_pcm;
+
+	is_ram = pat_pagerange_is_ram(paddr, paddr + size);
+
+	/*
+	 * reserve_pfn_range() for RAM pages. We do not refcount to keep
+	 * track of number of mappings of RAM pages. We can assert that
+	 * the type requested matches the type of first page in the range.
+	 */
+	if (is_ram) {
+		if (!pat_enabled())
+			return 0;
+
+		pcm = lookup_memtype(paddr);
+		if (want_pcm != pcm) {
+			pr_warn("x86/PAT: %s:%d map pfn RAM range req %s for [mem %#010Lx-%#010Lx], got %s\n",
+				current->comm, current->pid,
+				cattr_name(want_pcm),
+				(unsigned long long)paddr,
+				(unsigned long long)(paddr + size - 1),
+				cattr_name(pcm));
+			*vma_prot = __pgprot((pgprot_val(*vma_prot) &
+					     (~_PAGE_CACHE_MASK)) |
+					     cachemode2protval(pcm));
+		}
+		return 0;
+	}
+
+	ret = reserve_memtype(paddr, paddr + size, want_pcm, &pcm);
+	if (ret)
+		return ret;
+
+	if (pcm != want_pcm) {
+		if (strict_prot ||
+		    !is_new_memtype_allowed(paddr, size, want_pcm, pcm)) {
+			free_memtype(paddr, paddr + size);
+			pr_err("x86/PAT: %s:%d map pfn expected mapping type %s for [mem %#010Lx-%#010Lx], got %s\n",
+			       current->comm, current->pid,
+			       cattr_name(want_pcm),
+			       (unsigned long long)paddr,
+			       (unsigned long long)(paddr + size - 1),
+			       cattr_name(pcm));
+			return -EINVAL;
+		}
+		/*
+		 * We allow returning different type than the one requested in
+		 * non strict case.
+		 */
+		*vma_prot = __pgprot((pgprot_val(*vma_prot) &
+				      (~_PAGE_CACHE_MASK)) |
+				     cachemode2protval(pcm));
+	}
+
+	if (kernel_map_sync_memtype(paddr, size, pcm) < 0) {
+		free_memtype(paddr, paddr + size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Internal interface to free a range of physical memory.
+ * Frees non RAM regions only.
+ */
+static void free_pfn_range(u64 paddr, unsigned long size)
+{
+	int is_ram;
+
+	is_ram = pat_pagerange_is_ram(paddr, paddr + size);
+	if (is_ram == 0)
+		free_memtype(paddr, paddr + size);
+}
+
+/*
+ * track_pfn_copy is called when vma that is covering the pfnmap gets
+ * copied through copy_page_range().
+ *
+ * If the vma has a linear pfn mapping for the entire range, we get the prot
+ * from pte and reserve the entire vma range with single reserve_pfn_range call.
+ */
+int track_pfn_copy(struct vm_area_struct *vma)
+{
+	resource_size_t paddr;
+	unsigned long prot;
+	unsigned long vma_size = vma->vm_end - vma->vm_start;
+	pgprot_t pgprot;
+
+	if (vma->vm_flags & VM_PAT) {
+		/*
+		 * reserve the whole chunk covered by vma. We need the
+		 * starting address and protection from pte.
+		 */
+		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
+		pgprot = __pgprot(prot);
+		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	}
+
+	return 0;
+}
+
+/*
+ * prot is passed in as a parameter for the new mapping. If the vma has
+ * a linear pfn mapping for the entire range, or no vma is provided,
+ * reserve the entire pfn + size range with single reserve_pfn_range
+ * call.
+ */
+int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
+		    unsigned long pfn, unsigned long addr, unsigned long size)
+{
+	resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
+	enum page_cache_mode pcm;
+
+	/* reserve the whole chunk starting from paddr */
+	if (!vma || (addr == vma->vm_start
+				&& size == (vma->vm_end - vma->vm_start))) {
+		int ret;
+
+		ret = reserve_pfn_range(paddr, size, prot, 0);
+		if (ret == 0 && vma)
+			vma->vm_flags |= VM_PAT;
+		return ret;
+	}
+
+	if (!pat_enabled())
+		return 0;
+
+	/*
+	 * For anything smaller than the vma size we set prot based on the
+	 * lookup.
+	 */
+	pcm = lookup_memtype(paddr);
+
+	/* Check memtype for the remaining pages */
+	while (size > PAGE_SIZE) {
+		size -= PAGE_SIZE;
+		paddr += PAGE_SIZE;
+		if (pcm != lookup_memtype(paddr))
+			return -EINVAL;
+	}
+
+	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
+			 cachemode2protval(pcm));
+
+	return 0;
+}
+
+void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
+{
+	enum page_cache_mode pcm;
+
+	if (!pat_enabled())
+		return;
+
+	/* Set prot based on lookup */
+	pcm = lookup_memtype(pfn_t_to_phys(pfn));
+	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
+			 cachemode2protval(pcm));
+}
+
+/*
+ * untrack_pfn is called while unmapping a pfnmap for a region.
+ * untrack can be called for a specific region indicated by pfn and size or
+ * can be for the entire vma (in which case pfn, size are zero).
+ */
+void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
+		 unsigned long size)
+{
+	resource_size_t paddr;
+	unsigned long prot;
+
+	if (vma && !(vma->vm_flags & VM_PAT))
+		return;
+
+	/* free the chunk starting from pfn or the whole chunk */
+	paddr = (resource_size_t)pfn << PAGE_SHIFT;
+	if (!paddr && !size) {
+		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
+
+		size = vma->vm_end - vma->vm_start;
+	}
+	free_pfn_range(paddr, size);
+	if (vma)
+		vma->vm_flags &= ~VM_PAT;
+}
+
+/*
+ * untrack_pfn_moved is called, while mremapping a pfnmap for a new region,
+ * with the old vma after its pfnmap page table has been removed.  The new
+ * vma has a new pfnmap to the same pfn & cache type with VM_PAT set.
+ */
+void untrack_pfn_moved(struct vm_area_struct *vma)
+{
+	vma->vm_flags &= ~VM_PAT;
+}
+
+pgprot_t pgprot_writecombine(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) |
+				cachemode2protval(_PAGE_CACHE_MODE_WC));
+}
+EXPORT_SYMBOL_GPL(pgprot_writecombine);
+
+pgprot_t pgprot_writethrough(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) |
+				cachemode2protval(_PAGE_CACHE_MODE_WT));
+}
+EXPORT_SYMBOL_GPL(pgprot_writethrough);
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_X86_PAT)
+
+/*
+ * We are allocating a temporary printout-entry to be passed
+ * between seq_start()/next() and seq_show():
+ */
+static struct memtype *memtype_get_idx(loff_t pos)
+{
+	struct memtype *entry_print;
+	int ret;
+
+	entry_print  = kzalloc(sizeof(struct memtype), GFP_KERNEL);
+	if (!entry_print)
+		return NULL;
+
+	spin_lock(&memtype_lock);
+	ret = memtype_copy_nth_element(entry_print, pos);
+	spin_unlock(&memtype_lock);
+
+	/* Free it on error: */
+	if (ret) {
+		kfree(entry_print);
+		return NULL;
+	}
+
+	return entry_print;
+}
+
+static void *memtype_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos == 0) {
+		++*pos;
+		seq_puts(seq, "PAT memtype list:\n");
+	}
+
+	return memtype_get_idx(*pos);
+}
+
+static void *memtype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	return memtype_get_idx(*pos);
+}
+
+static void memtype_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int memtype_seq_show(struct seq_file *seq, void *v)
+{
+	struct memtype *entry_print = (struct memtype *)v;
+
+	seq_printf(seq, "PAT: [mem 0x%016Lx-0x%016Lx] %s\n",
+			entry_print->start,
+			entry_print->end,
+			cattr_name(entry_print->type));
+
+	kfree(entry_print);
+
+	return 0;
+}
+
+static const struct seq_operations memtype_seq_ops = {
+	.start = memtype_seq_start,
+	.next  = memtype_seq_next,
+	.stop  = memtype_seq_stop,
+	.show  = memtype_seq_show,
+};
+
+static int memtype_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &memtype_seq_ops);
+}
+
+static const struct file_operations memtype_fops = {
+	.open    = memtype_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init pat_memtype_list_init(void)
+{
+	if (pat_enabled()) {
+		debugfs_create_file("pat_memtype_list", S_IRUSR,
+				    arch_debugfs_dir, NULL, &memtype_fops);
+	}
+	return 0;
+}
+late_initcall(pat_memtype_list_init);
+
+#endif /* CONFIG_DEBUG_FS && CONFIG_X86_PAT */
diff --git a/arch/x86/mm/pat/memtype.h b/arch/x86/mm/pat/memtype.h
new file mode 100644
index 0000000..cacecdb
--- /dev/null
+++ b/arch/x86/mm/pat/memtype.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MEMTYPE_H_
+#define __MEMTYPE_H_
+
+extern int pat_debug_enable;
+
+#define dprintk(fmt, arg...) \
+	do { if (pat_debug_enable) pr_info("x86/PAT: " fmt, ##arg); } while (0)
+
+struct memtype {
+	u64			start;
+	u64			end;
+	u64			subtree_max_end;
+	enum page_cache_mode	type;
+	struct rb_node		rb;
+};
+
+static inline char *cattr_name(enum page_cache_mode pcm)
+{
+	switch (pcm) {
+	case _PAGE_CACHE_MODE_UC:		return "uncached";
+	case _PAGE_CACHE_MODE_UC_MINUS:		return "uncached-minus";
+	case _PAGE_CACHE_MODE_WB:		return "write-back";
+	case _PAGE_CACHE_MODE_WC:		return "write-combining";
+	case _PAGE_CACHE_MODE_WT:		return "write-through";
+	case _PAGE_CACHE_MODE_WP:		return "write-protected";
+	default:				return "broken";
+	}
+}
+
+#ifdef CONFIG_X86_PAT
+extern int memtype_check_insert(struct memtype *entry_new,
+				enum page_cache_mode *new_type);
+extern struct memtype *memtype_erase(u64 start, u64 end);
+extern struct memtype *memtype_lookup(u64 addr);
+extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
+#else
+static inline int memtype_check_insert(struct memtype *entry_new,
+				       enum page_cache_mode *new_type)
+{ return 0; }
+static inline struct memtype *memtype_erase(u64 start, u64 end)
+{ return NULL; }
+static inline struct memtype *memtype_lookup(u64 addr)
+{ return NULL; }
+static inline int memtype_copy_nth_element(struct memtype *out, loff_t pos)
+{ return 0; }
+#endif
+
+#endif /* __MEMTYPE_H_ */
diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
new file mode 100644
index 0000000..a7fbbdd
--- /dev/null
+++ b/arch/x86/mm/pat/memtype_interval.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle caching attributes in page tables (PAT)
+ *
+ * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *          Suresh B Siddha <suresh.b.siddha@intel.com>
+ *
+ * Interval tree used to store the PAT memory type reservations.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/sched.h>
+#include <linux/gfp.h>
+
+#include <asm/pgtable.h>
+#include <asm/pat.h>
+
+#include "memtype.h"
+
+/*
+ * The memtype tree keeps track of memory type for specific
+ * physical memory areas. Without proper tracking, conflicting memory
+ * types in different mappings can cause CPU cache corruption.
+ *
+ * The tree is an interval tree (augmented rbtree) which tree is ordered
+ * by the starting address. The tree can contain multiple entries for
+ * different regions which overlap. All the aliases have the same
+ * cache attributes of course, as enforced by the PAT logic.
+ *
+ * memtype_lock protects the rbtree.
+ */
+
+static inline u64 interval_start(struct memtype *entry)
+{
+	return entry->start;
+}
+
+static inline u64 interval_end(struct memtype *entry)
+{
+	return entry->end - 1;
+}
+
+INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
+		     interval_start, interval_end,
+		     static, interval)
+
+static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
+
+enum {
+	MEMTYPE_EXACT_MATCH	= 0,
+	MEMTYPE_END_MATCH	= 1
+};
+
+static struct memtype *memtype_match(u64 start, u64 end, int match_type)
+{
+	struct memtype *entry_match;
+
+	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
+
+	while (entry_match != NULL && entry_match->start < end) {
+		if ((match_type == MEMTYPE_EXACT_MATCH) &&
+		    (entry_match->start == start) && (entry_match->end == end))
+			return entry_match;
+
+		if ((match_type == MEMTYPE_END_MATCH) &&
+		    (entry_match->start < start) && (entry_match->end == end))
+			return entry_match;
+
+		entry_match = interval_iter_next(entry_match, start, end-1);
+	}
+
+	return NULL; /* Returns NULL if there is no match */
+}
+
+static int memtype_check_conflict(u64 start, u64 end,
+				  enum page_cache_mode reqtype,
+				  enum page_cache_mode *newtype)
+{
+	struct memtype *entry_match;
+	enum page_cache_mode found_type = reqtype;
+
+	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
+	if (entry_match == NULL)
+		goto success;
+
+	if (entry_match->type != found_type && newtype == NULL)
+		goto failure;
+
+	dprintk("Overlap at 0x%Lx-0x%Lx\n", entry_match->start, entry_match->end);
+	found_type = entry_match->type;
+
+	entry_match = interval_iter_next(entry_match, start, end-1);
+	while (entry_match) {
+		if (entry_match->type != found_type)
+			goto failure;
+
+		entry_match = interval_iter_next(entry_match, start, end-1);
+	}
+success:
+	if (newtype)
+		*newtype = found_type;
+
+	return 0;
+
+failure:
+	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
+		current->comm, current->pid, start, end,
+		cattr_name(found_type), cattr_name(entry_match->type));
+
+	return -EBUSY;
+}
+
+int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_type)
+{
+	int err = 0;
+
+	err = memtype_check_conflict(entry_new->start, entry_new->end, entry_new->type, ret_type);
+	if (err)
+		return err;
+
+	if (ret_type)
+		entry_new->type = *ret_type;
+
+	interval_insert(entry_new, &memtype_rbroot);
+	return 0;
+}
+
+struct memtype *memtype_erase(u64 start, u64 end)
+{
+	struct memtype *entry_old;
+
+	/*
+	 * Since the memtype_rbroot tree allows overlapping ranges,
+	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
+	 * a whole node for the munmap case.  If no such entry is found,
+	 * it then checks with END_MATCH, i.e. shrink the size of a node
+	 * from the end for the mremap case.
+	 */
+	entry_old = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
+	if (!entry_old) {
+		entry_old = memtype_match(start, end, MEMTYPE_END_MATCH);
+		if (!entry_old)
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (entry_old->start == start) {
+		/* munmap: erase this node */
+		interval_remove(entry_old, &memtype_rbroot);
+	} else {
+		/* mremap: update the end value of this node */
+		interval_remove(entry_old, &memtype_rbroot);
+		entry_old->end = start;
+		interval_insert(entry_old, &memtype_rbroot);
+
+		return NULL;
+	}
+
+	return entry_old;
+}
+
+struct memtype *memtype_lookup(u64 addr)
+{
+	return interval_iter_first(&memtype_rbroot, addr, addr + PAGE_SIZE-1);
+}
+
+/*
+ * Debugging helper, copy the Nth entry of the tree into a
+ * a copy for printout. This allows us to print out the tree
+ * via debugfs, without holding the memtype_lock too long:
+ */
+#ifdef CONFIG_DEBUG_FS
+int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos)
+{
+	struct memtype *entry_match;
+	int i = 1;
+
+	entry_match = interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+
+	while (entry_match && pos != i) {
+		entry_match = interval_iter_next(entry_match, 0, ULONG_MAX);
+		i++;
+	}
+
+	if (entry_match) { /* pos == i */
+		*entry_out = *entry_match;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+#endif
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
new file mode 100644
index 0000000..8fbefee
--- /dev/null
+++ b/arch/x86/mm/pat/set_memory.c
@@ -0,0 +1,2285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2002 Andi Kleen, SuSE Labs.
+ * Thanks to Ben LaHaise for precious feedback.
+ */
+#include <linux/highmem.h>
+#include <linux/memblock.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/pfn.h>
+#include <linux/percpu.h>
+#include <linux/gfp.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include <asm/e820/api.h>
+#include <asm/processor.h>
+#include <asm/tlbflush.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <linux/uaccess.h>
+#include <asm/pgalloc.h>
+#include <asm/proto.h>
+#include <asm/pat.h>
+#include <asm/set_memory.h>
+
+#include "../mm_internal.h"
+
+/*
+ * The current flushing context - we pass it instead of 5 arguments:
+ */
+struct cpa_data {
+	unsigned long	*vaddr;
+	pgd_t		*pgd;
+	pgprot_t	mask_set;
+	pgprot_t	mask_clr;
+	unsigned long	numpages;
+	unsigned long	curpage;
+	unsigned long	pfn;
+	unsigned int	flags;
+	unsigned int	force_split		: 1,
+			force_static_prot	: 1;
+	struct page	**pages;
+};
+
+enum cpa_warn {
+	CPA_CONFLICT,
+	CPA_PROTECT,
+	CPA_DETECT,
+};
+
+static const int cpa_warn_level = CPA_PROTECT;
+
+/*
+ * Serialize cpa() (for !DEBUG_PAGEALLOC which uses large identity mappings)
+ * using cpa_lock. So that we don't allow any other cpu, with stale large tlb
+ * entries change the page attribute in parallel to some other cpu
+ * splitting a large page entry along with changing the attribute.
+ */
+static DEFINE_SPINLOCK(cpa_lock);
+
+#define CPA_FLUSHTLB 1
+#define CPA_ARRAY 2
+#define CPA_PAGES_ARRAY 4
+#define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
+
+#ifdef CONFIG_PROC_FS
+static unsigned long direct_pages_count[PG_LEVEL_NUM];
+
+void update_page_count(int level, unsigned long pages)
+{
+	/* Protect against CPA */
+	spin_lock(&pgd_lock);
+	direct_pages_count[level] += pages;
+	spin_unlock(&pgd_lock);
+}
+
+static void split_page_count(int level)
+{
+	if (direct_pages_count[level] == 0)
+		return;
+
+	direct_pages_count[level]--;
+	direct_pages_count[level - 1] += PTRS_PER_PTE;
+}
+
+void arch_report_meminfo(struct seq_file *m)
+{
+	seq_printf(m, "DirectMap4k:    %8lu kB\n",
+			direct_pages_count[PG_LEVEL_4K] << 2);
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
+	seq_printf(m, "DirectMap2M:    %8lu kB\n",
+			direct_pages_count[PG_LEVEL_2M] << 11);
+#else
+	seq_printf(m, "DirectMap4M:    %8lu kB\n",
+			direct_pages_count[PG_LEVEL_2M] << 12);
+#endif
+	if (direct_gbpages)
+		seq_printf(m, "DirectMap1G:    %8lu kB\n",
+			direct_pages_count[PG_LEVEL_1G] << 20);
+}
+#else
+static inline void split_page_count(int level) { }
+#endif
+
+#ifdef CONFIG_X86_CPA_STATISTICS
+
+static unsigned long cpa_1g_checked;
+static unsigned long cpa_1g_sameprot;
+static unsigned long cpa_1g_preserved;
+static unsigned long cpa_2m_checked;
+static unsigned long cpa_2m_sameprot;
+static unsigned long cpa_2m_preserved;
+static unsigned long cpa_4k_install;
+
+static inline void cpa_inc_1g_checked(void)
+{
+	cpa_1g_checked++;
+}
+
+static inline void cpa_inc_2m_checked(void)
+{
+	cpa_2m_checked++;
+}
+
+static inline void cpa_inc_4k_install(void)
+{
+	cpa_4k_install++;
+}
+
+static inline void cpa_inc_lp_sameprot(int level)
+{
+	if (level == PG_LEVEL_1G)
+		cpa_1g_sameprot++;
+	else
+		cpa_2m_sameprot++;
+}
+
+static inline void cpa_inc_lp_preserved(int level)
+{
+	if (level == PG_LEVEL_1G)
+		cpa_1g_preserved++;
+	else
+		cpa_2m_preserved++;
+}
+
+static int cpastats_show(struct seq_file *m, void *p)
+{
+	seq_printf(m, "1G pages checked:     %16lu\n", cpa_1g_checked);
+	seq_printf(m, "1G pages sameprot:    %16lu\n", cpa_1g_sameprot);
+	seq_printf(m, "1G pages preserved:   %16lu\n", cpa_1g_preserved);
+	seq_printf(m, "2M pages checked:     %16lu\n", cpa_2m_checked);
+	seq_printf(m, "2M pages sameprot:    %16lu\n", cpa_2m_sameprot);
+	seq_printf(m, "2M pages preserved:   %16lu\n", cpa_2m_preserved);
+	seq_printf(m, "4K pages set-checked: %16lu\n", cpa_4k_install);
+	return 0;
+}
+
+static int cpastats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpastats_show, NULL);
+}
+
+static const struct file_operations cpastats_fops = {
+	.open		= cpastats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init cpa_stats_init(void)
+{
+	debugfs_create_file("cpa_stats", S_IRUSR, arch_debugfs_dir, NULL,
+			    &cpastats_fops);
+	return 0;
+}
+late_initcall(cpa_stats_init);
+#else
+static inline void cpa_inc_1g_checked(void) { }
+static inline void cpa_inc_2m_checked(void) { }
+static inline void cpa_inc_4k_install(void) { }
+static inline void cpa_inc_lp_sameprot(int level) { }
+static inline void cpa_inc_lp_preserved(int level) { }
+#endif
+
+
+static inline int
+within(unsigned long addr, unsigned long start, unsigned long end)
+{
+	return addr >= start && addr < end;
+}
+
+static inline int
+within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
+{
+	return addr >= start && addr <= end;
+}
+
+#ifdef CONFIG_X86_64
+
+static inline unsigned long highmap_start_pfn(void)
+{
+	return __pa_symbol(_text) >> PAGE_SHIFT;
+}
+
+static inline unsigned long highmap_end_pfn(void)
+{
+	/* Do not reference physical address outside the kernel. */
+	return __pa_symbol(roundup(_brk_end, PMD_SIZE) - 1) >> PAGE_SHIFT;
+}
+
+static bool __cpa_pfn_in_highmap(unsigned long pfn)
+{
+	/*
+	 * Kernel text has an alias mapping at a high address, known
+	 * here as "highmap".
+	 */
+	return within_inclusive(pfn, highmap_start_pfn(), highmap_end_pfn());
+}
+
+#else
+
+static bool __cpa_pfn_in_highmap(unsigned long pfn)
+{
+	/* There is no highmap on 32-bit */
+	return false;
+}
+
+#endif
+
+/*
+ * See set_mce_nospec().
+ *
+ * Machine check recovery code needs to change cache mode of poisoned pages to
+ * UC to avoid speculative access logging another error. But passing the
+ * address of the 1:1 mapping to set_memory_uc() is a fine way to encourage a
+ * speculative access. So we cheat and flip the top bit of the address. This
+ * works fine for the code that updates the page tables. But at the end of the
+ * process we need to flush the TLB and cache and the non-canonical address
+ * causes a #GP fault when used by the INVLPG and CLFLUSH instructions.
+ *
+ * But in the common case we already have a canonical address. This code
+ * will fix the top bit if needed and is a no-op otherwise.
+ */
+static inline unsigned long fix_addr(unsigned long addr)
+{
+#ifdef CONFIG_X86_64
+	return (long)(addr << 1) >> 1;
+#else
+	return addr;
+#endif
+}
+
+static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
+{
+	if (cpa->flags & CPA_PAGES_ARRAY) {
+		struct page *page = cpa->pages[idx];
+
+		if (unlikely(PageHighMem(page)))
+			return 0;
+
+		return (unsigned long)page_address(page);
+	}
+
+	if (cpa->flags & CPA_ARRAY)
+		return cpa->vaddr[idx];
+
+	return *cpa->vaddr + idx * PAGE_SIZE;
+}
+
+/*
+ * Flushing functions
+ */
+
+static void clflush_cache_range_opt(void *vaddr, unsigned int size)
+{
+	const unsigned long clflush_size = boot_cpu_data.x86_clflush_size;
+	void *p = (void *)((unsigned long)vaddr & ~(clflush_size - 1));
+	void *vend = vaddr + size;
+
+	if (p >= vend)
+		return;
+
+	for (; p < vend; p += clflush_size)
+		clflushopt(p);
+}
+
+/**
+ * clflush_cache_range - flush a cache range with clflush
+ * @vaddr:	virtual start address
+ * @size:	number of bytes to flush
+ *
+ * CLFLUSHOPT is an unordered instruction which needs fencing with MFENCE or
+ * SFENCE to avoid ordering issues.
+ */
+void clflush_cache_range(void *vaddr, unsigned int size)
+{
+	mb();
+	clflush_cache_range_opt(vaddr, size);
+	mb();
+}
+EXPORT_SYMBOL_GPL(clflush_cache_range);
+
+void arch_invalidate_pmem(void *addr, size_t size)
+{
+	clflush_cache_range(addr, size);
+}
+EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
+
+static void __cpa_flush_all(void *arg)
+{
+	unsigned long cache = (unsigned long)arg;
+
+	/*
+	 * Flush all to work around Errata in early athlons regarding
+	 * large page flushing.
+	 */
+	__flush_tlb_all();
+
+	if (cache && boot_cpu_data.x86 >= 4)
+		wbinvd();
+}
+
+static void cpa_flush_all(unsigned long cache)
+{
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
+
+	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
+}
+
+void __cpa_flush_tlb(void *data)
+{
+	struct cpa_data *cpa = data;
+	unsigned int i;
+
+	for (i = 0; i < cpa->numpages; i++)
+		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
+}
+
+static void cpa_flush(struct cpa_data *data, int cache)
+{
+	struct cpa_data *cpa = data;
+	unsigned int i;
+
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
+
+	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
+	if (cpa->numpages <= tlb_single_page_flush_ceiling)
+		on_each_cpu(__cpa_flush_tlb, cpa, 1);
+	else
+		flush_tlb_all();
+
+	if (!cache)
+		return;
+
+	mb();
+	for (i = 0; i < cpa->numpages; i++) {
+		unsigned long addr = __cpa_addr(cpa, i);
+		unsigned int level;
+
+		pte_t *pte = lookup_address(addr, &level);
+
+		/*
+		 * Only flush present addresses:
+		 */
+		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
+			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
+	}
+	mb();
+}
+
+static bool overlaps(unsigned long r1_start, unsigned long r1_end,
+		     unsigned long r2_start, unsigned long r2_end)
+{
+	return (r1_start <= r2_end && r1_end >= r2_start) ||
+		(r2_start <= r1_end && r2_end >= r1_start);
+}
+
+#ifdef CONFIG_PCI_BIOS
+/*
+ * The BIOS area between 640k and 1Mb needs to be executable for PCI BIOS
+ * based config access (CONFIG_PCI_GOBIOS) support.
+ */
+#define BIOS_PFN	PFN_DOWN(BIOS_BEGIN)
+#define BIOS_PFN_END	PFN_DOWN(BIOS_END - 1)
+
+static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
+{
+	if (pcibios_enabled && overlaps(spfn, epfn, BIOS_PFN, BIOS_PFN_END))
+		return _PAGE_NX;
+	return 0;
+}
+#else
+static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
+{
+	return 0;
+}
+#endif
+
+/*
+ * The .rodata section needs to be read-only. Using the pfn catches all
+ * aliases.  This also includes __ro_after_init, so do not enforce until
+ * kernel_set_to_readonly is true.
+ */
+static pgprotval_t protect_rodata(unsigned long spfn, unsigned long epfn)
+{
+	unsigned long epfn_ro, spfn_ro = PFN_DOWN(__pa_symbol(__start_rodata));
+
+	/*
+	 * Note: __end_rodata is at page aligned and not inclusive, so
+	 * subtract 1 to get the last enforced PFN in the rodata area.
+	 */
+	epfn_ro = PFN_DOWN(__pa_symbol(__end_rodata)) - 1;
+
+	if (kernel_set_to_readonly && overlaps(spfn, epfn, spfn_ro, epfn_ro))
+		return _PAGE_RW;
+	return 0;
+}
+
+/*
+ * Protect kernel text against becoming non executable by forbidding
+ * _PAGE_NX.  This protects only the high kernel mapping (_text -> _etext)
+ * out of which the kernel actually executes.  Do not protect the low
+ * mapping.
+ *
+ * This does not cover __inittext since that is gone after boot.
+ */
+static pgprotval_t protect_kernel_text(unsigned long start, unsigned long end)
+{
+	unsigned long t_end = (unsigned long)_etext - 1;
+	unsigned long t_start = (unsigned long)_text;
+
+	if (overlaps(start, end, t_start, t_end))
+		return _PAGE_NX;
+	return 0;
+}
+
+#if defined(CONFIG_X86_64)
+/*
+ * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
+ * kernel text mappings for the large page aligned text, rodata sections
+ * will be always read-only. For the kernel identity mappings covering the
+ * holes caused by this alignment can be anything that user asks.
+ *
+ * This will preserve the large page mappings for kernel text/data at no
+ * extra cost.
+ */
+static pgprotval_t protect_kernel_text_ro(unsigned long start,
+					  unsigned long end)
+{
+	unsigned long t_end = (unsigned long)__end_rodata_hpage_align - 1;
+	unsigned long t_start = (unsigned long)_text;
+	unsigned int level;
+
+	if (!kernel_set_to_readonly || !overlaps(start, end, t_start, t_end))
+		return 0;
+	/*
+	 * Don't enforce the !RW mapping for the kernel text mapping, if
+	 * the current mapping is already using small page mapping.  No
+	 * need to work hard to preserve large page mappings in this case.
+	 *
+	 * This also fixes the Linux Xen paravirt guest boot failure caused
+	 * by unexpected read-only mappings for kernel identity
+	 * mappings. In this paravirt guest case, the kernel text mapping
+	 * and the kernel identity mapping share the same page-table pages,
+	 * so the protections for kernel text and identity mappings have to
+	 * be the same.
+	 */
+	if (lookup_address(start, &level) && (level != PG_LEVEL_4K))
+		return _PAGE_RW;
+	return 0;
+}
+#else
+static pgprotval_t protect_kernel_text_ro(unsigned long start,
+					  unsigned long end)
+{
+	return 0;
+}
+#endif
+
+static inline bool conflicts(pgprot_t prot, pgprotval_t val)
+{
+	return (pgprot_val(prot) & ~val) != pgprot_val(prot);
+}
+
+static inline void check_conflict(int warnlvl, pgprot_t prot, pgprotval_t val,
+				  unsigned long start, unsigned long end,
+				  unsigned long pfn, const char *txt)
+{
+	static const char *lvltxt[] = {
+		[CPA_CONFLICT]	= "conflict",
+		[CPA_PROTECT]	= "protect",
+		[CPA_DETECT]	= "detect",
+	};
+
+	if (warnlvl > cpa_warn_level || !conflicts(prot, val))
+		return;
+
+	pr_warn("CPA %8s %10s: 0x%016lx - 0x%016lx PFN %lx req %016llx prevent %016llx\n",
+		lvltxt[warnlvl], txt, start, end, pfn, (unsigned long long)pgprot_val(prot),
+		(unsigned long long)val);
+}
+
+/*
+ * Certain areas of memory on x86 require very specific protection flags,
+ * for example the BIOS area or kernel text. Callers don't always get this
+ * right (again, ioremap() on BIOS memory is not uncommon) so this function
+ * checks and fixes these known static required protection bits.
+ */
+static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
+					  unsigned long pfn, unsigned long npg,
+					  unsigned long lpsize, int warnlvl)
+{
+	pgprotval_t forbidden, res;
+	unsigned long end;
+
+	/*
+	 * There is no point in checking RW/NX conflicts when the requested
+	 * mapping is setting the page !PRESENT.
+	 */
+	if (!(pgprot_val(prot) & _PAGE_PRESENT))
+		return prot;
+
+	/* Operate on the virtual address */
+	end = start + npg * PAGE_SIZE - 1;
+
+	res = protect_kernel_text(start, end);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
+	forbidden = res;
+
+	/*
+	 * Special case to preserve a large page. If the change spawns the
+	 * full large page mapping then there is no point to split it
+	 * up. Happens with ftrace and is going to be removed once ftrace
+	 * switched to text_poke().
+	 */
+	if (lpsize != (npg * PAGE_SIZE) || (start & (lpsize - 1))) {
+		res = protect_kernel_text_ro(start, end);
+		check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
+		forbidden |= res;
+	}
+
+	/* Check the PFN directly */
+	res = protect_pci_bios(pfn, pfn + npg - 1);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "PCIBIOS NX");
+	forbidden |= res;
+
+	res = protect_rodata(pfn, pfn + npg - 1);
+	check_conflict(warnlvl, prot, res, start, end, pfn, "Rodata RO");
+	forbidden |= res;
+
+	return __pgprot(pgprot_val(prot) & ~forbidden);
+}
+
+/*
+ * Lookup the page table entry for a virtual address in a specific pgd.
+ * Return a pointer to the entry and the level of the mapping.
+ */
+pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
+			     unsigned int *level)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	*level = PG_LEVEL_NONE;
+
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, address);
+	if (p4d_none(*p4d))
+		return NULL;
+
+	*level = PG_LEVEL_512G;
+	if (p4d_large(*p4d) || !p4d_present(*p4d))
+		return (pte_t *)p4d;
+
+	pud = pud_offset(p4d, address);
+	if (pud_none(*pud))
+		return NULL;
+
+	*level = PG_LEVEL_1G;
+	if (pud_large(*pud) || !pud_present(*pud))
+		return (pte_t *)pud;
+
+	pmd = pmd_offset(pud, address);
+	if (pmd_none(*pmd))
+		return NULL;
+
+	*level = PG_LEVEL_2M;
+	if (pmd_large(*pmd) || !pmd_present(*pmd))
+		return (pte_t *)pmd;
+
+	*level = PG_LEVEL_4K;
+
+	return pte_offset_kernel(pmd, address);
+}
+
+/*
+ * Lookup the page table entry for a virtual address. Return a pointer
+ * to the entry and the level of the mapping.
+ *
+ * Note: We return pud and pmd either when the entry is marked large
+ * or when the present bit is not set. Otherwise we would return a
+ * pointer to a nonexisting mapping.
+ */
+pte_t *lookup_address(unsigned long address, unsigned int *level)
+{
+	return lookup_address_in_pgd(pgd_offset_k(address), address, level);
+}
+EXPORT_SYMBOL_GPL(lookup_address);
+
+static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
+				  unsigned int *level)
+{
+	if (cpa->pgd)
+		return lookup_address_in_pgd(cpa->pgd + pgd_index(address),
+					       address, level);
+
+	return lookup_address(address, level);
+}
+
+/*
+ * Lookup the PMD entry for a virtual address. Return a pointer to the entry
+ * or NULL if not present.
+ */
+pmd_t *lookup_pmd_address(unsigned long address)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	pgd = pgd_offset_k(address);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, address);
+	if (p4d_none(*p4d) || p4d_large(*p4d) || !p4d_present(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, address);
+	if (pud_none(*pud) || pud_large(*pud) || !pud_present(*pud))
+		return NULL;
+
+	return pmd_offset(pud, address);
+}
+
+/*
+ * This is necessary because __pa() does not work on some
+ * kinds of memory, like vmalloc() or the alloc_remap()
+ * areas on 32-bit NUMA systems.  The percpu areas can
+ * end up in this kind of memory, for instance.
+ *
+ * This could be optimized, but it is only intended to be
+ * used at inititalization time, and keeping it
+ * unoptimized should increase the testing coverage for
+ * the more obscure platforms.
+ */
+phys_addr_t slow_virt_to_phys(void *__virt_addr)
+{
+	unsigned long virt_addr = (unsigned long)__virt_addr;
+	phys_addr_t phys_addr;
+	unsigned long offset;
+	enum pg_level level;
+	pte_t *pte;
+
+	pte = lookup_address(virt_addr, &level);
+	BUG_ON(!pte);
+
+	/*
+	 * pXX_pfn() returns unsigned long, which must be cast to phys_addr_t
+	 * before being left-shifted PAGE_SHIFT bits -- this trick is to
+	 * make 32-PAE kernel work correctly.
+	 */
+	switch (level) {
+	case PG_LEVEL_1G:
+		phys_addr = (phys_addr_t)pud_pfn(*(pud_t *)pte) << PAGE_SHIFT;
+		offset = virt_addr & ~PUD_PAGE_MASK;
+		break;
+	case PG_LEVEL_2M:
+		phys_addr = (phys_addr_t)pmd_pfn(*(pmd_t *)pte) << PAGE_SHIFT;
+		offset = virt_addr & ~PMD_PAGE_MASK;
+		break;
+	default:
+		phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
+		offset = virt_addr & ~PAGE_MASK;
+	}
+
+	return (phys_addr_t)(phys_addr | offset);
+}
+EXPORT_SYMBOL_GPL(slow_virt_to_phys);
+
+/*
+ * Set the new pmd in all the pgds we know about:
+ */
+static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
+{
+	/* change init_mm */
+	set_pte_atomic(kpte, pte);
+#ifdef CONFIG_X86_32
+	if (!SHARED_KERNEL_PMD) {
+		struct page *page;
+
+		list_for_each_entry(page, &pgd_list, lru) {
+			pgd_t *pgd;
+			p4d_t *p4d;
+			pud_t *pud;
+			pmd_t *pmd;
+
+			pgd = (pgd_t *)page_address(page) + pgd_index(address);
+			p4d = p4d_offset(pgd, address);
+			pud = pud_offset(p4d, address);
+			pmd = pmd_offset(pud, address);
+			set_pte_atomic((pte_t *)pmd, pte);
+		}
+	}
+#endif
+}
+
+static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
+{
+	/*
+	 * _PAGE_GLOBAL means "global page" for present PTEs.
+	 * But, it is also used to indicate _PAGE_PROTNONE
+	 * for non-present PTEs.
+	 *
+	 * This ensures that a _PAGE_GLOBAL PTE going from
+	 * present to non-present is not confused as
+	 * _PAGE_PROTNONE.
+	 */
+	if (!(pgprot_val(prot) & _PAGE_PRESENT))
+		pgprot_val(prot) &= ~_PAGE_GLOBAL;
+
+	return prot;
+}
+
+static int __should_split_large_page(pte_t *kpte, unsigned long address,
+				     struct cpa_data *cpa)
+{
+	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
+	pgprot_t old_prot, new_prot, req_prot, chk_prot;
+	pte_t new_pte, *tmp;
+	enum pg_level level;
+
+	/*
+	 * Check for races, another CPU might have split this page
+	 * up already:
+	 */
+	tmp = _lookup_address_cpa(cpa, address, &level);
+	if (tmp != kpte)
+		return 1;
+
+	switch (level) {
+	case PG_LEVEL_2M:
+		old_prot = pmd_pgprot(*(pmd_t *)kpte);
+		old_pfn = pmd_pfn(*(pmd_t *)kpte);
+		cpa_inc_2m_checked();
+		break;
+	case PG_LEVEL_1G:
+		old_prot = pud_pgprot(*(pud_t *)kpte);
+		old_pfn = pud_pfn(*(pud_t *)kpte);
+		cpa_inc_1g_checked();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	psize = page_level_size(level);
+	pmask = page_level_mask(level);
+
+	/*
+	 * Calculate the number of pages, which fit into this large
+	 * page starting at address:
+	 */
+	lpaddr = (address + psize) & pmask;
+	numpages = (lpaddr - address) >> PAGE_SHIFT;
+	if (numpages < cpa->numpages)
+		cpa->numpages = numpages;
+
+	/*
+	 * We are safe now. Check whether the new pgprot is the same:
+	 * Convert protection attributes to 4k-format, as cpa->mask* are set
+	 * up accordingly.
+	 */
+
+	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
+	req_prot = pgprot_large_2_4k(old_prot);
+
+	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
+	pgprot_val(req_prot) |= pgprot_val(cpa->mask_set);
+
+	/*
+	 * req_prot is in format of 4k pages. It must be converted to large
+	 * page format: the caching mode includes the PAT bit located at
+	 * different bit positions in the two formats.
+	 */
+	req_prot = pgprot_4k_2_large(req_prot);
+	req_prot = pgprot_clear_protnone_bits(req_prot);
+	if (pgprot_val(req_prot) & _PAGE_PRESENT)
+		pgprot_val(req_prot) |= _PAGE_PSE;
+
+	/*
+	 * old_pfn points to the large page base pfn. So we need to add the
+	 * offset of the virtual address:
+	 */
+	pfn = old_pfn + ((address & (psize - 1)) >> PAGE_SHIFT);
+	cpa->pfn = pfn;
+
+	/*
+	 * Calculate the large page base address and the number of 4K pages
+	 * in the large page
+	 */
+	lpaddr = address & pmask;
+	numpages = psize >> PAGE_SHIFT;
+
+	/*
+	 * Sanity check that the existing mapping is correct versus the static
+	 * protections. static_protections() guards against !PRESENT, so no
+	 * extra conditional required here.
+	 */
+	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
+				      psize, CPA_CONFLICT);
+
+	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
+		/*
+		 * Split the large page and tell the split code to
+		 * enforce static protections.
+		 */
+		cpa->force_static_prot = 1;
+		return 1;
+	}
+
+	/*
+	 * Optimization: If the requested pgprot is the same as the current
+	 * pgprot, then the large page can be preserved and no updates are
+	 * required independent of alignment and length of the requested
+	 * range. The above already established that the current pgprot is
+	 * correct, which in consequence makes the requested pgprot correct
+	 * as well if it is the same. The static protection scan below will
+	 * not come to a different conclusion.
+	 */
+	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
+		cpa_inc_lp_sameprot(level);
+		return 0;
+	}
+
+	/*
+	 * If the requested range does not cover the full page, split it up
+	 */
+	if (address != lpaddr || cpa->numpages != numpages)
+		return 1;
+
+	/*
+	 * Check whether the requested pgprot is conflicting with a static
+	 * protection requirement in the large page.
+	 */
+	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
+				      psize, CPA_DETECT);
+
+	/*
+	 * If there is a conflict, split the large page.
+	 *
+	 * There used to be a 4k wise evaluation trying really hard to
+	 * preserve the large pages, but experimentation has shown, that this
+	 * does not help at all. There might be corner cases which would
+	 * preserve one large page occasionally, but it's really not worth the
+	 * extra code and cycles for the common case.
+	 */
+	if (pgprot_val(req_prot) != pgprot_val(new_prot))
+		return 1;
+
+	/* All checks passed. Update the large page mapping. */
+	new_pte = pfn_pte(old_pfn, new_prot);
+	__set_pmd_pte(kpte, address, new_pte);
+	cpa->flags |= CPA_FLUSHTLB;
+	cpa_inc_lp_preserved(level);
+	return 0;
+}
+
+static int should_split_large_page(pte_t *kpte, unsigned long address,
+				   struct cpa_data *cpa)
+{
+	int do_split;
+
+	if (cpa->force_split)
+		return 1;
+
+	spin_lock(&pgd_lock);
+	do_split = __should_split_large_page(kpte, address, cpa);
+	spin_unlock(&pgd_lock);
+
+	return do_split;
+}
+
+static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
+			  pgprot_t ref_prot, unsigned long address,
+			  unsigned long size)
+{
+	unsigned int npg = PFN_DOWN(size);
+	pgprot_t prot;
+
+	/*
+	 * If should_split_large_page() discovered an inconsistent mapping,
+	 * remove the invalid protection in the split mapping.
+	 */
+	if (!cpa->force_static_prot)
+		goto set;
+
+	/* Hand in lpsize = 0 to enforce the protection mechanism */
+	prot = static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT);
+
+	if (pgprot_val(prot) == pgprot_val(ref_prot))
+		goto set;
+
+	/*
+	 * If this is splitting a PMD, fix it up. PUD splits cannot be
+	 * fixed trivially as that would require to rescan the newly
+	 * installed PMD mappings after returning from split_large_page()
+	 * so an eventual further split can allocate the necessary PTE
+	 * pages. Warn for now and revisit it in case this actually
+	 * happens.
+	 */
+	if (size == PAGE_SIZE)
+		ref_prot = prot;
+	else
+		pr_warn_once("CPA: Cannot fixup static protections for PUD split\n");
+set:
+	set_pte(pte, pfn_pte(pfn, ref_prot));
+}
+
+static int
+__split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
+		   struct page *base)
+{
+	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
+	pte_t *pbase = (pte_t *)page_address(base);
+	unsigned int i, level;
+	pgprot_t ref_prot;
+	pte_t *tmp;
+
+	spin_lock(&pgd_lock);
+	/*
+	 * Check for races, another CPU might have split this page
+	 * up for us already:
+	 */
+	tmp = _lookup_address_cpa(cpa, address, &level);
+	if (tmp != kpte) {
+		spin_unlock(&pgd_lock);
+		return 1;
+	}
+
+	paravirt_alloc_pte(&init_mm, page_to_pfn(base));
+
+	switch (level) {
+	case PG_LEVEL_2M:
+		ref_prot = pmd_pgprot(*(pmd_t *)kpte);
+		/*
+		 * Clear PSE (aka _PAGE_PAT) and move
+		 * PAT bit to correct position.
+		 */
+		ref_prot = pgprot_large_2_4k(ref_prot);
+		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
+		lpaddr = address & PMD_MASK;
+		lpinc = PAGE_SIZE;
+		break;
+
+	case PG_LEVEL_1G:
+		ref_prot = pud_pgprot(*(pud_t *)kpte);
+		ref_pfn = pud_pfn(*(pud_t *)kpte);
+		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
+		lpaddr = address & PUD_MASK;
+		lpinc = PMD_SIZE;
+		/*
+		 * Clear the PSE flags if the PRESENT flag is not set
+		 * otherwise pmd_present/pmd_huge will return true
+		 * even on a non present pmd.
+		 */
+		if (!(pgprot_val(ref_prot) & _PAGE_PRESENT))
+			pgprot_val(ref_prot) &= ~_PAGE_PSE;
+		break;
+
+	default:
+		spin_unlock(&pgd_lock);
+		return 1;
+	}
+
+	ref_prot = pgprot_clear_protnone_bits(ref_prot);
+
+	/*
+	 * Get the target pfn from the original entry:
+	 */
+	pfn = ref_pfn;
+	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc, lpaddr += lpinc)
+		split_set_pte(cpa, pbase + i, pfn, ref_prot, lpaddr, lpinc);
+
+	if (virt_addr_valid(address)) {
+		unsigned long pfn = PFN_DOWN(__pa(address));
+
+		if (pfn_range_is_mapped(pfn, pfn + 1))
+			split_page_count(level);
+	}
+
+	/*
+	 * Install the new, split up pagetable.
+	 *
+	 * We use the standard kernel pagetable protections for the new
+	 * pagetable protections, the actual ptes set above control the
+	 * primary protection behavior:
+	 */
+	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
+
+	/*
+	 * Do a global flush tlb after splitting the large page
+	 * and before we do the actual change page attribute in the PTE.
+	 *
+	 * Without this, we violate the TLB application note, that says:
+	 * "The TLBs may contain both ordinary and large-page
+	 *  translations for a 4-KByte range of linear addresses. This
+	 *  may occur if software modifies the paging structures so that
+	 *  the page size used for the address range changes. If the two
+	 *  translations differ with respect to page frame or attributes
+	 *  (e.g., permissions), processor behavior is undefined and may
+	 *  be implementation-specific."
+	 *
+	 * We do this global tlb flush inside the cpa_lock, so that we
+	 * don't allow any other cpu, with stale tlb entries change the
+	 * page attribute in parallel, that also falls into the
+	 * just split large page entry.
+	 */
+	flush_tlb_all();
+	spin_unlock(&pgd_lock);
+
+	return 0;
+}
+
+static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
+			    unsigned long address)
+{
+	struct page *base;
+
+	if (!debug_pagealloc_enabled())
+		spin_unlock(&cpa_lock);
+	base = alloc_pages(GFP_KERNEL, 0);
+	if (!debug_pagealloc_enabled())
+		spin_lock(&cpa_lock);
+	if (!base)
+		return -ENOMEM;
+
+	if (__split_large_page(cpa, kpte, address, base))
+		__free_page(base);
+
+	return 0;
+}
+
+static bool try_to_free_pte_page(pte_t *pte)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		if (!pte_none(pte[i]))
+			return false;
+
+	free_page((unsigned long)pte);
+	return true;
+}
+
+static bool try_to_free_pmd_page(pmd_t *pmd)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		if (!pmd_none(pmd[i]))
+			return false;
+
+	free_page((unsigned long)pmd);
+	return true;
+}
+
+static bool unmap_pte_range(pmd_t *pmd, unsigned long start, unsigned long end)
+{
+	pte_t *pte = pte_offset_kernel(pmd, start);
+
+	while (start < end) {
+		set_pte(pte, __pte(0));
+
+		start += PAGE_SIZE;
+		pte++;
+	}
+
+	if (try_to_free_pte_page((pte_t *)pmd_page_vaddr(*pmd))) {
+		pmd_clear(pmd);
+		return true;
+	}
+	return false;
+}
+
+static void __unmap_pmd_range(pud_t *pud, pmd_t *pmd,
+			      unsigned long start, unsigned long end)
+{
+	if (unmap_pte_range(pmd, start, end))
+		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+			pud_clear(pud);
+}
+
+static void unmap_pmd_range(pud_t *pud, unsigned long start, unsigned long end)
+{
+	pmd_t *pmd = pmd_offset(pud, start);
+
+	/*
+	 * Not on a 2MB page boundary?
+	 */
+	if (start & (PMD_SIZE - 1)) {
+		unsigned long next_page = (start + PMD_SIZE) & PMD_MASK;
+		unsigned long pre_end = min_t(unsigned long, end, next_page);
+
+		__unmap_pmd_range(pud, pmd, start, pre_end);
+
+		start = pre_end;
+		pmd++;
+	}
+
+	/*
+	 * Try to unmap in 2M chunks.
+	 */
+	while (end - start >= PMD_SIZE) {
+		if (pmd_large(*pmd))
+			pmd_clear(pmd);
+		else
+			__unmap_pmd_range(pud, pmd, start, start + PMD_SIZE);
+
+		start += PMD_SIZE;
+		pmd++;
+	}
+
+	/*
+	 * 4K leftovers?
+	 */
+	if (start < end)
+		return __unmap_pmd_range(pud, pmd, start, end);
+
+	/*
+	 * Try again to free the PMD page if haven't succeeded above.
+	 */
+	if (!pud_none(*pud))
+		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+			pud_clear(pud);
+}
+
+static void unmap_pud_range(p4d_t *p4d, unsigned long start, unsigned long end)
+{
+	pud_t *pud = pud_offset(p4d, start);
+
+	/*
+	 * Not on a GB page boundary?
+	 */
+	if (start & (PUD_SIZE - 1)) {
+		unsigned long next_page = (start + PUD_SIZE) & PUD_MASK;
+		unsigned long pre_end	= min_t(unsigned long, end, next_page);
+
+		unmap_pmd_range(pud, start, pre_end);
+
+		start = pre_end;
+		pud++;
+	}
+
+	/*
+	 * Try to unmap in 1G chunks?
+	 */
+	while (end - start >= PUD_SIZE) {
+
+		if (pud_large(*pud))
+			pud_clear(pud);
+		else
+			unmap_pmd_range(pud, start, start + PUD_SIZE);
+
+		start += PUD_SIZE;
+		pud++;
+	}
+
+	/*
+	 * 2M leftovers?
+	 */
+	if (start < end)
+		unmap_pmd_range(pud, start, end);
+
+	/*
+	 * No need to try to free the PUD page because we'll free it in
+	 * populate_pgd's error path
+	 */
+}
+
+static int alloc_pte_page(pmd_t *pmd)
+{
+	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
+	if (!pte)
+		return -1;
+
+	set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+	return 0;
+}
+
+static int alloc_pmd_page(pud_t *pud)
+{
+	pmd_t *pmd = (pmd_t *)get_zeroed_page(GFP_KERNEL);
+	if (!pmd)
+		return -1;
+
+	set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+	return 0;
+}
+
+static void populate_pte(struct cpa_data *cpa,
+			 unsigned long start, unsigned long end,
+			 unsigned num_pages, pmd_t *pmd, pgprot_t pgprot)
+{
+	pte_t *pte;
+
+	pte = pte_offset_kernel(pmd, start);
+
+	pgprot = pgprot_clear_protnone_bits(pgprot);
+
+	while (num_pages-- && start < end) {
+		set_pte(pte, pfn_pte(cpa->pfn, pgprot));
+
+		start	 += PAGE_SIZE;
+		cpa->pfn++;
+		pte++;
+	}
+}
+
+static long populate_pmd(struct cpa_data *cpa,
+			 unsigned long start, unsigned long end,
+			 unsigned num_pages, pud_t *pud, pgprot_t pgprot)
+{
+	long cur_pages = 0;
+	pmd_t *pmd;
+	pgprot_t pmd_pgprot;
+
+	/*
+	 * Not on a 2M boundary?
+	 */
+	if (start & (PMD_SIZE - 1)) {
+		unsigned long pre_end = start + (num_pages << PAGE_SHIFT);
+		unsigned long next_page = (start + PMD_SIZE) & PMD_MASK;
+
+		pre_end   = min_t(unsigned long, pre_end, next_page);
+		cur_pages = (pre_end - start) >> PAGE_SHIFT;
+		cur_pages = min_t(unsigned int, num_pages, cur_pages);
+
+		/*
+		 * Need a PTE page?
+		 */
+		pmd = pmd_offset(pud, start);
+		if (pmd_none(*pmd))
+			if (alloc_pte_page(pmd))
+				return -1;
+
+		populate_pte(cpa, start, pre_end, cur_pages, pmd, pgprot);
+
+		start = pre_end;
+	}
+
+	/*
+	 * We mapped them all?
+	 */
+	if (num_pages == cur_pages)
+		return cur_pages;
+
+	pmd_pgprot = pgprot_4k_2_large(pgprot);
+
+	while (end - start >= PMD_SIZE) {
+
+		/*
+		 * We cannot use a 1G page so allocate a PMD page if needed.
+		 */
+		if (pud_none(*pud))
+			if (alloc_pmd_page(pud))
+				return -1;
+
+		pmd = pmd_offset(pud, start);
+
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+					canon_pgprot(pmd_pgprot))));
+
+		start	  += PMD_SIZE;
+		cpa->pfn  += PMD_SIZE >> PAGE_SHIFT;
+		cur_pages += PMD_SIZE >> PAGE_SHIFT;
+	}
+
+	/*
+	 * Map trailing 4K pages.
+	 */
+	if (start < end) {
+		pmd = pmd_offset(pud, start);
+		if (pmd_none(*pmd))
+			if (alloc_pte_page(pmd))
+				return -1;
+
+		populate_pte(cpa, start, end, num_pages - cur_pages,
+			     pmd, pgprot);
+	}
+	return num_pages;
+}
+
+static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
+			pgprot_t pgprot)
+{
+	pud_t *pud;
+	unsigned long end;
+	long cur_pages = 0;
+	pgprot_t pud_pgprot;
+
+	end = start + (cpa->numpages << PAGE_SHIFT);
+
+	/*
+	 * Not on a Gb page boundary? => map everything up to it with
+	 * smaller pages.
+	 */
+	if (start & (PUD_SIZE - 1)) {
+		unsigned long pre_end;
+		unsigned long next_page = (start + PUD_SIZE) & PUD_MASK;
+
+		pre_end   = min_t(unsigned long, end, next_page);
+		cur_pages = (pre_end - start) >> PAGE_SHIFT;
+		cur_pages = min_t(int, (int)cpa->numpages, cur_pages);
+
+		pud = pud_offset(p4d, start);
+
+		/*
+		 * Need a PMD page?
+		 */
+		if (pud_none(*pud))
+			if (alloc_pmd_page(pud))
+				return -1;
+
+		cur_pages = populate_pmd(cpa, start, pre_end, cur_pages,
+					 pud, pgprot);
+		if (cur_pages < 0)
+			return cur_pages;
+
+		start = pre_end;
+	}
+
+	/* We mapped them all? */
+	if (cpa->numpages == cur_pages)
+		return cur_pages;
+
+	pud = pud_offset(p4d, start);
+	pud_pgprot = pgprot_4k_2_large(pgprot);
+
+	/*
+	 * Map everything starting from the Gb boundary, possibly with 1G pages
+	 */
+	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
+		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+				   canon_pgprot(pud_pgprot))));
+
+		start	  += PUD_SIZE;
+		cpa->pfn  += PUD_SIZE >> PAGE_SHIFT;
+		cur_pages += PUD_SIZE >> PAGE_SHIFT;
+		pud++;
+	}
+
+	/* Map trailing leftover */
+	if (start < end) {
+		long tmp;
+
+		pud = pud_offset(p4d, start);
+		if (pud_none(*pud))
+			if (alloc_pmd_page(pud))
+				return -1;
+
+		tmp = populate_pmd(cpa, start, end, cpa->numpages - cur_pages,
+				   pud, pgprot);
+		if (tmp < 0)
+			return cur_pages;
+
+		cur_pages += tmp;
+	}
+	return cur_pages;
+}
+
+/*
+ * Restrictions for kernel page table do not necessarily apply when mapping in
+ * an alternate PGD.
+ */
+static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
+{
+	pgprot_t pgprot = __pgprot(_KERNPG_TABLE);
+	pud_t *pud = NULL;	/* shut up gcc */
+	p4d_t *p4d;
+	pgd_t *pgd_entry;
+	long ret;
+
+	pgd_entry = cpa->pgd + pgd_index(addr);
+
+	if (pgd_none(*pgd_entry)) {
+		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
+		if (!p4d)
+			return -1;
+
+		set_pgd(pgd_entry, __pgd(__pa(p4d) | _KERNPG_TABLE));
+	}
+
+	/*
+	 * Allocate a PUD page and hand it down for mapping.
+	 */
+	p4d = p4d_offset(pgd_entry, addr);
+	if (p4d_none(*p4d)) {
+		pud = (pud_t *)get_zeroed_page(GFP_KERNEL);
+		if (!pud)
+			return -1;
+
+		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
+	}
+
+	pgprot_val(pgprot) &= ~pgprot_val(cpa->mask_clr);
+	pgprot_val(pgprot) |=  pgprot_val(cpa->mask_set);
+
+	ret = populate_pud(cpa, addr, p4d, pgprot);
+	if (ret < 0) {
+		/*
+		 * Leave the PUD page in place in case some other CPU or thread
+		 * already found it, but remove any useless entries we just
+		 * added to it.
+		 */
+		unmap_pud_range(p4d, addr,
+				addr + (cpa->numpages << PAGE_SHIFT));
+		return ret;
+	}
+
+	cpa->numpages = ret;
+	return 0;
+}
+
+static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
+			       int primary)
+{
+	if (cpa->pgd) {
+		/*
+		 * Right now, we only execute this code path when mapping
+		 * the EFI virtual memory map regions, no other users
+		 * provide a ->pgd value. This may change in the future.
+		 */
+		return populate_pgd(cpa, vaddr);
+	}
+
+	/*
+	 * Ignore all non primary paths.
+	 */
+	if (!primary) {
+		cpa->numpages = 1;
+		return 0;
+	}
+
+	/*
+	 * Ignore the NULL PTE for kernel identity mapping, as it is expected
+	 * to have holes.
+	 * Also set numpages to '1' indicating that we processed cpa req for
+	 * one virtual address page and its pfn. TBD: numpages can be set based
+	 * on the initial value and the level returned by lookup_address().
+	 */
+	if (within(vaddr, PAGE_OFFSET,
+		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT))) {
+		cpa->numpages = 1;
+		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
+		return 0;
+
+	} else if (__cpa_pfn_in_highmap(cpa->pfn)) {
+		/* Faults in the highmap are OK, so do not warn: */
+		return -EFAULT;
+	} else {
+		WARN(1, KERN_WARNING "CPA: called for zero pte. "
+			"vaddr = %lx cpa->vaddr = %lx\n", vaddr,
+			*cpa->vaddr);
+
+		return -EFAULT;
+	}
+}
+
+static int __change_page_attr(struct cpa_data *cpa, int primary)
+{
+	unsigned long address;
+	int do_split, err;
+	unsigned int level;
+	pte_t *kpte, old_pte;
+
+	address = __cpa_addr(cpa, cpa->curpage);
+repeat:
+	kpte = _lookup_address_cpa(cpa, address, &level);
+	if (!kpte)
+		return __cpa_process_fault(cpa, address, primary);
+
+	old_pte = *kpte;
+	if (pte_none(old_pte))
+		return __cpa_process_fault(cpa, address, primary);
+
+	if (level == PG_LEVEL_4K) {
+		pte_t new_pte;
+		pgprot_t new_prot = pte_pgprot(old_pte);
+		unsigned long pfn = pte_pfn(old_pte);
+
+		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
+		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
+
+		cpa_inc_4k_install();
+		/* Hand in lpsize = 0 to enforce the protection mechanism */
+		new_prot = static_protections(new_prot, address, pfn, 1, 0,
+					      CPA_PROTECT);
+
+		new_prot = pgprot_clear_protnone_bits(new_prot);
+
+		/*
+		 * We need to keep the pfn from the existing PTE,
+		 * after all we're only going to change it's attributes
+		 * not the memory it points to
+		 */
+		new_pte = pfn_pte(pfn, new_prot);
+		cpa->pfn = pfn;
+		/*
+		 * Do we really change anything ?
+		 */
+		if (pte_val(old_pte) != pte_val(new_pte)) {
+			set_pte_atomic(kpte, new_pte);
+			cpa->flags |= CPA_FLUSHTLB;
+		}
+		cpa->numpages = 1;
+		return 0;
+	}
+
+	/*
+	 * Check, whether we can keep the large page intact
+	 * and just change the pte:
+	 */
+	do_split = should_split_large_page(kpte, address, cpa);
+	/*
+	 * When the range fits into the existing large page,
+	 * return. cp->numpages and cpa->tlbflush have been updated in
+	 * try_large_page:
+	 */
+	if (do_split <= 0)
+		return do_split;
+
+	/*
+	 * We have to split the large page:
+	 */
+	err = split_large_page(cpa, kpte, address);
+	if (!err)
+		goto repeat;
+
+	return err;
+}
+
+static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
+
+static int cpa_process_alias(struct cpa_data *cpa)
+{
+	struct cpa_data alias_cpa;
+	unsigned long laddr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);
+	unsigned long vaddr;
+	int ret;
+
+	if (!pfn_range_is_mapped(cpa->pfn, cpa->pfn + 1))
+		return 0;
+
+	/*
+	 * No need to redo, when the primary call touched the direct
+	 * mapping already:
+	 */
+	vaddr = __cpa_addr(cpa, cpa->curpage);
+	if (!(within(vaddr, PAGE_OFFSET,
+		    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
+
+		alias_cpa = *cpa;
+		alias_cpa.vaddr = &laddr;
+		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
+		alias_cpa.curpage = 0;
+
+		ret = __change_page_attr_set_clr(&alias_cpa, 0);
+		if (ret)
+			return ret;
+	}
+
+#ifdef CONFIG_X86_64
+	/*
+	 * If the primary call didn't touch the high mapping already
+	 * and the physical address is inside the kernel map, we need
+	 * to touch the high mapped kernel as well:
+	 */
+	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
+	    __cpa_pfn_in_highmap(cpa->pfn)) {
+		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
+					       __START_KERNEL_map - phys_base;
+		alias_cpa = *cpa;
+		alias_cpa.vaddr = &temp_cpa_vaddr;
+		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
+		alias_cpa.curpage = 0;
+
+		/*
+		 * The high mapping range is imprecise, so ignore the
+		 * return value.
+		 */
+		__change_page_attr_set_clr(&alias_cpa, 0);
+	}
+#endif
+
+	return 0;
+}
+
+static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
+{
+	unsigned long numpages = cpa->numpages;
+	unsigned long rempages = numpages;
+	int ret = 0;
+
+	while (rempages) {
+		/*
+		 * Store the remaining nr of pages for the large page
+		 * preservation check.
+		 */
+		cpa->numpages = rempages;
+		/* for array changes, we can't use large page */
+		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
+			cpa->numpages = 1;
+
+		if (!debug_pagealloc_enabled())
+			spin_lock(&cpa_lock);
+		ret = __change_page_attr(cpa, checkalias);
+		if (!debug_pagealloc_enabled())
+			spin_unlock(&cpa_lock);
+		if (ret)
+			goto out;
+
+		if (checkalias) {
+			ret = cpa_process_alias(cpa);
+			if (ret)
+				goto out;
+		}
+
+		/*
+		 * Adjust the number of pages with the result of the
+		 * CPA operation. Either a large page has been
+		 * preserved or a single page update happened.
+		 */
+		BUG_ON(cpa->numpages > rempages || !cpa->numpages);
+		rempages -= cpa->numpages;
+		cpa->curpage += cpa->numpages;
+	}
+
+out:
+	/* Restore the original numpages */
+	cpa->numpages = numpages;
+	return ret;
+}
+
+static int change_page_attr_set_clr(unsigned long *addr, int numpages,
+				    pgprot_t mask_set, pgprot_t mask_clr,
+				    int force_split, int in_flag,
+				    struct page **pages)
+{
+	struct cpa_data cpa;
+	int ret, cache, checkalias;
+
+	memset(&cpa, 0, sizeof(cpa));
+
+	/*
+	 * Check, if we are requested to set a not supported
+	 * feature.  Clearing non-supported features is OK.
+	 */
+	mask_set = canon_pgprot(mask_set);
+
+	if (!pgprot_val(mask_set) && !pgprot_val(mask_clr) && !force_split)
+		return 0;
+
+	/* Ensure we are PAGE_SIZE aligned */
+	if (in_flag & CPA_ARRAY) {
+		int i;
+		for (i = 0; i < numpages; i++) {
+			if (addr[i] & ~PAGE_MASK) {
+				addr[i] &= PAGE_MASK;
+				WARN_ON_ONCE(1);
+			}
+		}
+	} else if (!(in_flag & CPA_PAGES_ARRAY)) {
+		/*
+		 * in_flag of CPA_PAGES_ARRAY implies it is aligned.
+		 * No need to check in that case
+		 */
+		if (*addr & ~PAGE_MASK) {
+			*addr &= PAGE_MASK;
+			/*
+			 * People should not be passing in unaligned addresses:
+			 */
+			WARN_ON_ONCE(1);
+		}
+	}
+
+	/* Must avoid aliasing mappings in the highmem code */
+	kmap_flush_unused();
+
+	vm_unmap_aliases();
+
+	cpa.vaddr = addr;
+	cpa.pages = pages;
+	cpa.numpages = numpages;
+	cpa.mask_set = mask_set;
+	cpa.mask_clr = mask_clr;
+	cpa.flags = 0;
+	cpa.curpage = 0;
+	cpa.force_split = force_split;
+
+	if (in_flag & (CPA_ARRAY | CPA_PAGES_ARRAY))
+		cpa.flags |= in_flag;
+
+	/* No alias checking for _NX bit modifications */
+	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
+	/* Has caller explicitly disabled alias checking? */
+	if (in_flag & CPA_NO_CHECK_ALIAS)
+		checkalias = 0;
+
+	ret = __change_page_attr_set_clr(&cpa, checkalias);
+
+	/*
+	 * Check whether we really changed something:
+	 */
+	if (!(cpa.flags & CPA_FLUSHTLB))
+		goto out;
+
+	/*
+	 * No need to flush, when we did not set any of the caching
+	 * attributes:
+	 */
+	cache = !!pgprot2cachemode(mask_set);
+
+	/*
+	 * On error; flush everything to be sure.
+	 */
+	if (ret) {
+		cpa_flush_all(cache);
+		goto out;
+	}
+
+	cpa_flush(&cpa, cache);
+out:
+	return ret;
+}
+
+static inline int change_page_attr_set(unsigned long *addr, int numpages,
+				       pgprot_t mask, int array)
+{
+	return change_page_attr_set_clr(addr, numpages, mask, __pgprot(0), 0,
+		(array ? CPA_ARRAY : 0), NULL);
+}
+
+static inline int change_page_attr_clear(unsigned long *addr, int numpages,
+					 pgprot_t mask, int array)
+{
+	return change_page_attr_set_clr(addr, numpages, __pgprot(0), mask, 0,
+		(array ? CPA_ARRAY : 0), NULL);
+}
+
+static inline int cpa_set_pages_array(struct page **pages, int numpages,
+				       pgprot_t mask)
+{
+	return change_page_attr_set_clr(NULL, numpages, mask, __pgprot(0), 0,
+		CPA_PAGES_ARRAY, pages);
+}
+
+static inline int cpa_clear_pages_array(struct page **pages, int numpages,
+					 pgprot_t mask)
+{
+	return change_page_attr_set_clr(NULL, numpages, __pgprot(0), mask, 0,
+		CPA_PAGES_ARRAY, pages);
+}
+
+int _set_memory_uc(unsigned long addr, int numpages)
+{
+	/*
+	 * for now UC MINUS. see comments in ioremap()
+	 * If you really need strong UC use ioremap_uc(), but note
+	 * that you cannot override IO areas with set_memory_*() as
+	 * these helpers cannot work with IO memory.
+	 */
+	return change_page_attr_set(&addr, numpages,
+				    cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
+				    0);
+}
+
+int set_memory_uc(unsigned long addr, int numpages)
+{
+	int ret;
+
+	/*
+	 * for now UC MINUS. see comments in ioremap()
+	 */
+	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
+			      _PAGE_CACHE_MODE_UC_MINUS, NULL);
+	if (ret)
+		goto out_err;
+
+	ret = _set_memory_uc(addr, numpages);
+	if (ret)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
+out_err:
+	return ret;
+}
+EXPORT_SYMBOL(set_memory_uc);
+
+int _set_memory_wc(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = change_page_attr_set(&addr, numpages,
+				   cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
+				   0);
+	if (!ret) {
+		ret = change_page_attr_set_clr(&addr, numpages,
+					       cachemode2pgprot(_PAGE_CACHE_MODE_WC),
+					       __pgprot(_PAGE_CACHE_MASK),
+					       0, 0, NULL);
+	}
+	return ret;
+}
+
+int set_memory_wc(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
+		_PAGE_CACHE_MODE_WC, NULL);
+	if (ret)
+		return ret;
+
+	ret = _set_memory_wc(addr, numpages);
+	if (ret)
+		free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
+
+	return ret;
+}
+EXPORT_SYMBOL(set_memory_wc);
+
+int _set_memory_wt(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages,
+				    cachemode2pgprot(_PAGE_CACHE_MODE_WT), 0);
+}
+
+int _set_memory_wb(unsigned long addr, int numpages)
+{
+	/* WB cache mode is hard wired to all cache attribute bits being 0 */
+	return change_page_attr_clear(&addr, numpages,
+				      __pgprot(_PAGE_CACHE_MASK), 0);
+}
+
+int set_memory_wb(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = _set_memory_wb(addr, numpages);
+	if (ret)
+		return ret;
+
+	free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
+	return 0;
+}
+EXPORT_SYMBOL(set_memory_wb);
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	if (!(__supported_pte_mask & _PAGE_NX))
+		return 0;
+
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX), 0);
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	if (!(__supported_pte_mask & _PAGE_NX))
+		return 0;
+
+	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX), 0);
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_RW), 0);
+}
+
+int set_memory_np(unsigned long addr, int numpages)
+{
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+
+int set_memory_np_noalias(unsigned long addr, int numpages)
+{
+	int cpa_flags = CPA_NO_CHECK_ALIAS;
+
+	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
+					__pgprot(_PAGE_PRESENT), 0,
+					cpa_flags, NULL);
+}
+
+int set_memory_4k(unsigned long addr, int numpages)
+{
+	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
+					__pgprot(0), 1, 0, NULL);
+}
+
+int set_memory_nonglobal(unsigned long addr, int numpages)
+{
+	return change_page_attr_clear(&addr, numpages,
+				      __pgprot(_PAGE_GLOBAL), 0);
+}
+
+int set_memory_global(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages,
+				    __pgprot(_PAGE_GLOBAL), 0);
+}
+
+static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
+{
+	struct cpa_data cpa;
+	int ret;
+
+	/* Nothing to do if memory encryption is not active */
+	if (!mem_encrypt_active())
+		return 0;
+
+	/* Should not be working on unaligned addresses */
+	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
+		addr &= PAGE_MASK;
+
+	memset(&cpa, 0, sizeof(cpa));
+	cpa.vaddr = &addr;
+	cpa.numpages = numpages;
+	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
+	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+	cpa.pgd = init_mm.pgd;
+
+	/* Must avoid aliasing mappings in the highmem code */
+	kmap_flush_unused();
+	vm_unmap_aliases();
+
+	/*
+	 * Before changing the encryption attribute, we need to flush caches.
+	 */
+	cpa_flush(&cpa, 1);
+
+	ret = __change_page_attr_set_clr(&cpa, 1);
+
+	/*
+	 * After changing the encryption attribute, we need to flush TLBs again
+	 * in case any speculative TLB caching occurred (but no need to flush
+	 * caches again).  We could just use cpa_flush_all(), but in case TLB
+	 * flushing gets optimized in the cpa_flush() path use the same logic
+	 * as above.
+	 */
+	cpa_flush(&cpa, 0);
+
+	return ret;
+}
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	return __set_memory_enc_dec(addr, numpages, true);
+}
+EXPORT_SYMBOL_GPL(set_memory_encrypted);
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	return __set_memory_enc_dec(addr, numpages, false);
+}
+EXPORT_SYMBOL_GPL(set_memory_decrypted);
+
+int set_pages_uc(struct page *page, int numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	return set_memory_uc(addr, numpages);
+}
+EXPORT_SYMBOL(set_pages_uc);
+
+static int _set_pages_array(struct page **pages, int numpages,
+		enum page_cache_mode new_type)
+{
+	unsigned long start;
+	unsigned long end;
+	enum page_cache_mode set_type;
+	int i;
+	int free_idx;
+	int ret;
+
+	for (i = 0; i < numpages; i++) {
+		if (PageHighMem(pages[i]))
+			continue;
+		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
+		end = start + PAGE_SIZE;
+		if (reserve_memtype(start, end, new_type, NULL))
+			goto err_out;
+	}
+
+	/* If WC, set to UC- first and then WC */
+	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
+				_PAGE_CACHE_MODE_UC_MINUS : new_type;
+
+	ret = cpa_set_pages_array(pages, numpages,
+				  cachemode2pgprot(set_type));
+	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
+		ret = change_page_attr_set_clr(NULL, numpages,
+					       cachemode2pgprot(
+						_PAGE_CACHE_MODE_WC),
+					       __pgprot(_PAGE_CACHE_MASK),
+					       0, CPA_PAGES_ARRAY, pages);
+	if (ret)
+		goto err_out;
+	return 0; /* Success */
+err_out:
+	free_idx = i;
+	for (i = 0; i < free_idx; i++) {
+		if (PageHighMem(pages[i]))
+			continue;
+		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
+		end = start + PAGE_SIZE;
+		free_memtype(start, end);
+	}
+	return -EINVAL;
+}
+
+int set_pages_array_uc(struct page **pages, int numpages)
+{
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_UC_MINUS);
+}
+EXPORT_SYMBOL(set_pages_array_uc);
+
+int set_pages_array_wc(struct page **pages, int numpages)
+{
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WC);
+}
+EXPORT_SYMBOL(set_pages_array_wc);
+
+int set_pages_array_wt(struct page **pages, int numpages)
+{
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
+}
+EXPORT_SYMBOL_GPL(set_pages_array_wt);
+
+int set_pages_wb(struct page *page, int numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	return set_memory_wb(addr, numpages);
+}
+EXPORT_SYMBOL(set_pages_wb);
+
+int set_pages_array_wb(struct page **pages, int numpages)
+{
+	int retval;
+	unsigned long start;
+	unsigned long end;
+	int i;
+
+	/* WB cache mode is hard wired to all cache attribute bits being 0 */
+	retval = cpa_clear_pages_array(pages, numpages,
+			__pgprot(_PAGE_CACHE_MASK));
+	if (retval)
+		return retval;
+
+	for (i = 0; i < numpages; i++) {
+		if (PageHighMem(pages[i]))
+			continue;
+		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
+		end = start + PAGE_SIZE;
+		free_memtype(start, end);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(set_pages_array_wb);
+
+int set_pages_ro(struct page *page, int numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	return set_memory_ro(addr, numpages);
+}
+
+int set_pages_rw(struct page *page, int numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	return set_memory_rw(addr, numpages);
+}
+
+static int __set_pages_p(struct page *page, int numpages)
+{
+	unsigned long tempaddr = (unsigned long) page_address(page);
+	struct cpa_data cpa = { .vaddr = &tempaddr,
+				.pgd = NULL,
+				.numpages = numpages,
+				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+				.mask_clr = __pgprot(0),
+				.flags = 0};
+
+	/*
+	 * No alias checking needed for setting present flag. otherwise,
+	 * we may need to break large pages for 64-bit kernel text
+	 * mappings (this adds to complexity if we want to do this from
+	 * atomic context especially). Let's keep it simple!
+	 */
+	return __change_page_attr_set_clr(&cpa, 0);
+}
+
+static int __set_pages_np(struct page *page, int numpages)
+{
+	unsigned long tempaddr = (unsigned long) page_address(page);
+	struct cpa_data cpa = { .vaddr = &tempaddr,
+				.pgd = NULL,
+				.numpages = numpages,
+				.mask_set = __pgprot(0),
+				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+				.flags = 0};
+
+	/*
+	 * No alias checking needed for setting not present flag. otherwise,
+	 * we may need to break large pages for 64-bit kernel text
+	 * mappings (this adds to complexity if we want to do this from
+	 * atomic context especially). Let's keep it simple!
+	 */
+	return __change_page_attr_set_clr(&cpa, 0);
+}
+
+int set_direct_map_invalid_noflush(struct page *page)
+{
+	return __set_pages_np(page, 1);
+}
+
+int set_direct_map_default_noflush(struct page *page)
+{
+	return __set_pages_p(page, 1);
+}
+
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (PageHighMem(page))
+		return;
+	if (!enable) {
+		debug_check_no_locks_freed(page_address(page),
+					   numpages * PAGE_SIZE);
+	}
+
+	/*
+	 * The return value is ignored as the calls cannot fail.
+	 * Large pages for identity mappings are not used at boot time
+	 * and hence no memory allocations during large page split.
+	 */
+	if (enable)
+		__set_pages_p(page, numpages);
+	else
+		__set_pages_np(page, numpages);
+
+	/*
+	 * We should perform an IPI and flush all tlbs,
+	 * but that can deadlock->flush only current cpu.
+	 * Preemption needs to be disabled around __flush_tlb_all() due to
+	 * CR3 reload in __native_flush_tlb().
+	 */
+	preempt_disable();
+	__flush_tlb_all();
+	preempt_enable();
+
+	arch_flush_lazy_mmu_mode();
+}
+
+#ifdef CONFIG_HIBERNATION
+bool kernel_page_present(struct page *page)
+{
+	unsigned int level;
+	pte_t *pte;
+
+	if (PageHighMem(page))
+		return false;
+
+	pte = lookup_address((unsigned long)page_address(page), &level);
+	return (pte_val(*pte) & _PAGE_PRESENT);
+}
+#endif /* CONFIG_HIBERNATION */
+
+int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
+				   unsigned numpages, unsigned long page_flags)
+{
+	int retval = -EINVAL;
+
+	struct cpa_data cpa = {
+		.vaddr = &address,
+		.pfn = pfn,
+		.pgd = pgd,
+		.numpages = numpages,
+		.mask_set = __pgprot(0),
+		.mask_clr = __pgprot(0),
+		.flags = 0,
+	};
+
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
+	if (!(__supported_pte_mask & _PAGE_NX))
+		goto out;
+
+	if (!(page_flags & _PAGE_NX))
+		cpa.mask_clr = __pgprot(_PAGE_NX);
+
+	if (!(page_flags & _PAGE_RW))
+		cpa.mask_clr = __pgprot(_PAGE_RW);
+
+	if (!(page_flags & _PAGE_ENC))
+		cpa.mask_clr = pgprot_encrypted(cpa.mask_clr);
+
+	cpa.mask_set = __pgprot(_PAGE_PRESENT | page_flags);
+
+	retval = __change_page_attr_set_clr(&cpa, 0);
+	__flush_tlb_all();
+
+out:
+	return retval;
+}
+
+/*
+ * __flush_tlb_all() flushes mappings only on current CPU and hence this
+ * function shouldn't be used in an SMP environment. Presently, it's used only
+ * during boot (way before smp_init()) by EFI subsystem and hence is ok.
+ */
+int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+				     unsigned long numpages)
+{
+	int retval;
+
+	/*
+	 * The typical sequence for unmapping is to find a pte through
+	 * lookup_address_in_pgd() (ideally, it should never return NULL because
+	 * the address is already mapped) and change it's protections. As pfn is
+	 * the *target* of a mapping, it's not useful while unmapping.
+	 */
+	struct cpa_data cpa = {
+		.vaddr		= &address,
+		.pfn		= 0,
+		.pgd		= pgd,
+		.numpages	= numpages,
+		.mask_set	= __pgprot(0),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.flags		= 0,
+	};
+
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
+	retval = __change_page_attr_set_clr(&cpa, 0);
+	__flush_tlb_all();
+
+	return retval;
+}
+
+/*
+ * The testcases use internal knowledge of the implementation that shouldn't
+ * be exposed to the rest of the kernel. Include these directly here.
+ */
+#ifdef CONFIG_CPA_DEBUG
+#include "cpa-test.c"
+#endif
diff --git a/arch/x86/mm/pat_internal.h b/arch/x86/mm/pat_internal.h
deleted file mode 100644
index 23ce8cd..0000000
--- a/arch/x86/mm/pat_internal.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PAT_INTERNAL_H_
-#define __PAT_INTERNAL_H_
-
-extern int pat_debug_enable;
-
-#define dprintk(fmt, arg...) \
-	do { if (pat_debug_enable) pr_info("x86/PAT: " fmt, ##arg); } while (0)
-
-struct memtype {
-	u64			start;
-	u64			end;
-	u64			subtree_max_end;
-	enum page_cache_mode	type;
-	struct rb_node		rb;
-};
-
-static inline char *cattr_name(enum page_cache_mode pcm)
-{
-	switch (pcm) {
-	case _PAGE_CACHE_MODE_UC:		return "uncached";
-	case _PAGE_CACHE_MODE_UC_MINUS:		return "uncached-minus";
-	case _PAGE_CACHE_MODE_WB:		return "write-back";
-	case _PAGE_CACHE_MODE_WC:		return "write-combining";
-	case _PAGE_CACHE_MODE_WT:		return "write-through";
-	case _PAGE_CACHE_MODE_WP:		return "write-protected";
-	default:				return "broken";
-	}
-}
-
-#ifdef CONFIG_X86_PAT
-extern int memtype_check_insert(struct memtype *entry_new,
-				enum page_cache_mode *new_type);
-extern struct memtype *memtype_erase(u64 start, u64 end);
-extern struct memtype *memtype_lookup(u64 addr);
-extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
-#else
-static inline int memtype_check_insert(struct memtype *entry_new,
-				       enum page_cache_mode *new_type)
-{ return 0; }
-static inline struct memtype *memtype_erase(u64 start, u64 end)
-{ return NULL; }
-static inline struct memtype *memtype_lookup(u64 addr)
-{ return NULL; }
-static inline int memtype_copy_nth_element(struct memtype *out, loff_t pos)
-{ return 0; }
-#endif
-
-#endif /* __PAT_INTERNAL_H_ */
diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
deleted file mode 100644
index 3c983de..0000000
--- a/arch/x86/mm/pat_interval.c
+++ /dev/null
@@ -1,194 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Handle caching attributes in page tables (PAT)
- *
- * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- *          Suresh B Siddha <suresh.b.siddha@intel.com>
- *
- * Interval tree used to store the PAT memory type reservations.
- */
-
-#include <linux/seq_file.h>
-#include <linux/debugfs.h>
-#include <linux/kernel.h>
-#include <linux/interval_tree_generic.h>
-#include <linux/sched.h>
-#include <linux/gfp.h>
-
-#include <asm/pgtable.h>
-#include <asm/pat.h>
-
-#include "pat_internal.h"
-
-/*
- * The memtype tree keeps track of memory type for specific
- * physical memory areas. Without proper tracking, conflicting memory
- * types in different mappings can cause CPU cache corruption.
- *
- * The tree is an interval tree (augmented rbtree) which tree is ordered
- * by the starting address. The tree can contain multiple entries for
- * different regions which overlap. All the aliases have the same
- * cache attributes of course, as enforced by the PAT logic.
- *
- * memtype_lock protects the rbtree.
- */
-
-static inline u64 interval_start(struct memtype *entry)
-{
-	return entry->start;
-}
-
-static inline u64 interval_end(struct memtype *entry)
-{
-	return entry->end - 1;
-}
-
-INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
-		     interval_start, interval_end,
-		     static, interval)
-
-static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
-
-enum {
-	MEMTYPE_EXACT_MATCH	= 0,
-	MEMTYPE_END_MATCH	= 1
-};
-
-static struct memtype *memtype_match(u64 start, u64 end, int match_type)
-{
-	struct memtype *entry_match;
-
-	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
-
-	while (entry_match != NULL && entry_match->start < end) {
-		if ((match_type == MEMTYPE_EXACT_MATCH) &&
-		    (entry_match->start == start) && (entry_match->end == end))
-			return entry_match;
-
-		if ((match_type == MEMTYPE_END_MATCH) &&
-		    (entry_match->start < start) && (entry_match->end == end))
-			return entry_match;
-
-		entry_match = interval_iter_next(entry_match, start, end-1);
-	}
-
-	return NULL; /* Returns NULL if there is no match */
-}
-
-static int memtype_check_conflict(u64 start, u64 end,
-				  enum page_cache_mode reqtype,
-				  enum page_cache_mode *newtype)
-{
-	struct memtype *entry_match;
-	enum page_cache_mode found_type = reqtype;
-
-	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
-	if (entry_match == NULL)
-		goto success;
-
-	if (entry_match->type != found_type && newtype == NULL)
-		goto failure;
-
-	dprintk("Overlap at 0x%Lx-0x%Lx\n", entry_match->start, entry_match->end);
-	found_type = entry_match->type;
-
-	entry_match = interval_iter_next(entry_match, start, end-1);
-	while (entry_match) {
-		if (entry_match->type != found_type)
-			goto failure;
-
-		entry_match = interval_iter_next(entry_match, start, end-1);
-	}
-success:
-	if (newtype)
-		*newtype = found_type;
-
-	return 0;
-
-failure:
-	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
-		current->comm, current->pid, start, end,
-		cattr_name(found_type), cattr_name(entry_match->type));
-
-	return -EBUSY;
-}
-
-int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_type)
-{
-	int err = 0;
-
-	err = memtype_check_conflict(entry_new->start, entry_new->end, entry_new->type, ret_type);
-	if (err)
-		return err;
-
-	if (ret_type)
-		entry_new->type = *ret_type;
-
-	interval_insert(entry_new, &memtype_rbroot);
-	return 0;
-}
-
-struct memtype *memtype_erase(u64 start, u64 end)
-{
-	struct memtype *entry_old;
-
-	/*
-	 * Since the memtype_rbroot tree allows overlapping ranges,
-	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
-	 * a whole node for the munmap case.  If no such entry is found,
-	 * it then checks with END_MATCH, i.e. shrink the size of a node
-	 * from the end for the mremap case.
-	 */
-	entry_old = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
-	if (!entry_old) {
-		entry_old = memtype_match(start, end, MEMTYPE_END_MATCH);
-		if (!entry_old)
-			return ERR_PTR(-EINVAL);
-	}
-
-	if (entry_old->start == start) {
-		/* munmap: erase this node */
-		interval_remove(entry_old, &memtype_rbroot);
-	} else {
-		/* mremap: update the end value of this node */
-		interval_remove(entry_old, &memtype_rbroot);
-		entry_old->end = start;
-		interval_insert(entry_old, &memtype_rbroot);
-
-		return NULL;
-	}
-
-	return entry_old;
-}
-
-struct memtype *memtype_lookup(u64 addr)
-{
-	return interval_iter_first(&memtype_rbroot, addr, addr + PAGE_SIZE-1);
-}
-
-/*
- * Debugging helper, copy the Nth entry of the tree into a
- * a copy for printout. This allows us to print out the tree
- * via debugfs, without holding the memtype_lock too long:
- */
-#ifdef CONFIG_DEBUG_FS
-int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos)
-{
-	struct memtype *entry_match;
-	int i = 1;
-
-	entry_match = interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
-
-	while (entry_match && pos != i) {
-		entry_match = interval_iter_next(entry_match, 0, ULONG_MAX);
-		i++;
-	}
-
-	if (entry_match) { /* pos == i */
-		*entry_out = *entry_match;
-		return 0;
-	} else {
-		return 1;
-	}
-}
-#endif
