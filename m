Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC4AC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291362070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzsVGA43";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qxgg/nHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGQOvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgGQOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E0C0619D2;
        Fri, 17 Jul 2020 07:51:11 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:51:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGo03R4W0hoxkgLDYq6DpLgqYkOjCOAWvX6xJ6wX4dM=;
        b=FzsVGA43/krbNZAzMqJolkiKMQ5ZSGcOg9w2jTto8DatVE7sdcQcqqNaz6n4dnZnCTOb12
        dIoh0wRk+hGX/zAnQAlvas3iFakK4g4pPuoP/ZB2QBe3C07d7gu1LKslSde04BGynxdfk0
        XKiUysZ38STJp0NGkieIXvMX7mCy6WwAJEP5tpZM29G0dkOW/eImUb340KUmHtEP0uo9+T
        PJtQ0TNdMD0rz1znjbR/U+e1heGKEesvgYA3TwucMAaz8cAPP74iRUajscdJHHXZSBO0ip
        aOUdw3Gz//NGbmVggPmTQKvDVaZH0nUbVceMkIOD8X1+xjReJyMPszR0A1bMDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGo03R4W0hoxkgLDYq6DpLgqYkOjCOAWvX6xJ6wX4dM=;
        b=Qxgg/nHlPlHS4h1nKTXII4U/6kHyNbVT4U5QCO8iPeDz70Nkth53c4+xbO2pHnSm/ZjuDH
        9EFVfxuex5PvNwBg==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/efi: Remove references to no-longer-used
 efi_have_uv1_memmap()
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.786177105@hpe.com>
References: <20200713212955.786177105@hpe.com>
MIME-Version: 1.0
Message-ID: <159499746771.4006.7069875500892929737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     66d67fecd896370d4cbbd146c9a7bf5b4c5303af
Gitweb:        https://git.kernel.org/tip/66d67fecd896370d4cbbd146c9a7bf5b4c5303af
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:05 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:47 +02:00

x86/efi: Remove references to no-longer-used efi_have_uv1_memmap()

In removing UV1 support, efi_have_uv1_memmap is no longer used.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200713212955.786177105@hpe.com

---
 arch/x86/kernel/kexec-bzimage64.c |  9 +-------
 arch/x86/platform/efi/efi.c       | 14 ++---------
 arch/x86/platform/efi/efi_64.c    | 38 ++----------------------------
 arch/x86/platform/efi/quirks.c    |  8 +------
 4 files changed, 6 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index db6578d..57c2ecf 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -170,15 +170,6 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
-	/*
-	 * If 1:1 mapping is not enabled, second kernel can not setup EFI
-	 * and use EFI run time services. User space will have to pass
-	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
-	 * without efi.
-	 */
-	if (efi_have_uv1_memmap())
-		return 0;
-
 	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e966115..2cc1590 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -648,7 +648,7 @@ static inline void *efi_map_next_entry_reverse(void *entry)
  */
 static void *efi_map_next_entry(void *entry)
 {
-	if (!efi_have_uv1_memmap() && efi_enabled(EFI_64BIT)) {
+	if (efi_enabled(EFI_64BIT)) {
 		/*
 		 * Starting in UEFI v2.5 the EFI_PROPERTIES_TABLE
 		 * config table feature requires us to map all entries
@@ -777,11 +777,9 @@ static void __init kexec_enter_virtual_mode(void)
 
 	/*
 	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI. With the UV1 memmap, we don't do runtime services in
-	 * kexec kernel because in the initial boot something else might
-	 * have been mapped at these virtual addresses.
+	 * non-native EFI.
 	 */
-	if (efi_is_mixed() || efi_have_uv1_memmap()) {
+	if (efi_is_mixed()) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
@@ -832,12 +830,6 @@ static void __init kexec_enter_virtual_mode(void)
  * has the runtime attribute bit set in its memory descriptor into the
  * efi_pgd page table.
  *
- * The old method which used to update that memory descriptor with the
- * virtual address obtained from ioremap() is still supported when the
- * kernel is booted on SG1 UV1 hardware. Same old method enabled the
- * runtime services to be called without having to thunk back into
- * physical mode for every invocation.
- *
  * The new method does a pagetable switch in a preemption-safe manner
  * so that we're in a different address space when calling a runtime
  * function. For function arguments passing we do copy the PUDs of the
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8e364c4..413583f 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -74,9 +74,6 @@ int __init efi_alloc_page_tables(void)
 	pud_t *pud;
 	gfp_t gfp_mask;
 
-	if (efi_have_uv1_memmap())
-		return 0;
-
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
 	if (!efi_pgd)
@@ -115,9 +112,6 @@ void efi_sync_low_kernel_mappings(void)
 	pud_t *pud_k, *pud_efi;
 	pgd_t *efi_pgd = efi_mm.pgd;
 
-	if (efi_have_uv1_memmap())
-		return;
-
 	/*
 	 * We can share all PGD entries apart from the one entry that
 	 * covers the EFI runtime mapping space.
@@ -206,9 +200,6 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
 
-	if (efi_have_uv1_memmap())
-		return 0;
-
 	/*
 	 * It can happen that the physical address of new_memmap lands in memory
 	 * which is not mapped in the EFI page table. Therefore we need to go
@@ -315,9 +306,6 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
 
-	if (efi_have_uv1_memmap())
-		return old_map_region(md);
-
 	/*
 	 * Make sure the 1:1 mappings are present as a catch-all for b0rked
 	 * firmware which doesn't update all internal pointers after switching
@@ -420,12 +408,6 @@ void __init efi_runtime_update_mappings(void)
 {
 	efi_memory_desc_t *md;
 
-	if (efi_have_uv1_memmap()) {
-		if (__supported_pte_mask & _PAGE_NX)
-			runtime_code_page_mkexec();
-		return;
-	}
-
 	/*
 	 * Use the EFI Memory Attribute Table for mapping permissions if it
 	 * exists, since it is intended to supersede EFI_PROPERTIES_TABLE.
@@ -474,10 +456,7 @@ void __init efi_runtime_update_mappings(void)
 void __init efi_dump_pagetable(void)
 {
 #ifdef CONFIG_EFI_PGT_DUMP
-	if (efi_have_uv1_memmap())
-		ptdump_walk_pgd_level(NULL, &init_mm);
-	else
-		ptdump_walk_pgd_level(NULL, &efi_mm);
+	ptdump_walk_pgd_level(NULL, &efi_mm);
 #endif
 }
 
@@ -849,21 +828,13 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 	const efi_system_table_t *systab = (efi_system_table_t *)systab_phys;
 	efi_status_t status;
 	unsigned long flags;
-	pgd_t *save_pgd = NULL;
 
 	if (efi_is_mixed())
 		return efi_thunk_set_virtual_address_map(memory_map_size,
 							 descriptor_size,
 							 descriptor_version,
 							 virtual_map);
-
-	if (efi_have_uv1_memmap()) {
-		save_pgd = efi_uv1_memmap_phys_prolog();
-		if (!save_pgd)
-			return EFI_ABORTED;
-	} else {
-		efi_switch_mm(&efi_mm);
-	}
+	efi_switch_mm(&efi_mm);
 
 	kernel_fpu_begin();
 
@@ -879,10 +850,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 	/* grab the virtually remapped EFI runtime services table pointer */
 	efi.runtime = READ_ONCE(systab->runtime);
 
-	if (save_pgd)
-		efi_uv1_memmap_phys_epilog(save_pgd);
-	else
-		efi_switch_mm(efi_scratch.prev_mm);
+	efi_switch_mm(efi_scratch.prev_mm);
 
 	return status;
 }
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index d627f55..5a40fe4 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -381,14 +381,6 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 	u64 va = md->virt_addr;
 
 	/*
-	 * To Do: Remove this check after adding functionality to unmap EFI boot
-	 * services code/data regions from direct mapping area because the UV1
-	 * memory map maps EFI regions in swapper_pg_dir.
-	 */
-	if (efi_have_uv1_memmap())
-		return;
-
-	/*
 	 * EFI mixed mode has all RAM mapped to access arguments while making
 	 * EFI runtime calls, hence don't unmap EFI boot services code/data
 	 * regions.
