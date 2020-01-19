Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25879C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0654C2072B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgASNOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 08:14:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:54272 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgASNOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:14:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 05:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,338,1574150400"; 
   d="scan'208";a="220464497"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2020 05:14:31 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/4] mm/page_alloc.c: extract commom part to check page
Date:   Sun, 19 Jan 2020 21:14:05 +0800
Message-Id: <20200119131408.23247-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119131408.23247-1-richardw.yang@linux.intel.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During free and new page, we did some check on the status of page
struct.

There is some common part, just extract them.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_alloc.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..8cd06729169f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1025,13 +1025,9 @@ static inline bool page_expected_state(struct page *page,
 	return true;
 }
 
-static void free_pages_check_bad(struct page *page)
+static inline const char *__check_page(struct page *page)
 {
-	const char *bad_reason;
-	unsigned long bad_flags;
-
-	bad_reason = NULL;
-	bad_flags = 0;
+	const char *bad_reason = NULL;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
 		bad_reason = "nonzero mapcount";
@@ -1039,14 +1035,23 @@ static void free_pages_check_bad(struct page *page)
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
-		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
-		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
-	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
 		bad_reason = "page still charged to cgroup";
 #endif
+	return bad_reason;
+}
+
+static void free_pages_check_bad(struct page *page)
+{
+	const char *bad_reason = NULL;
+	unsigned long bad_flags = 0;
+
+	bad_reason = __check_page(page);
+	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
+		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
+		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
+	}
 	bad_page(page, bad_reason, bad_flags);
 }
 
@@ -2044,12 +2049,7 @@ static void check_new_page_bad(struct page *page)
 	const char *bad_reason = NULL;
 	unsigned long bad_flags = 0;
 
-	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
-	if (unlikely(page->mapping != NULL))
-		bad_reason = "non-NULL mapping";
-	if (unlikely(page_ref_count(page) != 0))
-		bad_reason = "nonzero _refcount";
+	bad_reason = __check_page(page);
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		bad_reason = "HWPoisoned (hardware-corrupted)";
 		bad_flags = __PG_HWPOISON;
@@ -2061,10 +2061,6 @@ static void check_new_page_bad(struct page *page)
 		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
 		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
 	}
-#ifdef CONFIG_MEMCG
-	if (unlikely(page->mem_cgroup))
-		bad_reason = "page still charged to cgroup";
-#endif
 	bad_page(page, bad_reason, bad_flags);
 }
 
-- 
2.17.1

