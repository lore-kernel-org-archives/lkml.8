Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93169C33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94924125
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578828990;
	bh=x3lkok6yMxz/trfKMecT0QU+pQYlkaiXwXy+75fbrL4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AGLgWnStKr4bEiBpLg06QJLo6wb6vzIMZ+i7ZgWSK9FVGxQXEH/3qTMKXVQQ3oyZw
	 GQ+3GzIs/hFU6s7jTzUfWAo4sSxS33zQOIMO5vY5ST45Vaez7VJA26FW1KBfwSZZJK
	 WOx2bpz4ixMgyjY3Y893NquQUHGkhFShZxwJKFnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbgALLg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 06:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732673AbgALLg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 06:36:29 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B36422314;
        Sun, 12 Jan 2020 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578828988;
        bh=x3lkok6yMxz/trfKMecT0QU+pQYlkaiXwXy+75fbrL4=;
        h=From:To:Cc:Subject:Date:From;
        b=y2N7sm80JAw90ZvCwM/MuJup7eE879aePES4MtLWzqKqolaCBQYLa2a0UFOt0jSBo
         J3LOSzuEsSjP+SmMKZmyzYfD4tRxa/kzb+z3SECqVmorgDiCM5Q6i6l/r7LHwROtBj
         hxBVfV7ma3bBILFyx+19usU+Y/ZpbsM3PXGEuYr8=
From:   Mike Rapoport <rppt@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Meelis Roos <mroos@linux.ee>, Jeroen Roovers <jer@gentoo.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] parisc: map_pages(): cleanup page table initialization
Date:   Sun, 12 Jan 2020 13:36:15 +0200
Message-Id: <20200112113615.24198-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The current code uses '#if PTRS_PER_PMD == 1' to distinguish 2 vs 3 levels,
setup, it casts pgd to pgd to cope with page table folding and converts
addresses of page table entries from physical to virtual and back for no
good reason.

Simplify the accesses to the page table entries using proper unfolding of
the upper layers and replacing '#if PTRS_PER_PMD' with explicit
'#if CONFIG_PGTABLE_LEVELS == 3'

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
Hi,

This patch is on top of the current parisc/for-next.
I've build-tested for generic-{32,64}_defconfig and was able to boot
qemu-system-parisc up to rootfs mount.

 arch/parisc/mm/init.c | 50 +++++++++++--------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 354cf060b67f..5224fb38d766 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -351,7 +351,6 @@ static void __init map_pages(unsigned long start_vaddr,
 			     unsigned long start_paddr, unsigned long size,
 			     pgprot_t pgprot, int force)
 {
-	pgd_t *pg_dir;
 	pmd_t *pmd;
 	pte_t *pg_table;
 	unsigned long end_paddr;
@@ -372,62 +371,37 @@ static void __init map_pages(unsigned long start_vaddr,
 
 	end_paddr = start_paddr + size;
 
-	pg_dir = pgd_offset_k(start_vaddr);
-
-#if PTRS_PER_PMD == 1
-	start_pmd = 0;
-#else
+	/* for 2-level configuration PTRS_PER_PMD is 0 so start_pmd will be 0 */
 	start_pmd = ((start_vaddr >> PMD_SHIFT) & (PTRS_PER_PMD - 1));
-#endif
 	start_pte = ((start_vaddr >> PAGE_SHIFT) & (PTRS_PER_PTE - 1));
 
 	address = start_paddr;
 	vaddr = start_vaddr;
 	while (address < end_paddr) {
-#if PTRS_PER_PMD == 1
-		pmd = (pmd_t *)__pa(pg_dir);
-#else
-		pmd = (pmd_t *)pgd_address(*pg_dir);
-
-		/*
-		 * pmd is physical at this point
-		 */
+		pgd_t *pgd = pgd_offset_k(vaddr);
+		p4d_t *p4d = p4d_offset(pgd, vaddr);
+		pud_t *pud = pud_offset(p4d, vaddr);
 
-		if (!pmd) {
+#if CONFIG_PGTABLE_LEVELS == 3
+		if (pud_none(*pud)) {
 			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
 					     PAGE_SIZE << PMD_ORDER);
 			if (!pmd)
 				panic("pmd allocation failed.\n");
-			pmd = (pmd_t *) __pa(pmd);
+			pud_populate(NULL, pud, pmd);
 		}
-
-		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
 #endif
-		pg_dir++;
-
-		/* now change pmd to kernel virtual addresses */
 
-		pmd = (pmd_t *)__va(pmd) + start_pmd;
+		pmd = pmd_offset(pud, vaddr);
 		for (tmp1 = start_pmd; tmp1 < PTRS_PER_PMD; tmp1++, pmd++) {
-
-			/*
-			 * pg_table is physical at this point
-			 */
-
-			pg_table = (pte_t *)pmd_address(*pmd);
-			if (!pg_table) {
-				pg_table = memblock_alloc(PAGE_SIZE,
-							  PAGE_SIZE);
+			if (pmd_none(*pmd)) {
+				pg_table = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 				if (!pg_table)
 					panic("page table allocation failed\n");
-				pg_table = (pte_t *) __pa(pg_table);
+				pmd_populate_kernel(NULL, pmd, pg_table);
 			}
 
-			pmd_populate_kernel(NULL, pmd, __va(pg_table));
-
-			/* now change pg_table to kernel virtual addresses */
-
-			pg_table = (pte_t *) __va(pg_table) + start_pte;
+			pg_table = pte_offset_kernel(pmd, vaddr);
 			for (tmp2 = start_pte; tmp2 < PTRS_PER_PTE; tmp2++, pg_table++) {
 				pte_t pte;
 				pgprot_t prot;

base-commit: 9cf86a639ffdd9c38d510d35efcc15ed6dfb2efa
-- 
2.24.0

