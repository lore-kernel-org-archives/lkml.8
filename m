Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1682173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCCDhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:37:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:16422 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgCCDhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:37:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 19:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="232132380"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2020 19:36:58 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm, migrate: Check return value of try_to_unmap()
Date:   Tue,  3 Mar 2020 11:36:45 +0800
Message-Id: <20200303033645.280694-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

During the page migration, try_to_unmap() is called to replace the
page table entries with the migration entries.  Now its return value
is ignored, that is generally OK in most cases.  But in theory, it's
possible that try_to_unmap() return false (failure) for the page
migration after arch_unmap_one() is called in unmap code.  Even if
without arch_unmap_one(), it makes code more robust for the future
code changing to check the return value.

Known issue: I don't know what is the appropriate error code for
try_to_unmap() failure.  Whether EIO is OK?

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/migrate.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3900044cfaa6..981f8374a6ef 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1116,8 +1116,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		/* Establish migration ptes */
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
-		try_to_unmap(page,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
+		if (!try_to_unmap(page,
+			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS)) {
+			rc = -EIO;
+			goto out_unlock_both;
+		}
 		page_was_mapped = 1;
 	}
 
@@ -1337,8 +1340,11 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		try_to_unmap(hpage,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
+		if (!try_to_unmap(hpage,
+			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS)) {
+			rc = -EIO;
+			goto unlock_both;
+		}
 		page_was_mapped = 1;
 	}
 
@@ -1349,6 +1355,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		remove_migration_ptes(hpage,
 			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
 
+unlock_both:
 	unlock_page(new_hpage);
 
 put_anon:
@@ -2558,8 +2565,7 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
 			continue;
 
 		if (page_mapped(page)) {
-			try_to_unmap(page, flags);
-			if (page_mapped(page))
+			if (!try_to_unmap(page, flags))
 				goto restore;
 		}
 
-- 
2.25.0

