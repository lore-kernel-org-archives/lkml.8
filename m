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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE7C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9B520A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/d3gs9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEHVWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgEHVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:22:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51FC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:22:44 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b13so3051651pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+lPomwo6gVp+8sIw/I2u7q5nAUGKdenRSc6ButB2wWA=;
        b=Y/d3gs9c8fLWvNo8cv/JRlC7Gdv90wnQcNRlqk6pT0nZP3sUowsrJKLy1ajL1gCIKP
         BNUeVyKZcJBZjS+0eDdZFhjTK3KefN3ABh56eoNStvjd714RuGjuUnA3L4xeJIFNUkAY
         bO0mV9zYI5WmPppNa8u/mIKGLHCWC/TjhPqGsKKMVtsXjIEUy6r5sxDfnrG5LunrIWzK
         c4P45AcNlm8NzX8yWiwIltielavQyQsD9QYT1cC7LRok37X0rUT9i2vJ4vjVhIsWoAUZ
         ZCn8t+LqSaHTPehqaJHQ7MaZ0Cg0xB93YKJMmUk8rRApPNqqK1qZub7KUWVS80QT7IRV
         OJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lPomwo6gVp+8sIw/I2u7q5nAUGKdenRSc6ButB2wWA=;
        b=V2MaIWYZbizDUO32Jl8nU40DtBxdvL8fDnBlV4OdQ9MTyRqNKGf9qHffNlqAGGH7fk
         ftzw/JcYGlgYP7M6LZQIxM/9GNKfUitBIKAO+p53b93Esh7/zrzm27jrF6yWC3zKV5M2
         iSO6LsZILyOeOS376gaKFpjnoCu9XZuTd8I5guBC7J9I+Jy4u6XJKYzFndIVkJ9c0sIv
         KxJWo00WHcQiBbGbaVIuggJFfjCWI62/ntDW6AUOGyEQMUggLArZZk7XYTSK6bjnvWYh
         W5snwIz7j5XG+PnhTkmlWJud34ZyzQhD4QukRsfRlknT9U9OrjoepotI7vtGoGdt6v+I
         LLKg==
X-Gm-Message-State: AGi0PuY+BMttu+9XceWpP2Ez9EfBfem8BuKl1mEcuQAtW33NbgjQM+kv
        VpeTVFPDmcYqHwuYURsMtEJoIsxhtVHubw==
X-Google-Smtp-Source: APiQypJmqSHJBTT//7e2TqA5OSPQcmtaFbDDtkXqZeIJ65UCsh6cE8u40zY5RJjMUR0eep6ydcbTdiWgYEkrMw==
X-Received: by 2002:a63:f14b:: with SMTP id o11mr3831209pgk.429.1588972963716;
 Fri, 08 May 2020 14:22:43 -0700 (PDT)
Date:   Fri,  8 May 2020 14:22:15 -0700
In-Reply-To: <20200508212215.181307-1-shakeelb@google.com>
Message-Id: <20200508212215.181307-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20200508212215.181307-1-shakeelb@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 3/3] mm: swap: fix update_page_reclaim_stat for huge pages
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

Currently update_page_reclaim_stat() updates the lruvec.reclaim_stats
just once for a page irrespective if a page is huge or not. Fix that by
passing the hpage_nr_pages(page) to it.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/swap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4eb179ee0b72..dc7297cb76a0 100644
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
 
@@ -928,7 +928,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	}
 
 	if (!PageUnevictable(page))
-		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
+		update_page_reclaim_stat(lruvec, file, PageActive(page_tail), 1);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -973,7 +973,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
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

