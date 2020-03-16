Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C22BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5606620663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HcqOBxVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgCPMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:35:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63177 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbgCPMfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkp33Kvz9tygS;
        Mon, 16 Mar 2020 13:35:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HcqOBxVf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jGyaWm4O7Ilk; Mon, 16 Mar 2020 13:35:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkp1pTqz9tyg5;
        Mon, 16 Mar 2020 13:35:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362146; bh=fb8Dm2InOClKUpndBVgU08V295ttuJmHU5Av7nsj+Pg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=HcqOBxVf6Yz3ro30G9tatBWc4pvJVduX4luZ+LvNFwmA5KK1zDcULDyIoyRTRaGIA
         iBxhFurqB8VIoNeWHgf4PybGP7mtDYrNAo5dtwhPThl/v3xkAVFpC8d9OPnIEF1X2X
         eRVWPZIzx+k1FfRXw61KaAGrvyFGqYy8szbUnnqA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BF6E8B7D0;
        Mon, 16 Mar 2020 13:35:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m4VOUuB4DmEF; Mon, 16 Mar 2020 13:35:51 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DC8C8B7CB;
        Mon, 16 Mar 2020 13:35:51 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1650F65595; Mon, 16 Mar 2020 12:35:51 +0000 (UTC)
Message-Id: <5eb93a773184aa0d36faa93c096b21cbe0a069c9.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 06/46] powerpc/kasan: Refactor update of early shadow
 mappings
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_remap_early_shadow_ro() and kasan_unmap_early_shadow_vmalloc()
are both updating the early shadow mapping: the first one sets
the mapping read-only while the other clears the mapping.

Refactor and create kasan_update_early_region()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 39 +++++++++++++--------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index c9d053078c37..65fd8b891f8e 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -79,45 +79,42 @@ static int __init kasan_init_region(void *start, size_t size)
 	return 0;
 }
 
-static void __init kasan_remap_early_shadow_ro(void)
+static void __init
+kasan_update_early_region(unsigned long k_start, unsigned long k_end, pte_t pte)
 {
-	pgprot_t prot = kasan_prot_ro();
-	unsigned long k_start = KASAN_SHADOW_START;
-	unsigned long k_end = KASAN_SHADOW_END;
 	unsigned long k_cur;
 	phys_addr_t pa = __pa(kasan_early_shadow_page);
 
-	kasan_populate_pte(kasan_early_shadow_pte, prot);
-
-	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
+	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
 		pmd_t *pmd = pmd_ptr_k(k_cur);
 		pte_t *ptep = pte_offset_kernel(pmd, k_cur);
 
 		if ((pte_val(*ptep) & PTE_RPN_MASK) != pa)
 			continue;
 
-		__set_pte_at(&init_mm, k_cur, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
+		__set_pte_at(&init_mm, k_cur, ptep, pte, 0);
 	}
-	flush_tlb_kernel_range(KASAN_SHADOW_START, KASAN_SHADOW_END);
+
+	flush_tlb_kernel_range(k_start, k_end);
 }
 
-static void __init kasan_unmap_early_shadow_vmalloc(void)
+static void __init kasan_remap_early_shadow_ro(void)
 {
-	unsigned long k_start = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START);
-	unsigned long k_end = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END);
-	unsigned long k_cur;
+	pgprot_t prot = kasan_prot_ro();
 	phys_addr_t pa = __pa(kasan_early_shadow_page);
 
-	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
-		pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
-		pte_t *ptep = pte_offset_kernel(pmd, k_cur);
+	kasan_populate_pte(kasan_early_shadow_pte, prot);
 
-		if ((pte_val(*ptep) & PTE_RPN_MASK) != pa)
-			continue;
+	kasan_update_early_region(KASAN_SHADOW_START, KASAN_SHADOW_END,
+				  pfn_pte(PHYS_PFN(pa), prot));
+}
 
-		__set_pte_at(&init_mm, k_cur, ptep, __pte(0), 0);
-	}
-	flush_tlb_kernel_range(k_start, k_end);
+static void __init kasan_unmap_early_shadow_vmalloc(void)
+{
+	unsigned long k_start = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START);
+	unsigned long k_end = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END);
+
+	kasan_update_early_region(k_start, k_end, __pte(0));
 }
 
 static void __init kasan_mmu_init(void)
-- 
2.25.0

