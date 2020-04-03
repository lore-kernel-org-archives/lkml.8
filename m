Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A82C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4079F2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="HxR/QJ/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbgDCL3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:29:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40475 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgDCL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so6539095ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuEy02dea2Id4xDMDSGK8RSYYGNAW5A/0ZkDN1BjR34=;
        b=HxR/QJ/L4Z6HP93x/D6CzjyRFeUboWgvzTyMgbZfnDaxgUHZN6tIaAcsHiEasuYhNH
         5r/gCVehKDpxFiqtwJBjsLp0fDkEwMPG6M75u/aBZAg5RRr+kUJ1t7528sN06um6s34e
         +HarAoZzw6ob0Q+4xbBLr9YCpuByc629A8SomBymWKozj0ezCagw540mUpvay83YJQ8G
         ZOrHUWhr3kKtVIeOh6Nh+2Epm9gBMwcqjcnNUmXczD9YUlg+ON1QX840ur06fbbEHvi6
         ecRCHW4hgy3PbS/LvDAPkBfCAl8BIFXGMj++xMLy2Iy8e7YIAQ4H158yqwpl8FWaC9Yh
         Dftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuEy02dea2Id4xDMDSGK8RSYYGNAW5A/0ZkDN1BjR34=;
        b=oMvDlY/RqSWvPcdI9AcDr3iTsh4CK3js823i6Ae2xqWrYAR64q0DxNrLlV1K5F84iU
         1FUlaQzSmh9LKOgBR0tTzNR9IVh9d0df13KAmtBqIwaeMhaYvwT2HGJFuS9CWFHellVS
         AAJ+tST4nWTDlJWMav4TuNNdpJbc1DCraF6hAvXgD20HguWjKPUy4gfdwu8KpUIF2/9Z
         93IhWaEkdnVNVuwAdqcOtudLFeL+PqzcKtVKN/Pgp9bn7uGzWeD6Qj3dcLRRSaqb6VWU
         p7prCLx/4rrVaQ+hNgbYKfqH42NBN9BDS/iZa3aVZGMCxQsVKr0i6TP2TjVhzhIQGrl9
         tssA==
X-Gm-Message-State: AGi0PuZkXm++zfvze51kCI0TtgaTE/6q9qjnaHMMfz1byOMtdmbMXF1I
        ebK3ZvHuSTSS59t6XWbEyY/pWA==
X-Google-Smtp-Source: APiQypJx19H3PKA94XWdS8fRP37nmflFSLxOtZfO5fJK+nPnKT5g2EYx9/vmKNzWDSlNFpPCBSsWsw==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr4499348ljj.284.1585913375878;
        Fri, 03 Apr 2020 04:29:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n23sm4708341lji.59.2020.04.03.04.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:29:34 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 86739101334; Fri,  3 Apr 2020 14:29:31 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 6/8] khugepaged: Allow to collapse PTE-mapped compound pages
Date:   Fri,  3 Apr 2020 14:29:26 +0300
Message-Id: <20200403112928.19742-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can collapse PTE-mapped compound pages. We only need to avoid
handling them more than once: lock/unlock page only once if it's present
in the PMD range multiple times as it handled on compound level. The
same goes for LRU isolation and putback.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 103 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 35 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1e7e6543ebca..49e56e4e30d1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -515,23 +515,37 @@ void __khugepaged_exit(struct mm_struct *mm)
 
 static void release_pte_page(struct page *page)
 {
-	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
+	mod_node_page_state(page_pgdat(page),
+			NR_ISOLATED_ANON + page_is_file_cache(page),
+			-compound_nr(page));
 	unlock_page(page);
 	putback_lru_page(page);
 }
 
-static void release_pte_pages(pte_t *pte, pte_t *_pte)
+static void release_pte_pages(pte_t *pte, pte_t *_pte,
+		struct list_head *compound_pagelist)
 {
+	struct page *page, *tmp;
+
 	while (--_pte >= pte) {
 		pte_t pteval = *_pte;
-		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)))
-			release_pte_page(pte_page(pteval));
+
+		page = pte_page(pteval);
+		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
+				!PageCompound(page))
+			release_pte_page(page);
+	}
+
+	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
+		list_del(&page->lru);
+		release_pte_page(page);
 	}
 }
 
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long address,
-					pte_t *pte)
+					pte_t *pte,
+					struct list_head *compound_pagelist)
 {
 	struct page *page = NULL;
 	pte_t *_pte;
@@ -561,13 +575,21 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 
-		/* TODO: teach khugepaged to collapse THP mapped with pte */
+		VM_BUG_ON_PAGE(!PageAnon(page), page);
+
 		if (PageCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
-			goto out;
-		}
+			struct page *p;
+			page = compound_head(page);
 
-		VM_BUG_ON_PAGE(!PageAnon(page), page);
+			/*
+			 * Check if we have dealt with the compound page
+			 * already
+			 */
+			list_for_each_entry(p, compound_pagelist, lru) {
+				if (page == p)
+					goto next;
+			}
+		}
 
 		/*
 		 * We can do it before isolate_lru_page because the
@@ -597,19 +619,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_PAGE_COUNT;
 			goto out;
 		}
-		if (pte_write(pteval)) {
-			writable = true;
-		} else {
-			if (PageSwapCache(page) &&
-			    !reuse_swap_page(page, NULL)) {
-				unlock_page(page);
-				result = SCAN_SWAP_CACHE_PAGE;
-				goto out;
-			}
+		if (!pte_write(pteval) && PageSwapCache(page) &&
+				!reuse_swap_page(page, NULL)) {
 			/*
-			 * Page is not in the swap cache. It can be collapsed
-			 * into a THP.
+			 * Page is in the swap cache and cannot be re-used.
+			 * It cannot be collapsed into a THP.
 			 */
+			unlock_page(page);
+			result = SCAN_SWAP_CACHE_PAGE;
+			goto out;
 		}
 
 		/*
@@ -621,16 +639,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
 		}
-		inc_node_page_state(page,
-				NR_ISOLATED_ANON + page_is_file_cache(page));
+		mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_cache(page),
+				compound_nr(page));
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 
+		if (PageCompound(page))
+			list_add_tail(&page->lru, compound_pagelist);
+next:
 		/* There should be enough young pte to collapse the page */
 		if (pte_young(pteval) ||
 		    page_is_young(page) || PageReferenced(page) ||
 		    mmu_notifier_test_young(vma->vm_mm, address))
 			referenced++;
+
+		if (pte_write(pteval))
+			writable = true;
 	}
 	if (likely(writable)) {
 		if (likely(referenced)) {
@@ -644,7 +669,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	}
 
 out:
-	release_pte_pages(pte, _pte);
+	release_pte_pages(pte, _pte, compound_pagelist);
 	trace_mm_collapse_huge_page_isolate(page, none_or_zero,
 					    referenced, writable, result);
 	return 0;
@@ -653,13 +678,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 				      struct vm_area_struct *vma,
 				      unsigned long address,
-				      spinlock_t *ptl)
+				      spinlock_t *ptl,
+				      struct list_head *compound_pagelist)
 {
+	struct page *src_page, *tmp;
 	pte_t *_pte;
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 				_pte++, page++, address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
-		struct page *src_page;
 
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			clear_user_highpage(page, address);
@@ -679,7 +705,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
-			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
@@ -693,9 +718,18 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			pte_clear(vma->vm_mm, address, _pte);
 			page_remove_rmap(src_page, false);
 			spin_unlock(ptl);
-			free_page_and_swap_cache(src_page);
+			if (!PageCompound(src_page)) {
+				release_pte_page(src_page);
+				free_page_and_swap_cache(src_page);
+			}
 		}
 	}
+
+	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
+		list_del(&src_page->lru);
+		release_pte_page(src_page);
+		free_page_and_swap_cache(src_page);
+	}
 }
 
 static void khugepaged_alloc_sleep(void)
@@ -960,6 +994,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 				   struct page **hpage,
 				   int node, int referenced)
 {
+	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
 	pte_t *pte;
 	pgtable_t pgtable;
@@ -1059,7 +1094,8 @@ static void collapse_huge_page(struct mm_struct *mm,
 	mmu_notifier_invalidate_range_end(&range);
 
 	spin_lock(pte_ptl);
-	isolated = __collapse_huge_page_isolate(vma, address, pte);
+	isolated = __collapse_huge_page_isolate(vma, address, pte,
+			&compound_pagelist);
 	spin_unlock(pte_ptl);
 
 	if (unlikely(!isolated)) {
@@ -1084,7 +1120,8 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 */
 	anon_vma_unlock_write(vma->anon_vma);
 
-	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl);
+	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl,
+			&compound_pagelist);
 	pte_unmap(pte);
 	__SetPageUptodate(new_page);
 	pgtable = pmd_pgtable(_pmd);
@@ -1181,11 +1218,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
-		/* TODO: teach khugepaged to collapse THP mapped with pte */
-		if (PageCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
-			goto out_unmap;
-		}
+		page = compound_head(page);
 
 		/*
 		 * Record which node the original page is from and save this
-- 
2.26.0

