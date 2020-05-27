Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218FDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE34C2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRqm/ceE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgE0Sr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgE0Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C1EC08C5C7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:29:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k21so20047198pgn.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vLBHFyxDYq9Ns3YulLEQdnA3nE4XR0yQruh+9zYely8=;
        b=aRqm/ceEdrK7ztLIHW5n2QXxSGd4P1cmo1H98UyLtYRlbW83fAof/5IEwY56a8PCTU
         R97ROWa1whjZvyH+/ANH6vmk/8PQpO25d6JvFZ40KMzybbs682m+Bfmc95DCGsZSAKmr
         7SRHmwg6G/GB5pojDtQV3GBj/N/wcsJQGDclK/AomZRsNdxgKU4qi5TfKXa4Rf5jGEZP
         vNjDriTMZFsASZic59rUUDjVTyPjyDZb7OR4aF9SoN0Snmzl1rpz8RA0sbDIyR/7H8Wk
         IZiMRrOKF/oSmeoPZJKY34xuM3kUb1oFMbF6VnU6ltRvM2p3BxqsUOEuapMZSav/7AK6
         eDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vLBHFyxDYq9Ns3YulLEQdnA3nE4XR0yQruh+9zYely8=;
        b=JYTru6Zhq5fKyLQBkJehujtYcAu5jO86kgIRDEkG3iG2DELipywN9Knc18+m12pIqk
         /5T7AAaKONQAz8Cx6Lh2MHzVfLSS+RQwBwMQVbAcFbVlBnDApmIGMC3cAqOfvlm3gDHl
         myN2h/icDUr1dqMlCoPx2h5mrcBl/HyMV+d4IsE7I8FEDzEec/Nr01BiDlWU+TdyP3U9
         FbbAraSYtbvmhdE7DFCYp6LzewBY+ve0yWp6xRhUvgt8oM7Ouh9L1k2uaWSnr++hG+2q
         NOOd6OOdjs3Ufzbizk4+7EvB0HUm7UZ6uJhqn/taIa0ggtczOPkB/mZe3yjAINvwZ6Cx
         iehg==
X-Gm-Message-State: AOAM532pLh59a5/Fgcns1jgUBYk4iAft226Gdeg/QdCQlim6qHqWC72V
        Hro8VnLKrXDNhodhoFb6dpsIm4nKgJZXPw==
X-Google-Smtp-Source: ABdhPJx9poQ4/3XGCJwa1gTm9TpLPhbUmHfAU2RkxLT2xzzGwLxdBq04/4zyrOtLRfIJPx6PaayXwULP0topdg==
X-Received: by 2002:a17:90a:6546:: with SMTP id f6mr6349345pjs.55.1590604192056;
 Wed, 27 May 2020 11:29:52 -0700 (PDT)
Date:   Wed, 27 May 2020 11:29:47 -0700
Message-Id: <20200527182947.251343-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH resend 2/3] mm: swap: memcg: fix memcg stats for huge pages
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

The commit 2262185c5b28 ("mm: per-cgroup memory reclaim stats") added
PGLAZYFREE, PGACTIVATE & PGDEACTIVATE stats for cgroups but missed
couple of places and PGLAZYFREE missed huge page handling. Fix that.
Also for PGLAZYFREE use the irq-unsafe function to update as the irq is
already disabled.

Fixes: 2262185c5b28 ("mm: per-cgroup memory reclaim stats")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3dbef6517cac..4eb179ee0b72 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -278,6 +278,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_lru(page);
 		int lru = page_lru_base_type(page);
+		int nr_pages = hpage_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec, lru);
 		SetPageActive(page);
@@ -285,7 +286,8 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 		trace_mm_lru_activate(page);
 
-		__count_vm_events(PGACTIVATE, hpage_nr_pages(page));
+		__count_vm_events(PGACTIVATE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 		update_page_reclaim_stat(lruvec, file, 1);
 	}
 }
@@ -540,8 +542,10 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		__count_vm_events(PGROTATED, nr_pages);
 	}
 
-	if (active)
+	if (active) {
 		__count_vm_events(PGDEACTIVATE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
+	}
 	update_page_reclaim_stat(lruvec, file, 0);
 }
 
@@ -551,13 +555,15 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_lru(page);
 		int lru = page_lru_base_type(page);
+		int nr_pages = hpage_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		add_page_to_lru_list(page, lruvec, lru);
 
-		__count_vm_events(PGDEACTIVATE, hpage_nr_pages(page));
+		__count_vm_events(PGDEACTIVATE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 		update_page_reclaim_stat(lruvec, file, 0);
 	}
 }
@@ -568,6 +574,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		bool active = PageActive(page);
+		int nr_pages = hpage_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec,
 				       LRU_INACTIVE_ANON + active);
@@ -581,8 +588,8 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 		ClearPageSwapBacked(page);
 		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
 
-		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
-		count_memcg_page_event(page, PGLAZYFREE);
+		__count_vm_events(PGLAZYFREE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
 		update_page_reclaim_stat(lruvec, 1, 0);
 	}
 }
-- 
2.27.0.rc0.183.gde8f92d652-goog

