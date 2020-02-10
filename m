Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64924C3B184
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D761208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TaZLUGl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBJIfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:35:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39667 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgBJIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:35:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so3524020pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZtugCovuiY8oawv9NcCY9nsL5u7rZRlkF2gVWwkKqU=;
        b=TaZLUGl7d1wgv9IZ0dhogMchkwa+VUZZLFcDfgA5X2KYjmtdi11jXVG/dP2RT+olWf
         MZJw9axiiCpbu1WkgwNC+Sfff7+bh+8heQeTEBTBCRpOvpnnttAGxZf4eGtR4BYraPgf
         fakdmRm2CYF2i8lyxHluc+iQhIiXuZBD1k8PUs/pFFoVWLlvtbRBO07rQCubh1/3/COD
         op4hVvMoG/yr+Xbv1v3gtiWdr9QArsxYJHuqV8tuE6TkXEROZjMr8iiOYIqmNHpDar2A
         qTyR0In/vj6O+1MMXrnBj7SpM0vl4f42p6io1Yrj97KrilOy5GEGKsOGtkiY9w1bWzGX
         oj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZtugCovuiY8oawv9NcCY9nsL5u7rZRlkF2gVWwkKqU=;
        b=e6zjOMaHE5kt+fhwuaU++M2jRBhgOE9/LmNU3MylYQuMNulcGFqc3zzp0Lsfyhrm59
         ZIhK7xxN1uNgC0X6NUTrVwGYF3RU3In5I/Ax30IIwZWUxE231f1nuYi5IxACwkJkimac
         uMuu+JBxHt27mfc3eX7oN6uL+1S3h0EmfzovmyvUi43du5UzT4VhtuZGsof+ckddIBjW
         1OT/dPHJwxA/HVSX0YWabv8xhrUhRsZ3AO+tGKqKBPmsvLbxwkYn+vM/mPk/1HP1XG4P
         KFRaRKIkY7pTnzpyGjbu1BBkD02WMHUbeKR24DekLkk7ma2sF841jTHr7FYpQ/b+0COF
         Dcvg==
X-Gm-Message-State: APjAAAVd4pJCToEDv7//V7QVnDFW11eUlj8REUwiGDy0Tz/hubPLiJ9Y
        V1uDts6NIn9s72QRpK055sJ+jueTvmM=
X-Google-Smtp-Source: APXvYqxr7G+FGRseNAGheltXbcyhGDTXPPd08k8piODZNopRVspKt/aZpfYBAHQGNBWSwsCacxFeBg==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr127653pfq.138.1581323722225;
        Mon, 10 Feb 2020 00:35:22 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id q8sm10582409pje.2.2020.02.10.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 00:35:21 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/2] riscv: Add support to dump the kernel page tables
Date:   Mon, 10 Feb 2020 16:35:14 +0800
Message-Id: <20200210083515.10864-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210083515.10864-1-zong.li@sifive.com>
References: <20200210083515.10864-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a similar manner to arm64, x86, powerpc, etc., it can traverse all
page tables, and dump the page table layout with the memory types and
permissions.

Add a debugfs file at /sys/kernel/debug/kernel_page_tables to export
the page table layout to userspace.

Changes in v2:
- Remove #ifdef CONFIG_PTDUMP_CORE in header. Suggested by Steven Price.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/pgtable.h |  10 +
 arch/riscv/include/asm/ptdump.h  |  11 ++
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/ptdump.c           | 317 +++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/mm/ptdump.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 73f029eae0cc..6e81da55b5e4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -29,6 +29,7 @@ config RISCV
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_IOREMAP
+	select GENERIC_PTDUMP
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e43041519edd..ac353e44f80c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -444,6 +444,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #endif
 #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
 
+/*
+ * In the RV64 Linux scheme, we give the user half of the virtual-address space
+ * and give the kernel the other (upper) half.
+ */
+#ifdef CONFIG_64BIT
+#define KERN_VIRT_START	(-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
+#else
+#define KERN_VIRT_START	FIXADDR_START
+#endif
+
 /*
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
new file mode 100644
index 000000000000..e29af7191909
--- /dev/null
+++ b/arch/riscv/include/asm/ptdump.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#ifndef _ASM_RISCV_PTDUMP_H
+#define _ASM_RISCV_PTDUMP_H
+
+void ptdump_check_wx(void);
+
+#endif /* _ASM_RISCV_PTDUMP_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 50b7af58c566..814e16a8d68a 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -15,6 +15,7 @@ ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
 endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
 
 ifdef CONFIG_KASAN
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
new file mode 100644
index 000000000000..9a67e723fff7
--- /dev/null
+++ b/arch/riscv/mm/ptdump.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#include <linux/init.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/ptdump.h>
+
+#include <asm/ptdump.h>
+#include <asm/pgtable.h>
+#include <asm/kasan.h>
+
+#define pt_dump_seq_printf(m, fmt, args...)	\
+({						\
+	if (m)					\
+		seq_printf(m, fmt, ##args);	\
+})
+
+#define pt_dump_seq_puts(m, fmt)	\
+({					\
+	if (m)				\
+		seq_printf(m, fmt);	\
+})
+
+/*
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the pte entries. When the continuity is broken it then
+ * dumps out a description of the range.
+ */
+struct pg_state {
+	struct ptdump_state ptdump;
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	unsigned long start_address;
+	unsigned long start_pa;
+	unsigned long last_pa;
+	int level;
+	u64 current_prot;
+	bool check_wx;
+	unsigned long wx_pages;
+};
+
+/* Address marker */
+struct addr_marker {
+	unsigned long start_address;
+	const char *name;
+};
+
+static struct addr_marker address_markers[] = {
+#ifdef CONFIG_KASAN
+	{KASAN_SHADOW_START,	"Kasan shadow start"},
+	{KASAN_SHADOW_END,	"Kasan shadow end"},
+#endif
+	{FIXADDR_START,		"Fixmap start"},
+	{FIXADDR_TOP,		"Fixmap end"},
+	{PCI_IO_START,		"PCI I/O start"},
+	{PCI_IO_END,		"PCI I/O end"},
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	{VMEMMAP_START,		"vmemmap start"},
+	{VMEMMAP_END,		"vmemmap end"},
+#endif
+	{VMALLOC_START,		"vmalloc() area"},
+	{VMALLOC_END,		"vmalloc() end"},
+	{PAGE_OFFSET,		"Linear mapping"},
+	{-1, NULL},
+};
+
+/* Page Table Entry */
+struct prot_bits {
+	u64 mask;
+	u64 val;
+	const char *set;
+	const char *clear;
+};
+
+static const struct prot_bits pte_bits[] = {
+	{
+		.mask = _PAGE_SOFT,
+		.val = _PAGE_SOFT,
+		.set = "RSW",
+		.clear = "   ",
+	}, {
+		.mask = _PAGE_DIRTY,
+		.val = _PAGE_DIRTY,
+		.set = "D",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_ACCESSED,
+		.val = _PAGE_ACCESSED,
+		.set = "A",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_GLOBAL,
+		.val = _PAGE_GLOBAL,
+		.set = "G",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_USER,
+		.val = _PAGE_USER,
+		.set = "U",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_EXEC,
+		.val = _PAGE_EXEC,
+		.set = "X",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_WRITE,
+		.val = _PAGE_WRITE,
+		.set = "W",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_READ,
+		.val = _PAGE_READ,
+		.set = "R",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_PRESENT,
+		.val = _PAGE_PRESENT,
+		.set = "V",
+		.clear = ".",
+	}
+};
+
+/* Page Level */
+struct pg_level {
+	const char *name;
+	u64 mask;
+};
+
+static struct pg_level pg_level[] = {
+	{ /* pgd */
+		.name = "PGD",
+	}, { /* p4d */
+		.name = (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
+	}, { /* pud */
+		.name = (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+	}, { /* pmd */
+		.name = (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+	}, { /* pte */
+		.name = "PTE",
+	},
+};
+
+static void dump_prot(struct pg_state *st)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
+		const char *s;
+
+		if ((st->current_prot & pte_bits[i].mask) == pte_bits[i].val)
+			s = pte_bits[i].set;
+		else
+			s = pte_bits[i].clear;
+
+		if (s)
+			pt_dump_seq_printf(st->seq, " %s", s);
+	}
+}
+
+#ifdef CONFIG_64BIT
+#define ADDR_FORMAT	"0x%016lx"
+#else
+#define ADDR_FORMAT	"0x%08lx"
+#endif
+static void dump_addr(struct pg_state *st, unsigned long addr)
+{
+	static const char units[] = "KMGTPE";
+	const char *unit = units;
+	unsigned long delta;
+
+	pt_dump_seq_printf(st->seq, ADDR_FORMAT "-" ADDR_FORMAT "   ",
+			   st->start_address, addr);
+
+	pt_dump_seq_printf(st->seq, " " ADDR_FORMAT " ", st->start_pa);
+	delta = (addr - st->start_address) >> 10;
+
+	while (!(delta & 1023) && unit[1]) {
+		delta >>= 10;
+		unit++;
+	}
+
+	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
+			   pg_level[st->level].name);
+}
+
+static void note_prot_wx(struct pg_state *st, unsigned long addr)
+{
+	if (!st->check_wx)
+		return;
+
+	if ((st->current_prot & (_PAGE_WRITE | _PAGE_EXEC)) !=
+	    (_PAGE_WRITE | _PAGE_EXEC))
+		return;
+
+	WARN_ONCE(1, "riscv/mm: Found insecure W+X mapping at address %p/%pS\n",
+		  (void *)st->start_address, (void *)st->start_address);
+
+	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
+}
+
+static void note_page(struct ptdump_state *pt_st, unsigned long addr,
+		      int level, unsigned long val)
+{
+	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
+	u64 prot = 0;
+
+	if (level >= 0)
+		prot = val & pg_level[level].mask;
+
+	if (st->level == -1) {
+		st->level = level;
+		st->current_prot = prot;
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	} else if (prot != st->current_prot ||
+		   level != st->level || addr >= st->marker[1].start_address) {
+		if (st->current_prot) {
+			note_prot_wx(st, addr);
+			dump_addr(st, addr);
+			dump_prot(st);
+			pt_dump_seq_puts(st->seq, "\n");
+		}
+
+		while (addr >= st->marker[1].start_address) {
+			st->marker++;
+			pt_dump_seq_printf(st->seq, "---[ %s ]---\n",
+					   st->marker->name);
+		}
+
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		st->current_prot = prot;
+		st->level = level;
+	} else {
+		st->last_pa = pa;
+	}
+}
+
+static void ptdump_walk(struct seq_file *s)
+{
+	struct pg_state st = {
+		.seq = s,
+		.marker = address_markers,
+		.level = -1,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]) {
+				{KERN_VIRT_START, ULONG_MAX},
+				{0, 0}
+			}
+		}
+	};
+
+	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+}
+
+void ptdump_check_wx(void)
+{
+	struct pg_state st = {
+		.seq = NULL,
+		.marker = (struct addr_marker[]) {
+			{0, NULL},
+			{-1, NULL},
+		},
+		.level = -1,
+		.check_wx = true,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]) {
+				{KERN_VIRT_START, ULONG_MAX},
+				{0, 0}
+			}
+		}
+	};
+
+	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+
+	if (st.wx_pages)
+		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
+			st.wx_pages);
+	else
+		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
+}
+
+static int ptdump_show(struct seq_file *m, void *v)
+{
+	ptdump_walk(m);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(ptdump);
+
+static int ptdump_init(void)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
+		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
+			pg_level[i].mask |= pte_bits[j].mask;
+
+	debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
+			    &ptdump_fops);
+
+	return 0;
+}
+
+device_initcall(ptdump_init);
-- 
2.25.0

