Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1BCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C9220708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgESFsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:48:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31494 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgESFsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:48:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4gg49z7z9txm2;
        Tue, 19 May 2020 07:48:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sWX_9nDYwlmR; Tue, 19 May 2020 07:48:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4gg2M9Jz9txm4;
        Tue, 19 May 2020 07:48:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 596888B767;
        Tue, 19 May 2020 07:48:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IsiKKFXwQ44P; Tue, 19 May 2020 07:48:48 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A67FF8B7A9;
        Tue, 19 May 2020 07:48:47 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 87D2C65A4A; Tue, 19 May 2020 05:48:47 +0000 (UTC)
Message-Id: <8c496c0828de2608c7c940c45525d177e91b6f1b.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 05/45] powerpc/kasan: Refactor update of early shadow
 mappings
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:48:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_remap_early_shadow_ro() and kasan_unmap_early_shadow_vmalloc()
are both updating the early shadow mapping: the first one sets
the mapping read-only while the other clears the mapping.

Refactor and create kasan_update_early_region()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 39 +++++++++++++--------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 91e2ade75192..10481d904fea 100644
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
-	for (k_cur = k_start & PAGE_MASK; k_cur != k_end; k_cur += PAGE_SIZE) {
+	for (k_cur = k_start; k_cur != k_end; k_cur += PAGE_SIZE) {
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

