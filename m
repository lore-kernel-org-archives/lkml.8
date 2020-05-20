Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49533C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A5820759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ymMBqLQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgETX0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgETX0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD1C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o19so4059556qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9J/IQYd83mBxHLfy76lcnUtA4w8aOTMdLMgX2FLlLsQ=;
        b=ymMBqLQfEQW5KElYK7T4y/9ipWW33G9fMTVFLQGdE7/dQ8tAS9eUEHZ/dTtUN6QDxg
         Xy9tb3mMkcwSjTcxUTcF3DQJPt9WBlDHTk3QCb5zDYFV7SwSmr/Lp0/PoZf1hKtsyJ2I
         ZGsf7aOSH3VLyE6UVGBamMKPAm6XDF6HrmBBo/Sd9rB8CPomBmOLF2l0bqpSD4sdsV/Q
         JO1Y1kPqtWMRqhTCybPxStIDqi/CI/wi76l4izuGceQaxVUaG+6CEvGJGmxWyBjxNfeP
         USe2YSk+QvKaRB6PTHVaxDgXXENs4cwOTcwfIgDxfvV57Gbnl3MXK7YKxwrHsxMHoy2X
         Lfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9J/IQYd83mBxHLfy76lcnUtA4w8aOTMdLMgX2FLlLsQ=;
        b=MWZpWSXV3AfusXuCTxQHl/oS5u15JfFAqW/wipMhA9SNLRMkD98pHFu4mFYw3ge4iV
         1Fap9xNr5Mb1rbsKfyZWw/gWaA6FmJInXsiSu7dq5FeC1EUyrSz1QFg0y06irvcLHezn
         F9q70I5NwIDgEr5aKY0U00dc7+N7at6nxvKVYuZndgXblsbeLUAimIBilrPhRfAigAUn
         q0AM8ptqiAzXydToA1UmEayBB9dRSiIRkGxsQ5eMfGehEI7TNTt/srHAq4IhGV3+VwCK
         jplJ+7FMxf/QyJf0gbmMtVir/fOVPvtW5+2VhJHzYH0uKTvf1PgR1SMQnI+2VW2YMPC6
         iyBg==
X-Gm-Message-State: AOAM532msNoRRZhq9oLvDnuH2a8LvlMb+U4QyHepSiBQ9IsFNXy5lfTr
        vqs9SSYCMZVkusW1QQtOUcD3bxkniEA=
X-Google-Smtp-Source: ABdhPJzlcL09DR8Lj5VQfEi4dP0R0lZJ4ur4CgxgQLf8R+pIa0MbEqXFCRCw4JOTlBkaqQwSSR9Wlg==
X-Received: by 2002:ac8:37e6:: with SMTP id e35mr7733071qtc.310.1590017180044;
        Wed, 20 May 2020 16:26:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id w21sm3863134qtj.78.2020.05.20.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:19 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/14] mm: vmscan: reclaim writepage is IO cost
Date:   Wed, 20 May 2020 19:25:24 -0400
Message-Id: <20200520232525.798933-14-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM tries to balance reclaim pressure between anon and file so as
to reduce the amount of IO incurred due to the memory shortage. It
already counts refaults and swapins, but in addition it should also
count writepage calls during reclaim.

For swap, this is obvious: it's IO that wouldn't have occurred if the
anonymous memory hadn't been under memory pressure. From a relative
balancing point of view this makes sense as well: even if anon is cold
and reclaimable, a cache that isn't thrashing may have equally cold
pages that don't require IO to reclaim.

For file writeback, it's trickier: some of the reclaim writepage IO
would have likely occurred anyway due to dirty expiration. But not all
of it - premature writeback reduces batching and generates additional
writes. Since the flushers are already woken up by the time the VM
starts writing cache pages one by one, let's assume that we'e likely
causing writes that wouldn't have happened without memory pressure. In
addition, the per-page cost of IO would have probably been much
cheaper if written in larger batches from the flusher thread rather
than the single-page-writes from kswapd.

For our purposes - getting the trend right to accelerate convergence
on a stable state that doesn't require paging at all - this is
sufficiently accurate. If we later wanted to optimize for sustained
thrashing, we can still refine the measurements.

Count all writepage calls from kswapd as IO cost toward the LRU that
the page belongs to.

Why do this dynamically? Don't we know in advance that anon pages
require IO to reclaim, and so could build in a static bias?

First, scanning is not the same as reclaiming. If all the anon pages
are referenced, we may not swap for a while just because we're
scanning the anon list. During this time, however, it's important that
we age anonymous memory and the page cache at the same rate so that
their hot-cold gradients are comparable. Everything else being equal,
we still want to reclaim the coldest memory overall.

Second, we keep copies in swap unless the page changes. If there is
swap-backed data that's mostly read (tmpfs file) and has been swapped
out before, we can reclaim it without incurring additional IO.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h   |  4 +++-
 include/linux/vmstat.h |  1 +
 mm/swap.c              | 16 ++++++++++------
 mm/swap_state.c        |  2 +-
 mm/vmscan.c            |  3 +++
 mm/workingset.c        |  2 +-
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 818a94b41d82..157e5081bf98 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -333,7 +333,9 @@ extern unsigned long nr_free_pagecache_pages(void);
 
 
 /* linux/mm/swap.c */
-extern void lru_note_cost(struct page *);
+extern void lru_note_cost(struct lruvec *lruvec, bool file,
+			  unsigned int nr_pages);
+extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 10cc932e209a..3d12c34cd42a 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -26,6 +26,7 @@ struct reclaim_stat {
 	unsigned nr_congested;
 	unsigned nr_writeback;
 	unsigned nr_immediate;
+	unsigned nr_pageout;
 	unsigned nr_activate[2];
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
diff --git a/mm/swap.c b/mm/swap.c
index 3d8aa46c47ff..ffc457911be2 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -262,18 +262,16 @@ void rotate_reclaimable_page(struct page *page)
 	}
 }
 
-void lru_note_cost(struct page *page)
+void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 {
-	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-
 	do {
 		unsigned long lrusize;
 
 		/* Record cost event */
-		if (page_is_file_lru(page))
-			lruvec->file_cost++;
+		if (file)
+			lruvec->file_cost += nr_pages;
 		else
-			lruvec->anon_cost++;
+			lruvec->anon_cost += nr_pages;
 
 		/*
 		 * Decay previous events
@@ -295,6 +293,12 @@ void lru_note_cost(struct page *page)
 	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
+void lru_note_cost_page(struct page *page)
+{
+	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
+		      page_is_file_lru(page), hpage_nr_pages(page));
+}
+
 static void __activate_page(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8b902897a867..1e744e6c9c20 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -432,7 +432,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	/* XXX: Move to lru_cache_add() when it supports new vs putback */
 	spin_lock_irq(&page_pgdat(page)->lru_lock);
-	lru_note_cost(page);
+	lru_note_cost_page(page);
 	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 
 	/* Initiate read into locked page */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1487ff5d4698..5453b4ef2ea1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1359,6 +1359,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			case PAGE_ACTIVATE:
 				goto activate_locked;
 			case PAGE_SUCCESS:
+				stat->nr_pageout += hpage_nr_pages(page);
+
 				if (PageWriteback(page))
 					goto keep;
 				if (PageDirty(page))
@@ -1964,6 +1966,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	lru_note_cost(lruvec, file, stat.nr_pageout);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
diff --git a/mm/workingset.c b/mm/workingset.c
index a6a2a740ed0b..d481ea452eeb 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -367,7 +367,7 @@ void workingset_refault(struct page *page, void *shadow)
 		SetPageWorkingset(page);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
 		spin_lock_irq(&page_pgdat(page)->lru_lock);
-		lru_note_cost(page);
+		lru_note_cost_page(page);
 		spin_unlock_irq(&page_pgdat(page)->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
-- 
2.26.2

