Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B52C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5534C21941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UORH1UJO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUd76JAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgIJJ0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:26:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgIJJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:14 -0400
Date:   Thu, 10 Sep 2020 09:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3v9VQA2HW8/2mfkFz1TsejnH1B476u+6CJdGIZnhrg=;
        b=UORH1UJO1FXWaeBCVPpmdtxy/ZPF4p3Xl+sdshmB1orIFG0TlKO5ZHg99WBSBVWrqzy3Sb
        zSDJxAkxGfgxK934cRBNYfoP45Byt9xOWUOafqtLsWaWsdxHYniFhhvcsncVM4rvZBqvIn
        tgDXMr1msbRi4LTOqVm0Y85PkZxFLFjGU+H1Ni0RWzRf9sO4b8m+FLlk5slnD7lhWYEC61
        uiMwsRByhtRFMZ+Rp183YV9pKH7NKnQ2C/84uWhZ2EHfcf/d5dz6dkgyvzAY7YGC25ce1L
        qj/ix+mquFbr5u8tRPUJQ+Fu4wXlBbVFE7n1LFaNupa05/jo1lrOIesFcUcKfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3v9VQA2HW8/2mfkFz1TsejnH1B476u+6CJdGIZnhrg=;
        b=iUd76JANH3Sw5cyKvaSwbSaP/3dgdt3pF2GEkoZg1miC4E5IgL2prxmxkpnRCSbH0gr0cs
        Y6/kh24J4NBSHPBA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Rename kaslr_64.c to ident_map_64.c
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-15-joro@8bytes.org>
References: <20200907131613.12703-15-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974684.20229.17118173690351882447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     5f2bb01682b7b067783207994c7b8a3dbeb1cd83
Gitweb:        https://git.kernel.org/tip/5f2bb01682b7b067783207994c7b8a3dbeb1cd83
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Rename kaslr_64.c to ident_map_64.c

The file contains only code related to identity-mapped page tables.
Rename the file and compile it always in.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-15-joro@8bytes.org
---
 arch/x86/boot/compressed/Makefile       |   2 +-
 arch/x86/boot/compressed/ident_map_64.c | 162 +++++++++++++++++++++++-
 arch/x86/boot/compressed/kaslr.c        |   9 +-
 arch/x86/boot/compressed/kaslr_64.c     | 153 +----------------------
 arch/x86/boot/compressed/misc.h         |   8 +-
 5 files changed, 171 insertions(+), 163 deletions(-)
 create mode 100644 arch/x86/boot/compressed/ident_map_64.c
 delete mode 100644 arch/x86/boot/compressed/kaslr_64.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index c661dc5..e7f3eba 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,7 +84,7 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
 ifdef CONFIG_X86_64
-	vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr_64.o
+	vmlinux-objs-y += $(obj)/ident_map_64.o
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
new file mode 100644
index 0000000..d9932a1
--- /dev/null
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This code is used on x86_64 to create page table identity mappings on
+ * demand by building up a new set of page tables (or appending to the
+ * existing ones), and then switching over to them when ready.
+ *
+ * Copyright (C) 2015-2016  Yinghai Lu
+ * Copyright (C)      2016  Kees Cook
+ */
+
+/*
+ * Since we're dealing with identity mappings, physical and virtual
+ * addresses are the same, so override these defines which are ultimately
+ * used by the headers in misc.h.
+ */
+#define __pa(x)  ((unsigned long)(x))
+#define __va(x)  ((void *)((unsigned long)(x)))
+
+/* No PAGE_TABLE_ISOLATION support needed either: */
+#undef CONFIG_PAGE_TABLE_ISOLATION
+
+#include "misc.h"
+
+/* These actually do the work of building the kernel identity maps. */
+#include <linux/pgtable.h>
+#include <asm/init.h>
+/* Use the static base for this part of the boot process */
+#undef __PAGE_OFFSET
+#define __PAGE_OFFSET __PAGE_OFFSET_BASE
+#include "../../mm/ident_map.c"
+
+#ifdef CONFIG_X86_5LEVEL
+unsigned int __pgtable_l5_enabled;
+unsigned int pgdir_shift = 39;
+unsigned int ptrs_per_p4d = 1;
+#endif
+
+/* Used by PAGE_KERN* macros: */
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;
+
+/* Used to track our page table allocation area. */
+struct alloc_pgt_data {
+	unsigned char *pgt_buf;
+	unsigned long pgt_buf_size;
+	unsigned long pgt_buf_offset;
+};
+
+/*
+ * Allocates space for a page table entry, using struct alloc_pgt_data
+ * above. Besides the local callers, this is used as the allocation
+ * callback in mapping_info below.
+ */
+static void *alloc_pgt_page(void *context)
+{
+	struct alloc_pgt_data *pages = (struct alloc_pgt_data *)context;
+	unsigned char *entry;
+
+	/* Validate there is space available for a new page. */
+	if (pages->pgt_buf_offset >= pages->pgt_buf_size) {
+		debug_putstr("out of pgt_buf in " __FILE__ "!?\n");
+		debug_putaddr(pages->pgt_buf_offset);
+		debug_putaddr(pages->pgt_buf_size);
+		return NULL;
+	}
+
+	entry = pages->pgt_buf + pages->pgt_buf_offset;
+	pages->pgt_buf_offset += PAGE_SIZE;
+
+	return entry;
+}
+
+/* Used to track our allocated page tables. */
+static struct alloc_pgt_data pgt_data;
+
+/* The top level page table entry pointer. */
+static unsigned long top_level_pgt;
+
+phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+
+/*
+ * Mapping information structure passed to kernel_ident_mapping_init().
+ * Due to relocation, pointers must be assigned at run time not build time.
+ */
+static struct x86_mapping_info mapping_info;
+
+/* Locates and clears a region for a new top level page table. */
+void initialize_identity_maps(void)
+{
+	/* If running as an SEV guest, the encryption mask is required. */
+	set_sev_encryption_mask();
+
+	/* Exclude the encryption mask from __PHYSICAL_MASK */
+	physical_mask &= ~sme_me_mask;
+
+	/* Init mapping_info with run-time function/buffer pointers. */
+	mapping_info.alloc_pgt_page = alloc_pgt_page;
+	mapping_info.context = &pgt_data;
+	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
+	mapping_info.kernpg_flag = _KERNPG_TABLE;
+
+	/*
+	 * It should be impossible for this not to already be true,
+	 * but since calling this a second time would rewind the other
+	 * counters, let's just make sure this is reset too.
+	 */
+	pgt_data.pgt_buf_offset = 0;
+
+	/*
+	 * If we came here via startup_32(), cr3 will be _pgtable already
+	 * and we must append to the existing area instead of entirely
+	 * overwriting it.
+	 *
+	 * With 5-level paging, we use '_pgtable' to allocate the p4d page table,
+	 * the top-level page table is allocated separately.
+	 *
+	 * p4d_offset(top_level_pgt, 0) would cover both the 4- and 5-level
+	 * cases. On 4-level paging it's equal to 'top_level_pgt'.
+	 */
+	top_level_pgt = read_cr3_pa();
+	if (p4d_offset((pgd_t *)top_level_pgt, 0) == (p4d_t *)_pgtable) {
+		debug_putstr("booted via startup_32()\n");
+		pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
+		pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
+		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
+	} else {
+		debug_putstr("booted via startup_64()\n");
+		pgt_data.pgt_buf = _pgtable;
+		pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
+		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
+		top_level_pgt = (unsigned long)alloc_pgt_page(&pgt_data);
+	}
+}
+
+/*
+ * Adds the specified range to what will become the new identity mappings.
+ * Once all ranges have been added, the new mapping is activated by calling
+ * finalize_identity_maps() below.
+ */
+void add_identity_map(unsigned long start, unsigned long size)
+{
+	unsigned long end = start + size;
+
+	/* Align boundary to 2M. */
+	start = round_down(start, PMD_SIZE);
+	end = round_up(end, PMD_SIZE);
+	if (start >= end)
+		return;
+
+	/* Build the mapping. */
+	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
+				  start, end);
+}
+
+/*
+ * This switches the page tables to the new level4 that has been built
+ * via calls to add_identity_map() above. If booted via startup_32(),
+ * this is effectively a no-op.
+ */
+void finalize_identity_maps(void)
+{
+	write_cr3(top_level_pgt);
+}
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 877970d..e27de98 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -40,17 +40,8 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled;
-unsigned int pgdir_shift __ro_after_init = 39;
-unsigned int ptrs_per_p4d __ro_after_init = 1;
-#endif
-
 extern unsigned long get_cmd_line_ptr(void);
 
-/* Used by PAGE_KERN* macros: */
-pteval_t __default_kernel_pte_mask __read_mostly = ~0;
-
 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
deleted file mode 100644
index f9c5c13..0000000
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ /dev/null
@@ -1,153 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This code is used on x86_64 to create page table identity mappings on
- * demand by building up a new set of page tables (or appending to the
- * existing ones), and then switching over to them when ready.
- *
- * Copyright (C) 2015-2016  Yinghai Lu
- * Copyright (C)      2016  Kees Cook
- */
-
-/*
- * Since we're dealing with identity mappings, physical and virtual
- * addresses are the same, so override these defines which are ultimately
- * used by the headers in misc.h.
- */
-#define __pa(x)  ((unsigned long)(x))
-#define __va(x)  ((void *)((unsigned long)(x)))
-
-/* No PAGE_TABLE_ISOLATION support needed either: */
-#undef CONFIG_PAGE_TABLE_ISOLATION
-
-#include "misc.h"
-
-/* These actually do the work of building the kernel identity maps. */
-#include <linux/pgtable.h>
-#include <asm/init.h>
-/* Use the static base for this part of the boot process */
-#undef __PAGE_OFFSET
-#define __PAGE_OFFSET __PAGE_OFFSET_BASE
-#include "../../mm/ident_map.c"
-
-/* Used to track our page table allocation area. */
-struct alloc_pgt_data {
-	unsigned char *pgt_buf;
-	unsigned long pgt_buf_size;
-	unsigned long pgt_buf_offset;
-};
-
-/*
- * Allocates space for a page table entry, using struct alloc_pgt_data
- * above. Besides the local callers, this is used as the allocation
- * callback in mapping_info below.
- */
-static void *alloc_pgt_page(void *context)
-{
-	struct alloc_pgt_data *pages = (struct alloc_pgt_data *)context;
-	unsigned char *entry;
-
-	/* Validate there is space available for a new page. */
-	if (pages->pgt_buf_offset >= pages->pgt_buf_size) {
-		debug_putstr("out of pgt_buf in " __FILE__ "!?\n");
-		debug_putaddr(pages->pgt_buf_offset);
-		debug_putaddr(pages->pgt_buf_size);
-		return NULL;
-	}
-
-	entry = pages->pgt_buf + pages->pgt_buf_offset;
-	pages->pgt_buf_offset += PAGE_SIZE;
-
-	return entry;
-}
-
-/* Used to track our allocated page tables. */
-static struct alloc_pgt_data pgt_data;
-
-/* The top level page table entry pointer. */
-static unsigned long top_level_pgt;
-
-phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
-
-/*
- * Mapping information structure passed to kernel_ident_mapping_init().
- * Due to relocation, pointers must be assigned at run time not build time.
- */
-static struct x86_mapping_info mapping_info;
-
-/* Locates and clears a region for a new top level page table. */
-void initialize_identity_maps(void)
-{
-	/* If running as an SEV guest, the encryption mask is required. */
-	set_sev_encryption_mask();
-
-	/* Exclude the encryption mask from __PHYSICAL_MASK */
-	physical_mask &= ~sme_me_mask;
-
-	/* Init mapping_info with run-time function/buffer pointers. */
-	mapping_info.alloc_pgt_page = alloc_pgt_page;
-	mapping_info.context = &pgt_data;
-	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
-	mapping_info.kernpg_flag = _KERNPG_TABLE;
-
-	/*
-	 * It should be impossible for this not to already be true,
-	 * but since calling this a second time would rewind the other
-	 * counters, let's just make sure this is reset too.
-	 */
-	pgt_data.pgt_buf_offset = 0;
-
-	/*
-	 * If we came here via startup_32(), cr3 will be _pgtable already
-	 * and we must append to the existing area instead of entirely
-	 * overwriting it.
-	 *
-	 * With 5-level paging, we use '_pgtable' to allocate the p4d page table,
-	 * the top-level page table is allocated separately.
-	 *
-	 * p4d_offset(top_level_pgt, 0) would cover both the 4- and 5-level
-	 * cases. On 4-level paging it's equal to 'top_level_pgt'.
-	 */
-	top_level_pgt = read_cr3_pa();
-	if (p4d_offset((pgd_t *)top_level_pgt, 0) == (p4d_t *)_pgtable) {
-		debug_putstr("booted via startup_32()\n");
-		pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
-		pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
-		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
-	} else {
-		debug_putstr("booted via startup_64()\n");
-		pgt_data.pgt_buf = _pgtable;
-		pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
-		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
-		top_level_pgt = (unsigned long)alloc_pgt_page(&pgt_data);
-	}
-}
-
-/*
- * Adds the specified range to what will become the new identity mappings.
- * Once all ranges have been added, the new mapping is activated by calling
- * finalize_identity_maps() below.
- */
-void add_identity_map(unsigned long start, unsigned long size)
-{
-	unsigned long end = start + size;
-
-	/* Align boundary to 2M. */
-	start = round_down(start, PMD_SIZE);
-	end = round_up(end, PMD_SIZE);
-	if (start >= end)
-		return;
-
-	/* Build the mapping. */
-	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
-				  start, end);
-}
-
-/*
- * This switches the page tables to the new level4 that has been built
- * via calls to add_identity_map() above. If booted via startup_32(),
- * this is effectively a no-op.
- */
-void finalize_identity_maps(void)
-{
-	write_cr3(top_level_pgt);
-}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 8feb5f6..98b7a1d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -134,6 +134,14 @@ int count_immovable_mem_regions(void);
 static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
 
+/* ident_map_64.c */
+#ifdef CONFIG_X86_5LEVEL
+extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
+#endif
+
+/* Used by PAGE_KERN* macros: */
+extern pteval_t __default_kernel_pte_mask;
+
 /* idt_64.c */
 extern gate_desc boot_idt[BOOT_IDT_ENTRIES];
 extern struct desc_ptr boot_idt_desc;
