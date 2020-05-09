Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0443C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12F821655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euBpYkLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgEIOVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgEIOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:21:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23789C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 07:21:05 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id bm3so4870181qvb.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ho7QmA8ZMfJz5ce1k/QRjeTlDkjueHSq5xTJ1WkUGPU=;
        b=euBpYkLZT5GCedcber4H9h9dWGQVNueJcKLCWbi6PjcjCRaXvEO3FSv6oxRwwUAcRX
         7GMUSbDU/RRorSdHyDULaGTDy/Isb9HnWNv7uSFLIfnAXzEpjWDDZ9ecaAwCn38NKEax
         0gxXcwOHQME06+ZLRp6AKJRAprFG+BeMW0AMuJwFn4hm7d/fC18Mq2e2iKDvK5mUx0ky
         cX8PZeU1z8XhY6WWAroJsXpMPBuCNM/A3kiB8uNk78xyddWkFlb8dY2JcUKeYDVVxcxU
         03HIujUpyoUQNXPgcwuBD82gGKi09HB9Dvm1DNqlyDFFcRnk9xuzcpKm6feAtg5c87Eu
         SAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ho7QmA8ZMfJz5ce1k/QRjeTlDkjueHSq5xTJ1WkUGPU=;
        b=XPrgJaibEcDfdLRLEE/KjeYQhpMbpLjC5s1IX5L2Jk+iDn6cROM4q+2XtsgNeyLneC
         FckFVEUNbWZTLcS7hbBRqV7gMgxr0PiBFlx6cxshb5n5sYEMOIWyR3R7zDYLYC8KvXmj
         oUEhBOfsCoLK+jnW5zMVDpjmD2E99szxd2DxTFctLTDqGS68TzRYreQpm5wWzafH4c7r
         KcWggMyqz+w4XuuzojRiGBl/Z9goyBCCx1wRVSYgFwJNLmc3YEqMoeNlQi9uIBdAW5vA
         bEuYWj2jAUT4eMzJITVgMZahQO52sB5hLfvPPBFNC7BwvZuI2q7UB/QgfX8Wo3Dw9mti
         uNAQ==
X-Gm-Message-State: AGi0Pubh7IRtnDs3dJYAoSySNuoYxHr4WEid3qz+KB/HwDbAJvvL2Vel
        9XkCizDvJAsgJNAnkGKmlzC2iKACXmiKZA==
X-Google-Smtp-Source: APiQypKGo21usv+r+RSAulbzUM6zBXWr78hmsLPYbUwiyIoIbcg45yG57O7MJ//V4xvZCqSUvL0pXA7osc0+UQ==
X-Received: by 2002:a0c:f2d3:: with SMTP id c19mr7486154qvm.109.1589034063386;
 Sat, 09 May 2020 07:21:03 -0700 (PDT)
Date:   Sat,  9 May 2020 07:19:46 -0700
Message-Id: <20200509141946.158892-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] mm: fix LRU balancing effect of new transparent huge pages
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Currently, THP are counted as single pages until they are split right
before being swapped out. However, at that point the VM is already in
the middle of reclaim, and adjusting the LRU balance then is useless.

Always account THP by the number of basepages, and remove the fixup
from the splitting path.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Revived the patch from https://lore.kernel.org/patchwork/patch/685703/

 mm/swap.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4eb179ee0b72..b75c0ce90418 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -262,14 +262,14 @@ void rotate_reclaimable_page(struct page *page)
 	}
 }
 
-static void update_page_reclaim_stat(struct lruvec *lruvec,
-				     int file, int rotated)
+static void update_page_reclaim_stat(struct lruvec *lruvec, int file,
+				     int rotated, int nr_pages)
 {
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 
-	reclaim_stat->recent_scanned[file]++;
+	reclaim_stat->recent_scanned[file] += nr_pages;
 	if (rotated)
-		reclaim_stat->recent_rotated[file]++;
+		reclaim_stat->recent_rotated[file] += nr_pages;
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
@@ -288,7 +288,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
-		update_page_reclaim_stat(lruvec, file, 1);
+		update_page_reclaim_stat(lruvec, file, 1, nr_pages);
 	}
 }
 
@@ -546,7 +546,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 	}
-	update_page_reclaim_stat(lruvec, file, 0);
+	update_page_reclaim_stat(lruvec, file, 0, nr_pages);
 }
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
@@ -564,7 +564,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
-		update_page_reclaim_stat(lruvec, file, 0);
+		update_page_reclaim_stat(lruvec, file, 0, nr_pages);
 	}
 }
 
@@ -590,7 +590,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGLAZYFREE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
-		update_page_reclaim_stat(lruvec, 1, 0);
+		update_page_reclaim_stat(lruvec, 1, 0, nr_pages);
 	}
 }
 
@@ -899,8 +899,6 @@ EXPORT_SYMBOL(__pagevec_release);
 void lru_add_page_tail(struct page *page, struct page *page_tail,
 		       struct lruvec *lruvec, struct list_head *list)
 {
-	const int file = 0;
-
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
@@ -926,9 +924,6 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 		add_page_to_lru_list_tail(page_tail, lruvec,
 					  page_lru(page_tail));
 	}
-
-	if (!PageUnevictable(page))
-		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -973,7 +968,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	if (page_evictable(page)) {
 		lru = page_lru(page);
 		update_page_reclaim_stat(lruvec, page_is_file_lru(page),
-					 PageActive(page));
+					 PageActive(page), nr_pages);
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-- 
2.26.2.645.ge9eca65c58-goog

