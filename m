Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED99C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161BE2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G01Vhyqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svMNHxIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGQOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:11 -0400
Date:   Fri, 17 Jul 2020 14:51:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cyJK11zxUoXcQE18fem7Os4peZfGMTxEPyNW8IXdAI=;
        b=G01VhyqcQ0O8LDeh1TO0F+amVUUSnmmQxOYbPEAbthvg8wh0R8mfpbLjb+14uftoWubWUN
        aHXHy4ru91Y8VQToegdSvaqpCt4xsamYA0th8iU/rYtyCiLDKGTbfWaga/fcS1LLPrQwnD
        R8lQBLycjc2Nh1lgL+/+vHK/4RPgZlMy9JuQzisgSzc2MLSEO3UKkiGDTIbRAgafM6f8wp
        fX6J51WTlqxoRVIIJcplgZrp6GPUswmL/IqcmJ6ckJfuPsIUesJberTcPiO7DeTp8GUAG5
        cSfW4M2XLKXI6RgpCk2Mti+bWXwcsURKMQfEObS9nJkd/vdVxk4KH37TtCl1fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cyJK11zxUoXcQE18fem7Os4peZfGMTxEPyNW8IXdAI=;
        b=svMNHxItiHbc91hINq3dPMJNeQWuLKZdOZK7tFovOCUPlW/UIvdLaRSKRNLxHDh7t2oZ4G
        VPCAzAeQmoXil9AA==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove uv bios and efi code
 related to EFI_UV1_MEMMAP
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.902592618@hpe.com>
References: <20200713212955.902592618@hpe.com>
MIME-Version: 1.0
Message-ID: <159499746714.4006.4471517286922286809.tip-bot2@tip-bot2>
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

Commit-ID:     6aa3baabe106fa1182f904107244147395902a09
Gitweb:        https://git.kernel.org/tip/6aa3baabe106fa1182f904107244147395902a09
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:06 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:48 +02:00

x86/platform/uv: Remove uv bios and efi code related to EFI_UV1_MEMMAP

With UV1 removed, EFI_UV1_MEMMAP is not longer used.  Remove the code used
by it and the related code in EFI.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200713212955.902592618@hpe.com

---
 arch/x86/platform/efi/efi.c    |   2 +-
 arch/x86/platform/uv/bios_uv.c | 159 +--------------------------------
 2 files changed, 2 insertions(+), 159 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 2cc1590..f6ea8f1 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -496,7 +496,7 @@ void __init efi_init(void)
 		efi_print_memmap();
 }
 
-#if defined(CONFIG_X86_32) || defined(CONFIG_X86_UV)
+#if defined(CONFIG_X86_32)
 
 void __init efi_set_executable(efi_memory_desc_t *md, bool executable)
 {
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index cd2a6e2..a6e5f2c 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -30,17 +30,7 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 		 */
 		return BIOS_STATUS_UNIMPLEMENTED;
 
-	/*
-	 * If EFI_UV1_MEMMAP is set, we need to fall back to using our old EFI
-	 * callback method, which uses efi_call() directly, with the kernel page tables:
-	 */
-	if (unlikely(efi_enabled(EFI_UV1_MEMMAP))) {
-		kernel_fpu_begin();
-		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
-		kernel_fpu_end();
-	} else {
-		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
-	}
+	ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
 
 	return ret;
 }
@@ -209,150 +199,3 @@ int uv_bios_init(void)
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
 	return 0;
 }
-
-static void __init early_code_mapping_set_exec(int executable)
-{
-	efi_memory_desc_t *md;
-
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return;
-
-	/* Make EFI service code area executable */
-	for_each_efi_memory_desc(md) {
-		if (md->type == EFI_RUNTIME_SERVICES_CODE ||
-		    md->type == EFI_BOOT_SERVICES_CODE)
-			efi_set_executable(md, executable);
-	}
-}
-
-void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd)
-{
-	/*
-	 * After the lock is released, the original page table is restored.
-	 */
-	int pgd_idx, i;
-	int nr_pgds;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-
-	nr_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT) , PGDIR_SIZE);
-
-	for (pgd_idx = 0; pgd_idx < nr_pgds; pgd_idx++) {
-		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
-		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
-
-		if (!pgd_present(*pgd))
-			continue;
-
-		for (i = 0; i < PTRS_PER_P4D; i++) {
-			p4d = p4d_offset(pgd,
-					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
-
-			if (!p4d_present(*p4d))
-				continue;
-
-			pud = (pud_t *)p4d_page_vaddr(*p4d);
-			pud_free(&init_mm, pud);
-		}
-
-		p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-		p4d_free(&init_mm, p4d);
-	}
-
-	kfree(save_pgd);
-
-	__flush_tlb_all();
-	early_code_mapping_set_exec(0);
-}
-
-pgd_t * __init efi_uv1_memmap_phys_prolog(void)
-{
-	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
-	pgd_t *save_pgd, *pgd_k, *pgd_efi;
-	p4d_t *p4d, *p4d_k, *p4d_efi;
-	pud_t *pud;
-
-	int pgd;
-	int n_pgds, i, j;
-
-	early_code_mapping_set_exec(1);
-
-	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
-	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
-	if (!save_pgd)
-		return NULL;
-
-	/*
-	 * Build 1:1 identity mapping for UV1 memmap usage. Note that
-	 * PAGE_OFFSET is PGDIR_SIZE aligned when KASLR is disabled, while
-	 * it is PUD_SIZE ALIGNED with KASLR enabled. So for a given physical
-	 * address X, the pud_index(X) != pud_index(__va(X)), we can only copy
-	 * PUD entry of __va(X) to fill in pud entry of X to build 1:1 mapping.
-	 * This means here we can only reuse the PMD tables of the direct mapping.
-	 */
-	for (pgd = 0; pgd < n_pgds; pgd++) {
-		addr_pgd = (unsigned long)(pgd * PGDIR_SIZE);
-		vaddr = (unsigned long)__va(pgd * PGDIR_SIZE);
-		pgd_efi = pgd_offset_k(addr_pgd);
-		save_pgd[pgd] = *pgd_efi;
-
-		p4d = p4d_alloc(&init_mm, pgd_efi, addr_pgd);
-		if (!p4d) {
-			pr_err("Failed to allocate p4d table!\n");
-			goto out;
-		}
-
-		for (i = 0; i < PTRS_PER_P4D; i++) {
-			addr_p4d = addr_pgd + i * P4D_SIZE;
-			p4d_efi = p4d + p4d_index(addr_p4d);
-
-			pud = pud_alloc(&init_mm, p4d_efi, addr_p4d);
-			if (!pud) {
-				pr_err("Failed to allocate pud table!\n");
-				goto out;
-			}
-
-			for (j = 0; j < PTRS_PER_PUD; j++) {
-				addr_pud = addr_p4d + j * PUD_SIZE;
-
-				if (addr_pud > (max_pfn << PAGE_SHIFT))
-					break;
-
-				vaddr = (unsigned long)__va(addr_pud);
-
-				pgd_k = pgd_offset_k(vaddr);
-				p4d_k = p4d_offset(pgd_k, vaddr);
-				pud[j] = *pud_offset(p4d_k, vaddr);
-			}
-		}
-		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
-	}
-
-	__flush_tlb_all();
-	return save_pgd;
-out:
-	efi_uv1_memmap_phys_epilog(save_pgd);
-	return NULL;
-}
-
-void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
-				 u32 type, u64 attribute)
-{
-	unsigned long last_map_pfn;
-
-	if (type == EFI_MEMORY_MAPPED_IO)
-		return ioremap(phys_addr, size);
-
-	last_map_pfn = init_memory_mapping(phys_addr, phys_addr + size,
-					   PAGE_KERNEL);
-	if ((last_map_pfn << PAGE_SHIFT) < phys_addr + size) {
-		unsigned long top = last_map_pfn << PAGE_SHIFT;
-		efi_ioremap(top, size - (top - phys_addr), type, attribute);
-	}
-
-	if (!(attribute & EFI_MEMORY_WB))
-		efi_memory_uc((u64)(unsigned long)__va(phys_addr), size);
-
-	return (void __iomem *)__va(phys_addr);
-}
