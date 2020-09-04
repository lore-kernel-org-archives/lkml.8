Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35893C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B0B2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DJh1krJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgIDPPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbgIDPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:14:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1331C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:14:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u3so6575694qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Ax7bx8bGQgBf4enQQ+1dSxLeyQMe6jS9zSWW4q6utY=;
        b=DJh1krJ2Yk6Rnt67V78KVKnqi+1eEnz6nxzYBjVPlmoJNPjfglga67CAGD8foPoNcP
         DUN6UAYvOXud1X7dC+OAACIUO60+e0GIMXtX1EoWf8KBbXksIuRaWKDfbsfeML9+zkQQ
         UMhsekrqJZqGsYUalJGd3cDwGFpCVqbnTYej6GWGgf7G77U5dNDBuHt212oLfxN6952t
         4m6SfUV1JbFW8evros+nv7Gq+WhsQDMdQ1/nN6GIltGD/YeVgARi/5w/q16jWqXKwOSQ
         c/6MOdJbtKfOvbdqA1C8qiJZRJNvaDGJszysR7LyuLgKdJuo6xFzxz3gw5Xn9YkGoSPS
         yZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ax7bx8bGQgBf4enQQ+1dSxLeyQMe6jS9zSWW4q6utY=;
        b=kdD1wJLNNF1d9SlodXS+CxwRNN2n1pF/m3ZnnyhKzAK3NOxjLn4/Ckr/IHQHgET2fk
         EyBDewLEMOcpTEyaCXkjpuJjALQt/k1g3kgnpptz9v5kE564ANoiEUTnpx3K8NAd75lM
         QDUUaJ7dBLVADYFlaxTJKamE+dUfw68HbZJojPL+8mH0jH32wzTzoEAYaoAhR/5YWyG4
         d7rWGP9z5hGN3zl3h+kcGq2KrYkvLyi4vLqEESc66IJOYgSTqkfxhNaMoWugmftqbIp9
         wnlbtX3AC1w8jFtfLYOURymS6iNX53NdNxHc4L2aY+mLujrSp6oFyrQP2ZLJfVKTmoKV
         j5ww==
X-Gm-Message-State: AOAM530dinnI6HZijrGYJfRTweoAbhjXWf0TKIAo7vp0RWuJMGSxkViz
        lUiEsFc0YV9dxEdIFIPOaWEj95inLyM8Qw==
X-Google-Smtp-Source: ABdhPJyssxk1AMfs3g1XHj9xTwmyKkhKlBfUHsqyKTMI5WB3Vrx23rk1+SPiZoJMG1wZ1J735094kQ==
X-Received: by 2002:ae9:edc8:: with SMTP id c191mr7988285qkg.226.1599232493403;
        Fri, 04 Sep 2020 08:14:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r21sm4802727qtj.80.2020.09.04.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:14:52 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, pasha.tatashin@soleen.com,
        osalvador@suse.de, richard.weiyang@gmail.com, david@redhat.com,
        vbabka@suse.cz, rientjes@google.com
Subject: [PATCH v3 2/2] mm: drain per-cpu pages outside of isolate_migratepages_range
Date:   Fri,  4 Sep 2020 11:14:48 -0400
Message-Id: <20200904151448.100489-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904151448.100489-1-pasha.tatashin@soleen.com>
References: <20200904151448.100489-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expensive to drain per-cpu page lists as a thread is started on each
CPU, and we are waiting for them to complete.

Currently, we drain on every block of pages that is isolated. Instead lets
drain once after pages are isolated.

For example, when 2G of memory is hot-removed drain is called 16 times,
with this change it will be done only one time on average.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/memory_hotplug.c | 15 +--------------
 mm/page_alloc.c     |  2 ++
 mm/page_isolation.c | 40 ++++++++++++----------------------------
 3 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b11a269e2356..5a2ed1a94555 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1536,6 +1536,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	}
 
 	do {
+		drain_all_pages(zone);
 		pfn = start_pfn;
 		do {
 			if (signal_pending(current)) {
@@ -1575,20 +1576,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		/* check again */
 		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
 					    NULL, check_pages_isolated_cb);
-		/*
-		 * per-cpu pages are drained in start_isolate_page_range, but if
-		 * there are still pages that are not free, make sure that we
-		 * drain again, because when we isolated range we might
-		 * have raced with another thread that was adding pages to pcp
-		 * list.
-		 *
-		 * Forward progress should be still guaranteed because
-		 * pages on the pcp list can only belong to MOVABLE_ZONE
-		 * because has_unmovable_pages explicitly checks for
-		 * PageBuddy on freed pages on other zones.
-		 */
-		if (ret)
-			drain_all_pages(zone);
 	} while (ret);
 
 	/* Ok, all of our target is isolated.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..6d6a501a103e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8462,6 +8462,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	if (ret < 0)
 		return ret;
 
+	drain_all_pages(cc.zone);
+
 	/*
 	 * In case of -EBUSY, we'd like to know which page causes problem.
 	 * So, just fall through. test_pages_isolated() has a tracepoint
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 63a3db10a8c0..8dfa6c6c668d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -19,8 +19,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 {
 	struct page *unmovable = NULL;
 	struct zone *zone;
-	unsigned long flags;
-	int ret = -EBUSY;
+	unsigned long flags, nr_pages;
+	int ret = -EBUSY, mt;
 
 	zone = page_zone(page);
 
@@ -39,24 +39,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * We just check MOVABLE pages.
 	 */
 	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
-	if (!unmovable) {
-		unsigned long nr_pages;
-		int mt = get_pageblock_migratetype(page);
-
-		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
-		zone->nr_isolate_pageblock++;
-		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
-									NULL);
-
-		__mod_zone_freepage_state(zone, -nr_pages, mt);
-		ret = 0;
-	}
+	if (unmovable)
+		goto out;
 
+	mt = get_pageblock_migratetype(page);
+	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
+	zone->nr_isolate_pageblock++;
+	nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE, NULL);
+	__mod_zone_freepage_state(zone, -nr_pages, mt);
+	ret = 0;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret) {
-		drain_all_pages(zone);
-	} else {
+	if (ret) {
 		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
 
 		if ((isol_flags & REPORT_FAILURE) && unmovable)
@@ -170,14 +164,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pageblocks we may have modified and return -EBUSY to caller. This
  * prevents two threads from simultaneously working on overlapping ranges.
  *
- * Please note that there is no strong synchronization with the page allocator
- * either. Pages might be freed while their page blocks are marked ISOLATED.
- * In some cases pages might still end up on pcp lists and that would allow
- * for their allocation even when they are in fact isolated already. Depending
- * on how strong of a guarantee the caller needs drain_all_pages might be needed
- * (e.g. __offline_pages will need to call it after check for isolated range for
- * a next retry).
- *
  * Return: the number of isolated pageblocks on success and -EBUSY if any part
  * of range cannot be isolated.
  */
@@ -192,9 +178,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
 
-	for (pfn = start_pfn;
-	     pfn < end_pfn;
-	     pfn += pageblock_nr_pages) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page) {
 			if (set_migratetype_isolate(page, migratetype, flags)) {
-- 
2.25.1

