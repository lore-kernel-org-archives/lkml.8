Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47205C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271CD20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrll2XWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgE0Ss0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgE0Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A328C08C5C8
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:30:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o89so3147489pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Itmi6eqCHr9uvU0alfk4nQ2taw2pdtsFaFOl7Jh0s5M=;
        b=nrll2XWCUSepzWcwbG/FSimgFfkZXbJjwr/+w59jtgR+KjTU6RL0pZMHypgM3IFE3S
         Zr6/UzLotOHtYDU4au41TaQbpzUuZ6GI9aDCobu5dk8GNHBlFWbS3wy5BhmxT3K5bR46
         XHOJvLYl1uj1tT2fJLk6FBoDZ9rDFJ+CGctQdK6bnb/Nb+MeoWPElNifRCBb4bVZd4Gp
         S+JjXN8vUYJVydYSA7PfYqT1qzS+T/h3fgnINQ1guyfQYIKFBJAXGmaae/qKLlYtA3lf
         1xQUw/plmnLxrXjyUr7XsiTXKilrlgdPbVkXXB0YE97gOZ62fMRviivn0lHRvVSOYdDA
         Gfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Itmi6eqCHr9uvU0alfk4nQ2taw2pdtsFaFOl7Jh0s5M=;
        b=cFtLANkpxYN4iQk6sLJcx6aspqrFB0L/2Mg6O92ygeXl1USU2VI3bf8V0vDURbCGPA
         gtLYHdwvtlZAwO9khLPrjGFQz7toBEO0yw4x7CuoIPkmVNANfyv82PtXvaNmHTKEV4mf
         L6M6lIK+dCw2imbl3PptkqTHNMU2NSmS/usq0GZzI4KBShxq7pHfB3fSnswm05uPG5AS
         f0p471KVoi3DfUVLWpRvhKkBplJK44vlnnBXNwT3vLq4caUIRlJ0Y9FKNV7h2DNCdlVW
         g0XMZ1lhYQAdRLKVPMwueQWt0YQHlBhKJpljBbR4QbuEsmv/P5CWVV0af9AU5JWSs1Ph
         J11w==
X-Gm-Message-State: AOAM530tZVkYA+jKUAUNd1y9z29wbFtS1KDanbDS3K2riQGHx5ftZLdq
        0c4VCEoJ9HAoAp+jbHAYM35LcPzWpmSkxg==
X-Google-Smtp-Source: ABdhPJxb+dE1b5FLu4Xh6+Iw2WjBon3ufZnDa8XSrtrtTj40i1Ffv9vDQWSpMlZ6r/OoQ6KSzNTGI9WU1PZXgQ==
X-Received: by 2002:a65:66d5:: with SMTP id c21mr5132870pgw.155.1590604202631;
 Wed, 27 May 2020 11:30:02 -0700 (PDT)
Date:   Wed, 27 May 2020 11:29:58 -0700
Message-Id: <20200527182958.252402-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH resend 3/3] mm: fix LRU balancing effect of new transparent
 huge pages
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
2.27.0.rc0.183.gde8f92d652-goog

