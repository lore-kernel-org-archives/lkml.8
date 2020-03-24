Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EEC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C189620719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fT0T3waW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCXHbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43055 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXHbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so8588917pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aV00Aos6NfFPctBoXUWMRl1LHyRDZzOvQI99IlvbQVI=;
        b=fT0T3waWDmTJaCyblxvZqXAiyut9XsipmAA9zYYrRhahCx5Tuj7GnkLHgxS5uR+fcu
         oFtlRCXaTdfOYYdIOsufgKmLG9r0qEAGqwhSs70Ij/pbo4pk2FVOeBYxAKWQJAlt/OEH
         kKlEJ3dJJ0lJ3IdwIFj+ghtQoWNCbJm4dAFTEBDBMDnMoRgSFSamKtd2tFiwKFN2+HvJ
         XDxj+FGSVa4m8BbYzFaYAdnOHSRZHWQkJxQwRCXOfJNctC88YUwxaZFE05SkiH9EEFTc
         KT0go2um9CW3u8IgwqSTaaSj/7gjCT8PvwK6xkoA0J/W4V2jZJb6p3s7BIzy507NBH0t
         H4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aV00Aos6NfFPctBoXUWMRl1LHyRDZzOvQI99IlvbQVI=;
        b=VqPpNOdQ73QML2TGsDNaemdIsURDLrLH9ej9UGqYmTMYOJQfsX02utA65IG9/xSzva
         gQfNnrLPE9Ar/MLik0Fbeig3Lu0B02G5Gdg2KEWKaTPJCs8equqZqD3DCQqYw/EbG/Td
         Cr5NEuXrQrRlZduE7svDkXpOZigI6xcEqBA9Jw7i6wXjOeL+2+A9aa+Ta1vDMrGKm2Kj
         otxfWoCmLB0oExlpP9rC4xgpxZERqzYCMGScUuDs4Is5glGB6S1fEka1oM85vw2hjFpX
         RiR52AFBERlVpExgD13x7DsVqSx1UzF/X6Y8yppQln/O4lIa1fuEqa7ID3jHDzybange
         g4ZA==
X-Gm-Message-State: ANhLgQ0+Grg0wMAage6di+T4YiGSauVRrYHoTz2Ip1oerFBY4GYNC7fh
        ipIj/lOGmq5A8xAn+IhFl0puT5sBeog=
X-Google-Smtp-Source: ADFU+vub8hYsaP14B7TYJsABqmijrSWr1OBNZOXedSsNTIs8xznh1U4qgPc6eT95n5xiW0Nnyg9KdQ==
X-Received: by 2002:a63:312:: with SMTP id 18mr25374634pgd.377.1585035062381;
        Tue, 24 Mar 2020 00:31:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:01 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 3/8] riscv/kaslr: support KASLR infrastructure
Date:   Tue, 24 Mar 2020 15:30:48 +0800
Message-Id: <fe97f88c69a9f752a96623afa398c4125aab930f.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch support KASLR implementation. It copies kernel image to a
proper and random place, and make all harts go to the new destination.

After KASLR initialization, secondary harts go to the new destination
to wait their stack pointer to be setup by main hart, main hart goes to
re-create the early page table and doing relocation by going back to
setup_vm again.

We separate the randomization process from this patch, so the kernel
offset was not randomized yet, it just hardcode a meanless number here.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig         | 15 +++++++++++
 arch/riscv/kernel/Makefile |  2 ++
 arch/riscv/kernel/head.S   | 39 +++++++++++++++++++++++++++
 arch/riscv/kernel/kaslr.c  | 55 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/init.c       | 53 +++++++++++++++++++++++++++++++++++-
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/kaslr.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index aea03ac470c8..8f566b40ea1e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -183,6 +183,21 @@ config RELOCATABLE
           relocation pass at runtime even if the kernel is loaded at the
           same address it was linked at.
 
+config RANDOMIZE_BASE
+	bool "Randomize the address of the kernel image"
+	depends on MMU
+	select MODULE_SECTIONS if MODULES
+	select RELOCATABLE
+	help
+	  Randomizes the virtual address at which the kernel image is
+	  loaded, as a security feature that deters exploit attempts
+	  relying on knowledge of the location of kernel internals.
+
+	  It is the job of previous stage to provide entropy, by passing a
+	  random u64 value in /chosen/kaslr-seed at kernel entry.
+
+	  If unsure, say N.
+
 source "arch/riscv/Kconfig.socs"
 
 menu "Platform type"
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index d189bd3d8501..8f62732b1135 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -45,4 +45,6 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 
+obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
+
 clean:
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index cb4a6e2d3793..5191e528d813 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -113,9 +113,12 @@ clear_bss_done:
 	la a2, boot_cpu_hartid
 	REG_S a0, (a2)
 
+.align 2
+early_page_table:
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
 	mv a0, s1
+
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
@@ -127,6 +130,29 @@ clear_bss_done:
 	sw zero, TASK_TI_CPU(tp)
 	la sp, init_thread_union + THREAD_SIZE
 
+#ifdef CONFIG_RANDOMIZE_BASE
+	/* KASRL initialization. Try to get a random kernel offset. */
+	call kaslr_early_init
+
+	/* If return value equals to zero, we don't need to randomize kernel */
+	beqz a0, 1f
+
+	la a1, early_page_table
+	add a1, a1, a0
+	la a0, va_pa_offset
+	REG_L a0, 0(a0)
+	sub a1, a1, a0
+	mv a0, s1
+
+	/*
+	 * Go to new kernel image destination, and disable MMU to re-create
+	 * early page table and do relocation.
+	 */
+	csrw CSR_TVEC, a1
+	csrw CSR_SATP, x0
+1:
+#endif
+
 #ifdef CONFIG_KASAN
 	call kasan_early_init
 #endif
@@ -194,6 +220,19 @@ relocate:
 	la a3, .Lsecondary_park
 	csrw CSR_TVEC, a3
 
+#ifdef CONFIG_RANDOMIZE_BASE
+	/*
+	 * Wait winning hart to tell secondary harts where is the new
+	 * destination to go.
+	 */
+.Lwait_for_next_target:
+	la a3, secondary_next_target
+	REG_L a3, 0(a3)
+	beqz a3, .Lwait_for_next_target
+	jr a3
+.global secondary_random_target
+secondary_random_target:
+#endif
 	slli a3, a0, LGREG
 	la a1, __cpu_up_stack_pointer
 	la a2, __cpu_up_task_pointer
diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
new file mode 100644
index 000000000000..281b5fcca5c8
--- /dev/null
+++ b/arch/riscv/kernel/kaslr.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 SiFive
+ * Copyright (C) 2020 Zong Li <zong.li@sifive.com>
+ */
+
+#include <linux/libfdt.h>
+#include <linux/timex.h>
+#include <linux/random.h>
+#include <linux/set_memory.h>
+#include <asm/cacheflush.h>
+
+extern char _start[], _end[];
+extern void secondary_random_target(void);
+extern void kaslr_create_page_table(uintptr_t start, uintptr_t end);
+
+uintptr_t secondary_next_target __initdata;
+static uintptr_t kaslr_offset __initdata;
+
+uintptr_t __init kaslr_early_init(void)
+{
+	uintptr_t dest_start, dest_end;
+	uintptr_t kernel_size = (uintptr_t) _end - (uintptr_t) _start;
+
+	/* Get zero value at second time to avoid doing randomization again. */
+	if (kaslr_offset)
+		return 0;
+
+	/* Get the random number for kaslr offset. */
+	kaslr_offset = 0x10000000;
+
+	/* Update kernel_virt_addr for get_kaslr_offset. */
+	kernel_virt_addr += kaslr_offset;
+
+	if (kaslr_offset) {
+		dest_start = (uintptr_t) (PAGE_OFFSET + kaslr_offset);
+		dest_end = dest_start + kernel_size;
+
+		/* Create the new destination mapping for kernel image. */
+		kaslr_create_page_table(dest_start, dest_end);
+
+		/* Copy kernel image from orignial location. */
+		memcpy((void *)dest_start, (void *)_start, kernel_size);
+		flush_icache_range(dest_start, dest_end);
+
+		/* Make secondary harts jump to new kernel image destination. */
+		WRITE_ONCE(secondary_next_target,
+			   __pa_symbol(secondary_random_target) + kaslr_offset);
+	} else {
+		WRITE_ONCE(secondary_next_target,
+			   __pa_symbol(secondary_random_target));
+	}
+
+	return kaslr_offset;
+}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 51e263c04fa2..2f5b25f02b6c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -413,6 +413,41 @@ static void __init clear_pgd(pgd_t *pgdp)
 			}
 		}
 }
+
+static void __init clear_page_tables(void)
+{
+	clear_pgd(early_pg_dir);
+	clear_pgd(trampoline_pg_dir);
+}
+
+void __init kaslr_create_page_table(uintptr_t start, uintptr_t end)
+{
+	pgd_next_t *nextp;
+	phys_addr_t next_phys;
+	uintptr_t pgd_index, va;
+	phys_addr_t pa = __pa(PAGE_OFFSET) + get_kaslr_offset();
+	uintptr_t map_size =
+		best_map_size(__pa(PAGE_OFFSET), MAX_EARLY_MAPPING_SIZE);
+
+	/* Expolit early_pg_dir and early_pmd during using early page table. */
+	for (va = start; va < end; va += map_size, pa += map_size) {
+		pgd_index = pgd_index(va);
+
+		if (pgd_val(early_pg_dir[pgd_index]) == 0) {
+			next_phys = alloc_pgd_next(va);
+			early_pg_dir[pgd_index] =
+				pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
+			nextp = (pgd_next_t *)(__va(next_phys));
+			memset(nextp, 0, PAGE_SIZE);
+		} else {
+			next_phys = PFN_PHYS(_pgd_pfn(early_pg_dir[pgd_index]));
+			nextp = (pgd_next_t *)(__va(next_phys));
+		}
+
+		create_pgd_next_mapping(nextp, va, pa, map_size,
+					PAGE_KERNEL_EXEC);
+	}
+}
 #endif
 
 /*
@@ -489,7 +524,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
 
 	va_pa_offset = kernel_virt_addr - load_pa;
-	pfn_base = PFN_DOWN(load_pa);
+
+	/*
+	 * Update pfn_base only if pfn_base is empty. It's avoid to mess up it
+	 * when re-enter this function by KASLR.
+	 */
+	if (!pfn_base)
+		pfn_base = PFN_DOWN(load_pa);
 
 #ifdef CONFIG_RELOCATABLE
 	/*
@@ -513,6 +554,16 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((load_pa % map_size) != 0);
 	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
 
+#ifdef CONFIG_RANDOMIZE_BASE
+	/*
+	 * Enter setup_vm twice if there is a legal random destination in KASLR,
+	 * Reach here at second time, Clear page table because PTE entris allow
+	 * writing when it's empty.
+	 */
+	if (get_kaslr_offset())
+		clear_page_tables();
+#endif
+
 	/* Setup early PGD for fixmap */
 	create_pgd_mapping(early_pg_dir, FIXADDR_START,
 			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
-- 
2.25.1

