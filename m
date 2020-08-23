Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54CAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86038207CD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdV7bvhm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWws6EiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgHWI1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgHWI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:27:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D90C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 01:27:00 -0700 (PDT)
Date:   Sun, 23 Aug 2020 08:25:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598171212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tR4jIfP7V7noDB3vp6DlJxvw+Mwn9fO0Kfls/0QfD3Q=;
        b=YdV7bvhmTxFGDRHWsQhWE/BtDAeC+ai5y122c5Wg7YXj5uFgNjVpanQ4LqVD2ECmB205sM
        cZV7115+wMeqjW82FZniAyqmdcrVtLcRrHWuAvf5JyxsPCzZhppJE08dLc6xsdJ+RMwpHu
        UDtr2uASiEbwyIDasIy14iYXhgf4Xugg1wkn2xnY5ruZLXvKRTBgKitkMG1Z2boDsF4UFA
        n5lyz5F0T2TGy5pPXgBIG0OTvMvmXSxBiir59EDeZtYPmI6FyCJTBpqulOnMdz8ELdmkgb
        fOaTFZDcetVkN5d9Ey4hf5NNqZmTV6Xt9+f5EpZkBIH8y9qx7n0NC9jOGw/qUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598171212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tR4jIfP7V7noDB3vp6DlJxvw+Mwn9fO0Kfls/0QfD3Q=;
        b=fWws6EiZyR30spRfL7A8hftqpCwTqy7f7E+8vBcES2MAbZe3xG1WZZLOPi9oL/wndCHp8M
        kPtYfiOznHICN+Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] efi/urgent for v5.9-rc2
References: <159817113401.5783.14776307451257171431.tglx@nanos>
Message-ID: <159817113521.5783.17455022106783691165.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-08-23

up to:  fb1201aececc: Documentation: efi: remove description of efi=old_map


A set of EFI fixes:

 - Enforce NX on RO data in mixed EFI mode
 - Destroy workqueue in an error handling path to prevent UAF
 - Stop argument parser at '--' which is the delimiter for init
 - Treat a NULL command line pointer as empty instead of dereferncing it
   unconditionally.
 - Handle an unterminated command line correctly
 - Cleanup the 32bit code leftovers and remove obsolete documentation

Thanks,

	tglx

------------------>
Ard Biesheuvel (2):
      efi/x86: Move 32-bit code into efi_32.c
      Documentation: efi: remove description of efi=old_map

Arvind Sankar (4):
      efi/x86: Mark kernel rodata non-executable for mixed mode
      efi/libstub: Stop parsing arguments at "--"
      efi/libstub: Handle NULL cmdline
      efi/libstub: Handle unterminated cmdline

Li Heng (1):
      efi: add missed destroy_workqueue when efisubsys_init fails


 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 arch/x86/include/asm/efi.h                      | 10 ----
 arch/x86/platform/efi/efi.c                     | 69 -------------------------
 arch/x86/platform/efi/efi_32.c                  | 44 +++++++++++++---
 arch/x86/platform/efi/efi_64.c                  |  2 +
 drivers/firmware/efi/efi.c                      |  2 +
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 12 ++++-
 7 files changed, 52 insertions(+), 92 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33fd3d1..a1068742a6df 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1233,8 +1233,7 @@
 	efi=		[EFI]
 			Format: { "debug", "disable_early_pci_dma",
 				  "nochunk", "noruntime", "nosoftreserve",
-				  "novamap", "no_disable_early_pci_dma",
-				  "old_map" }
+				  "novamap", "no_disable_early_pci_dma" }
 			debug: enable misc debug output.
 			disable_early_pci_dma: disable the busmaster bit on all
 			PCI bridges while in the EFI boot stub.
@@ -1251,8 +1250,6 @@
 			novamap: do not call SetVirtualAddressMap().
 			no_disable_early_pci_dma: Leave the busmaster bit set
 			on all PCI bridges while in the EFI boot stub
-			old_map [X86-64]: switch to the old ioremap-based EFI
-			runtime services mapping. [Needs CONFIG_X86_UV=y]
 
 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b9c2667ac46c..bc9758ef292e 100644
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
index f6ea8f1a9d57..d37ebe6e70d7 100644
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
index 826ead67753d..e06a199423c0 100644
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
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 413583f904a6..6af4da1149ba 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -259,6 +259,8 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	npages = (__end_rodata - __start_rodata) >> PAGE_SHIFT;
 	rodata = __pa(__start_rodata);
 	pfn = rodata >> PAGE_SHIFT;
+
+	pf = _PAGE_NX | _PAGE_ENC;
 	if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
 		pr_err("Failed to map kernel rodata 1:1\n");
 		return 1;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdd1db025dbf..3aa07c3b5136 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -381,6 +381,7 @@ static int __init efisubsys_init(void)
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
 		pr_err("efi: Firmware registration failed.\n");
+		destroy_workqueue(efi_rts_wq);
 		return -ENOMEM;
 	}
 
@@ -424,6 +425,7 @@ static int __init efisubsys_init(void)
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
+	destroy_workqueue(efi_rts_wq);
 	return error;
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 6bca70bbb43d..f735db55adc0 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -187,20 +187,28 @@ int efi_printk(const char *fmt, ...)
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
-	size_t len = strlen(cmdline) + 1;
+	size_t len;
 	efi_status_t status;
 	char *str, *buf;
 
+	if (!cmdline)
+		return EFI_SUCCESS;
+
+	len = strnlen(cmdline, COMMAND_LINE_SIZE - 1) + 1;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	str = skip_spaces(memcpy(buf, cmdline, len));
+	memcpy(buf, cmdline, len - 1);
+	buf[len - 1] = '\0';
+	str = skip_spaces(buf);
 
 	while (*str) {
 		char *param, *val;
 
 		str = next_arg(str, &param, &val);
+		if (!val && !strcmp(param, "--"))
+			break;
 
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;

