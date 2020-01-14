Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9D3C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A424673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pk6gO3ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgANUL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:11:29 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45165 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:11:29 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so6284299qvu.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBp3Gt/C+a/mHRpipU20c3QaHKvIEsS9ocruCJDZZhE=;
        b=pk6gO3ry5wNUzd/t243vbBkeE+MDmMeF+1KrIkjJBT/AhgL4JEKmh4UN3hSngT6aG3
         s4YyCYSJR48wyozqNncYg3yc3kFwVQ85HD8EEyz65dIgFlIkNrm24+JwhhJeVLQqn0R9
         5eWxKX5YjIymf+FI6ozamFVtZ216TCUKUOKwQyyavzhz3tlwtNS88w3UCNRUKKB/vbN2
         IBeu/o+ArE6aCPZyeA2Vluva4jEfnQX/dC34VXRf5XfjNSIQnCMlutDeuLABBSm3L2W6
         c7vhVZsf1gSRjij4tRPuLyNVkhHUMAcFPrCalN1BqrWeTJc38vo2XsusRoB8/jbJiNKF
         4lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBp3Gt/C+a/mHRpipU20c3QaHKvIEsS9ocruCJDZZhE=;
        b=PMZRqBh8apOX+CUlu/ZBweWj9u/xKhDUbJLcLGaLF9RswJMnDns6+T1HHwVIVWqloS
         TrO4ZM6PgHzbxWjxndOLqMvWVtOTp/xrHGzSdb7Q0k3g+ajP6m5qfKeXWjVo8Nv5syoQ
         oMBAsPvsFTbTu+XBaVfazv8jcB/paRWLJuNTshp/2phA+VZnx0ZhSp7eel04hBB0ukEe
         S51zLFRqVao4NY79O4h4oYXCTbWJQ3RiTcKq5HfEldvieTWTnJJHGOTH0ZRjAukdpiSJ
         jopJIam1uBDKf4yS20kQq5GeUwcagGJ/ZG22gpc7GIdz3fLlc/W8fldwfSm6EyL+JwEu
         StPQ==
X-Gm-Message-State: APjAAAVXW1UxltVk5QwcuyXL4RD26Luq2kkfoHYhDqefnZWfnbU5x7bK
        CONewGbOeYCfn9o5ZV4ucVPr4Q==
X-Google-Smtp-Source: APXvYqzxZ8pgPcoyA9hDnr6J0eUQT4XcUQ6l54zl8N2EkmcgtTpRJuaSSDwK+/DZmuoelSC7OCcxrw==
X-Received: by 2002:a0c:e28e:: with SMTP id r14mr18896392qvl.234.1579032688196;
        Tue, 14 Jan 2020 12:11:28 -0800 (PST)
Received: from ovpn-120-31.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j15sm7912023qtn.37.2020.01.14.12.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 12:11:27 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Date:   Tue, 14 Jan 2020 15:11:14 -0500
Message-Id: <20200114201114.14696-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the recent commit [1] merged into the random and -next trees,
it is not a good idea to call printk() with zone->lock held. The
standard fix is to use printk_deferred() in those places, but memory
offline will call dump_page() which need to defer after the lock. While
at it, remove a similar but unnecessary debug printk() as well.

[1] https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/page-isolation.h |  2 +-
 mm/memory_hotplug.c            |  2 +-
 mm/page_alloc.c                | 12 +++++-------
 mm/page_isolation.c            | 10 +++++++++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 148e65a9c606..5d8ba078006f 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -34,7 +34,7 @@ static inline bool is_migrate_isolate(int migratetype)
 #define REPORT_FAILURE	0x2
 
 bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
-			 int flags);
+			 int flags, char *dump);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a6de9b0dcab..f10928538fa3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1149,7 +1149,7 @@ static bool is_pageblock_removable_nolock(unsigned long pfn)
 		return false;
 
 	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
-				    MEMORY_OFFLINE);
+				    MEMORY_OFFLINE, NULL);
 }
 
 /* Checks if this range of memory is likely to be hot-removable. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e56cd1f33242..b6bec3925e80 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8204,7 +8204,7 @@ void *__init alloc_large_system_hash(const char *tablename,
  * race condition. So you can't expect this function should be exact.
  */
 bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
-			 int flags)
+			 int flags, char *dump)
 {
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
@@ -8305,8 +8305,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
 	return false;
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	if (flags & REPORT_FAILURE)
-		dump_page(pfn_to_page(pfn + iter), reason);
+	if (flags & REPORT_FAILURE) {
+		page = pfn_to_page(pfn + iter);
+		strscpy(dump, reason, 64);
+	}
 	return true;
 }
 
@@ -8711,10 +8713,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
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
index 1f8b9dfecbe8..ce0fe3c1ceff 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -20,6 +20,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	struct zone *zone;
 	unsigned long flags;
 	int ret = -EBUSY;
+	char dump[64];
 
 	zone = page_zone(page);
 
@@ -37,7 +38,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, migratetype, isol_flags)) {
+	if (!has_unmovable_pages(zone, page, migratetype, isol_flags,
+				 dump)) {
 		unsigned long nr_pages;
 		int mt = get_pageblock_migratetype(page);
 
@@ -54,6 +56,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret)
 		drain_all_pages(zone);
+	else if (isol_flags & REPORT_FAILURE)
+		/*
+		 * printk() with zone->lock held will guarantee to trigger a
+		 * lockdep splat, so defer it here.
+		 */
+		dump_page(page, dump);
 	return ret;
 }
 
-- 
2.21.0 (Apple Git-122.2)

