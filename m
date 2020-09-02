Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54A0208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="er9QpnC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rl9EvIJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIBSHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44823 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbgIBSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C19645C0163;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=b9eSgdBVc6KPh
        Gvl15otgB0JUvsTDCKSyaNNO5dyWDg=; b=er9QpnC9pzM1R7WWQiY5NxWp9AHDD
        MaNd48f0CiyA/HkajR0zAjmnLP7JT8fC9Wi6B3SrQH41vdRx8uBGbjf6bymNnVzl
        GL9JLzRPPcMRxdBHxcnfZGJKlsZV8eBBThqNmYpNY7sl0SbC+bfUcvUOBJff9Tvy
        H9+50K4VxJ9UKMC5vxHoko3AT1Qm/cFE0il4BQZ2zeLSBWr81iM/5grQ3GiatvUL
        SBDi03Hwgj3v04PccCt5e37EkkIvQ7MVRFPYK93ClkN+5Rk0BmaFGQqzAOOZljBJ
        BLRSh0s1UGLqifZiIY+12BepFUkexOWclMpDRa42Ge2azkRxhXxzFp0OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=b9eSgdBVc6KPhGvl15otgB0JUvsTDCKSyaNNO5dyWDg=; b=Rl9EvIJW
        8nBI4WIKOFKe4Y+iElnDPRJiFX3vCfp3M/nlpT3zG9LUhR3S6ylBE8/iNTHimfT3
        tUtt1X/4/Z13K1MCYsGOGhAy+K0l30GVolETvOB9e3F/JZCmH7uzbiuEDFs2ZhzH
        pymZK7ArXPIkWTifRNwCjSG7BMj4Ehy1qO+uKHVE5+ydxY6AgiWgfHfg6b7bOuXI
        K7s0vc84PWZxA8j6fHLAr+6J8UFF7PVnnvJNMZS1CWY9CYRz3FKpgWD0M0CcnAdF
        POX5rsH0cNPHsLXkpgeEyS/ebjZw1YbosxaPiTjoFmv40LdEmAB8oygNsNaXmzZ7
        vfixVQmNaJ72EA==
X-ME-Sender: <xms:Kd9PXxIb5H14dL1diV4WFZjIX_hH6FS5BcL0RgPl8U6kcPZayDH1Ig>
    <xme:Kd9PX9LO_2JIwN9xqtnWHbvPMYca5h4dQlH9ykhHDUo2eXIOwtMeiutyDyLhXyhFO
    S4JneUm906GF0lxHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:Kd9PX5sTtLdKPX495-N2bLzzmytAfjAS4gu1NW_undV0HAPkdXpq7g>
    <xmx:Kd9PXyYHEcPD9RI2W6MVYpsWgFsPi_aylVANJXOow4mfQPvuLTYMOA>
    <xmx:Kd9PX4bz9yH6ReKYKVJ1CgDZcqlqXXDEsL1ZIc8S-St8vlaMXBx9tw>
    <xmx:Kd9PX46xIoyNH1CbnqzWkB3BbFXu-gftIK-f92dcfm1l_mriOBAB0Q>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEA5D30600A6;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 09/16] mm: thp: 1GB THP support in try_to_unmap().
Date:   Wed,  2 Sep 2020 14:06:21 -0400
Message-Id: <20200902180628.4052244-10-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Unmap different subpages in different sized THPs properly in the
try_to_unmap() function.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c |   2 +-
 mm/rmap.c    | 159 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 116 insertions(+), 45 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index be0e80b32686..df069a55722e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -225,7 +225,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
-		if (!pvmw.pte) {
+		if (!pvmw.pte && pvmw.pmd) {
 			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
 			remove_migration_pmd(&pvmw, new);
 			continue;
diff --git a/mm/rmap.c b/mm/rmap.c
index 0bbaaa891b3c..6c788abdb0b9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1123,6 +1123,7 @@ void do_page_add_anon_rmap(struct page *page,
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
+	struct page *head = compound_head(page);
 
 	if (unlikely(PageKsm(page)))
 		lock_page_memcg(page);
@@ -1132,8 +1133,8 @@ void do_page_add_anon_rmap(struct page *page,
 	if (compound) {
 		atomic_t *mapcount = NULL;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
-		if (compound_order(page) == HPAGE_PUD_ORDER) {
+		VM_BUG_ON_PAGE(!PMDPageInPUD(page) && !PageTransHuge(page), page);
+		if (compound_order(head) == HPAGE_PUD_ORDER) {
 			if (order == HPAGE_PUD_ORDER) {
 				mapcount = compound_mapcount_ptr(page);
 			} else if (order == HPAGE_PMD_ORDER) {
@@ -1141,7 +1142,7 @@ void do_page_add_anon_rmap(struct page *page,
 				mapcount = sub_compound_mapcount_ptr(page, 1);
 			} else
 				VM_BUG_ON(1);
-		} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+		} else if (compound_order(head) == HPAGE_PMD_ORDER) {
 			mapcount = compound_mapcount_ptr(page);
 		} else
 			VM_BUG_ON(1);
@@ -1151,7 +1152,8 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (first) {
-		int nr = compound ? thp_nr_pages(page) : 1;
+		/* int nr = compound ? thp_nr_pages(page) : 1; */
+		int nr = 1<<order;
 		/*
 		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
 		 * these counters are not modified in interrupt context, and
@@ -1460,10 +1462,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		.address = address,
 	};
 	pte_t pteval;
-	struct page *subpage;
+	pmd_t pmdval;
+	pud_t pudval;
+	struct page *subpage = NULL;
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	int order = 0;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
@@ -1473,6 +1478,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	    is_zone_device_page(page) && !is_device_private_page(page))
 		return true;
 
+	if (flags & TTU_SPLIT_HUGE_PUD) {
+		split_huge_pud_address(vma, address,
+				flags & TTU_SPLIT_FREEZE, page);
+	}
+
 	if (flags & TTU_SPLIT_HUGE_PMD) {
 		split_huge_pmd_address(vma, address,
 				flags & TTU_SPLIT_FREEZE, page);
@@ -1505,7 +1515,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
-		if (!pvmw.pte && (flags & TTU_MIGRATION)) {
+		if (!pvmw.pte && pvmw.pmd && (flags & TTU_MIGRATION)) {
 			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
 
 			set_pmd_migration_entry(&pvmw, page);
@@ -1537,9 +1547,18 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_PAGE(!pvmw.pte, page);
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		if (pvmw.pte) {
+			subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+			order = 0;
+		} else if (!pvmw.pte && pvmw.pmd) {
+			subpage = page - page_to_pfn(page) + pmd_pfn(*pvmw.pmd);
+			order = HPAGE_PMD_ORDER;
+		} else if (!pvmw.pte && !pvmw.pmd && pvmw.pud) {
+			subpage = page - page_to_pfn(page) + pud_pfn(*pvmw.pud);
+			order = HPAGE_PUD_ORDER;
+		}
+		VM_BUG_ON(!subpage);
 		address = pvmw.address;
 
 		if (PageHuge(page)) {
@@ -1617,16 +1636,26 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		if (!(flags & TTU_IGNORE_ACCESS)) {
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte)) {
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if ((pvmw.pte &&
+				 ptep_clear_flush_young_notify(vma, address, pvmw.pte)) ||
+				((!pvmw.pte && pvmw.pmd) &&
+				 pmdp_clear_flush_young_notify(vma, address, pvmw.pmd)) ||
+				((!pvmw.pte && !pvmw.pmd && pvmw.pud) &&
+				 pudp_clear_flush_young_notify(vma, address, pvmw.pud))
+				) {
+					ret = false;
+					page_vma_mapped_walk_done(&pvmw);
+					break;
 			}
 		}
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		if (pvmw.pte)
+			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		else if (!pvmw.pte && pvmw.pmd)
+			flush_cache_page(vma, address, pmd_pfn(*pvmw.pmd));
+		else if (!pvmw.pte && !pvmw.pmd && pvmw.pud)
+			flush_cache_page(vma, address, pud_pfn(*pvmw.pud));
 		if (should_defer_flush(mm, flags)) {
 			/*
 			 * We clear the PTE but do not flush so potentially
@@ -1636,16 +1665,34 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			 * transition on a cached TLB entry is written through
 			 * and traps if the PTE is unmapped.
 			 */
-			pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+			if (pvmw.pte) {
+				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+
+				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+			} else if (!pvmw.pte && pvmw.pmd) {
+				pmdval = pmdp_huge_get_and_clear(mm, address, pvmw.pmd);
 
-			set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				set_tlb_ubc_flush_pending(mm, pmd_dirty(pmdval));
+			} else if (!pvmw.pte && !pvmw.pmd && pvmw.pud) {
+				pudval = pudp_huge_get_and_clear(mm, address, pvmw.pud);
+
+				set_tlb_ubc_flush_pending(mm, pud_dirty(pudval));
+			}
 		} else {
-			pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			if (pvmw.pte)
+				pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			else if (!pvmw.pte && pvmw.pmd)
+				pmdval = pmdp_huge_clear_flush(vma, address, pvmw.pmd);
+			else if (!pvmw.pte && !pvmw.pmd && pvmw.pud)
+				pudval = pudp_huge_clear_flush(vma, address, pvmw.pud);
 		}
 
 		/* Move the dirty bit to the page. Now the pte is gone. */
-		if (pte_dirty(pteval))
-			set_page_dirty(page);
+			if ((pvmw.pte && pte_dirty(pteval)) ||
+				((!pvmw.pte && pvmw.pmd) && pmd_dirty(pmdval)) ||
+				((!pvmw.pte && !pvmw.pmd && pvmw.pud) && pud_dirty(pudval))
+				)
+				set_page_dirty(page);
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
@@ -1680,35 +1727,59 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		} else if (IS_ENABLED(CONFIG_MIGRATION) &&
 				(flags & (TTU_MIGRATION|TTU_SPLIT_FREEZE))) {
 			swp_entry_t entry;
-			pte_t swp_pte;
 
-			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
-			}
+			if (pvmw.pte) {
+				pte_t swp_pte;
 
-			/*
-			 * Store the pfn of the page in a special migration
-			 * pte. do_swap_page() will wait until the migration
-			 * pte is removed and then restart fault handling.
-			 */
-			entry = make_migration_entry(subpage,
-					pte_write(pteval));
-			swp_pte = swp_entry_to_pte(entry);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			set_pte_at(mm, address, pvmw.pte, swp_pte);
-			/*
-			 * No need to invalidate here it will synchronize on
-			 * against the special swap migration pte.
-			 */
+				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					ret = false;
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+
+				/*
+				 * Store the pfn of the page in a special migration
+				 * pte. do_swap_page() will wait until the migration
+				 * pte is removed and then restart fault handling.
+				 */
+				entry = make_migration_entry(subpage,
+						pte_write(pteval));
+				swp_pte = swp_entry_to_pte(entry);
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+				set_pte_at(mm, address, pvmw.pte, swp_pte);
+				/*
+				 * No need to invalidate here it will synchronize on
+				 * against the special swap migration pte.
+				 */
+			} else if (!pvmw.pte && pvmw.pmd) {
+				pmd_t swp_pmd;
+				/*
+				 * Store the pfn of the page in a special migration
+				 * pte. do_swap_page() will wait until the migration
+				 * pte is removed and then restart fault handling.
+				 */
+				entry = make_migration_entry(subpage,
+						pmd_write(pmdval));
+				swp_pmd = swp_entry_to_pmd(entry);
+				if (pmd_soft_dirty(pmdval))
+					swp_pmd = pmd_swp_mksoft_dirty(swp_pmd);
+				set_pmd_at(mm, address, pvmw.pmd, swp_pmd);
+				/*
+				 * No need to invalidate here it will synchronize on
+				 * against the special swap migration pte.
+				 */
+			} else if (!pvmw.pte && !pvmw.pmd && pvmw.pud) {
+				VM_BUG_ON(1);
+			}
 		} else if (PageAnon(page)) {
 			swp_entry_t entry = { .val = page_private(subpage) };
 			pte_t swp_pte;
+
+			VM_BUG_ON(!pvmw.pte);
 			/*
 			 * Store the swap location in the pte.
 			 * See handle_pte_fault() ...
@@ -1794,7 +1865,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page), 0);
+		page_remove_rmap(subpage, PageHuge(page) || order >= HPAGE_PMD_ORDER, order);
 		put_page(page);
 	}
 
-- 
2.28.0

