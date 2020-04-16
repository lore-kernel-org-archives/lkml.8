Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC78EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EE4217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895344AbgDPQBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:45354 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636435AbgDPQAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:00:48 -0400
IronPort-SDR: L8eiLAQk2w7n4uH9K3zJYXh7jVL7At0MTCOgpb68WoSRRdSlhMXK5PZcwrkFyZeJrmV9hRxIBm
 64ZpDSMdqZ9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:00:39 -0700
IronPort-SDR: iVqiOFP25a1U7dkVbtw6j6AhwqdEaRPeexBVhz1fyFmL2prtZ3BGMOenCbnFEt1bk5Nu7sKlXm
 Asw+O+k1MpTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="454377415"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 09:00:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8359D638; Thu, 16 Apr 2020 19:00:31 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 5/8] khugepaged: Allow to collapse a page shared across fork
Date:   Thu, 16 Apr 2020 19:00:23 +0300
Message-Id: <20200416160026.16538-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
References: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page can be included into collapse as long as it doesn't have extra
pins (from GUP or otherwise).

Logic to check the refcount is moved to a separate function.
For pages in swap cache, add compound_nr(page) to the expected refcount,
in order to handle the compound page case. This is in preparation for
the following patch.

VM_BUG_ON_PAGE() was removed from __collapse_huge_page_copy() as the
invariant it checks is no longer valid: the source can be mapped
multiple times now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-and-Tested-by: Zi Yan <ziy@nvidia.com>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/khugepaged.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index adc686f13447..c3eb9d0d53f8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -526,6 +526,24 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte)
 	}
 }
 
+static bool is_refcount_suitable(struct page *page)
+{
+	int expected_refcount, refcount;
+
+	refcount = page_count(page);
+	expected_refcount = total_mapcount(page);
+	if (PageSwapCache(page))
+		expected_refcount += compound_nr(page);
+
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
+		pr_err("expected_refcount (%d) > refcount (%d)\n",
+				expected_refcount, refcount);
+		dump_page(page, "Unexpected refcount");
+	}
+
+	return page_count(page) == expected_refcount;
+}
+
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long address,
 					pte_t *pte)
@@ -578,11 +596,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		}
 
 		/*
-		 * cannot use mapcount: can't collapse if there's a gup pin.
-		 * The page must only be referenced by the scanned process
-		 * and page swap cache.
+		 * Check if the page has any GUP (or other external) pins.
+		 *
+		 * The page table that maps the page has been already unlinked
+		 * from the page table tree and this process cannot get
+		 * an additinal pin on the page.
+		 *
+		 * New pins can come later if the page is shared across fork,
+		 * but not from this process. The other process cannot write to
+		 * the page, only trigger CoW.
 		 */
-		if (page_count(page) != 1 + PageSwapCache(page)) {
+		if (!is_refcount_suitable(page)) {
 			unlock_page(page);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -669,7 +693,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
-			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
 			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
@@ -1220,12 +1243,8 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
-		/*
-		 * cannot use mapcount: can't collapse if there's a gup pin.
-		 * The page must only be referenced by the scanned process
-		 * and page swap cache.
-		 */
-		if (page_count(page) != 1 + PageSwapCache(page)) {
+		/* Check if the page has any GUP (or other external) pins */
+		if (!is_refcount_suitable(page)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
-- 
2.26.1

