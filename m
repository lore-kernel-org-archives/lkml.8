Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F53C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3F42078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSOJ3mS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPb4zR+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgHVNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgHVNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 09:39:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8CC061573;
        Sat, 22 Aug 2020 06:39:00 -0700 (PDT)
Date:   Sat, 22 Aug 2020 13:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598103538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GN0PC7Pif+jrqS7c50GEn9tp0ajxemty22qWtDObI6U=;
        b=MSOJ3mS1HC7nQALHa7mR5FH1zteLCJ5HodFMAiA2W6NJBEL/6v6BqoC7KCFHhOybtIVI+d
        Yo7XygoU0AMh/abOsesSN2s1jsuzVg3SDIx34iSdLvIBIFyfsrvNVbxqL592wUoRVeBE95
        DgpWtZV8r3iIUOMjaVzRroPAMrj3QPt1D+J3E22MgEYkK3y0/OToJGBXltY4j1olg/5hDA
        NeCnFZIdqcYvHMy1TgPnkslHWowlBgL065wzIfFbcjYFO1rerWvj9nlBKzDZUQomSf/0g6
        LXFfTVqaj422phVsYQmGdZvVdT+PC+KDe6djpJPLgqij1FGKEAsUkfXN08A+mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598103538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GN0PC7Pif+jrqS7c50GEn9tp0ajxemty22qWtDObI6U=;
        b=wPb4zR+3ihpPUsmFg+prpJ42UaZrKslbgH9FIb7Oij6x6YaNHvoLH/JBNELi2K2UukxExO
        ayY1oJSAJFErcvCA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Move 32-bit code into efi_32.c
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159810353815.3192.485619706663820751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     39ada88f9c862c1ff8929ff67e0d1199c7af73fe
Gitweb:        https://git.kernel.org/tip/39ada88f9c862c1ff8929ff67e0d1199c7af73fe
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 13 Aug 2020 19:38:17 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 20 Aug 2020 11:18:36 +02:00

efi/x86: Move 32-bit code into efi_32.c

Now that the old memmap code has been removed, some code that was left
behind in arch/x86/platform/efi/efi.c is only used for 32-bit builds,
which means it can live in efi_32.c as well. So move it over.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     | 10 +-----
 arch/x86/platform/efi/efi.c    | 69 +---------------------------------
 arch/x86/platform/efi/efi_32.c | 44 +++++++++++++++++----
 3 files changed, 37 insertions(+), 86 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b9c2667..bc9758e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -81,11 +81,8 @@ extern unsigned long efi_fw_vendor, efi_config_table;
 	kernel_fpu_end();						\
 })
 
-
 #define arch_efi_call_virt(p, f, args...)	p->f(args)
 
-#define efi_ioremap(addr, size, type, attr)	ioremap_cache(addr, size)
-
 #else /* !CONFIG_X86_32 */
 
 #define EFI_LOADER_SIGNATURE	"EL64"
@@ -125,9 +122,6 @@ struct efi_scratch {
 	kernel_fpu_end();						\
 })
 
-extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
-					u32 type, u64 attribute);
-
 #ifdef CONFIG_KASAN
 /*
  * CONFIG_KASAN may redefine memset to __memset.  __memset function is present
@@ -143,17 +137,13 @@ extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
 #endif /* CONFIG_X86_32 */
 
 extern struct efi_scratch efi_scratch;
-extern void __init efi_set_executable(efi_memory_desc_t *md, bool executable);
 extern int __init efi_memblock_x86_reserve_range(void);
 extern void __init efi_print_memmap(void);
-extern void __init efi_memory_uc(u64 addr, unsigned long size);
 extern void __init efi_map_region(efi_memory_desc_t *md);
 extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
 extern void efi_sync_low_kernel_mappings(void);
 extern int __init efi_alloc_page_tables(void);
 extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
-extern void __init old_map_region(efi_memory_desc_t *md);
-extern void __init runtime_code_page_mkexec(void);
 extern void __init efi_runtime_update_mappings(void);
 extern void __init efi_dump_pagetable(void);
 extern void __init efi_apply_memmap_quirks(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f6ea8f1..d37ebe6 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -49,7 +49,6 @@
 #include <asm/efi.h>
 #include <asm/e820/api.h>
 #include <asm/time.h>
-#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 #include <asm/x86_init.h>
 #include <asm/uv/uv.h>
@@ -496,74 +495,6 @@ void __init efi_init(void)
 		efi_print_memmap();
 }
 
-#if defined(CONFIG_X86_32)
-
-void __init efi_set_executable(efi_memory_desc_t *md, bool executable)
-{
-	u64 addr, npages;
-
-	addr = md->virt_addr;
-	npages = md->num_pages;
-
-	memrange_efi_to_native(&addr, &npages);
-
-	if (executable)
-		set_memory_x(addr, npages);
-	else
-		set_memory_nx(addr, npages);
-}
-
-void __init runtime_code_page_mkexec(void)
-{
-	efi_memory_desc_t *md;
-
-	/* Make EFI runtime service code area executable */
-	for_each_efi_memory_desc(md) {
-		if (md->type != EFI_RUNTIME_SERVICES_CODE)
-			continue;
-
-		efi_set_executable(md, true);
-	}
-}
-
-void __init efi_memory_uc(u64 addr, unsigned long size)
-{
-	unsigned long page_shift = 1UL << EFI_PAGE_SHIFT;
-	u64 npages;
-
-	npages = round_up(size, page_shift) / page_shift;
-	memrange_efi_to_native(&addr, &npages);
-	set_memory_uc(addr, npages);
-}
-
-void __init old_map_region(efi_memory_desc_t *md)
-{
-	u64 start_pfn, end_pfn, end;
-	unsigned long size;
-	void *va;
-
-	start_pfn = PFN_DOWN(md->phys_addr);
-	size	  = md->num_pages << PAGE_SHIFT;
-	end	  = md->phys_addr + size;
-	end_pfn   = PFN_UP(end);
-
-	if (pfn_range_is_mapped(start_pfn, end_pfn)) {
-		va = __va(md->phys_addr);
-
-		if (!(md->attribute & EFI_MEMORY_WB))
-			efi_memory_uc((u64)(unsigned long)va, size);
-	} else
-		va = efi_ioremap(md->phys_addr, size,
-				 md->type, md->attribute);
-
-	md->virt_addr = (u64) (unsigned long) va;
-	if (!va)
-		pr_err("ioremap of 0x%llX failed!\n",
-		       (unsigned long long)md->phys_addr);
-}
-
-#endif
-
 /* Merge contiguous regions of the same type and attribute */
 static void __init efi_merge_regions(void)
 {
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 826ead6..e06a199 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -29,9 +29,35 @@
 #include <asm/io.h>
 #include <asm/desc.h>
 #include <asm/page.h>
+#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 #include <asm/efi.h>
 
+void __init efi_map_region(efi_memory_desc_t *md)
+{
+	u64 start_pfn, end_pfn, end;
+	unsigned long size;
+	void *va;
+
+	start_pfn	= PFN_DOWN(md->phys_addr);
+	size		= md->num_pages << PAGE_SHIFT;
+	end		= md->phys_addr + size;
+	end_pfn 	= PFN_UP(end);
+
+	if (pfn_range_is_mapped(start_pfn, end_pfn)) {
+		va = __va(md->phys_addr);
+
+		if (!(md->attribute & EFI_MEMORY_WB))
+			set_memory_uc((unsigned long)va, md->num_pages);
+	} else {
+		va = ioremap_cache(md->phys_addr, size);
+	}
+
+	md->virt_addr = (unsigned long)va;
+	if (!va)
+		pr_err("ioremap of 0x%llX failed!\n", md->phys_addr);
+}
+
 /*
  * To make EFI call EFI runtime service in physical addressing mode we need
  * prolog/epilog before/after the invocation to claim the EFI runtime service
@@ -58,11 +84,6 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
-{
-	old_map_region(md);
-}
-
 void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
@@ -107,6 +128,15 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 
 void __init efi_runtime_update_mappings(void)
 {
-	if (__supported_pte_mask & _PAGE_NX)
-		runtime_code_page_mkexec();
+	if (__supported_pte_mask & _PAGE_NX) {
+		efi_memory_desc_t *md;
+
+		/* Make EFI runtime service code area executable */
+		for_each_efi_memory_desc(md) {
+			if (md->type != EFI_RUNTIME_SERVICES_CODE)
+				continue;
+
+			set_memory_x(md->virt_addr, md->num_pages);
+		}
+	}
 }
