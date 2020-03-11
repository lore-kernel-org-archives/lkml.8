Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4910DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C4120727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCKBMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:12:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:6130 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbgCKBMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:12:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 18:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="415398543"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2020 18:12:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH] mm: Add more comments for MADV_FREE
Date:   Wed, 11 Mar 2020 09:11:17 +0800
Message-Id: <20200311011117.1656744-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

To help people understand the MADV_FREE code, especially the page flag,
PG_swapbacked.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@surriel.com>
---
 include/linux/mm_inline.h  | 9 +++++----
 include/linux/page-flags.h | 4 ++++
 mm/swap.c                  | 6 +++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f2fef7b0784..01144dd02a5f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -9,10 +9,11 @@
  * page_is_file_cache - should the page be on a file LRU or anon LRU?
  * @page: the page to test
  *
- * Returns 1 if @page is page cache page backed by a regular filesystem,
- * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
- * Used by functions that manipulate the LRU lists, to sort a page
- * onto the right LRU list.
+ * Returns 1 if @page is page cache page backed by a regular filesystem or
+ * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
+ * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
+ * functions that manipulate the LRU lists, to sort a page onto the right LRU
+ * list.
  *
  * We would like to get this info without a page flag, but the state
  * needs to survive until the page is last deleted from the LRU, which
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 49c2697046b9..992b71c4fc85 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -63,6 +63,10 @@
  * page_waitqueue(page) is a wait queue of all tasks waiting for the page
  * to become unlocked.
  *
+ * PG_swapbacked is cleared if the page is page cache page backed by a regular
+ * file system or anonymous page lazily freed (e.g. via MADV_FREE).  It is set
+ * if the page is normal anonymous page, tmpfs or otherwise RAM or swap backed.
+ *
  * PG_uptodate tells whether the page's contents is valid.  When a read
  * completes, the page becomes uptodate, unless a disk I/O error happened.
  *
diff --git a/mm/swap.c b/mm/swap.c
index 6a8be910b14d..90bb14695809 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -573,9 +573,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		/*
-		 * lazyfree pages are clean anonymous pages. They have
-		 * SwapBacked flag cleared to distinguish normal anonymous
-		 * pages
+		 * Lazyfree pages are clean anonymous pages.  They
+		 * have PG_swapbacked flag cleared, to distinguish
+		 * them from normal anonymous pages
 		 */
 		ClearPageSwapBacked(page);
 		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
-- 
2.25.0

