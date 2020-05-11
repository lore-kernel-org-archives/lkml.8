Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA93C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAAC20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgEKLZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:25:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39938 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbgEKLZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXC4hHdz9ty3k;
        Mon, 11 May 2020 13:25:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZCbNnw1iZSjV; Mon, 11 May 2020 13:25:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXC3NCdz9ty3g;
        Mon, 11 May 2020 13:25:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AA6B8B7AE;
        Mon, 11 May 2020 13:25:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HwFzcCTV1eSa; Mon, 11 May 2020 13:25:54 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA75E8B7AD;
        Mon, 11 May 2020 13:25:53 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CEF1765A09; Mon, 11 May 2020 11:25:53 +0000 (UTC)
Message-Id: <ce32c612b010ccaf2aee3189ecfe77df64db2d57.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 27/45] powerpc/8xx: Only 8M pages are hugepte pages now
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

512k pages are now standard pages, so only 8M pages
are hugepte.

No more handling of normal page tables through hugepd allocation
and freeing, and hugepte helpers can also be simplified.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h |  7 +++----
 arch/powerpc/mm/hugetlbpage.c                    | 16 +++-------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index 785437323576..1c7d4693a78e 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -13,13 +13,13 @@ static inline pte_t *hugepd_page(hugepd_t hpd)
 
 static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
-	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
+	return PAGE_SHIFT_8M;
 }
 
 static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 				    unsigned int pdshift)
 {
-	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
+	unsigned long idx = (addr & (SZ_4M - 1)) >> PAGE_SHIFT;
 
 	return hugepd_page(hpd) + idx;
 }
@@ -32,8 +32,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 
 static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
 {
-	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT |
-			 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M : _PMD_PAGE_512K));
+	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT | _PMD_PAGE_8M);
 }
 
 static inline int check_and_get_huge_psize(int shift)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 35eb29584b54..243e90db400c 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -54,24 +54,17 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (pshift >= pdshift) {
 		cachep = PGT_CACHE(PTE_T_ORDER);
 		num_hugepd = 1 << (pshift - pdshift);
-		new = NULL;
-	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
-		cachep = NULL;
-		num_hugepd = 1;
-		new = pte_alloc_one(mm);
 	} else {
 		cachep = PGT_CACHE(pdshift - pshift);
 		num_hugepd = 1;
-		new = NULL;
 	}
 
-	if (!cachep && !new) {
+	if (!cachep) {
 		WARN_ONCE(1, "No page table cache created for hugetlb tables");
 		return -ENOMEM;
 	}
 
-	if (cachep)
-		new = kmem_cache_alloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
+	new = kmem_cache_alloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
 
 	BUG_ON(pshift > HUGEPD_SHIFT_MASK);
 	BUG_ON((unsigned long)new & HUGEPD_SHIFT_MASK);
@@ -102,10 +95,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (i < num_hugepd) {
 		for (i = i - 1 ; i >= 0; i--, hpdp--)
 			*hpdp = __hugepd(0);
-		if (cachep)
-			kmem_cache_free(cachep, new);
-		else
-			pte_free(mm, new);
+		kmem_cache_free(cachep, new);
 	} else {
 		kmemleak_ignore(new);
 	}
-- 
2.25.0

