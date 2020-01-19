Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF374C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6F206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgASNOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 08:14:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:54272 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgASNOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:14:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 05:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,338,1574150400"; 
   d="scan'208";a="220464515"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2020 05:14:34 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 3/4] mm/page_alloc.c: rename free_pages_check() to check_free_page()
Date:   Sun, 19 Jan 2020 21:14:07 +0800
Message-Id: <20200119131408.23247-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119131408.23247-1-richardw.yang@linux.intel.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pages_check() is the counterpart of check_new_page(), while
their naming convention is a little different.

Use verb at first and singular form.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2324df1b261..87658a16af07 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1055,7 +1055,7 @@ static void check_free_page_bad(struct page *page)
 	bad_page(page, bad_reason, bad_flags);
 }
 
-static inline int free_pages_check(struct page *page)
+static inline int check_free_page(struct page *page)
 {
 	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
 		return 0;
@@ -1147,7 +1147,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-			if (unlikely(free_pages_check(page + i))) {
+			if (unlikely(check_free_page(page + i))) {
 				bad++;
 				continue;
 			}
@@ -1159,7 +1159,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (memcg_kmem_enabled() && PageKmemcg(page))
 		__memcg_kmem_uncharge(page, order);
 	if (check_free)
-		bad += free_pages_check(page);
+		bad += check_free_page(page);
 	if (bad)
 		return false;
 
@@ -1206,7 +1206,7 @@ static bool free_pcp_prepare(struct page *page)
 static bool bulkfree_pcp_prepare(struct page *page)
 {
 	if (debug_pagealloc_enabled_static())
-		return free_pages_check(page);
+		return check_free_page(page);
 	else
 		return false;
 }
@@ -1227,7 +1227,7 @@ static bool free_pcp_prepare(struct page *page)
 
 static bool bulkfree_pcp_prepare(struct page *page)
 {
-	return free_pages_check(page);
+	return check_free_page(page);
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
2.17.1

