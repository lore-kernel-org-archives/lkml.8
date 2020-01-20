Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5040BC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F94820714
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgATDEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:04:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:51507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgATDE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:04:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 19:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="306802521"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2020 19:04:26 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, richardw.yang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
Subject: [Patch v2 3/4] mm/page_alloc.c: pass all bad reasons to bad_page()
Date:   Mon, 20 Jan 2020 11:04:14 +0800
Message-Id: <20200120030415.15925-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120030415.15925-1-richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can pass all bad reasons to __dump_page().

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_alloc.c | 52 ++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a43b9d2482f2..a7b793c739fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -609,7 +609,7 @@ static inline int __maybe_unused bad_range(struct zone *zone, struct page *page)
 }
 #endif
 
-static void bad_page(struct page *page, const char *reason,
+static void bad_page(struct page *page, int nr, const char **reason,
 		unsigned long bad_flags)
 {
 	static unsigned long resume;
@@ -638,7 +638,7 @@ static void bad_page(struct page *page, const char *reason,
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
-	__dump_page(page, 1, &reason);
+	__dump_page(page, nr, reason);
 	bad_flags &= page->flags;
 	if (bad_flags)
 		pr_alert("bad because of flags: %#lx(%pGp)\n",
@@ -1027,27 +1027,25 @@ static inline bool page_expected_state(struct page *page,
 
 static void free_pages_check_bad(struct page *page)
 {
-	const char *bad_reason;
-	unsigned long bad_flags;
-
-	bad_reason = NULL;
-	bad_flags = 0;
+	const char *bad_reason[5];
+	unsigned long bad_flags = 0;
+	int nr = 0;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
+		bad_reason[nr++] = "nonzero mapcount";
 	if (unlikely(page->mapping != NULL))
-		bad_reason = "non-NULL mapping";
+		bad_reason[nr++] = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
-		bad_reason = "nonzero _refcount";
+		bad_reason[nr++] = "nonzero _refcount";
 	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
-		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
+		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
 		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
 	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
-		bad_reason = "page still charged to cgroup";
+		bad_reason[nr++] = "page still charged to cgroup";
 #endif
-	bad_page(page, bad_reason, bad_flags);
+	bad_page(page, nr, bad_reason, bad_flags);
 }
 
 static inline int free_pages_check(struct page *page)
@@ -1062,6 +1060,7 @@ static inline int free_pages_check(struct page *page)
 
 static int free_tail_pages_check(struct page *head_page, struct page *page)
 {
+	const char *reason;
 	int ret = 1;
 
 	/*
@@ -1078,7 +1077,8 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 	case 1:
 		/* the first tail page: ->mapping may be compound_mapcount() */
 		if (unlikely(compound_mapcount(page))) {
-			bad_page(page, "nonzero compound_mapcount", 0);
+			reason = "nonzero compound_mapcount";
+			bad_page(page, 1, &reason, 0);
 			goto out;
 		}
 		break;
@@ -1090,17 +1090,20 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		break;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
-			bad_page(page, "corrupted mapping in tail page", 0);
+			reason = "corrupted mapping in tail page";
+			bad_page(page, 1, &reason, 0);
 			goto out;
 		}
 		break;
 	}
 	if (unlikely(!PageTail(page))) {
-		bad_page(page, "PageTail not set", 0);
+		reason = "PageTail not set";
+		bad_page(page, 1, &reason, 0);
 		goto out;
 	}
 	if (unlikely(compound_head(page) != head_page)) {
-		bad_page(page, "compound_head not consistent", 0);
+		reason = "compound_head not consistent";
+		bad_page(page, 1, &reason, 0);
 		goto out;
 	}
 	ret = 0;
@@ -2041,29 +2044,30 @@ static inline void expand(struct zone *zone, struct page *page,
 
 static void check_new_page_bad(struct page *page)
 {
-	const char *bad_reason = NULL;
+	const char *bad_reason[5];
 	unsigned long bad_flags = 0;
+	int nr = 0;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
+		bad_reason[nr++] = "nonzero mapcount";
 	if (unlikely(page->mapping != NULL))
-		bad_reason = "non-NULL mapping";
+		bad_reason[nr++] = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
-		bad_reason = "nonzero _refcount";
+		bad_reason[nr++] = "nonzero _refcount";
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
 		return;
 	}
 	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP)) {
-		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
+		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_PREP flag set";
 		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
 	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
-		bad_reason = "page still charged to cgroup";
+		bad_reason[nr++] = "page still charged to cgroup";
 #endif
-	bad_page(page, bad_reason, bad_flags);
+	bad_page(page, 1, bad_reason, bad_flags);
 }
 
 /*
-- 
2.17.1

