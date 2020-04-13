Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DEC2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB33B206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgDMKF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:05:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:63626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgDMKE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:58 -0400
IronPort-SDR: 2I1wx/AK1hz5+5PNBE7t27cuU9a3BlQDJf1oqedWeouOnFnxBIZaiuciTnn8W0FQRk55TMc4QH
 cTzJ6J2g+COg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 03:04:53 -0700
IronPort-SDR: Xqmk6jTy4ieXBOVMMhQAIu0zp0jWrua68mhW+1Xlt2bLQU6qzENoTC3uHAMwruDw6g3AMNRYlm
 FlSr+BPAeAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="453111385"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2020 03:04:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 87B8A16B; Mon, 13 Apr 2020 13:04:50 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/6] khugepaged: Do not stop collapse if less than half PTEs are referenced
Date:   Mon, 13 Apr 2020 13:04:43 +0300
Message-Id: <20200413100447.20073-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
References: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_swapin() checks the number of referenced PTE to
decide if the memory range is hot enough to justify swapin.

We have few problems with the approach:

 - It is way too late: we can do the check much earlier and safe time.
   khugepaged_scan_pmd() already knows if we have any pages to swap in
   and number of referenced page.

 - It stops collapse altogether if there's not enough referenced pages,
   not only swappingin.

Fix it by making the right check early. We also can avoid additional
page table scanning if khugepaged_scan_pmd() haven't found any swap
entries.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
---
 mm/khugepaged.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99bab7e4d05b..5968ec5ddd6b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -902,11 +902,6 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 		.pgoff = linear_page_index(vma, address),
 	};
 
-	/* we only decide to swapin, if there is enough young ptes */
-	if (referenced < HPAGE_PMD_NR/2) {
-		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-		return false;
-	}
 	vmf.pte = pte_offset_map(pmd, address);
 	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
 			vmf.pte++, vmf.address += PAGE_SIZE) {
@@ -946,7 +941,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 static void collapse_huge_page(struct mm_struct *mm,
 				   unsigned long address,
 				   struct page **hpage,
-				   int node, int referenced)
+				   int node, int referenced, int unmapped)
 {
 	pmd_t *pmd, _pmd;
 	pte_t *pte;
@@ -1003,7 +998,8 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 * If it fails, we release mmap_sem and jump out_nolock.
 	 * Continuing to collapse causes inconsistency.
 	 */
-	if (!__collapse_huge_page_swapin(mm, vma, address, pmd, referenced)) {
+	if (unmapped && !__collapse_huge_page_swapin(mm, vma, address,
+				pmd, referenced)) {
 		mem_cgroup_cancel_charge(new_page, memcg, true);
 		up_read(&mm->mmap_sem);
 		goto out_nolock;
@@ -1214,22 +1210,21 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		    mmu_notifier_test_young(vma->vm_mm, address))
 			referenced++;
 	}
-	if (writable) {
-		if (referenced) {
+	if (!writable) {
+		result = SCAN_PAGE_RO;
+	} else if (!referenced || (unmapped && referenced < HPAGE_PMD_NR/2)) {
+		result = SCAN_LACK_REFERENCED_PAGE;
+	} else {
 			result = SCAN_SUCCEED;
 			ret = 1;
-		} else {
-			result = SCAN_LACK_REFERENCED_PAGE;
-		}
-	} else {
-		result = SCAN_PAGE_RO;
 	}
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
 	if (ret) {
 		node = khugepaged_find_target_node();
 		/* collapse_huge_page will return with the mmap_sem released */
-		collapse_huge_page(mm, address, hpage, node, referenced);
+		collapse_huge_page(mm, address, hpage, node,
+				referenced, unmapped);
 	}
 out:
 	trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,
-- 
2.26.0

