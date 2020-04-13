Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2DD20737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgDMKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:05:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:63626 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgDMKFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:05:17 -0400
IronPort-SDR: AShcXmRT+21nbrpiCG2DaAMYtuQQjLbTa3+Jeq2vAJVeaazlchxGA3k+9d9eYgmLy3V/XRae0c
 S8HaNru5LSSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 03:04:57 -0700
IronPort-SDR: cLZHmO+l+QKfmjoFjz3dZ1MGe5wuaWm/RPlyh8Ulv1B9c46mfYFCPsX0/iFhX7tTTOwgvuXTQ9
 25V3V9bdAysQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="426640509"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2020 03:04:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A788B1F5; Mon, 13 Apr 2020 13:04:50 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 5/6] khugepaged: Allow to collapse a page shared across fork
Date:   Mon, 13 Apr 2020 13:04:46 +0300
Message-Id: <20200413100447.20073-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
References: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page can be included into collapse as long as it doesn't have extra
pins (from GUP or otherwise).

Logic to check the refcound is moved to a separate function.
Note that the function is ready to deal with compound pages. It's
preparation for the following patch.

VM_BUG_ON_PAGE() was removed from __collapse_huge_page_copy() as the
invariant it checks is no longer valid: the source can be mapped
multiple times now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e3e41c2768d8..f9864644c3b7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -529,6 +529,24 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte)
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
+		pr_err("expected_refcount: %d, refcount: %d\n",
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
@@ -581,11 +599,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
+		 * but not for the this process. It is fine. The other process
+		 * cannot write to the page, only trigger CoW.
 		 */
-		if (page_count(page) != 1 + PageSwapCache(page)) {
+		if (!is_refcount_suitable(page)) {
 			unlock_page(page);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -672,7 +696,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
-			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
 			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
@@ -1201,12 +1224,8 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
2.26.0

