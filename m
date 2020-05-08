Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53487217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljlb+5Jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEHVWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgEHVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:22:37 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13732C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:22:37 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b13so3051346pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WB4fh0ll1orLfT6cXNAXpIF6IJgnNIJAflmvuUUH6tI=;
        b=ljlb+5JoPOLhwCwo/9ooaMm5dNWWqB4RKavWnR1bMTb4L6DZlaJkSQfWkg3sAAEQ0X
         UMnUuP9OvKrvFO2Zf1tnvuK0HExsQ2dYx49Deh2BpHI0OnP5ZatGHYAs8ZTI/yxrils3
         xzpe4ILlD48aErissngz/JZQjPXUgLkKPbNMlhHbgVIt6JvI2Qqhq9LILj81H24qLUpd
         2GqNHMP6geeEqMap9slI4hgNGU5PWE9SdVjpN1ZygLe6+JYzxYDnJcgw76g8ZJaiwYbx
         XGaBJ2xHrlPcPEipfB3nycm7Y2ZiWhkuNvSYmpS4fjdgG5Kmdhl2nIvXnPOUcLCgKgr5
         47gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WB4fh0ll1orLfT6cXNAXpIF6IJgnNIJAflmvuUUH6tI=;
        b=Yd7Ddnolv66K/NwMbqQ5bB9ezxYGMPJ/XrCEfHjcuFzot1DaSFruBpX7U3edrg+l+Y
         nSWUWm4ZC0UwpmGHcotIr2j8EahRtMy9ySoMCZWv0svKm0zZTT2Li2w/7TnPxgghkXL4
         LxUCFgAV+lUdZmD57pAtgsxd1MBiNWrirns624mk7tT2pJUmm1yotugN6OzjzIwDRXw9
         8ngMBJ8eLi9bkKNZPeyJ148PpQcgOGR2YPQ2Ii1WnjjsaLJ0OX2gi/y/DnDvolyg002N
         w/jVmMN42tB+2OWO+AiPDJl3BdtMvWqDr0Zy/y029i32PZBIeYx89GSZfFToWNqWCbyl
         XJHw==
X-Gm-Message-State: AGi0Puai5Ln6FqCPaFaOg9As8BdVJxPtBF4DTv2NUjN5nC6AxX6tbpUi
        VaQwwBDSD19tAcZ5GQlOuR9cyKMKNDMZZg==
X-Google-Smtp-Source: APiQypLOtqKOw6qGIFJrdKSoiXSUY0c+iu42+pRBK9bHu2cCiYtB9/Zi/7+9qgttPV+xyxHeaRmrB0aXGe1j9A==
X-Received: by 2002:a17:90a:6f22:: with SMTP id d31mr7728053pjk.14.1588972956538;
 Fri, 08 May 2020 14:22:36 -0700 (PDT)
Date:   Fri,  8 May 2020 14:22:14 -0700
In-Reply-To: <20200508212215.181307-1-shakeelb@google.com>
Message-Id: <20200508212215.181307-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20200508212215.181307-1-shakeelb@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 2/3] mm: swap: memcg: fix memcg stats for huge pages
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
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
2.26.2.645.ge9eca65c58-goog

