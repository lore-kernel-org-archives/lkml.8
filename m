Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7ADC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B40E20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgATDEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:04:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:51507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgATDEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:04:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 19:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="306802525"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2020 19:04:28 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, richardw.yang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
Subject: [Patch v2 4/4] mm/page_alloc.c: extract commom part to check page
Date:   Mon, 20 Jan 2020 11:04:15 +0800
Message-Id: <20200120030415.15925-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120030415.15925-1-richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During free and new page, we did some check on the status of page
struct. There is some common part, just extract them.

Besides this, this patch also rename two functions to keep the name
convention, since free_pages_check_bad/free_pages_check are counterparts
of check_new_page_bad/check_new_page.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_alloc.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a7b793c739fc..7f23cc836f90 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1025,36 +1025,44 @@ static inline bool page_expected_state(struct page *page,
 	return true;
 }
 
-static void free_pages_check_bad(struct page *page)
+static inline int __check_page(struct page *page, int nr,
+				const char **bad_reason)
 {
-	const char *bad_reason[5];
-	unsigned long bad_flags = 0;
-	int nr = 0;
-
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
 		bad_reason[nr++] = "nonzero mapcount";
 	if (unlikely(page->mapping != NULL))
 		bad_reason[nr++] = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason[nr++] = "nonzero _refcount";
-	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
-		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
-		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
-	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
 		bad_reason[nr++] = "page still charged to cgroup";
 #endif
+
+	return nr;
+}
+
+static void check_free_page_bad(struct page *page)
+{
+	const char *bad_reason[5];
+	unsigned long bad_flags = 0;
+	int nr = 0;
+
+	nr = __check_page(page, nr, bad_reason);
+	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
+		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
+		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
+	}
 	bad_page(page, nr, bad_reason, bad_flags);
 }
 
-static inline int free_pages_check(struct page *page)
+static inline int check_free_page(struct page *page)
 {
 	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
 		return 0;
 
 	/* Something has gone sideways, find it */
-	free_pages_check_bad(page);
+	check_free_page_bad(page);
 	return 1;
 }
 
@@ -1145,7 +1153,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-			if (unlikely(free_pages_check(page + i))) {
+			if (unlikely(check_free_page(page + i))) {
 				bad++;
 				continue;
 			}
@@ -1157,7 +1165,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (memcg_kmem_enabled() && PageKmemcg(page))
 		__memcg_kmem_uncharge(page, order);
 	if (check_free)
-		bad += free_pages_check(page);
+		bad += check_free_page(page);
 	if (bad)
 		return false;
 
@@ -1204,7 +1212,7 @@ static bool free_pcp_prepare(struct page *page)
 static bool bulkfree_pcp_prepare(struct page *page)
 {
 	if (debug_pagealloc_enabled_static())
-		return free_pages_check(page);
+		return check_free_page(page);
 	else
 		return false;
 }
@@ -1225,7 +1233,7 @@ static bool free_pcp_prepare(struct page *page)
 
 static bool bulkfree_pcp_prepare(struct page *page)
 {
-	return free_pages_check(page);
+	return check_free_page(page);
 }
 #endif /* CONFIG_DEBUG_VM */
 
@@ -2048,12 +2056,7 @@ static void check_new_page_bad(struct page *page)
 	unsigned long bad_flags = 0;
 	int nr = 0;
 
-	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason[nr++] = "nonzero mapcount";
-	if (unlikely(page->mapping != NULL))
-		bad_reason[nr++] = "non-NULL mapping";
-	if (unlikely(page_ref_count(page) != 0))
-		bad_reason[nr++] = "nonzero _refcount";
+	nr = __check_page(page, nr, bad_reason);
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
@@ -2063,10 +2066,6 @@ static void check_new_page_bad(struct page *page)
 		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_PREP flag set";
 		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
 	}
-#ifdef CONFIG_MEMCG
-	if (unlikely(page->mem_cgroup))
-		bad_reason[nr++] = "page still charged to cgroup";
-#endif
 	bad_page(page, 1, bad_reason, bad_flags);
 }
 
-- 
2.17.1

