Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2956BC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6A224679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OCHYlLdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAOR3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:29:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44462 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAOR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:29:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so16366042qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALGtJRIfs6JPuh7XQxbp07M5KedAZgbWwahNq6bx2Aw=;
        b=OCHYlLdXBSz+MTgV0/aodXdMuuIA6WvbsMHuI2qdqv0pe/kCZb1arw8Ub57pZPU+PU
         CIsfywS5LFuVThHkzrM8D04JKBxu5GSoxxC27OfQBfLCAVzYU9nP27RYeqBR3W6RGNsU
         8Q0j2JeaB9wxS4axj9Ligrcol02rvlztrukWEZ/0KK6bVHTEnHfZ6O+b1+62Xm143pBo
         lnCnzOBa8wT6Rxy0e8VviYzalmV07bv+PpxZPdjH+nNqVHmZ3vjs8xxGKxBck2sAEX81
         DKkdIWCKmoOyRASJrgz8QH9iQxQXSuU1UtuDS89teNsNJozzihXfXrTFYtQLtXqeeDud
         GeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALGtJRIfs6JPuh7XQxbp07M5KedAZgbWwahNq6bx2Aw=;
        b=lo5u5dIDxzcBu9y/+U7x5XWnbyQGR9bY3jnh/iVyPmpcKeYvRkltUDJTplZIHx5EEI
         nwhAnhfD8WNfcWFFl0EiRkg/7oPcNc5c/5sDkjxiQ2HFG1lRLjkKGk5jnUhl4TL6enQF
         GoI4EmU/XBB4JMULxjN2wPTy88q9fqg+TKjX2mOF/UxND2KiEFXlu0j/Dq/7s5Lb1PF1
         SSt13yYzAQO1MkturAg/WsGX0ApgxkdWJmXyzj3Wyp4g21BcAjQ8PTGdSrLuzXIAE67O
         A/IT/1/TWgEkVVyGZnxb0xmosK7BG4CuE2D84gfJH0iRINhUAdrL1byynbDgO6wa9WHO
         GuXA==
X-Gm-Message-State: APjAAAXQwd2i+Pfj0ULtW9gw/PsYnDT6xGGw+EXj4f4iCu5+uUlPNQ0U
        f0VJRyyZUyhCMPqLti5EaPTfEg==
X-Google-Smtp-Source: APXvYqwf3aG2GyIDGkHdz2kicACxuHDNJAJ2YO/EK75Z6xRYK4GiPSRlAWTHyqslu0RSTWp2TGRFIA==
X-Received: by 2002:a05:620a:164e:: with SMTP id c14mr27248366qko.19.1579109363458;
        Wed, 15 Jan 2020 09:29:23 -0800 (PST)
Received: from ovpn-120-31.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z6sm8523147qkz.101.2020.01.15.09.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:29:22 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v3] mm/hotplug: silence a lockdep splat with printk()
Date:   Wed, 15 Jan 2020 12:29:16 -0500
Message-Id: <20200115172916.16277-1-cai@lca.pw>
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
well. A few sample lockdep splats can be founnd here [2].

[1] https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/
[2] https://lore.kernel.org/lkml/7CD27FC6-CFFF-4519-A57D-85179E9815FE@lca.pw/

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Rebase to next-20200115 for the mm/debug change and update some
    comments thanks to Michal.

v2: Improve the commit log and report CMA in dump_page() per Andrew.
    has_unmovable_pages() returns a "struct page *" to the caller.

 include/linux/page-isolation.h |  4 ++--
 mm/debug.c                     |  4 +++-
 mm/memory_hotplug.c            |  6 ++++--
 mm/page_alloc.c                | 22 +++++++++-------------
 mm/page_isolation.c            | 11 ++++++++++-
 5 files changed, 28 insertions(+), 19 deletions(-)

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
index 6a52316af839..784f9da711b0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -46,6 +46,7 @@ void __dump_page(struct page *page, const char *reason)
 {
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
+	bool page_cma = is_migrate_cma_page(page);
 	int mapcount;
 	char *type = "";
 
@@ -92,7 +93,8 @@ void __dump_page(struct page *page, const char *reason)
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
+	pr_warn("%sflags: %#lx(%pGp)%s", type, page->flags, &page->flags,
+		page_cma ? " CMA\n" : "\n");
 
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
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
index e56cd1f33242..e90140e879e6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8202,13 +8202,16 @@ void *__init alloc_large_system_hash(const char *tablename,
  * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
  * check without lock_page also may miss some movable non-lru pages at
  * race condition. So you can't expect this function should be exact.
+ *
+ * It returns a page without holding a reference. It should be safe here
+ * because the page cannot go away because it is unmovable, but it must not to
+ * be used for anything else rather than dumping its state.
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
@@ -8225,9 +8228,8 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
 		 * so consider them movable here.
 		 */
 		if (is_migrate_cma(migratetype))
-			return false;
+			return NULL;
 
-		reason = "CMA page";
 		goto unmovable;
 	}
 
@@ -8302,12 +8304,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
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
@@ -8711,10 +8711,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
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
index 1f8b9dfecbe8..f3af65bac1e0 100644
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
 
@@ -54,6 +56,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret)
 		drain_all_pages(zone);
+	else if (isol_flags & REPORT_FAILURE && unmovable)
+		/*
+		 * printk() with zone->lock held will guarantee to trigger a
+		 * lockdep splat, so defer it here.
+		 */
+		dump_page(unmovable, "unmovable page");
+
 	return ret;
 }
 
-- 
2.21.0 (Apple Git-122.2)

