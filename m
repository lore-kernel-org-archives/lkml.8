Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5686D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgCaIq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:46:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:54982 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaIq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:46:28 -0400
IronPort-SDR: 3sDlFRQVqoPfxddfLtdZDebpngSOJNurqDvYqXraGdAQRzcK9O+MicZa2ku/Ux4WiTb1vp4doi
 SHVywhbou7ZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 01:46:27 -0700
IronPort-SDR: f7rPsaBapnpRYt+jaYUbJlG+PrJWci/MRaj4t6k8fAtPtK0vZ9u+M3+ew0AAsh/+whCDaAI2qx
 EjJ458LOzUPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="294864861"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2020 01:46:24 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH] mm, trivial: Simplify swap related code in try_to_unmap_one()
Date:   Tue, 31 Mar 2020 16:46:13 +0800
Message-Id: <20200331084613.1258555-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

Because PageSwapCache() will always return false if PageSwapBacked() returns
false, and PageSwapBacked() will be check for MADV_FREE pages in
try_to_unmap_one().  The swap related code in try_to_unmap_one() can be
simplified to improve the readability.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@surriel.com>
---
 mm/rmap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2126fd4a254b..cd3c406aeac7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1613,19 +1613,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		} else if (PageAnon(page)) {
 			swp_entry_t entry = { .val = page_private(subpage) };
 			pte_t swp_pte;
-			/*
-			 * Store the swap location in the pte.
-			 * See handle_pte_fault() ...
-			 */
-			if (unlikely(PageSwapBacked(page) != PageSwapCache(page))) {
-				WARN_ON_ONCE(1);
-				ret = false;
-				/* We have to invalidate as we cleared the pte */
-				mmu_notifier_invalidate_range(mm, address,
-							address + PAGE_SIZE);
-				page_vma_mapped_walk_done(&pvmw);
-				break;
-			}
 
 			/* MADV_FREE page check */
 			if (!PageSwapBacked(page)) {
@@ -1648,6 +1635,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				break;
 			}
 
+			/*
+			 * Store the swap location in the pte.
+			 * See handle_pte_fault() ...
+			 */
+			if (unlikely(!PageSwapCache(page))) {
+				WARN_ON_ONCE(1);
+				ret = false;
+				/* We have to invalidate as we cleared the pte */
+				mmu_notifier_invalidate_range(mm, address,
+							address + PAGE_SIZE);
+				page_vma_mapped_walk_done(&pvmw);
+				break;
+			}
+
 			if (swap_duplicate(entry) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
-- 
2.25.0

