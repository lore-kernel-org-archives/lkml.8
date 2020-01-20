Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E23CC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5724673
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G06DXa04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATNTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:19:23 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42190 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgATNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:19:23 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so13913952qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgJJtE+3yyE+N9S25iMw/ePK2fC497PluXTrflyuZaE=;
        b=G06DXa046ce21M+FFj1pf7M+SGMVIOvKQ+KNzI/2S3rOacs4u1ls5MIf1HIAx+FNiE
         I0qr8pAozP1iqZ2XsgbOehQSm/pMzINNxWS0+mJOho4c8xYI0jGBaMo7emeg/gPMz79t
         9evp2GdT1tOWeiM55y76vxTZzbHaA5GWZj3iFKLf3tVmrzp3YS8Yw1gJw3aRjbxo0zzJ
         tEhmdQHGtK0D9F2I17LwpvEYHEYm7+yVycIsG+Ge8q40XddoVwWDt/e6X5YafgYBAp80
         uMJwGSlxMcCeWKaJPzFujOlXNjjIk/px3nfH7a0tbdqNtuNSGUrT8A7fM9gnQYMbpRyw
         VJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgJJtE+3yyE+N9S25iMw/ePK2fC497PluXTrflyuZaE=;
        b=Qe4D+pHeOqKU4zfHm+J35SYc6BuJuiRaYyrh0uE1HzHe/jfYyzwYJSwdm1I9a6+tbe
         wDjNGqVACa6Q2QUaZMHKxWGQlH40h0IzBY9oZB84IDDZSfc+A3cHqW51he6XPfu3Uox5
         HoTAjC57Js3h8Z0H/TciZ5m9K7IlLbdaZoCdhqsD0SC81eD2y4NR6gkvNfYSO8B/EjM6
         OxvBCFHe+KcqC+ZBSFDhtA1nI+VYacVcbstQBZp6Wrcl0GSP2L7s8qmVyeHOm7fbsbOo
         XDyUrEm4jhUJ18gcMzpOWV75q1Qfd1w2Hc8N2O9/WEw0DgycsyCQ3LIeSg9gk0vDzJc3
         ln4A==
X-Gm-Message-State: APjAAAW7x2a8URQE5goAL71CINYVfCuGMTOLs3ZEhfGiBpUNDuF2ZrD6
        4Cwq+EzaRVzRdBl3ZoDamzODvA==
X-Google-Smtp-Source: APXvYqxsRmhPVJuM4MfM26pZXbz3E1qumMVxOSodoqqDohH3qx7zZcC75mmbeG64Yp8Grh8JNuVP1w==
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr20644399qvb.107.1579526362281;
        Mon, 20 Jan 2020 05:19:22 -0800 (PST)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t73sm15903831qke.71.2020.01.20.05.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 05:19:21 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
Date:   Mon, 20 Jan 2020 08:19:09 -0500
Message-Id: <20200120131909.813-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
from start_isolate_page_range(), but should avoid triggering it from
userspace, i.e, from is_mem_section_removable() because it could be a
DoS if warn_on_panic is set.

While at it, simplify the code a bit by removing an unnecessary jump
label and a local variable, so set_migratetype_isolate() could really
return a bool.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Improve the commit log.
    Warn for all start_isolate_page_range() users not just offlining.

 mm/page_alloc.c     | 11 ++++-------
 mm/page_isolation.c | 30 +++++++++++++++++-------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 621716a25639..3c4eb750a199 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		if (is_migrate_cma(migratetype))
 			return NULL;
 
-		goto unmovable;
+		return page;
 	}
 
 	for (; iter < pageblock_nr_pages; iter++) {
@@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		page = pfn_to_page(pfn + iter);
 
 		if (PageReserved(page))
-			goto unmovable;
+			return page;
 
 		/*
 		 * If the zone is movable and we have ruled out all reserved
@@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 			unsigned int skip_pages;
 
 			if (!hugepage_migration_supported(page_hstate(head)))
-				goto unmovable;
+				return page;
 
 			skip_pages = compound_nr(head) - (page - head);
 			iter += skip_pages - 1;
@@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * is set to both of a memory hole page and a _used_ kernel
 		 * page at boot.
 		 */
-		goto unmovable;
+		return page;
 	}
 	return NULL;
-unmovable:
-	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	return pfn_to_page(pfn + iter);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e70586523ca3..31f5516f5d54 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,12 +15,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
-static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
+static bool set_migratetype_isolate(struct page *page, int migratetype,
+				    int isol_flags)
 {
-	struct page *unmovable = NULL;
+	struct page *unmovable = ERR_PTR(-EBUSY);
 	struct zone *zone;
 	unsigned long flags;
-	int ret = -EBUSY;
 
 	zone = page_zone(page);
 
@@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 									NULL);
 
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
-		ret = 0;
 	}
 
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret)
+
+	if (!unmovable) {
 		drain_all_pages(zone);
-	else if ((isol_flags & REPORT_FAILURE) && unmovable)
-		/*
-		 * printk() with zone->lock held will guarantee to trigger a
-		 * lockdep splat, so defer it here.
-		 */
-		dump_page(unmovable, "unmovable page");
-
-	return ret;
+	} else {
+		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
+
+		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
+			/*
+			 * printk() with zone->lock held will likely trigger a
+			 * lockdep splat, so defer it here.
+			 */
+			dump_page(unmovable, "unmovable page");
+	}
+
+	return !!unmovable;
 }
 
 static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
-- 
2.21.0 (Apple Git-122.2)

