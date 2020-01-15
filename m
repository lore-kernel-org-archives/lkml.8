Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB910C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E6124671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AjQ/j0aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgAOFbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:31:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39255 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOFbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:31:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so14761860qtm.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 21:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N/Grf0h86aCdnpP8US/jQXa2nTyUfKvifn9VZTSxVM=;
        b=AjQ/j0aPkIhUSI07x8Y2CsVa4wUUsi3jIhS6hf+4v3Zeh4TMtA2eyYM6nLGxXh11gM
         ynzityt/yH96Vc4eeaqu73sJxvleM8gLM6vNvdP75cOC7Bq2LTSgOQwqVKDvqPzNLemk
         lzRcQYuNEHZZDwnrw4yiwRSuM3U2yLfg+zCRODODwejG6RCLwsiHNbW9P558lnH0d53C
         K23fTpCUXJrMCCBpEdHXeLHJWKMxMikKg/V14ihQ9IIUpnygsiG/osh93TcV1Qi/JsDg
         FT0D6hqHpvJAWJxwyscjL/lVGtBurj74OX2jbuaIU1fvSLPj+WcKsi4D+v5XQubr6trL
         VYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N/Grf0h86aCdnpP8US/jQXa2nTyUfKvifn9VZTSxVM=;
        b=AqpEyUR5KqBy02gvSnkxMhHFCqii2DMDp2tnZyePtLS5CvNr9Y63rz0SFS9ybup/LR
         84EcDsIEACmV3B/kZFinaap3vX0aqWwVx9ri0KLX/n9kS2Fa3wqlD1RkQOdBJ+xjJRau
         7J3e/QMRMFFfh33UsvIULzT2dJ/GGMZYTWQhkCiGOecgd4+zOJ6kW0i0ojUfoCzDzf4X
         A4FQvZH32H6XB1GetyvWSg9gWGsTzfta7y6ZQMa8tihqZ63LA5aVS0nwJw0ZMlni6Tc7
         94LWQOPLQR35B63hxfK8+YhDKMkItjHVxjWz0ev6Cu+8ZoVjWWmGb7GMXC+9WS9/sFMX
         A5LA==
X-Gm-Message-State: APjAAAWh+NchF8SETupECJY6ZjSV98i8+OfPVuJgDJPZO3I6nanfdBnb
        A3H37E3D861XaWfBqboiFHU1JQ==
X-Google-Smtp-Source: APXvYqwM5841GH8tvssxIK4kb2L2mjuNzPEOHdbsJHC4+oTTcRaP2r4oZr9r5fZQh6x38AbogUIKrQ==
X-Received: by 2002:ac8:5395:: with SMTP id x21mr2015457qtp.64.1579066300750;
        Tue, 14 Jan 2020 21:31:40 -0800 (PST)
Received: from ovpn-120-31.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e64sm8623448qtd.45.2020.01.14.21.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 21:31:39 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/hotplug: silence a lockdep splat with printk()
Date:   Wed, 15 Jan 2020 00:31:30 -0500
Message-Id: <20200115053130.15490-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is guaranteed to trigger a lockdep splat if calling printk() with
zone->lock held because there are many places (tty, console drivers,
debugobjects etc) would allocate some memory with another lock
held which is proved to be difficult to fix them all.

A common workaround until the onging effort to make all printk() as
deferred happens is to use printk_deferred() in those places similar to
the recent commit [1] merged into the random and -next trees, but memory
offline will call dump_page() which needs to be deferred after the lock.

So change has_unmovable_pages() so that it no longer calls dump_page()
itself - instead it returns a "struct page *" of the unmovable page back
to the caller so that in the case of a has_unmovable_pages() failure,
the caller can call dump_page() after releasing zone->lock. Also, make
dump_page() is able to report a CMA page as well, so the reason string
from has_unmovable_pages() can be removed.

While at it, remove a similar but unnecessary debug-only printk() as
well.

[1] https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Improve the commit log and report CMA in dump_page() per Andrew.
    has_unmovable_pages() returns a "struct page *" to the caller.

 include/linux/page-isolation.h |  4 ++--
 mm/debug.c                     |  5 +++--
 mm/memory_hotplug.c            |  6 ++++--
 mm/page_alloc.c                | 18 +++++-------------
 mm/page_isolation.c            |  7 ++++++-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 148e65a9c606..da043ae86488 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,8 +33,8 @@ static inline bool is_migrate_isolate(int migratetype)
 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
 
-bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
-			 int flags);
+struct page *has_unmovable_pages(struct zone *zone, struct page *page, int
+				 migratetype, int flags);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
diff --git a/mm/debug.c b/mm/debug.c
index 0461df1207cb..2165a4c83b97 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -46,6 +46,7 @@ void __dump_page(struct page *page, const char *reason)
 {
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
+	bool page_cma = is_migrate_cma_page(page);
 	int mapcount;
 
 	/*
@@ -74,9 +75,9 @@ void __dump_page(struct page *page, const char *reason)
 			page->mapping, page_to_pgoff(page),
 			compound_mapcount(page));
 	else
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx cma:%d\n",
 			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page));
+			page->mapping, page_to_pgoff(page), page_cma);
 	if (PageKsm(page))
 		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	else if (PageAnon(page))
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a6de9b0dcab..06e7dd3eb9a9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1148,8 +1148,10 @@ static bool is_pageblock_removable_nolock(unsigned long pfn)
 	if (!zone_spans_pfn(zone, pfn))
 		return false;
 
-	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
-				    MEMORY_OFFLINE);
+	if (has_unmovable_pages(zone, page, MIGRATE_MOVABLE, MEMORY_OFFLINE))
+		return false;
+
+	return true;
 }
 
 /* Checks if this range of memory is likely to be hot-removable. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e56cd1f33242..728e36f24aea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8203,12 +8203,11 @@ void *__init alloc_large_system_hash(const char *tablename,
  * check without lock_page also may miss some movable non-lru pages at
  * race condition. So you can't expect this function should be exact.
  */
-bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
-			 int flags)
+struct page *has_unmovable_pages(struct zone *zone, struct page *page,
+				 int migratetype, int flags)
 {
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
-	const char *reason = "unmovable page";
 
 	/*
 	 * TODO we could make this much more efficient by not checking every
@@ -8225,9 +8224,8 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
 		 * so consider them movable here.
 		 */
 		if (is_migrate_cma(migratetype))
-			return false;
+			return NULL;
 
-		reason = "CMA page";
 		goto unmovable;
 	}
 
@@ -8302,12 +8300,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
 		 */
 		goto unmovable;
 	}
-	return false;
+	return NULL;
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	if (flags & REPORT_FAILURE)
-		dump_page(pfn_to_page(pfn + iter), reason);
-	return true;
+	return pfn_to_page(pfn + iter);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
@@ -8711,10 +8707,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(!PageBuddy(page));
 		order = page_order(page);
 		offlined_pages += 1 << order;
-#ifdef CONFIG_DEBUG_VM
-		pr_info("remove from free list %lx %d %lx\n",
-			pfn, 1 << order, end_pfn);
-#endif
 		del_page_from_free_area(page, &zone->free_area[order]);
 		pfn += (1 << order);
 	}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 1f8b9dfecbe8..a2b730ea3732 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -20,6 +20,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	struct zone *zone;
 	unsigned long flags;
 	int ret = -EBUSY;
+	struct page *unmovable = NULL;
 
 	zone = page_zone(page);
 
@@ -37,7 +38,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, migratetype, isol_flags)) {
+	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
+	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt = get_pageblock_migratetype(page);
 
@@ -54,6 +56,9 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret)
 		drain_all_pages(zone);
+	else if (isol_flags & REPORT_FAILURE && unmovable)
+		dump_page(unmovable, "unmovable page");
+
 	return ret;
 }
 
-- 
2.21.0 (Apple Git-122.2)

